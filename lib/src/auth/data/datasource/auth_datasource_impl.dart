import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/user/admin_model.dart';
import 'package:husbandman/core/common/app/models/user/buyer_model.dart';
import 'package:husbandman/core/common/app/models/user/farmer_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/app/provider/invitation_key_provider.dart';
import 'package:husbandman/core/common/app/provider/state_notifier_providers/user_provider.dart';
import 'package:husbandman/core/common/app/storage/hbm_storage.dart';
import 'package:husbandman/core/common/strings/error_messages.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/data/datasource/auth_datasource.dart';

const kBuyerSignUpEndpoint = '/buyer/sign-up';
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
  Future<UserModel> buyerSignUp({
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

      final responseMap = jsonDecode(response.body) as DataMap;

      final buyerModel = BuyerModel.fromMap(responseMap);
      return buyerModel;
    } on AuthException catch (_) {
      log('Buyer signUp error');
      rethrow;
    } catch (e) {
      log('Buyer signUp error');

      throw AuthException(
        message: e.toString(),
        statusCode: 505,
      );
    } finally {}
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
  Future<UserModel> farmerSignUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String type,
    required String invitationKey,
  }) async {
    try {
      log('Passed key: ${_ref.read(invitationKeyProvider)}');
      log('55555555');
      final response = await _client.post(
        Uri.parse(
          '$kBaseUrl$kFarmerSignUpEndpoint',
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'address': address,
          'type': type,
          'invitationKey': _ref.read(invitationKeyProvider),
        }),
      );

      if (response.statusCode != 201 && response.statusCode != 200) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final responseMap = jsonDecode(response.body) as DataMap;

      final farmerModel = FarmerModel.fromMap(responseMap);
      return farmerModel;
    } on AuthException catch (_) {
      log('Farmer signUp error');
      rethrow;
    } catch (e) {
      log('Farmer signUp error');
      throw AuthException(message: e.toString(), statusCode: 500);
    } finally {}
  }

  @override
  Future<String> retrieveUserToken() async {
    try {
      final result = await _storage.readData(key: kAuthToken);
      if (result == null) {
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
  Future<UserModel> setUser({required DataMap user}) async {
    try {
      final userModel = UserModel.fromMap(user);
      _ref.read(userProvider.notifier).updateUserFromMap(map: user);

      return userModel;
    } catch (e) {
      log('Set user error');
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
  Future<UserModel> signIn({
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
      if (response.statusCode != 200 && response.statusCode != 201) {
        log('Sign in response: ${response.statusCode}');

        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      final responseMap = jsonDecode(response.body) as DataMap;

      final userModel = UserModel.fromMap(responseMap);
      log('Farmer sign in response: $responseMap');

      switch (userModel.type) {
        case 'Farmer':
          final farmerModel = FarmerModel.fromMap(responseMap);
          return farmerModel;
        case 'Buyer':
          final buyerModel = BuyerModel.fromMap(responseMap);
          return buyerModel;
        case 'Admin':
          final adminModel =
              AdminModel.fromMap(jsonDecode(response.body) as DataMap);
          return adminModel;
        default:
          throw const AuthException(
            message: kInvalidUserType,
            statusCode: 404,
          );
      }
    } on AuthException catch (_) {
      log('Sign in error');
      rethrow;
    } catch (e) {
      log('Sign in error');
      throw AuthException(message: e.toString(), statusCode: 400);
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
  Future<UserModel> updateUser({
    required dynamic newData,
    required UpdateUserCulprit culprit,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kUpdateUserEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'newData': newData,
          'culprit': culprit.name,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      _client.close();

      final userModel = UserModel.fromMap(jsonDecode(response.body) as DataMap);

      switch (userModel.type) {
        case 'Farmer':
          final farmerModel =
              FarmerModel.fromMap(jsonDecode(response.body) as DataMap);
          return farmerModel;
        case 'Buyer':
          final buyerModel =
              BuyerModel.fromMap(jsonDecode(response.body) as DataMap);
          return buyerModel;
        case 'Admin':
          final adminModel =
              AdminModel.fromMap(jsonDecode(response.body) as DataMap);
          return adminModel;
        default:
          throw const AuthException(
            message: kInvalidUserType,
            statusCode: 401,
          );
      }
    } on AuthException catch (_) {
      log('Update user error');
      rethrow;
    } catch (e) {
      log('Update user error');
      throw AuthException(message: e.toString(), statusCode: 400);
    } finally {}
  }

  @override
  Future<UserModel> validateUser({required String token}) async {
    try {
      final response = await Dio()
          .post<Map<String, dynamic>>(
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
      log('Res response: ${response.data}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AuthException(
          message: response.data.toString(),
          statusCode: response.statusCode!,
        );
      }

      final userModel = UserModel.fromMap(response.data!);

      switch (userModel.type) {
        case 'Farmer':
          return FarmerModel.fromMap(response.data!);
        case 'Buyer':
          return BuyerModel.fromMap(response.data!);
        case 'Admin':
          return AdminModel.fromMap(response.data!);
        default:
          throw const AuthException(
            message: kInvalidUserType,
            statusCode: 401,
          );
      }
    } on AuthException catch (_) {
      rethrow;
    } catch (e) {
      log('Validate user error: $e');
      throw AuthException(message: e.toString(), statusCode: 600);
    }
  }

  // Future<UserModel> validateUser({required String token}) async {
  //   try {
  //     final response = await _client.post(
  //       Uri.parse('$kBaseUrl$kValidateUserEndpoint'),
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //         kAuthToken: token,
  //       },
  //       body: jsonEncode({
  //         'token': token,
  //       }),
  //     );
  //
  //     if (response.statusCode != 200 && response.statusCode != 201) {
  //       throw AuthException(
  //         message: response.body,
  //         statusCode: response.statusCode,
  //       );
  //     }
  //     final userModel = UserModel.fromMap(jsonDecode(response.body) as DataMap);
  //
  //     switch (userModel.type) {
  //       case 'Farmer':
  //         final farmerModel =
  //         FarmerModel.fromMap(jsonDecode(response.body) as DataMap);
  //         return farmerModel;
  //       case 'Buyer':
  //         final buyerModel =
  //         BuyerModel.fromMap(jsonDecode(response.body) as DataMap);
  //         return buyerModel;
  //       case 'Admin':
  //         final adminModel =
  //         AdminModel.fromMap(jsonDecode(response.body) as DataMap);
  //         return adminModel;
  //       default:
  //         throw const AuthException(
  //           message: kInvalidUserType,
  //           statusCode: 401,
  //         );
  //     }
  //
  //   } on AuthException catch (_) {
  //     log('Validate user error');
  //     rethrow;
  //   } catch (e) {
  //     log('Validate user error');
  //     throw AuthException(message: e.toString(), statusCode: 600);
  //   }finally{
  //
  //   }
  // }

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
      log('Validate Farmer Invitation Key');
      rethrow;
    } catch (e) {
      log('Validate Farmer Invitation Key');
      throw AuthException(message: e.toString(), statusCode: 400);
    } finally {}
  }
}
