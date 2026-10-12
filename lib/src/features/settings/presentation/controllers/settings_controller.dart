import '../../../../imports/imports.dart';

class SettingsController extends GetxController {
  void onChangePasswordPressed() {
    Get.toNamed<dynamic>(AppRoutes.changePassword);
  }

  void onDeleteAccountPressed() {
    Get.toNamed<dynamic>(AppRoutes.deleteAccount);
  }
}
