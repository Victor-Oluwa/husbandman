// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationEntity _$NotificationEntityFromJson(Map<String, dynamic> json) =>
    NotificationEntity(
      id: json['_id'] as String,
      ownerId: json['ownerId'] as String,
      unread: (json['unread'] as num).toInt(),
      childNotification: (json['childNotification'] as List<dynamic>)
          .map((e) =>
              ChildNotificationEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationEntityToJson(NotificationEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'unread': instance.unread,
      'childNotification':
          instance.childNotification.map((e) => e.toJson()).toList(),
    };

ChildNotificationEntity _$ChildNotificationEntityFromJson(
        Map<String, dynamic> json) =>
    ChildNotificationEntity(
      id: json['_id'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      timeSent: json['timeSent'] as String,
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$ChildNotificationEntityToJson(
        ChildNotificationEntity instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subject': instance.subject,
      'message': instance.message,
      'timeSent': instance.timeSent,
      'isRead': instance.isRead,
    };
