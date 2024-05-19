import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/invitation_token_model.dart';
import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/common/app/public_methods/token-generator/token_generator.dart';
import 'package:husbandman/core/common/strings/error_messages.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';

const kBlockUserEndpoint = '/admin/block-user';
const kChangeFarmerBadgeEndpoint = '/admin/farmer/change-badge';
const kDeleteAccountEndpoint = '/admin/delete-account';
const kFetchAllOrdersEndpoint = '/admin/fetch-all-orders';
const kFetchAllInvitationTokenEndpoint = '/admin/fetch-all-invitation-token';
const kFetchAllUsersEndpoint = '/admin/fetch-all-users';
const kFilterUserEndpoint = '/admin/filter-user';
const kGenerateInvitationTokenEndpoint = '/admin/generate-invitation-token';
const kSearchUserEndpoint = '/admin/search-user';
const kSaveInvitationTokenEndpoint = '/admin/save-token';

class AdminDatasourceImpl implements AdminDatasource {
  const AdminDatasourceImpl(this._client, this._tokenGenerator);

  final http.Client _client;
  final TokenGenerator _tokenGenerator;

  @override
  Future<void> blockAccount({required String accountId}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kBlockUserEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'accountId': accountId},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 400,
      );
    }
  }

  @override
  Future<void> changeFarmerBadge({
    required String farmerId,
    required int badge,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kChangeFarmerBadgeEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'farmerId': farmerId,
          'badge': badge,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<void> deleteAccount({required String userId}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kDeleteAccountEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          {'userId': userId},
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<OrderModel>> fetchAllOrders() async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kFetchAllOrdersEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(
            OrderModel.fromMap,
          )
          .toList();

      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<List<InvitationTokenModel>> fetchAllInvitationToken() async {
    try {
      final response = await _client.get(
        Uri.parse('$kBaseUrl$kFetchAllInvitationTokenEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(InvitationTokenModel.fromMap)
          .toList();
      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final response = await _client.get(
        Uri.parse(
          '$kBaseUrl$kFetchAllUsersEndpoint',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(UserModel.fromMap)
          .toList();

      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<List<UserModel>> filterUser({
    required FilterUserProperty property,
    required dynamic value,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
          '$kBaseUrl$kFilterUserEndpoint',
        ),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'property': property.name,
          'value': value,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(UserModel.fromMap)
          .toList();

      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<String> generateUniqueInvitationToken() async {
    try {
      final result = _tokenGenerator.generateToken();

      if (result.length > 8 || result.length < 8) {
        throw const AdminException(
          message: kInvalidTokenLength,
          statusCode: 400,
        );
      }

      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<UserModel>> searchUser({
    required String query,
    required SearchUserProperty property,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kSearchUserEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'query': query,
          'property': property.name,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }

      final result = List<DataMap>.from(jsonDecode(response.body) as List)
          .map(UserModel.fromMap)
          .toList();

      return result;
    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<void> shareInvitationTokenToEmail({
    required String token,
    required String emailAddress,
  }) {
    // TODO: implement shareInvitationTokenToEmail
    throw UnimplementedError();
  }

  @override
  Future<void> shareInvitationTokenToWhatsApp({required String token}) {
    // TODO: implement shareInvitationTokenToWhatsApp
    throw UnimplementedError();
  }

  @override
  Future<void> saveInvitationToken({required String key}) async {
    try {
      final response = await _client.post(
        Uri.parse('$kBaseUrl$kSaveInvitationTokenEndpoint'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'key': key,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw AdminException(
            message: response.body, statusCode: response.statusCode,);
      }

    } on AdminException catch (_) {
      rethrow;
    } catch (e) {
      throw AdminException(message: e.toString(), statusCode: 400);
    }
  }
}
