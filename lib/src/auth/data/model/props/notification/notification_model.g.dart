// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['_id'] as String,
      ownerId: json['ownerId'] as String,
      unread: (json['unread'] as num).toInt(),
      childNotification: (json['childNotification'] as List<dynamic>)
          .map(
              (e) => ChildNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'unread': instance.unread,
      'childNotification':
          instance.childNotification.map((e) => e.toJson()).toList(),
    };

ChildNotificationModel _$ChildNotificationModelFromJson(
        Map<String, dynamic> json) =>
    ChildNotificationModel(
      id: json['_id'] as String,
      subject: json['subject'] as String,
      message: json['message'] as String,
      timeSent: json['timeSent'] as String,
      isRead: json['isRead'] as bool,
    );

Map<String, dynamic> _$ChildNotificationModelToJson(
        ChildNotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'subject': instance.subject,
      'message': instance.message,
      'timeSent': instance.timeSent,
      'isRead': instance.isRead,
    };
