import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class SaveInvitationToken extends UseCaseWithParams<void,String>{
  const SaveInvitationToken(this._repo);
  final AdminRepo _repo;

  @override
  ResultFuture<void> call(String params)async {
  return _repo.saveInvitationToken(token: params);
  }
}