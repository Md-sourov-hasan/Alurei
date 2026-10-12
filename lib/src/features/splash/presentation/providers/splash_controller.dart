import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';

class SplashController extends GetxController {
  static const String _isFirstTimeKey = 'is_first_time';

  final isAnimationCompleted = false.obs;
  bool _hasNavigated = false;

  @override
  void onReady() {
    super.onReady();
    // Fallback safety timer (~3.3s) in case animation status callback is delayed
    Future.delayed(const Duration(milliseconds: 3300), () {
      if (!_hasNavigated) {
        onContinue();
      }
    });
  }

  void completeAnimation() {
    isAnimationCompleted.value = true;
    if (!_hasNavigated) {
      onContinue();
    }
  }

  Future<void> onContinue() async {
    if (_hasNavigated) return;
    _hasNavigated = true;

    // 1. If 1st time open app -> open ChoosingScreen
    final isFirstTime =
        StorageService.instance.getBool(_isFirstTimeKey) ?? true;
    if (isFirstTime) {
      await StorageService.instance.setBool(_isFirstTimeKey, false);
      Get.offNamed<dynamic>(AppRoutes.roleSelection);
      return;
    }

    // 2. Check login status via AuthSessionStorageService accessToken
    final tokenResult =
        await AuthSessionStorageService.instance.readAccessToken();
    final hasAccessToken = tokenResult.fold(
      (_) => false,
      (token) => token != null && token.isNotEmpty,
    );

    if (hasAccessToken) {
      // Ensure SessionController state is restored before displaying role main shell
      final sessionController = Get.find<SessionController>();
      if (sessionController.user.value == null) {
        final authRepo = Get.find<AuthRepository>();
        final userResult = await authRepo.checkAuthState();
        userResult.fold((_) {}, (user) {
          if (user != null) {
            sessionController.acceptAuthenticatedUser(user);
          }
        });
      }
      Get.offNamed<dynamic>(AppRoutes.main);
    } else {
      Get.offNamed<dynamic>(AppRoutes.login);
    }
  }
}
