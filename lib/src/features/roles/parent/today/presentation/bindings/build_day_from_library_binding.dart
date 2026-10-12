import 'package:alurei/src/features/roles/parent/today/presentation/controllers/build_day_from_library_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class BuildDayFromLibraryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BuildDayFromLibraryController>(
      () => BuildDayFromLibraryController(),
    );
  }
}
