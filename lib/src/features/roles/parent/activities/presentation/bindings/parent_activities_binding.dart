import 'package:get/get.dart';
import '../controllers/parent_activities_controller.dart';

class ParentActivitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentActivitiesController>(
      ParentActivitiesController.new,
      fenix: true,
    );
  }
}
