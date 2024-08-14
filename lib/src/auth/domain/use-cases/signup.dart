import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SignUp extends UseCaseWithParams<DataMap, SignUpParams> {
  const SignUp(
    this._authRepo,
  );

  final AuthRepo _authRepo;

  @override
  ResultFuture<DataMap> call(SignUpParams params) => _authRepo.signUp(
        name: params.name,
        email: params.email,
        password: params.password,
        type: params.type,
        address: params.address,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.address,
  });

  const SignUpParams.empty()
      : this(
          name: 'empty.name',
          email: 'empty.email',
          password: 'empty.password',
          address: 'empty.address',
          type: 'empty.type',
        );

  final String name;
  final String email;
  final String password;
  final String type;
  final String address;

  @override
  List<String> get props => [name, email, address, password];
}
