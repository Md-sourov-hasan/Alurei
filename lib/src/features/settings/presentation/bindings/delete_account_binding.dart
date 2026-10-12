import '../../../../imports/imports.dart';
import '../../data/repositories/settings_repository_impl.dart';
import '../../domain/repositories/settings_repository.dart';
import '../controllers/delete_account_controller.dart';

class DeleteAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsRepository>(
      SettingsRepositoryImpl.new,
    );
    Get.lazyPut<DeleteAccountController>(
      () => DeleteAccountController(repository: Get.find()),
    );
  }
}
