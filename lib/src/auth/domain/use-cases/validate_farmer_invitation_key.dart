import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class ValidateFarmerInvitationKey extends UseCaseWithParams<String, String> {
  ValidateFarmerInvitationKey(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<String> call(String params) =>
      _authRepo.validateFarmerInvitationKey(invitationKey: params);
}
