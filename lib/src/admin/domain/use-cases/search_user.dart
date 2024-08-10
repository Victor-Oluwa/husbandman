import 'package:equatable/equatable.dart';
import 'package:husbandman/core/enums/search_user.dart';
import 'package:husbandman/core/usecases/usecases.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';

class SearchUser extends UseCaseWithParams<List<DataMap>, SearchUserParams> {
  const SearchUser(this._adminRepo);

  final AdminRepo _adminRepo;

  @override
  ResultFuture<List<DataMap>> call(SearchUserParams params) =>
      _adminRepo.searchUser(
        query: params.query,
        property: params.property,
      );
}

class SearchUserParams extends Equatable {
  const SearchUserParams({
    required this.query,
    required this.property,
  });

  const SearchUserParams.empty()
      : this(
          query: 'John boo',
          property: SearchUserProperty.name,
        );

  final String query;
  final SearchUserProperty property;

  @override
  List<Object> get props => [query, property];
}
