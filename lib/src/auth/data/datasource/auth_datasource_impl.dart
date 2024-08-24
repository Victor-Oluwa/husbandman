import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/provider/invitation_key_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';
import 'package:husbandman/src/auth/data/model/seller/seller_model.dart';
import 'package:husbandman/src/auth/domain/entity/user/props/pendingPayment/pending_payment_entity.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';

const kBuyerSignUpEndpoint = '/sign-up';
const kFarmerSignUpEndpoint = '/farmer/sign-up';
const kAuthenticateResetPasswordTokenEndpoint = '/admin/password/token/send';
const kResetPasswordEndpoint = '/user/password/reset';
const kSendResetPasswordTokenEndpoint = '/admin/password/reset/send-token';
const kSignInEndpoint = '/user/sign-in';
const kUpdateUserEndpoint = '/user/update-info';
const kValidateUserEndpoint = '/admin/validate-user';
const kValidateFarmerInvitationKeyEndpoint = '/admin/farmer-key/validate';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this._client, this._storage, this._ref);

  final http.Client _client;
  final HBMStorage _storage;
  final Ref _ref;

  @override
  Future<bool> authenticateResetPasswordToken({
    required String token,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kAuthenticateResetPasswordTokenEndpoint'),
        body: jsonEncode({'token': token}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return jsonDecode(response.body) as bool;
    } on AuthException catch (_) {
      log('Authenticate reset password error');
      rethrow;
    } catch (e) {
      log('Authenticate reset password error');
      throw AuthException(message: e.toString(), statusCode: 500);
    } finally {}
  }

  @override
  Future<DataMap> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kSignInEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );
      log('Sign in res: ${response.body}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = jsonDecode(response.body) as DataMap;
      return result;
    } on AuthException catch (_) {
      log('Sign in error');
      rethrow;
    } catch (e) {
      log('Sign in error');
      throw AuthException(message: e.toString(), statusCode: 400);
    } finally {}
  }

  @override
  Future<DataMap> signUp({
    required String name,
    required String email,
    required String password,
    required String type,
    required String address,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
          '$kBaseUrl$kBuyerSignUpEndpoint',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'type': type,
          'address': address,
        }),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      log('Sign Up response: 1');

      return jsonDecode(response.body) as DataMap;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthException(
        message: e.toString(),
        statusCode: 505,
      );
    }
  }

  @override
  Future<void> cacheUserToken({required String token}) async {
    try {
      await _storage.writeData(key: kAuthToken, value: token);
    } catch (e) {
      log('Cache user error');
      throw AuthException(message: e.toString(), statusCode: 500);
    } finally {}
  }

  @override
  Future<void> cacheVerifiedInvitationToken({required String token}) async {
    try {
      _ref
          .read(invitationKeyProvider.notifier)
          .cacheInvitationToken(token: token);
    } on AuthException catch (_) {
      log('Cache Invitation error');
      rethrow;
    } catch (e) {
      log('Cache Invitation error');
      throw AuthException(message: e.toString(), statusCode: 500);
    } finally {}
  }

  @override
  Future<SellerModel> farmerSignUp({
    required SellerEntity seller,
    required String invitationKey,
  }) async {
    try {
      log('Passed key: ${_ref.read(invitationKeyProvider)}');
      final response = await _client.post(
        Uri.parse(
          '$kBaseUrl$kFarmerSignUpEndpoint',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {
            'invitationKey': _ref.read(invitationKeyProvider),
            'name': seller.name,
            'email': seller.email,
            'password': seller.password,
            'type': seller.userType,
          },
        ),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final responseMap = jsonDecode(response.body) as DataMap;
      log('Farmer sign up response $responseMap');

      final sellerModel = SellerModel.fromJson(responseMap);

      return sellerModel;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<String> retrieveUserToken() async {
    try {
      final result = await _storage.readData(key: kAuthToken);
      if (result == null || result.isEmpty) {
        throw const AuthException(
          message: 'User token is null',
          statusCode: 400,
        );
      }
      return result;
    } catch (e) {
      throw AuthException(message: e.toString(), statusCode: 400);
    } finally {}
  }

  @override
  Future<void> resetPassword({required String newPassword}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kResetPasswordEndpoint'),
        body: jsonEncode({'newPassword': newPassword}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on AuthException {
      log('Reset password error');
      rethrow;
    } catch (e) {
      log('Reset password error');
      throw AuthException(message: e.toString(), statusCode: 400);
    }
  }

  @override
  Future<DataMap> setUser({required DataMap user}) async {
    try {
      return _ref.read(userProvider.notifier).updateUserFromMap(map: user);
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthException(message: e.toString(), statusCode: 100);
    }
  }

  @override
  Future<void> sendResetPasswordToken({required String email}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kSendResetPasswordTokenEndpoint'),
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on AuthException catch (_) {
      log('Send reset password token error');
      rethrow;
    } catch (e) {
      log('Send reset password token error');
      throw AuthException(message: e.toString(), statusCode: 500);
    } finally {}
  }

  @override
  Future<void> signOut() async {
    try {
      final result = _storage.deleteData(key: kAuthToken);
      return result;
    } on AuthException catch (_) {
      log('Sign out error');
      rethrow;
    } catch (e) {
      log('Sign out error');
      throw AuthException(message: e.toString(), statusCode: 505);
    } finally {}
  }

  @override
  Future<DataMap> updateUser({
    required String userId,
    required String userType,
    required dynamic newData,
    required UpdateUserCulprit culprit,
  }) async {
    try {
      final response = await Dio().post<DataMap>(
        '$kBaseUrl$kUpdateUserEndpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
        data: jsonEncode({
          'userId': userId,
          'userType': userType,
          'newData': newData,
          'culprit': culprit.name,
        }),
      );
      final result = response.data;
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.data.toString(),
          statusCode: response.statusCode ?? 500,
        );
      }

      if (result == null) {
        throw const AuthException(
          message: 'User update failed. Null was returned',
          statusCode: 500,
        );
      }
      return result;
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        throw AuthException(
          message: response.data.toString(),
          statusCode: 500,
        );
      } else {
        throw AuthException(
          message: e.message ?? '',
          statusCode: 500,
        );
      }
    } on AuthException catch (_) {
      log('Update user error');
      rethrow;
    } catch (e) {
      log('Update user error');
      throw AuthException(message: e.toString(), statusCode: 400);
    }
  }

  @override
  Future<DataMap> validateUser({required String token}) async {
    try {
      final response = await Dio()
          .post<DataMap>(
            '$kBaseUrl$kValidateUserEndpoint',
            data: jsonEncode({
              'token': token,
            }),
            options: Options(
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                kAuthToken: token,
              },
            ),
          )
          .timeout(const Duration(seconds: 30));
      log('Response from datasource: ${response.data}');
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.data.toString(),
          statusCode: response.statusCode!,
        );
      }

      final result = response.data;

      if (result == null) {
        throw const AuthException(
          message: 'Verification failed. Null was returned',
          statusCode: 500,
        );
      }
      return result;
    } on AuthException catch (_) {
      rethrow;
    } on DioException catch (e) {
      final response = e.response;
      if (response != null) {
        throw AuthException(
          message: response.data.toString(),
          statusCode: 500,
        );
      } else {
        throw AuthException(
          message: e.message ?? 'Unknown Error',
          statusCode: 500,
        );
      }
    } catch (e) {
      throw AuthException(message: e.toString(), statusCode: 600);
    }
  }

  @override
  Future<String> validateFarmerInvitationKey({
    required String invitationKey,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kValidateFarmerInvitationKeyEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'invitationKey': invitationKey,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return jsonDecode(response.body) as String;
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      throw AuthException(message: e.toString(), statusCode: 400);
    } finally {}
  }
}
