import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user/seller/seller_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class FarmerSignUp extends UseCaseWithParams<SellerEntity, FarmerSignUpParams> {
  const FarmerSignUp(
    this._authRepo,
  );

  final AuthRepo _authRepo;

  @override
  ResultFuture<SellerEntity> call(FarmerSignUpParams params) {
    return _authRepo.farmerSignUp(
      seller: params.seller,
      invitationKey: params.invitationKey,
    );
  }
}

class FarmerSignUpParams extends Equatable {
  const FarmerSignUpParams({
    required this.seller,
    required this.invitationKey,
  });

  const FarmerSignUpParams.empty()
      : this(
          invitationKey: '',
          seller: SellerEntity.empty,
        );

  final SellerEntity seller;
  final String invitationKey;

  @override
  List<dynamic> get props => [
        seller,
        invitationKey,
      ];
}
