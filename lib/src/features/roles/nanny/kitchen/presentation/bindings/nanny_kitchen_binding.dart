import 'package:alurei/src/features/roles/parent/kitchen_recepi/presentation/controllers/base_kitchen_controller.dart';
import 'package:alurei/src/imports/imports.dart';
import '../controllers/nanny_kitchen_controller.dart';

class NannyKitchenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NannyKitchenController>(() => NannyKitchenController());
    Get.lazyPut<BaseKitchenController>(() => Get.find<NannyKitchenController>());
  }
}
