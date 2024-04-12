import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SignOut extends UseCaseWithoutParams<void>{
  const SignOut(this._authRepo);
  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call()async => _authRepo.signOut();
}
