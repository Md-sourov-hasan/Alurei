import 'package:alurei/src/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:alurei/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:alurei/src/features/settings/presentation/controllers/change_password_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(
      SettingsRepositoryImpl.new,
    );
    Get.lazyPut<ChangePasswordController>(
      () => ChangePasswordController(repository: Get.find()),
    );
  }
}
