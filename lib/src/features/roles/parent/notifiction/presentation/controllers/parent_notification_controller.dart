import 'package:get/get.dart';

import '../../../../../../shared/dummy_data/parent_notification_dummy_data.dart';
import '../../domain/entities/parent_notification_entity.dart';

class ParentNotificationController extends GetxController {
  final RxList<ParentNotificationEntity> notifications =
      <ParentNotificationEntity>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    notifications.assignAll(ParentNotificationDummyData.getNotifications());
  }

  List<ParentNotificationEntity> get todayNotifications => notifications
      .where((item) => item.section == NotificationSection.today)
      .toList();

  List<ParentNotificationEntity> get thisWeekNotifications => notifications
      .where((item) => item.section == NotificationSection.thisWeek)
      .toList();

  List<ParentNotificationEntity> get olderNotifications => notifications
      .where((item) => item.section == NotificationSection.older)
      .toList();

  void onNotificationActionTap(ParentNotificationEntity item) {
    switch (item.type) {
      case NotificationType.message:
        Get.toNamed('/parent/ai');
        break;
      case NotificationType.offer:
        Get.toNamed('/parent/my-offer');
        break;
      default:
        // Handle action navigation or details display
        break;
    }
  }
}
