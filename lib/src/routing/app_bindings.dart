import 'package:get/get.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';

import 'package:alurei/src/features/role_selection/presentation/providers/role_selection_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(),
      fenix: true,
    );
    Get.put<SessionController>(
      SessionController(repository: Get.find<AuthRepository>()),
      permanent: true,
    );
    Get.lazyPut<AuthController>(
      () => AuthController(repository: Get.find<AuthRepository>()),
      fenix: true,
    );
    Get.lazyPut<RoleSelectionController>(
      () => RoleSelectionController(),
      fenix: true,
    );
  }
}
