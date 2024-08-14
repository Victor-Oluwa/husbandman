

import 'package:json_annotation/json_annotation.dart';

part 'notification_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationEntity {
 const NotificationEntity({
    required this.id,
    required this.ownerId,
    required this.unread,
    required this.childNotification,
  });

  const NotificationEntity.empty()
      : id = '',
        ownerId = '',
        unread = 0,
        childNotification = const[];

  factory NotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$NotificationEntityFromJson(json);

  @JsonKey(name: '_id')
  final String id;
  final String ownerId;
  final int unread;
  final List<ChildNotificationEntity> childNotification;

  Map<String, dynamic> toJson() => _$NotificationEntityToJson(this);
}

@JsonSerializable()
class ChildNotificationEntity {
  ChildNotificationEntity({
    required this.id,
    required this.subject,
    required this.message,
    required this.timeSent,
    required this.isRead,
  });

  factory ChildNotificationEntity.fromJson(Map<String, dynamic> json) =>
      _$ChildNotificationEntityFromJson(json);

  ChildNotificationEntity.empty()
      : id = '',
        subject = '',
        message = '',
        timeSent = '',
        isRead = false;

  @JsonKey(name: '_id')
  final String id;
  final String subject;
  final String message;
  final String timeSent;
  final bool isRead;

  Map<String, dynamic> toJson() => _$ChildNotificationEntityToJson(this);
}
