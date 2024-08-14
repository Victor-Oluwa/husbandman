// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvitationTokenModel _$InvitationTokenModelFromJson(
        Map<String, dynamic> json) =>
    InvitationTokenModel(
      id: json['_id'] as String? ?? '',
      ownerName: json['ownerName'] as String,
      ownerEmail: json['ownerEmail'] as String,
      ownerId: json['ownerId'] as String,
      assigned: json['assigned'] as bool,
      value: json['value'] as String,
    );

Map<String, dynamic> _$InvitationTokenModelToJson(
        InvitationTokenModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerName': instance.ownerName,
      'ownerEmail': instance.ownerEmail,
      'ownerId': instance.ownerId,
      'assigned': instance.assigned,
      'value': instance.value,
    };
