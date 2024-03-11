import 'package:husbandman/core/common/app/models/user/user_model.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class FetchAllUsers extends UseCaseWithoutParams<List<UserModel>> {
  const FetchAllUsers(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<List<UserModel>> call() => _adminRepo.fetchAllUsers();
}
