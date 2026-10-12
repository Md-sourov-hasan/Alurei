import 'package:get/get.dart';

import '../../data/repositories/parent_ai_repository_impl.dart';
import '../../domain/repositories/parent_ai_repository.dart';
import '../controllers/parent_ai_controller.dart';

class ParentAiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentAiRepository>(ParentAiRepositoryImpl.new);
    Get.lazyPut<ParentAiController>(
      () => ParentAiController(Get.find<ParentAiRepository>()),
    );
  }
}
