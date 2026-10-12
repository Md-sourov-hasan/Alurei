import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_camera_capture_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_review_images_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_verify_identity_step.dart';

class PassportCaptureScreen extends HookWidget {
  const PassportCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState<int>(0);
    final passportImage = useState<File?>(null);

    return PopScope(
      canPop: currentStep.value == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && currentStep.value > 0) {
          if (currentStep.value == 2) {
            currentStep.value = 1;
          } else if (currentStep.value == 1) {
            currentStep.value = 0;
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8F8),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: KeyedSubtree(
                key: ValueKey<int>(currentStep.value),
                child: switch (currentStep.value) {
                  0 => SingleChildScrollView(
                      child: Column(
                        children: [
                          16.verticalSpace,
                          SignupCameraCaptureStep(
                            title:
                                "Take a clear photo of your passport's photo page.",
                            subtitle:
                                'Place your passport within the frame and ensure all information is clearly visible.',
                            onBack: () => Get.back<dynamic>(),
                            onCaptured: (file) {
                              passportImage.value = file;
                              currentStep.value = 1;
                            },
                          ),
                        ],
                      ),
                    ),
                  1 => SingleChildScrollView(
                      child: Column(
                        children: [
                          16.verticalSpace,
                          SignupReviewImagesStep(
                            frontImage: passportImage.value,
                            isPassport: true,
                            submitLabel: 'Submit',
                            onBack: () => currentStep.value = 0,
                            onRetakeFront: () {
                              passportImage.value = null;
                              currentStep.value = 0;
                            },
                            onComplete: () => currentStep.value = 2,
                          ),
                        ],
                      ),
                    ),
                  2 => Column(
                      children: [
                        16.verticalSpace,
                        Expanded(
                          child: SignupVerifyIdentityStep(
                            onBack: () => currentStep.value = 1,
                            onCaptured: (selfieFile) {
                              Get.offAllNamed<dynamic>(
                                AppRoutes.verificationSuccess,
                                arguments: <String, dynamic>{
                                  'title': 'Verification Successful!',
                                  'subtitle':
                                      'Your Passport and face scan have been verified successfully.',
                                  'targetRoute': AppRoutes.parentToday,
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
