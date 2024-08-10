import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SignIn extends UseCaseWithParams<DataMap, SignInParams> {
  const SignIn(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<DataMap> call(SignInParams params) => _authRepo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });

  const SignInParams.empty()
      : this(
          email: 'empty.email',
          password: 'empty.password',
        );

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}
