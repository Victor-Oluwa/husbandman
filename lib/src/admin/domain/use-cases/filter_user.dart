import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class FilterUser extends UseCaseWithParams<List<UserModel>, FilterUserParams> {
  const FilterUser(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<List<UserModel>> call(FilterUserParams params) =>
      _adminRepo.filterUser(
        property: params.property,
        value: params.value,
      );
}

class FilterUserParams extends Equatable {
  const FilterUserParams({
    required this.property,
    required this.value,
  });

  const FilterUserParams.empty()
      : this(
          property: FilterUserProperty.type,
          value: 'Farmer',
        );

  final FilterUserProperty property;
  final dynamic value;

  @override
  List<Object?> get props => [property, value];
}
