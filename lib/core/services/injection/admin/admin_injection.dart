

//ADMIN
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:husbandman/core/common/app/public_methods/token-generator/token_generator.dart';
import 'package:husbandman/core/services/injection/injection_container.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource.dart';
import 'package:husbandman/src/admin/data/datasource/admin_datasource_impl.dart';
import 'package:husbandman/src/admin/data/repo/admin_repo_impl.dart';
import 'package:husbandman/src/admin/domain/repo/admin_repo.dart';
import 'package:husbandman/src/admin/domain/use-cases/block_account.dart';
import 'package:husbandman/src/admin/domain/use-cases/change_farmer_badge.dart';
import 'package:husbandman/src/admin/domain/use-cases/delete_account.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_orders.dart';
import 'package:husbandman/src/admin/domain/use-cases/fetch_all_users.dart';
import 'package:husbandman/src/admin/domain/use-cases/filter_user.dart';
import 'package:husbandman/src/admin/domain/use-cases/generate_unique_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/save_invitation_token.dart';
import 'package:husbandman/src/admin/domain/use-cases/search_user.dart';
import 'package:husbandman/src/admin/presentation/bloc/admin_bloc.dart';

final adminBlocProvider = Provider<AdminBloc>((ref) {
  return AdminBloc(
    blockAccount: ref.read(blockAccountProvider),
    changeFarmerBadge: ref.read(changeFarmerBadgeProvider),
    deleteAccount: ref.read(deleteAccountProvider),
    fetchAllInvitationToken: ref.read(fetchAllInvitationTokenProvider),
    fetchAllOrders: ref.read(fetchAllOrdersProvider),
    fetchAllUsers: ref.read(fetchAllUsersProvider),
    filterUser: ref.read(filterUserProvider),
    generateUniqueInvitationToken: ref.read(
      generateUniqueInvitationTokenProvider,
    ),
    searchUser: ref.read(searchUserProvider),
    saveInvitationToken: ref.read(saveInvitationTokenProvider),
  );
});

//Admin Dependencies
final tokenGeneratorProvider = Provider<TokenGenerator>((ref) {
  return TokenGenerator();
});

final adminDatasourceProvider = Provider<AdminDatasource>((ref) {
  return AdminDatasourceImpl(
    ref.read(httpClientProvider),
    ref.read(tokenGeneratorProvider),
  );
});

final adminRepoProvider = Provider<AdminRepo>((ref) {
  return AdminRepoImpl(ref.read(adminDatasourceProvider));
});

//Admin Use-cases
final blockAccountProvider = Provider<BlockAccount>((ref) {
  return BlockAccount(ref.read(adminRepoProvider));
});

final changeFarmerBadgeProvider = Provider<ChangeFarmerBadge>((ref) {
  return ChangeFarmerBadge(ref.read(adminRepoProvider));
});

final deleteAccountProvider = Provider<DeleteAccount>((ref) {
  return DeleteAccount(ref.read(adminRepoProvider));
});

final fetchAllInvitationTokenProvider =
Provider<FetchAllInvitationToken>((ref) {
  return FetchAllInvitationToken(ref.read(adminRepoProvider));
});

final fetchAllOrdersProvider = Provider<FetchAllOrders>((ref) {
  return FetchAllOrders(ref.read(adminRepoProvider));
});

final fetchAllUsersProvider = Provider<FetchAllUsers>((ref) {
  return FetchAllUsers(ref.read(adminRepoProvider));
});

final filterUserProvider = Provider<FilterUser>((ref) {
  return FilterUser(ref.read(adminRepoProvider));
});

final generateUniqueInvitationTokenProvider =
Provider<GenerateUniqueInvitationToken>((ref) {
  return GenerateUniqueInvitationToken(ref.read(adminRepoProvider));
});

final searchUserProvider = Provider<SearchUser>((ref) {
  return SearchUser(ref.read(adminRepoProvider));
});

final saveInvitationTokenProvider = Provider<SaveInvitationToken>((ref) {
  return SaveInvitationToken(ref.read(adminRepoProvider));
});
