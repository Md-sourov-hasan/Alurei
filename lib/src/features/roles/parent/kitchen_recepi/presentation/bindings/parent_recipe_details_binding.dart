import 'package:get/get.dart';
import '../controllers/parent_recipe_details_controller.dart';

class ParentRecipeDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentRecipeDetailsController>(
        ParentRecipeDetailsController.new);
  }
}
