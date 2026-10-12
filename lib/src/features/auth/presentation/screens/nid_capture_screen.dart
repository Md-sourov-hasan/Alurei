import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_capture_nid_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_camera_capture_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_review_images_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_verify_identity_step.dart';

class NidCaptureScreen extends HookWidget {
  const NidCaptureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentStep = useState<int>(0);
    final frontImage = useState<File?>(null);
    final backImage = useState<File?>(null);

    return PopScope(
      canPop: currentStep.value == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && currentStep.value > 0) {
          if (currentStep.value == 4) {
            currentStep.value = 3;
          } else if (currentStep.value == 3) {
            currentStep.value = 0;
          } else if (currentStep.value == 1 || currentStep.value == 2) {
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
                          SignupCaptureNidStep(
                            frontImage: frontImage.value,
                            backImage: backImage.value,
                            onBack: () => Get.back<dynamic>(),
                            onFrontClick: () => currentStep.value = 1,
                            onBackClick: () => currentStep.value = 2,
                            onClearFront: () => frontImage.value = null,
                            onClearBack: () => backImage.value = null,
                            onComplete: () => currentStep.value = 3,
                          ),
                        ],
                      ),
                    ),
                  1 => SingleChildScrollView(
                      child: Column(
                        children: [
                          16.verticalSpace,
                          SignupCameraCaptureStep(
                            title:
                                'Take a clear photo of the front of your National ID card.',
                            subtitle:
                                'Place your NID within the frame and ensure all information is clearly visible.',
                            onBack: () => currentStep.value = 0,
                            onCaptured: (file) {
                              frontImage.value = file;
                              if (frontImage.value != null &&
                                  backImage.value != null) {
                                currentStep.value = 3;
                              } else {
                                currentStep.value = 0;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  2 => SingleChildScrollView(
                      child: Column(
                        children: [
                          16.verticalSpace,
                          SignupCameraCaptureStep(
                            title:
                                'Take a clear photo of the back of your National ID card.',
                            subtitle:
                                'Place your NID within the frame and ensure all information is clearly visible.',
                            onBack: () => currentStep.value = 0,
                            onCaptured: (file) {
                              backImage.value = file;
                              if (frontImage.value != null &&
                                  backImage.value != null) {
                                currentStep.value = 3;
                              } else {
                                currentStep.value = 0;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  3 => SingleChildScrollView(
                      child: Column(
                        children: [
                          16.verticalSpace,
                          SignupReviewImagesStep(
                            frontImage: frontImage.value,
                            backImage: backImage.value,
                            submitLabel: 'Submit',
                            onBack: () => currentStep.value = 0,
                            onRetakeFront: () {
                              frontImage.value = null;
                              currentStep.value = 1;
                            },
                            onRetakeBack: () {
                              backImage.value = null;
                              currentStep.value = 2;
                            },
                            onComplete: () => currentStep.value = 4,
                          ),
                        ],
                      ),
                    ),
                  4 => Column(
                      children: [
                        16.verticalSpace,
                        Expanded(
                          child: SignupVerifyIdentityStep(
                            onBack: () => currentStep.value = 3,
                            onCaptured: (selfieFile) {
                              Get.offAllNamed<dynamic>(
                                AppRoutes.verificationSuccess,
                                arguments: <String, dynamic>{
                                  'title': 'Verification Successful!',
                                  'subtitle':
                                      'Your National ID card and face scan have been verified successfully.',
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
