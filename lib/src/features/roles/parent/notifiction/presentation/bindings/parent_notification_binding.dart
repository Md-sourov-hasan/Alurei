import 'package:get/get.dart';

import '../controllers/parent_notification_controller.dart';

class ParentNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentNotificationController>(
      () => ParentNotificationController(),
    );
  }
}
