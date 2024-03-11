import 'package:equatable/equatable.dart';

class InvitationTokenEntity extends Equatable {
  const InvitationTokenEntity({
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerId,
    required this.assigned,
  });

  const InvitationTokenEntity.empty()
      : this(
          ownerName: 'empty.name',
          ownerEmail: 'empty.email',
          ownerId: 'empty.id',
          assigned: false,
        );

  final String ownerName;
  final String ownerEmail;
  final String ownerId;
  final bool assigned;

  @override
  List<Object> get props => [ownerEmail];
}
