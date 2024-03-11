import 'package:equatable/equatable.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class ChangeFarmerBadge
    extends UseCaseWithParams<void, ChangeFarmerBadgeParams> {
  const ChangeFarmerBadge(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<void> call(ChangeFarmerBadgeParams params) =>
      _adminRepo.changeFarmerBadge(
        farmerId: params.farmerId,
        badge: params.badge,
      );
}

class ChangeFarmerBadgeParams extends Equatable {
  const ChangeFarmerBadgeParams({
    required this.farmerId,
    required this.badge,
  });

  const ChangeFarmerBadgeParams.empty()
      : this(farmerId: 'farmerId.empty', badge: 2);
  final String farmerId;
  final int badge;

  @override
  List<Object> get props => [farmerId, badge];
}
