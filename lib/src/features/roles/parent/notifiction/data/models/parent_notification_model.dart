import '../../domain/entities/parent_notification_entity.dart';

class ParentNotificationModel extends ParentNotificationEntity {
  const ParentNotificationModel({
    required super.id,
    required super.title,
    required super.timeAgo,
    required super.description,
    required super.section,
    required super.type,
    super.actionText,
    super.actionStyle,
    super.isUnread,
    super.avatarAsset,
    super.badgeBgColor,
    super.badgeIconColor,
    super.actionColor,
  });
}
