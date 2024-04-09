part of 'admin_bloc.dart';

abstract class AdminEvent extends Equatable {
  const AdminEvent();

  @override
  List<dynamic> get props => [];
}

class BlockAccountEvent extends AdminEvent {
  const BlockAccountEvent({required this.accountId});

  final String accountId;

  @override
  List<String> get props => [accountId];
}

class ChangeFarmerBadgeEvent extends AdminEvent {
  const ChangeFarmerBadgeEvent({
    required this.farmerId,
    required this.badge,
  });

  final String farmerId;
  final int badge;

  @override
  List<Object> get props => [farmerId, badge];
}

class DeleteAccountEvent extends AdminEvent {
  const DeleteAccountEvent({required this.userId});

  final String userId;

  @override
  List<String> get props => [userId];
}

class FetchAllOrdersEvent extends AdminEvent {
  const FetchAllOrdersEvent();
}

class FetchAllInvitationTokenEvent extends AdminEvent {
  const FetchAllInvitationTokenEvent();
}

class FetchAllUsersEvent extends AdminEvent {
  const FetchAllUsersEvent();
}

class FilterUserEvent extends AdminEvent {
  const FilterUserEvent({
    required this.property,
    required this.value,
  });

  final FilterUserProperty property;
  final dynamic value;

  @override
  List<dynamic> get props => [property, value];
}

class GenerateUniqueInvitationTokenEvent extends AdminEvent {
  const GenerateUniqueInvitationTokenEvent();
}

class SearchUserEvent extends AdminEvent {
  const SearchUserEvent({
    required this.query,
    required this.property,
  });

  final String query;
  final SearchUserProperty property;

  @override
  List<Object> get props => [query, property];
}

class SaveInvitationTokenEvent extends AdminEvent{
  const SaveInvitationTokenEvent({required this.key});
  final String key;

  @override
  List<String> get props => [key];

}

