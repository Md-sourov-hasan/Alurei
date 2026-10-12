import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/presentation/widgets/auth_progress_header.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_camera_capture_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_capture_nid_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_account_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_verify_code_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_submit_documents_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_review_images_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_verify_identity_step.dart';

/// Unified multi-step signup screen containing all steps (Account Details,
/// OTP Verification, and Document Submission) directly as internal widgets
/// inside a single file.
class NannySignupScreen extends HookWidget {
  final int initialStep;

  const NannySignupScreen({
    super.key,
    this.initialStep = 0,
  });

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;
    final argStep =
        (args is Map && args['step'] is int) ? args['step'] as int : null;
    final currentStep = useState(argStep ?? initialStep);
    final controller = Get.find<AuthController>();

    // NID Capture local states
    final nidFrontImage = useState<File?>(null);
    final nidBackImage = useState<File?>(null);

    // Passport Capture local state
    final passportImage = useState<File?>(null);

    // Track which doc type was chosen (to know flow in review/verify steps)
    final isPassportFlow = useState<bool>(false);

    return PopScope(
      canPop: currentStep.value == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && currentStep.value > 0) {
          if (currentStep.value == 8) {
            // Verify identity → back to review
            currentStep.value = 7;
          } else if (currentStep.value == 7) {
            // Review → back to NID selection (4) or passport capture (3)
            if (isPassportFlow.value) {
              currentStep.value = 3;
            } else {
              currentStep.value = 4;
            }
          } else if (currentStep.value == 5 || currentStep.value == 6) {
            currentStep.value = 4;
          } else {
            currentStep.value -= 1;
          }
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                16.verticalSpace,

                // Top Progress Bar (7 steps total, activeSteps = currentStep + 1)
                AuthProgressHeader(
                  activeSteps: currentStep.value == 8
                      ? 7
                      : currentStep.value == 7
                          ? 6
                          : currentStep.value >= 4
                              ? 5
                              : currentStep.value + 1,
                ),
                12.verticalSpace,

                // Animated step body based on index
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: KeyedSubtree(
                      key: ValueKey<int>(currentStep.value),
                      child: switch (currentStep.value) {
                        0 => SingleChildScrollView(
                            child: SignupAccountStep(
                              onNext: () {
                                controller.startVerifyTimer();
                                currentStep.value = 1;
                              },
                            ),
                          ),
                        1 => SingleChildScrollView(
                            child: SignupVerifyCodeStep(
                              onNext: () {
                                currentStep.value = 2;
                              },
                            ),
                          ),
                        2 => SingleChildScrollView(
                            child: SignupSubmitDocumentsStep(
                              onNext: (docType) {
                                isPassportFlow.value = docType == 'passport';
                                if (docType == 'passport') {
                                  currentStep.value = 3;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                            ),
                          ),
                        3 => SingleChildScrollView(
                            child: SignupCameraCaptureStep(
                              title:
                                  "Take a clear photo of your passport's photo page.",
                              subtitle:
                                  'Place your passport within the frame and ensure all information is clearly visible.',
                              onBack: () => currentStep.value = 2,
                              onCaptured: (file) {
                                passportImage.value = file;
                                currentStep.value = 7;
                              },
                            ),
                          ),
                        4 => SingleChildScrollView(
                            child: SignupCaptureNidStep(
                              frontImage: nidFrontImage.value,
                              backImage: nidBackImage.value,
                              onBack: () => currentStep.value = 2,
                              onFrontClick: () => currentStep.value = 5,
                              onBackClick: () => currentStep.value = 6,
                              onClearFront: () => nidFrontImage.value = null,
                              onClearBack: () => nidBackImage.value = null,
                              onComplete: () {
                                currentStep.value = 7;
                              },
                            ),
                          ),
                        5 => SingleChildScrollView(
                            child: SignupCameraCaptureStep(
                              title:
                                  'Take a clear photo of the front of your National ID card.',
                              subtitle:
                                  'Place your NID within the frame and ensure all information is clearly visible.',
                              onBack: () {
                                if (nidFrontImage.value != null &&
                                    nidBackImage.value != null) {
                                  currentStep.value = 7;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                              onCaptured: (file) {
                                nidFrontImage.value = file;
                                if (nidFrontImage.value != null &&
                                    nidBackImage.value != null) {
                                  currentStep.value = 7;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                            ),
                          ),
                        6 => SingleChildScrollView(
                            child: SignupCameraCaptureStep(
                              title:
                                  'Take a clear photo of the back of your National ID card.',
                              subtitle:
                                  'Place your NID within the frame and ensure all information is clearly visible.',
                              onBack: () {
                                if (nidFrontImage.value != null &&
                                    nidBackImage.value != null) {
                                  currentStep.value = 7;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                              onCaptured: (file) {
                                nidBackImage.value = file;
                                if (nidFrontImage.value != null &&
                                    nidBackImage.value != null) {
                                  currentStep.value = 7;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                            ),
                          ),
                        7 => SingleChildScrollView(
                            child: SignupReviewImagesStep(
                              frontImage: isPassportFlow.value
                                  ? passportImage.value
                                  : nidFrontImage.value,
                              backImage: isPassportFlow.value
                                  ? null
                                  : nidBackImage.value,
                              isPassport: isPassportFlow.value,
                              submitLabel: 'Submit',
                              onBack: () {
                                if (isPassportFlow.value) {
                                  currentStep.value = 3;
                                } else {
                                  currentStep.value = 4;
                                }
                              },
                              onRetakeFront: isPassportFlow.value
                                  ? () => currentStep.value = 3
                                  : () => currentStep.value = 5,
                              onRetakeBack: isPassportFlow.value
                                  ? null
                                  : () => currentStep.value = 6,
                              onComplete: () {
                                currentStep.value = 8;
                              },
                            ),
                          ),
                        8 => SignupVerifyIdentityStep(
                            onBack: () => currentStep.value = 7,
                            onCaptured: (file) {
                              final phone =
                                  controller.signupPhoneController.text.trim();
                              final email = '$phone@evaturner.com';
                              controller.signUp(
                                context: context,
                                name: controller.signupNameController.text.trim(),
                                email: email,
                                password:
                                    controller.signupPasswordController.text,
                              );
                              // Navigate directly to accept invitation screen
                              Get.toNamed<dynamic>(AppRoutes.acceptInvitation);
                            },
                          ),
                        _ => SingleChildScrollView(
                            child: SignupAccountStep(
                              onNext: () => currentStep.value = 1,
                            ),
                          ),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
