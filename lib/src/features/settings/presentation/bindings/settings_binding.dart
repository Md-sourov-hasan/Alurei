import '../../../../imports/imports.dart';
import '../controllers/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(SettingsController.new);
  }
}
