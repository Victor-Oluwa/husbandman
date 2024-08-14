import 'package:husbandman/core/utils/typedef.dart';
import 'package:husbandman/src/admin/domain/entity/invitation_token_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitation_token_model.g.dart';

@JsonSerializable()
class InvitationTokenModel extends InvitationTokenEntity {
  const InvitationTokenModel({
    required super.id,
    required super.ownerName,
    required super.ownerEmail,
    required super.ownerId,
    required super.assigned,
    required super.value,
  });

  factory InvitationTokenModel.fromJson(DataMap json) =>
      _$InvitationTokenModelFromJson(json);

  const InvitationTokenModel.empty()
      : this(
          id: 'empty.id',
          ownerName: 'empty.name',
          ownerEmail: 'empty.email',
          ownerId: 'empty.id',
          assigned: false,
          value: 'empty.value',
        );

  @override
  DataMap toJson() => _$InvitationTokenModelToJson(this);
}






