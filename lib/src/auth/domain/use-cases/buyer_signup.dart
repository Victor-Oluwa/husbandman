import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class BuyerSignUp extends UseCaseWithParams<void, BuyerSignUpParams> {
  const BuyerSignUp(
    this._authRepo,
  );

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(BuyerSignUpParams params) => _authRepo.buyerSignUp(
        name: params.name,
        email: params.email,
        password: params.password,
        type: params.type,
        address: params.address,
      );
}

class BuyerSignUpParams extends Equatable {
  const BuyerSignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    required this.address,
  });

  const BuyerSignUpParams.empty()
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
