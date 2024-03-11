import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class FarmerSignUp extends UseCaseWithParams<void, FarmerSignUpParams> {
  const FarmerSignUp(
    this._authRepo,
  );

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(FarmerSignUpParams params) {
   return _authRepo.farmerSignUp(
      name: params.name,
      email: params.email,
      password: params.password,
      address: params.address,
      type: params.type,
      invitationKey: params.invitationKey,
    );
  }
}

class FarmerSignUpParams extends Equatable {
  const FarmerSignUpParams({
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.type,
    required this.invitationKey,
  });

  const FarmerSignUpParams.empty()
      : this(
          name: '',
          email: '',
          password: '',
          address: '',
          type: '',
          invitationKey: '',
        );

  final String name;
  final String email;
  final String password;
  final String address;
  final String type;
  final String invitationKey;

  @override
  List<String> get props => [
        name,
        email,
        address,
        type,
        password,
        invitationKey,
      ];
}
