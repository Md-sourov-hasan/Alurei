import 'package:get/get.dart';

import '../../data/repositories/language_repository_impl.dart';
import '../../domain/repositories/language_repository.dart';
import '../controllers/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageRepository>(
      LanguageRepositoryImpl.new,
    );
    Get.lazyPut<LanguageController>(
      () => LanguageController(repository: Get.find()),
    );
  }
}
