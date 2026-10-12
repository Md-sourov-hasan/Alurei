import 'package:alurei/src/features/home/data/repositories/home_repository_impl.dart';
import 'package:alurei/src/features/home/domain/repositories/home_repository.dart';
import 'package:alurei/src/features/home/presentation/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<HomeRepository>()) {
      Get.lazyPut<HomeRepository>(HomeRepositoryImpl.new);
    }
    if (!Get.isRegistered<HomeController>()) {
      Get.lazyPut<HomeController>(
        () => HomeController(repository: Get.find<HomeRepository>()),
      );
    }
  }
}
