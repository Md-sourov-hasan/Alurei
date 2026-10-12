import 'package:alurei/src/imports/imports.dart';
import '../controllers/cancel_membership_controller.dart';

class CancelMembershipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CancelMembershipController());
  }
}
