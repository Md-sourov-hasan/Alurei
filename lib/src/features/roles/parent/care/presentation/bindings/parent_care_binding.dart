import 'package:get/get.dart';
import '../controllers/parent_care_controller.dart';

class ParentCareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentCareController>(ParentCareController.new);
  }
}
