import 'package:get/get.dart';
import '../controllers/edit_child_profile_controller.dart';

class EditChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditChildProfileController>(
      () => EditChildProfileController(),
    );
  }
}
