import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class SetUser extends UseCaseWithParams<DataMap, DataMap> {
  const SetUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<DataMap> call(DataMap params) async => _authRepo.setUser(
        user: params,
      );
}
