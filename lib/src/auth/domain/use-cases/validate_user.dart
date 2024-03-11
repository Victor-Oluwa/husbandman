import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class ValidateUser extends UseCaseWithParams<UserEntity, String> {
  const ValidateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<UserEntity> call(String params) => _authRepo.validateUser(
        token: params,
      );
}
