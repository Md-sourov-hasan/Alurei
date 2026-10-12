import 'package:get/get.dart';

import '../controllers/ai_setup_guide_controller.dart';

class AiSetupGuideBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<AiSetupGuideController>(AiSetupGuideController.new);
}
