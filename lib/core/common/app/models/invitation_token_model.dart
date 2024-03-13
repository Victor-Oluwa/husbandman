import 'package:husbandman/core/common/app/entities/invitation_token_entity.dart';

class InvitationTokenModel extends InvitationTokenEntity {
  const InvitationTokenModel({
    required super.id,
    required super.ownerName,
    required super.ownerEmail,
    required super.ownerId,
    required super.assigned,
  });

  factory InvitationTokenModel.fromMap(Map<String, dynamic> map) {
    return InvitationTokenModel(
      id: map['_id'] as String,
      ownerName: map['ownerName'] as String,
      ownerEmail: map['ownerEmail'] as String,
      ownerId: map['ownerId'] as String,
      assigned: map['assigned'] as bool,
    );
  }

  const InvitationTokenModel.empty()
      : this(
          id: 'empty.id',
          ownerName: 'empty.name',
          ownerEmail: 'empty.email',
          ownerId: 'empty.id',
          assigned: false,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'ownerName': ownerName,
      'ownerEmail': ownerEmail,
      'ownerId': ownerId,
      'assigned': assigned,
    };
  }
}
