import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:get/get.dart';

import '../controllers/parent_kitchen_controller.dart';

class ParentKitchenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentKitchenController>(ParentKitchenController.new);
    Get.lazyPut<BaseKitchenController>(() => Get.find<ParentKitchenController>());
  }
}
