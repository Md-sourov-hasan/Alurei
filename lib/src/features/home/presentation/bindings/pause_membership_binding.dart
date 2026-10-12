import 'package:alurei/src/imports/imports.dart';
import '../controllers/pause_membership_controller.dart';

class PauseMembershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PauseMembershipController());
  }
}
