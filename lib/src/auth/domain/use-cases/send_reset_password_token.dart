import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SendResetPasswordToken extends UseCaseWithParams<void, String> {
  const SendResetPasswordToken(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(String params) =>
      _authRepo.sendResetPasswordToken(email: params);
}
