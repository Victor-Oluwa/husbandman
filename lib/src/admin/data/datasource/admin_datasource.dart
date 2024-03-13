import 'package:husbandman/core/common/app/models/order_model.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';

abstract class AdminDatasource{
  const AdminDatasource();

  Future<void> blockAccount({required String accountId});

  Future<void> changeFarmerBadge({
    required String farmerId,
    required int badge,
  });

  Future<void> deleteAccount({required String userId});

  Future<List<OrderModel>> fetchAllOrders();

  Future<List<InvitationTokenEntity>> fetchAllInvitationToken();

  Future<List<UserModel>> fetchAllUsers();

  Future<List<UserModel>> filterUser({
    required FilterUserProperty property,
    required dynamic value,
  });

  Future<String> generateUniqueInvitationToken();

  Future<void> shareInvitationTokenToEmail({
    required String token,
    required String emailAddress,
  });

  Future<void> shareInvitationTokenToWhatsApp({
    required String token,
  });

  Future<List<UserModel>> searchUser({
    required String query,
    required SearchUserProperty property,
  });
}

