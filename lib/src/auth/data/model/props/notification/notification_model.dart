import 'package:husbandman/src/auth/domain/entity/user/props/notification/notification_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class NotificationModel extends NotificationEntity {
  NotificationModel({
    required super.id,
    required super.ownerId,
    required super.unread,
    required List<ChildNotificationModel> super.childNotification,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

@JsonSerializable()
class ChildNotificationModel extends ChildNotificationEntity {
  ChildNotificationModel({
    required super.id,
    required super.subject,
    required super.message,
    required super.timeSent,
    required super.isRead,
  });

  factory ChildNotificationModel.fromJson(Map<String, dynamic> json) =>
      _$ChildNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChildNotificationModelToJson(this);
}
