import 'package:get/get.dart';
import '../controllers/parent_activity_details_controller.dart';

class ParentActivityDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentActivityDetailsController>(
      ParentActivityDetailsController.new,
    );
  }
}
