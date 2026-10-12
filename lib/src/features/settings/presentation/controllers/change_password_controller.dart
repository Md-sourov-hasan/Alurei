import 'package:alurei/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:alurei/src/imports/imports.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController({
    required SettingsRepository repository,
  }) : _repository = repository;

  final SettingsRepository _repository;

  final changePasswordFormKey = GlobalKey<FormState>();
  final changePasswordCurrentController = TextEditingController();
  final changePasswordNewController = TextEditingController();
  final changePasswordConfirmController = TextEditingController();

  final obscureCurrentPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;

  final changePasswordHas8Chars = false.obs;
  final changePasswordHasSpecialChar = false.obs;
  final changePasswordHasNumber = false.obs;
  final changePasswordPasswordsMatch = false.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    changePasswordNewController.addListener(_validateRequirements);
    changePasswordConfirmController.addListener(_validateRequirements);
  }

  void toggleObscureCurrentPassword() {
    obscureCurrentPassword.value = !obscureCurrentPassword.value;
  }

  void toggleObscureNewPassword() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void _validateRequirements() {
    final newPassword = changePasswordNewController.text;
    final confirmPassword = changePasswordConfirmController.text;

    changePasswordHas8Chars.value = newPassword.length >= 8;
    changePasswordHasSpecialChar.value =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPassword);
    changePasswordHasNumber.value = RegExp(r'[0-9]').hasMatch(newPassword);
    changePasswordPasswordsMatch.value =
        newPassword.isNotEmpty && newPassword == confirmPassword;
  }

  Future<void> saveNewPassword(BuildContext context) async {
    if (!(changePasswordFormKey.currentState?.validate() ?? false)) return;

    if (!changePasswordHas8Chars.value ||
        !changePasswordHasSpecialChar.value ||
        !changePasswordHasNumber.value ||
        !changePasswordPasswordsMatch.value) {
      showGlobalToast(
        message: LangKey.changePasswordScreen.passwordsDoNotMatch,
        status: 'error',
      );
      return;
    }

    isLoading.value = true;
    AppLogger.info('Submitting change password request');
    final result = await _repository.changePassword(
      currentPassword: changePasswordCurrentController.text,
      newPassword: changePasswordNewController.text,
    );
    isLoading.value = false;

    result.fold(
      (failure) {
        AppLogger.warning('Change password failed: ${failure.runtimeType}');
        showGlobalToast(message: failure.message, status: 'error');
      },
      (message) {
        _clearForm();
        showGlobalToast(message: message);
        Get.back<void>();
      },
    );
  }

  void _clearForm() {
    changePasswordCurrentController.clear();
    changePasswordNewController.clear();
    changePasswordConfirmController.clear();
  }

  @override
  void onClose() {
    changePasswordNewController.removeListener(_validateRequirements);
    changePasswordConfirmController.removeListener(_validateRequirements);
    changePasswordCurrentController.dispose();
    changePasswordNewController.dispose();
    changePasswordConfirmController.dispose();
    super.onClose();
  }
}
