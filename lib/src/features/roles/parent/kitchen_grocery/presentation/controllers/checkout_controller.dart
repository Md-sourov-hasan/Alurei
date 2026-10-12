import 'package:alurei/src/imports/imports.dart';

class CheckoutController extends GetxController {
  // 0: Pay Now (Online), 1: Cash on Delivery
  final RxInt selectedPaymentMethod = 0.obs;

  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  void onPayNow() {
    Get.toNamed<void>(AppRoutes.paymentMethod);
  }

  void onConfirmOrder() {
    Get.toNamed<void>(AppRoutes.orderConfirmed);
  }
}
