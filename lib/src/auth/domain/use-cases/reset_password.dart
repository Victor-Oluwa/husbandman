import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class ResetPassword extends UseCaseWithParams<void, String> {
  const ResetPassword(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(String params) =>
      _authRepo.resetPassword(newPassword: params);
}
