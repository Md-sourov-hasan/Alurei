import 'package:get/get.dart';

import '../../data/repositories/parent_message_repository_impl.dart';
import '../../domain/repositories/parent_message_repository.dart';
import '../controllers/parent_message_thread_controller.dart';

class ParentMessageThreadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentMessageRepository>(
      () => ParentMessageRepositoryImpl(),
    );

    Get.lazyPut<ParentMessageThreadController>(
      () => ParentMessageThreadController(
        repository: Get.find<ParentMessageRepository>(),
      ),
    );
  }
}
