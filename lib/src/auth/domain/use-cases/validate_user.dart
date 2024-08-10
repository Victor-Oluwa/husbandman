import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/auth/domain/repo/auth_repo.dart';

class ValidateUser extends UseCaseWithParams<DataMap, String> {
  const ValidateUser(this._authRepo);

  final AuthRepo _authRepo;

  @override
  ResultFuture<DataMap> call(String params) => _authRepo.validateUser(
        token: params,
      );
}
