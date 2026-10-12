import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/roles/parent/manage_caregiver/presentation/controllers/manage_caregiver_controller.dart';

class ManageCaregiverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ManageCaregiverController>(() => ManageCaregiverController());
  }
}
