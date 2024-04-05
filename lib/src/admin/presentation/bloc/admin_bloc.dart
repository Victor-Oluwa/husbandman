import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';
import 'package:husbandman/core/common/app/entities/order_entity.dart';
import 'package:husbandman/core/enums/filter_user.dart';
import 'package:husbandman/core/enums/search_user.dart';
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
import 'package:husbandman/src/auth/domain/entity/user_entity.dart';

part 'admin_event.dart';

part 'admin_state.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc({
    required BlockAccount blockAccount,
    required ChangeFarmerBadge changeFarmerBadge,
    required DeleteAccount deleteAccount,
    required FetchAllInvitationToken fetchAllInvitationToken,
    required FetchAllOrders fetchAllOrders,
    required FetchAllUsers fetchAllUsers,
    required FilterUser filterUser,
    required GenerateUniqueInvitationToken generateUniqueInvitationToken,
    required SearchUser searchUser,
    required SaveInvitationToken saveInvitationToken,
  })  : _blockAccount = blockAccount,
        _changeFarmerBadge = changeFarmerBadge,
        _deleteAccount = deleteAccount,
        _fetchAllInvitationToken = fetchAllInvitationToken,
        _fetchAllOrders = fetchAllOrders,
        _fetchAllUsers = fetchAllUsers,
        _filterUser = filterUser,
        _generateUniqueInvitationToken = generateUniqueInvitationToken,
        _searchUser = searchUser,
        _saveInvitationToken = saveInvitationToken,
        super(const AdminInitial()) {
    on<AdminEvent>((event, emit) {
      emit(const AdminLoading());
    });

    on<BlockAccountEvent>(_blockAccountHandler);
    on<ChangeFarmerBadgeEvent>(_changeFarmerBadgeHandler);
    on<DeleteAccountEvent>(_deleteAccountHandler);
    on<FetchAllInvitationTokenEvent>(_fetchAllInvitationTokenHandler);
    on<FetchAllOrdersEvent>(_fetchAllOrdersHandler);
    on<FetchAllUsersEvent>(_fetchAllUsersHandler);
    on<FilterUserEvent>(_filterUserHandler);
    on<GenerateUniqueInvitationTokenEvent>(
      _generateUniqueInvitationTokenHandler,
    );
    on<SearchUserEvent>(_searchUserHandler);
    on<SaveInvitationTokenEvent>(_saveInvitationTokenHandler);
  }

  final BlockAccount _blockAccount;
  final ChangeFarmerBadge _changeFarmerBadge;
  final DeleteAccount _deleteAccount;
  final FetchAllInvitationToken _fetchAllInvitationToken;
  final FetchAllOrders _fetchAllOrders;
  final FetchAllUsers _fetchAllUsers;
  final FilterUser _filterUser;
  final GenerateUniqueInvitationToken _generateUniqueInvitationToken;
  final SearchUser _searchUser;
  final SaveInvitationToken _saveInvitationToken;

  Future<void> _blockAccountHandler(
    BlockAccountEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _blockAccount(event.accountId);

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        const AccountBlocked(),
      ),
    );
  }

  Future<void> _changeFarmerBadgeHandler(
    ChangeFarmerBadgeEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _changeFarmerBadge(
      ChangeFarmerBadgeParams(
        farmerId: event.farmerId,
        badge: event.badge,
      ),
    );

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        const ChangedFarmerBadge(),
      ),
    );
  }

  Future<void> _deleteAccountHandler(
    DeleteAccountEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _deleteAccount(event.userId);

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(const AccountDeleted()),
    );
  }

  Future<void> _fetchAllInvitationTokenHandler(
    FetchAllInvitationTokenEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _fetchAllInvitationToken();

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        FetchedInvitationToken(r),
      ),
    );
  }

  Future<void> _fetchAllOrdersHandler(
    FetchAllOrdersEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _fetchAllOrders();

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        FetchedOrders(r),
      ),
    );
  }

  Future<void> _fetchAllUsersHandler(
    FetchAllUsersEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _fetchAllUsers();

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        FetchedAllUsers(r),
      ),
    );
  }

  Future<void> _filterUserHandler(
    FilterUserEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _filterUser(
      FilterUserParams(
        property: event.property,
        value: event.value,
      ),
    );

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(FilteredUser(r)),
    );
  }

  Future<void> _generateUniqueInvitationTokenHandler(
    GenerateUniqueInvitationTokenEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _generateUniqueInvitationToken();

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        InvitationTokenGenerated(r),
      ),
    );
  }

  Future<void> _searchUserHandler(
    SearchUserEvent event,
    Emitter<AdminState> emit,
  ) async {
    final result = await _searchUser(
      SearchUserParams(
        query: event.query,
        property: event.property,
      ),
    );

    result.fold(
      (l) => emit(AdminError(l.errorMessage)),
      (r) => emit(
        FoundUsers(r),
      ),
    );
  }

  Future<void> _saveInvitationTokenHandler(
    SaveInvitationTokenEvent event,
    Emitter<AdminState> emit,
  ) async {
    emit(const SavingInvitationToken());
    final result = await _saveInvitationToken(event.token);

    result.fold(
      (l) => AdminError(l.errorMessage),
      (_) => const InvitationTokenSaved(),
    );
  }
}
