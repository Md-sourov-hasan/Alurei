import 'package:alurei/src/imports/imports.dart';
import '../controllers/care_module_details_controller.dart';

class CareModuleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CareModuleDetailsController>(
      () => CareModuleDetailsController(),
    );
  }
}
