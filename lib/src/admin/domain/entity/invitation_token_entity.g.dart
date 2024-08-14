// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_token_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationTokenEntity _$InvitationTokenEntityFromJson(
        Map<String, dynamic> json) =>
    InvitationTokenEntity(
      ownerName: json['ownerName'] as String,
      ownerEmail: json['ownerEmail'] as String,
      ownerId: json['ownerId'] as String,
      assigned: json['assigned'] as bool,
      value: json['value'] as String,
      id: json['_id'] as String? ?? '',
    );

Map<String, dynamic> _$InvitationTokenEntityToJson(
        InvitationTokenEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerName': instance.ownerName,
      'ownerEmail': instance.ownerEmail,
      'ownerId': instance.ownerId,
      'assigned': instance.assigned,
      'value': instance.value,
    };
