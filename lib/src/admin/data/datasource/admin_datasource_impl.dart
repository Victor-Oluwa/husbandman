import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/error/exceptions.dart';
import 'package:husbandman/core/utils/constants.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/domain/entity/invitation_token_entity.dart';

const kBlockUserEndpoint = '/admin/block-user';
const kChangeFarmerBadgeEndpoint = '/admin/farmer/change-badge';
const kDeleteAccountEndpoint = '/admin/delete-account';
const kFetchAllOrdersEndpoint = '/admin/fetch-all-orders';

class AdminDatasourceImpl implements AdminDatasource {
  const AdminDatasourceImpl(this._client);

  final http.Client _client;

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
    } on AdminException catch (e) {
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
    } on AdminException catch (e) {
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
    } on AdminException catch (e) {
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
    } on AdminException catch (e) {
      rethrow;
    } catch (e) {
      throw AdminException(
        message: e.toString(),
        statusCode: 404,
      );
    }
  }

  @override
  Future<List<InvitationTokenEntity>> fetchAllInvitationToken() {
    // TODO: implement fetchAllInvitationToken
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> fetchAllUsers() {
    // TODO: implement fetchAllUsers
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> filterUser({
    required FilterUserProperty property,
    required dynamic value,
  }) {
    // TODO: implement filterUser
    throw UnimplementedError();
  }

  @override
  Future<String> generateUniqueInvitationToken() {
    // TODO: implement generateUniqueInvitationToken
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>> searchUser(
      {required String query, required SearchUserProperty property}) {
    // TODO: implement searchUser
    throw UnimplementedError();
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
}
