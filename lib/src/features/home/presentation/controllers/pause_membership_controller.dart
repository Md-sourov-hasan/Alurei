import 'package:alurei/src/imports/imports.dart';

class PauseMembershipController extends GetxController {
  final selectedDuration = LangKey.membership.twoWeeks.obs;

  void selectDuration(String duration) {
    selectedDuration.value = duration;
  }

  void onPauseSubscriptions() {
    Get.toNamed<dynamic>(AppRoutes.pauseMembershipSuccess);
  }
}
