import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/entity/invitation_token_entity.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class FetchAllInvitationToken
    extends UseCaseWithoutParams<List<InvitationTokenEntity>> {
  const FetchAllInvitationToken(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<List<InvitationTokenEntity>> call() =>
      _adminRepo.fetchAllInvitationToken();
}
