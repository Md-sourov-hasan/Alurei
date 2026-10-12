import 'package:flutter/material.dart';

enum NotificationSection {
  today,
  thisWeek,
  older,
}

enum NotificationActionStyle {
  link,
  filledButton,
  outlinedButton,
}

enum NotificationType {
  activity,
  meal,
  message,
  grocery,
  story,
  care,
  invitation,
  offer,
  aiInsight,
}

class ParentNotificationEntity {
  const ParentNotificationEntity({
    required this.id,
    required this.title,
    required this.timeAgo,
    required this.description,
    required this.section,
    required this.type,
    this.actionText,
    this.actionStyle = NotificationActionStyle.link,
    this.isUnread = false,
    this.avatarAsset,
    this.badgeBgColor,
    this.badgeIconColor,
    this.actionColor,
  });

  final String id;
  final String title;
  final String timeAgo;
  final String description;
  final NotificationSection section;
  final NotificationType type;
  final String? actionText;
  final NotificationActionStyle actionStyle;
  final bool isUnread;
  final String? avatarAsset;
  final Color? badgeBgColor;
  final Color? badgeIconColor;
  final Color? actionColor;
}
