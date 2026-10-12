import 'package:flutter/material.dart';

import '../../features/roles/parent/notifiction/data/models/parent_notification_model.dart';
import '../../features/roles/parent/notifiction/domain/entities/parent_notification_entity.dart';
import '../app_assets.dart';
import '../../theme/app_colors.dart';

abstract final class ParentNotificationDummyData {
  ParentNotificationDummyData._();

  static List<ParentNotificationModel> getNotifications() {
    return const [
      // TODAY SECTION
      ParentNotificationModel(
        id: 'notif_1',
        title: 'Language Activity Completed',
        timeAgo: '10 mins ago',
        description:
            "Deepa completed today's language learning session with Eve.",
        section: NotificationSection.today,
        type: NotificationType.activity,
        actionText: 'View Activity',
        actionStyle: NotificationActionStyle.link,
        badgeBgColor: Color(0x1A017D2D),
        badgeIconColor: Color(0xFF017D2D),
      ),
      ParentNotificationModel(
        id: 'notif_2',
        title: 'Lunch Completed',
        timeAgo: '35 mins ago',
        description:
            "Eve enjoyed today's vegetable pasta and finished 90% of her meal.",
        section: NotificationSection.today,
        type: NotificationType.meal,
        actionText: 'View Nutrition',
        actionStyle: NotificationActionStyle.link,
        badgeBgColor: Color(0x1A60CDFF),
        badgeIconColor: Color(0xFF0288D1),
      ),
      ParentNotificationModel(
        id: 'notif_3',
        title: 'New Message from Deepa',
        timeAgo: '1h ago',
        description: '"I\'ve uploaded today\'s activity photos."',
        section: NotificationSection.today,
        type: NotificationType.message,
        actionText: 'Open Chat',
        actionStyle: NotificationActionStyle.filledButton,
        isUnread: true,
        badgeBgColor: Color(0x1A0B5460),
        badgeIconColor: AppColors.primaryColor,
      ),
      ParentNotificationModel(
        id: 'notif_4',
        title: 'Your Grocery Order Has Arrived',
        timeAgo: '2h ago',
        description:
            'Carrefour has successfully delivered your grocery order.',
        section: NotificationSection.today,
        type: NotificationType.grocery,
        actionText: 'View Order',
        actionStyle: NotificationActionStyle.link,
        actionColor: AppColors.disabledTextColor,
        badgeBgColor: AppColors.bottomNavSelectedBackground,
        badgeIconColor: AppColors.primaryColor,
      ),

      // THIS WEEK SECTION
      ParentNotificationModel(
        id: 'notif_5',
        title: 'New Story Saved',
        timeAgo: '3 days ago',
        description:
            '"Dinosaur Adventure" has been added to Eve\'s bedtime library.',
        section: NotificationSection.thisWeek,
        type: NotificationType.story,
        actionText: 'Read Story',
        actionStyle: NotificationActionStyle.link,
        badgeBgColor: Color(0x3391F999),
        badgeIconColor: Color(0xFF17B26A),
      ),
      ParentNotificationModel(
        id: 'notif_6',
        title: 'Care Module Completed',
        timeAgo: 'Yesterday',
        description: 'Deepa successfully completed "Safe Baby Handling."',
        section: NotificationSection.thisWeek,
        type: NotificationType.care,
        actionText: 'View Progress',
        actionStyle: NotificationActionStyle.link,
        badgeBgColor: Color(0x4DC1E8FF),
        badgeIconColor: Color(0xFF0288D1),
      ),
      ParentNotificationModel(
        id: 'notif_7',
        title: 'Invitation Accepted',
        timeAgo: '2 days ago',
        description: "Rose has joined Eve's Care Team as Grandmother.",
        section: NotificationSection.thisWeek,
        type: NotificationType.invitation,
        actionText: 'Manage Access',
        actionStyle: NotificationActionStyle.outlinedButton,
        avatarAsset: AppAssets.parentTodayParentAvatar,
      ),

      // OLDER SECTION
      ParentNotificationModel(
        id: 'notif_8',
        title: 'New Partner Offer Available',
        timeAgo: 'Last Week',
        description:
            'Redeem 300 ALR for AED 30 off your next Carrefour grocery order.',
        section: NotificationSection.older,
        type: NotificationType.offer,
        actionText: 'View Offer',
        actionStyle: NotificationActionStyle.link,
        actionColor: AppColors.warning500,
        badgeBgColor: Color(0x66FFDAD6),
        badgeIconColor: Color(0xFFDC6803),
      ),
      ParentNotificationModel(
        id: 'notif_9',
        title: 'Weekly Care Insight Ready',
        timeAgo: 'Last Week',
        description:
            "Alurei AI has prepared Eve's personalized weekly care summary.",
        section: NotificationSection.older,
        type: NotificationType.aiInsight,
        actionText: 'View Insights',
        actionStyle: NotificationActionStyle.link,
        badgeBgColor: Color(0x4DC1E8FF),
        badgeIconColor: AppColors.primaryColor,
      ),
    ];
  }
}
