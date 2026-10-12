import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class ParentSignupController extends GetxController {
  static ParentSignupController get instance =>
      Get.find<ParentSignupController>();

  final currentStep = 0.obs;

  // Form keys
  final formKey = GlobalKey<FormState>();
  final addressFormKey = GlobalKey<FormState>();

  // Text controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final relationshipController = TextEditingController(text: 'Father');
  final languageController = TextEditingController(text: 'English (EN)');

  // Step 2 controllers
  final addressController = TextEditingController();
  final streetController = TextEditingController();
  final postalCodeController = TextEditingController();
  final cityController = TextEditingController();
  final stateController = TextEditingController();
  final phoneController = TextEditingController();

  // States
  final otpOption = 'E-mail'.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;
  final profileImage = Rx<File?>(null);

  // Dropdown field keys for overlays
  final relationshipFieldKey = GlobalKey();
  final languageFieldKey = GlobalKey();

  void nextStep() {
    currentStep.value += 1;
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value -= 1;
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void setOtpOption(String option) {
    otpOption.value = option;
  }

  void setProfileImage(File file) {
    profileImage.value = file;
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    relationshipController.dispose();
    languageController.dispose();
    addressController.dispose();
    streetController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    stateController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
