import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SetUser extends UseCaseWithParams<void, DataMap> {
  const SetUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<void> call(DataMap params) async => _authRepo.setUser(
        user: params,
      );
}
