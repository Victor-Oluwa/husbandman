import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class GenerateUniqueInvitationToken extends UseCaseWithoutParams<String> {
  const GenerateUniqueInvitationToken(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<String> call() => _adminRepo.generateUniqueInvitationToken();
}
