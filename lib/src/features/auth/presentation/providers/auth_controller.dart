import 'dart:async';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';

class AuthController extends GetxController {
  final AuthRepository _repository;

  AuthController({required AuthRepository repository})
      : _repository = repository;

  final isLoading = false.obs;

  // Login Screen
  final loginFormKey = GlobalKey<FormState>();
  final loginPhoneOrEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final obscurePassword = true.obs;

  // Forgot Password / Phone Screen
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final forgotPasswordPhoneController = TextEditingController();
  final selectedOtpOption = 'phone'.obs;

  // Verify Code Screen
  final verifyCodeFormKey = GlobalKey<FormState>();
  final verifyCodeController = TextEditingController();
  final secondsRemaining = 35.obs;
  Timer? _verifyTimer;

  // Change Password Screen
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

  @override
  void onInit() {
    super.onInit();
    changePasswordNewController.addListener(_validateChangePasswordRequirements);
    changePasswordConfirmController.addListener(_validateChangePasswordRequirements);
  }

  void _validateChangePasswordRequirements() {
    final newPass = changePasswordNewController.text;
    final confirmPass = changePasswordConfirmController.text;

    changePasswordHas8Chars.value = newPass.length >= 8;
    changePasswordHasSpecialChar.value =
        RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPass);
    changePasswordHasNumber.value = RegExp(r'[0-9]').hasMatch(newPass);
    changePasswordPasswordsMatch.value =
        newPass.isNotEmpty && newPass == confirmPass;
  }

  // Signup Screen
  final signupFormKey = GlobalKey<FormState>();
  final signupNameController = TextEditingController();
  final signupPhoneController = TextEditingController();
  final signupLanguageController = TextEditingController();
  final signupLanguageFieldKey = GlobalKey();
  final signupPasswordController = TextEditingController();
  final signupConfirmPasswordController = TextEditingController();
  final obscureSignupPassword = true.obs;
  final obscureSignupConfirmPassword = true.obs;

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureNewPassword() {
    obscureNewPassword.value = !obscureNewPassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void toggleObscureSignupPassword() {
    obscureSignupPassword.value = !obscureSignupPassword.value;
  }

  void toggleObscureSignupConfirmPassword() {
    obscureSignupConfirmPassword.value = !obscureSignupConfirmPassword.value;
  }

  void loginWithForm(BuildContext context) {
    if (!(loginFormKey.currentState?.validate() ?? false)) return;
    final args = Get.arguments as Map<String, dynamic>?;
    final isNanny = args?['role'] == 'nanny';
    login(
      context: context,
      identifier: loginPhoneOrEmailController.text.trim(),
      password: loginPasswordController.text,
      isNanny: isNanny,
    );
  }

  void login({
    required BuildContext context,
    required String identifier,
    required String password,
    bool isNanny = false,
  }) async {
    isLoading.value = true;

    final isEmail = identifier.contains('@');
    final result = await _repository.login(
      email: isEmail ? identifier : null,
      phoneNumber: isEmail ? null : identifier,
      password: password,
    );

    isLoading.value = false;

    result.fold(
      (failure) {
        if (context.mounted) {
          showToast(context, message: failure.message, status: 'error');
        }
      },
      (user) {
        final sessionController = Get.find<SessionController>();
        sessionController.acceptAuthenticatedUser(user);
        Get.offAllNamed<dynamic>(AppRoutes.main);
      },
    );
  }

  void signUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    isLoading.value = true;

    final result =
        await _repository.signUp(name: name, email: email, password: password);

    isLoading.value = false;
    result.fold(
      (failure) {
        if (context.mounted) {
          showToast(context, message: failure.message, status: 'error');
        }
      },
      (user) {
        Get.offAllNamed<dynamic>(AppRoutes.acceptInvitation);
      },
    );
  }

  void parentSignUp(
      {required BuildContext context,
      required String name,
      required String email,
      required String password}) async {
    isLoading.value = true;

    final result =
        await _repository.signUp(name: name, email: email, password: password);

    isLoading.value = false;
    result.fold(
      (failure) {
        if (context.mounted) {
          showToast(context, message: failure.message, status: 'error');
        }
      },
      (user) {
        Get.offAllNamed<dynamic>(AppRoutes.parentToday);
      },
    );
  }

  void signUpWithForm(BuildContext context) {
    if (!(signupFormKey.currentState?.validate() ?? false)) return;

    // Transition to OTP Screen with argument to indicate flow
    Get.toNamed<dynamic>(AppRoutes.verifyCode, arguments: {'from': 'signup'});
  }

  void forgotPassword(
      {required BuildContext context, required String email}) async {
    isLoading.value = true;

    final result = await _repository.forgotPassword(email: email);

    isLoading.value = false;
    result.fold(
      (failure) {
        if (context.mounted) {
          showToast(context, message: failure.message, status: 'error');
        }
      },
      (success) {
        if (context.mounted) {
          showToast(context,
              message: 'Password reset link sent successfully',
              status: 'success');
        }
        Get.offNamed<dynamic>(AppRoutes.verifyCode);
      },
    );
  }

  void startVerifyTimer() {
    _verifyTimer?.cancel();
    secondsRemaining.value = 35;
    _verifyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void sendOtp(BuildContext context) async {
    if (!(forgotPasswordFormKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    // Simulate sending OTP (allows any number)
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;

    startVerifyTimer();

    if (context.mounted) {
      showToast(
        context,
        message: 'OTP Code sent successfully',
        status: 'success',
      );
    }
    Get.toNamed<dynamic>(AppRoutes.verifyCode);
  }

  void resendOtp(BuildContext context) async {
    isLoading.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;

    startVerifyTimer();

    if (context.mounted) {
      showToast(
        context,
        message: 'Code resent successfully',
        status: 'success',
      );
    }
  }

  void verifyOtp(BuildContext context) async {
    if (verifyCodeController.text.length < 4) return;

    isLoading.value = true;
    await Future<void>.delayed(const Duration(seconds: 1));
    isLoading.value = false;

    if (context.mounted) {
      showToast(
        context,
        message: 'Code verified successfully',
        status: 'success',
      );
    }

    final isFromSignup =
        Get.arguments != null && (Get.arguments as Map)['from'] == 'signup';
    if (isFromSignup) {
      Get.toNamed<dynamic>(AppRoutes.submitDocuments);
    } else {
      Get.offNamed<dynamic>(AppRoutes.changePassword);
    }
  }

  void saveNewPassword(BuildContext context) async {
    if (!(changePasswordFormKey.currentState?.validate() ?? false)) return;

    isLoading.value = true;
    // Simulate saving password
    await Future<void>.delayed(const Duration(milliseconds: 500));
    isLoading.value = false;

    if (context.mounted) {
      showToast(
        context,
        message: 'Password changed successfully',
        status: 'success',
      );
    }
    Get.offAllNamed<dynamic>(AppRoutes.passwordSuccess);
  }

  void toggleObscureCurrentPassword() {
    obscureCurrentPassword.value = !obscureCurrentPassword.value;
  }

  @override
  void onClose() {
    loginPhoneOrEmailController.dispose();
    loginPasswordController.dispose();
    forgotPasswordPhoneController.dispose();
    verifyCodeController.dispose();
    changePasswordCurrentController.dispose();
    changePasswordNewController.dispose();
    changePasswordConfirmController.dispose();
    signupNameController.dispose();
    signupPhoneController.dispose();
    signupLanguageController.dispose();
    signupPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    _verifyTimer?.cancel();
    super.onClose();
  }
}
