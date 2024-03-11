import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class AuthenticateResetPasswordToken extends UseCaseWithParams<bool, String> {
  const AuthenticateResetPasswordToken(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<bool> call(String params) =>
      _authRepo.authenticateResetPasswordToken(token: params);
}
