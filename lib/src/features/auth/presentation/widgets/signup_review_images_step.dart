import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';
import 'signup_capture_nid_step.dart';

class SignupReviewImagesStep extends StatelessWidget {
  final File? frontImage;
  final File? backImage;
  final bool isPassport;
  final VoidCallback onBack;
  final VoidCallback? onRetakeFront;
  final VoidCallback? onRetakeBack;
  final VoidCallback onComplete;
  final String submitLabel;

  const SignupReviewImagesStep({
    super.key,
    required this.frontImage,
    this.backImage,
    this.isPassport = false,
    required this.onBack,
    this.onRetakeFront,
    this.onRetakeBack,
    required this.onComplete,
    this.submitLabel = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController(
            repository: Get.isRegistered<AuthRepository>()
                ? Get.find<AuthRepository>()
                : AuthRepositoryImpl(),
          ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Top Back Navigation Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: onBack,
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      IconsaxPlusLinear.arrow_left,
                      size: 24.w,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        16.verticalSpace,

        // Title
        Text(
          'Review your images',
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF0B5460),
            height: 32 / 24,
          ),
        ),
        10.verticalSpace,

        // Subtitle
        Text(
          'Using a fake, unclear, or misleading image may result in account restrictions.',
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4B5565),
            height: 20 / 14,
          ),
        ),
        36.verticalSpace,

        // Front Side Preview and Retake
        if (frontImage != null) ...[
          Center(
            child: Column(
              children: [
                CustomPaint(
                  painter: DashedBorderPainter(
                    color: const Color(0xFF0B5460),
                    radius: 8.r,
                    strokeWidth: 1.2.w,
                    gap: 6.w,
                    dashLength: 8.w,
                  ),
                  child: Container(
                    width: 279.w,
                    height: 191.h,
                    padding: EdgeInsets.all(10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        frontImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                12.verticalSpace,
                if (onRetakeFront != null)
                  _buildRetakeButton(onPressed: onRetakeFront!),
              ],
            ),
          ),
        ],

        24.verticalSpace,

        // Back Side Preview and Retake — only for NID (not passport)
        if (!isPassport && backImage != null) ...[
          Center(
            child: Column(
              children: [
                CustomPaint(
                  painter: DashedBorderPainter(
                    color: const Color(0xFF0B5460),
                    radius: 8.r,
                    strokeWidth: 1.2.w,
                    gap: 6.w,
                    dashLength: 8.w,
                  ),
                  child: Container(
                    width: 279.w,
                    height: 191.h,
                    padding: EdgeInsets.all(10.w),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: Image.file(
                        backImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                12.verticalSpace,
                if (onRetakeBack != null)
                  _buildRetakeButton(onPressed: onRetakeBack!),
              ],
            ),
          ),
        ],

        40.verticalSpace,

        // Next / Submit Button
        Obx(() {
          final isLoading = controller.isLoading.value;
          final isValid = isPassport
              ? frontImage != null
              : (frontImage != null && backImage != null);

          return AppButton(
            label: submitLabel,
            isLoading: isLoading,
            isFullWidth: true,
            height: ButtonSize.large,
            onPressed: (isLoading || !isValid)
                ? null
                : () {
                    onComplete();
                  },
          );
        }),
        40.verticalSpace,
      ],
    );
  }

  Widget _buildRetakeButton({required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 279.w,
        height: 44.h,
        decoration: BoxDecoration(
          color: AppColors.secondaryBackgroundColor,
          border: Border.all(color: AppColors.primaryColor, width: 1.w),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: Text(
            'Retake',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              height: 24 / 16,
            ),
          ),
        ),
      ),
    );
  }
}
