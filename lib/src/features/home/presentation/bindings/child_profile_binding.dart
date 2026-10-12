import 'package:alurei/src/imports/imports.dart';
import '../controllers/child_profile_controller.dart';

class ChildProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChildProfileController());
  }
}
