import 'package:get/get.dart';
import '../../../auth/presentation/providers/session_controller.dart';
import '../../../roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';

/// Owns the selected destination for the authenticated role's main shell.
class RoleMainController extends GetxController {
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments;
    if (arguments is Map && arguments['initial_index'] is int) {
      selectDestination(arguments['initial_index'] as int);
    }
    if (Get.isRegistered<SessionController>()) {
      Get.find<SessionController>().fetchUserProfile();
    }
  }

  void selectDestination(int index) {
    if (index < 0 || index > 4) return;
    selectedIndex.value = index;

    if (index == 1 && Get.isRegistered<BaseKitchenController>()) {
      Get.find<BaseKitchenController>().reloadOnTabSelected();
    }
  }
}
