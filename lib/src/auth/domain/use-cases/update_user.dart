import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class UpdateUser extends UseCaseWithParams<UserEntity, UpdateUserParams> {
  UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<UserEntity> call(UpdateUserParams params) => _authRepo.updateUser(
        newData: params.newData,
        culprit: params.culprit,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.newData,
    required this.culprit,
  });

  const UpdateUserParams.empty()
      : this(
          newData: 'empty.newData',
          culprit: UpdateUserCulprit.name,
        );

  final dynamic newData;
  final UpdateUserCulprit culprit;

  @override
  List<dynamic> get props => [newData, culprit];
}
