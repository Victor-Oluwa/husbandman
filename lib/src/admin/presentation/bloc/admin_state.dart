part of 'admin_bloc.dart';

abstract class AdminState extends Equatable {
  const AdminState();

  @override
  List<Object> get props => [];
}

class AdminInitial extends AdminState {
  const AdminInitial();
}

class AdminLoading extends AdminState {
  const AdminLoading();
}

class AccountBlocked extends AdminState {
  const AccountBlocked();
}

class ChangedFarmerBadge extends AdminState {
  const ChangedFarmerBadge();
}

class AccountDeleted extends AdminState {
  const AccountDeleted();
}

class FetchedInvitationToken extends AdminState {
  const FetchedInvitationToken(this.tokens);

  final List<InvitationTokenEntity> tokens;

  @override
  List<Object> get props => [tokens];
}

class FetchedAllUsers extends AdminState {
  const FetchedAllUsers(this.users);

  final List<DataMap> users;

  @override
  List<Object> get props => [users];
}

class FilteredUser extends AdminState {
  const FilteredUser(this.users);

  final List<DataMap> users;

  @override
  List<Object> get props => [users];
}

class InvitationTokenGenerated extends AdminState {
  const InvitationTokenGenerated(this.token);

  final String token;

  @override
  List<String> get props => [token];
}

class FoundUsers extends AdminState {
  const FoundUsers(this.users);

  final List<DataMap> users;

  @override
  List<Object> get props => [users];
}

class InvitationTokenSaved extends AdminState{
   const InvitationTokenSaved();
}

class SavingInvitationToken extends AdminState{
  const SavingInvitationToken();
}

class AdminError extends AdminState{
  const AdminError(this.message);

  final String message;

  @override
  List<String> get props => [message];
}
