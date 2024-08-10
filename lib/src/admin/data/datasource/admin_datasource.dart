import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/utils/typedef.dart';

abstract class AdminDatasource{
  const AdminDatasource();

  Future<void> blockAccount({required String accountId});

  Future<void> changeFarmerBadge({
    required String farmerId,
    required int badge,
  });

  Future<void> deleteAccount({required String userId});


  Future<List<InvitationTokenEntity>> fetchAllInvitationToken();

  Future<List<DataMap>> fetchAllUsers();

  Future<List<DataMap>> filterUser({
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

  Future<List<DataMap>> searchUser({
    required String query,
    required SearchUserProperty property,
  });

  Future<void> saveInvitationToken({required String key});
}

