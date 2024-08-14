import 'package:husbandman/src/admin/domain/entity/invitation_token_entity.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/utils/typedef.dart';
// String uniqueKey = UniqueKey().toString();

abstract class AdminRepo {
  ResultFuture<void> blockAccount({required String accountId});

  ResultFuture<void> changeFarmerBadge({
    required String farmerId,
    required int badge,
  });

  ResultFuture<void> deleteAccount({required String userId});

  ResultFuture<List<InvitationTokenEntity>> fetchAllInvitationToken();

  ResultFuture<List<DataMap>> fetchAllUsers();

  ResultFuture<List<DataMap>> filterUser({
    required FilterUserProperty property,
    required dynamic value,
  });

  ResultFuture<String> generateUniqueInvitationToken({
    required List<int> generatedToken,
  });

  ResultFuture<void> shareInvitationTokenToEmail({
    required String token,
    required String emailAddress,
  });

  ResultFuture<void> shareInvitationTokenToWhatsApp({
    required String token,
  });

  ResultFuture<List<DataMap>> searchUser({
    required String query,
    required SearchUserProperty property,
  });

  ResultFuture<void> saveInvitationToken({required String key});
}
