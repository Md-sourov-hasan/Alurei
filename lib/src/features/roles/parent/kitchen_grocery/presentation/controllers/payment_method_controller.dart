import 'package:alurei/src/imports/imports.dart';

class PaymentMethodController extends GetxController {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardholderNameController = TextEditingController();

  final RxInt defaultCardIndex = 0.obs;

  void setDefaultCard(int index) {
    defaultCardIndex.value = index;
  }

  void onConfirmOrder() {
    // if (cardNumberController.text.trim().isEmpty ||
    //     expiryDateController.text.trim().isEmpty ||
    //     cvvController.text.trim().isEmpty ||
    //     cardholderNameController.text.trim().isEmpty) {
    //   showGlobalToast(message: LangKey.parentKitchen.pleaseFillCardDetails);
    //   return;
    // }
    
    // Proceed to confirm order logic
    Get.toNamed<void>(AppRoutes.orderConfirmed);
  }

  @override
  void onClose() {
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    cardholderNameController.dispose();
    super.onClose();
  }
}
