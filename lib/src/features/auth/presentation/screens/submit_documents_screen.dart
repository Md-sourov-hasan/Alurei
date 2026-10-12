import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class SubmitDocumentsScreen extends HookWidget {
  const SubmitDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedDoc = useState<String?>(null);

    // final args = Get.arguments as Map<String, dynamic>? ?? {};
    // final activeSteps = args['activeSteps'] as int? ?? 5;
    // final totalSteps = args['totalSteps'] as int? ?? 5;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    24.verticalSpace,
                    Text(
                      'Submit Documents',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 24
                            .sp, // Looking at image, it's slightly smaller than huge header
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    12.verticalSpace,
                    Text(
                      'Choose how you want to verify',
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primaryColor.withValues(alpha: 0.7),
                      ),
                    ),
                    48.verticalSpace,

                    // Passport Card
                    _buildDocCard(
                      title: 'Passport',
                      subtitle: 'We need to see your full name and photo',
                      icon: IconsaxPlusLinear.document,
                      isSelected: selectedDoc.value == 'passport',
                      onTap: () => selectedDoc.value = 'passport',
                    ),

                    24.verticalSpace,
                    Center(
                      child: Text(
                        'Or',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    24.verticalSpace,

                    // National ID Card
                    _buildDocCard(
                      title: 'National ID Card',
                      subtitle: 'We need to see your full name and photo',
                      icon: IconsaxPlusBold.cards,
                      isSelected: selectedDoc.value == 'id_card',
                      onTap: () => selectedDoc.value = 'id_card',
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Buttons
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'Remind me later',
                      onPressed: () {
                        context.showAppDialog<dynamic>(
                          builder: (context) => Dialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(24.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  12.verticalSpace,
                                  Text(
                                    'Skip verification now?',
                                    textAlign: TextAlign.center,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColor,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  16.verticalSpace,
                                  Text(
                                    "You'll need to submit your documents before adding a child. Are you sure you want to skip this step for now?",
                                    textAlign: TextAlign.center,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(
                                          0xFF536A70), // Close to the grayish blue text in screenshot
                                      height: 1.5,
                                    ),
                                  ),
                                  32.verticalSpace,
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: AppButton(
                                          label: 'Skip',
                                          isFullWidth: true,
                                          variant: ButtonVariant.secondary,
                                          color: const Color(0xFFF6F8F8),
                                          textColor: AppColors.primaryColor,
                                          onPressed: () {
                                            Get.back<dynamic>(); // close dialog
                                            Get.back<dynamic>(); // skip step
                                          },
                                        ),
                                      ),
                                      12.horizontalSpace,
                                      Expanded(
                                        flex: 3,
                                        child: AppButton(
                                          label: 'Submit documents',
                                          isFullWidth: true,
                                          variant: ButtonVariant.primary,
                                          onPressed: () {
                                            Get.back<dynamic>(); // close dialog
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  4.verticalSpace,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      variant: ButtonVariant.secondary,
                      color: Colors.white,
                      textColor: AppColors.primaryColor,
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: AppButton(
                      label: 'Next',
                      onPressed: selectedDoc.value == null
                          ? null
                          : () {
                              if (selectedDoc.value == 'passport') {
                                Get.toNamed<dynamic>(AppRoutes.passportCapture);
                              } else if (selectedDoc.value == 'id_card') {
                                Get.toNamed<dynamic>(AppRoutes.nidCapture);
                              }
                            },
                      variant: ButtonVariant.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F1F2) : const Color(0xFFF1F4F5),
          border: Border.all(
            color:
                isSelected ? AppColors.primaryColor : const Color(0xFFD3E0E2),
            width: 1.5.w,
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFD7EAEB),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: AppColors.primaryColor,
                size: 24.w,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  4.verticalSpace,
                  Text(
                    subtitle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColor.withValues(alpha: 0.6),
                      height: 20 / 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
