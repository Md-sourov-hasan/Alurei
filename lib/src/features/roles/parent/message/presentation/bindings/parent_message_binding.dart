import 'package:get/get.dart';

import '../../data/repositories/parent_message_repository_impl.dart';
import '../../domain/repositories/parent_message_repository.dart';
import '../controllers/parent_message_controller.dart';

class ParentMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentMessageRepository>(() => ParentMessageRepositoryImpl());
    Get.lazyPut<ParentMessageController>(
      () => ParentMessageController(
        repository: Get.find<ParentMessageRepository>(),
      ),
    );
  }
}
