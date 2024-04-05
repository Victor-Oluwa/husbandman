import 'package:equatable/equatable.dart';

class InvitationTokenEntity extends Equatable {
  const InvitationTokenEntity({
    required this.id,
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerId,
    required this.assigned,
    required this.value,
  });

  factory InvitationTokenEntity.fromMap(Map<String, dynamic> map) {
    return InvitationTokenEntity(
      id: map['_id'] as String,
      ownerName: map['ownerName'] as String,
      ownerEmail: map['ownerEmail'] as String,
      ownerId: map['ownerId'] as String,
      assigned: map['assigned'] as bool,
      value: map['value'] as String,
    );
  }

  const InvitationTokenEntity.empty()
      : this(
          id: 'empty.id',
          ownerName: 'empty.name',
          ownerEmail: 'empty.email',
          ownerId: 'empty.id',
          assigned: false,
          value: 'empty.value',
        );

  final String id;
  final String ownerName;
  final String ownerEmail;
  final String ownerId;
  final bool assigned;
  final String value;

  @override
  List<Object> get props => [ownerEmail];

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerName': ownerName,
      'ownerEmail': ownerEmail,
      'ownerId': ownerId,
      'assigned': assigned,
      'value':value,
    };
  }
}
