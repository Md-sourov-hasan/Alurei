import 'package:alurei/src/imports/imports.dart';

class CancelMembershipController extends GetxController {
  final selectedReason = ''.obs;
  final TextEditingController detailsController = TextEditingController();

  void selectReason(String reason) {
    selectedReason.value = reason;
  }

  void onContinue() {
    if (selectedReason.value.isEmpty) {
      showGlobalToast(message: LangKey.membership.pleaseSelectReason);
      return;
    }
    Get.toNamed<dynamic>(AppRoutes.cancelMembershipConfirm);
  }

  void onConfirmCancellation() {
    Get.toNamed<dynamic>(AppRoutes.cancelMembershipSuccess);
  }

  void onKeepMembership() {
    Get.back<void>();
    Get.back<void>();
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
