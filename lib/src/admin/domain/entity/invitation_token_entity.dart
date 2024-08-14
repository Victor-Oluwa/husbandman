import 'package:equatable/equatable.dart';
import 'package:husbandman/core/utils/typedef.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitation_token_entity.g.dart';

@JsonSerializable()
class InvitationTokenEntity extends Equatable {
  const InvitationTokenEntity({
    required this.ownerName,
    required this.ownerEmail,
    required this.ownerId,
    required this.assigned,
    required this.value,
    this.id = '',
  });

  const InvitationTokenEntity.empty()
      : this(
          id: 'empty.id',
          ownerName: 'empty.name',
          ownerEmail: 'empty.email',
          ownerId: 'empty.id',
          assigned: false,
          value: 'empty.value',
        );

  factory InvitationTokenEntity.fromJson(DataMap json) =>
      _$InvitationTokenEntityFromJson(json);

  DataMap toJson() => _$InvitationTokenEntityToJson(this);

  @JsonKey(name: '_id')
  final String id;
  final String ownerName;
  final String ownerEmail;
  final String ownerId;
  final bool assigned;
  final String value;

  @override
  List<Object> get props => [ownerEmail];
}
