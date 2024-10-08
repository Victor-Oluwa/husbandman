import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/update_user.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class UpdateUser extends UseCaseWithParams<DataMap, UpdateUserParams> {
  UpdateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<DataMap> call(UpdateUserParams params) => _authRepo.updateUser(
        userId: params.userId,
        userType: params.userType,
        newData: params.newData,
        culprit: params.culprit,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.userId,
    required this.userType,
    required this.newData,
    required this.culprit,
  });

  const UpdateUserParams.empty()
      : this(
          userId: '',
          userType: '',
          newData: '',
          culprit: UpdateUserCulprit.name,
        );

  final String userId;
  final String userType;
  final dynamic newData;
  final UpdateUserCulprit culprit;

  @override
  List<dynamic> get props => [newData, culprit];
}
