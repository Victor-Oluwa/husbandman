import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class DeleteAccount extends UseCaseWithParams<void, String> {
  const DeleteAccount(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<void> call(String params) => _adminRepo.deleteAccount(
        userId: params,
      );
}
