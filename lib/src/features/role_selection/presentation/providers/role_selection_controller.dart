import 'package:alurei/src/imports/imports.dart';

class RoleSelectionController extends GetxController {
  Future<void> selectRole(String role) async {
    // Show the full-screen loading overlay (Figma node 23523:62579)
    AppLoadingOverlay.show();

    // Simulate a brief loading period before navigating
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    // Hide the overlay and navigate to login
    AppLoadingOverlay.hide();
    Get.toNamed<dynamic>(AppRoutes.login, arguments: {'role': role});
  }
}
