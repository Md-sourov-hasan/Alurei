import 'package:alurei/src/features/edit_profile/data/repositories/edit_profile_repository_impl.dart';
import 'package:alurei/src/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:alurei/src/features/edit_profile/presentation/controllers/edit_profile_controller.dart';
import 'package:get/get.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileRepository>(EditProfileRepositoryImpl.new);
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        repository: Get.find<EditProfileRepository>(),
      ),
    );
  }
}
