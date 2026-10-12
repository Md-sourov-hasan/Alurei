import 'dart:io';
import 'dart:ui';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';

class SignupCaptureNidStep extends StatelessWidget {
  final File? frontImage;
  final File? backImage;
  final VoidCallback onBack;
  final VoidCallback onFrontClick;
  final VoidCallback onBackClick;
  final VoidCallback onClearFront;
  final VoidCallback onClearBack;
  final VoidCallback onComplete;

  const SignupCaptureNidStep({
    super.key,
    required this.frontImage,
    required this.backImage,
    required this.onBack,
    required this.onFrontClick,
    required this.onBackClick,
    required this.onClearFront,
    required this.onClearBack,
    required this.onComplete,
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
          'Capture your NID',
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
          'Capture your National ID to verify your identity and keep the platform safe for everyone.',
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4B5565),
            height: 20 / 14,
          ),
        ),
        36.verticalSpace,

        // Front Side Card
        _buildNidCaptureCard(
          context: context,
          title: 'Front side photo of your NID card with your clear name and photo',
          image: frontImage,
          onTap: onFrontClick,
          onClear: onClearFront,
        ),

        24.verticalSpace,

        // Back Side Card
        _buildNidCaptureCard(
          context: context,
          title: 'Back side photo of your NID card with your clear name and photo',
          image: backImage,
          onTap: onBackClick,
          onClear: onClearBack,
        ),

        48.verticalSpace,

        // Next Button
        Obx(() => AppButton(
              label: 'Next',
              isLoading: controller.isLoading.value,
              isFullWidth: true,
              height: ButtonSize.large,
              onPressed: (frontImage == null || backImage == null || controller.isLoading.value)
                  ? null
                  : onComplete,
            )),
        40.verticalSpace,
      ],
    );
  }

  Widget _buildNidCaptureCard({
    required BuildContext context,
    required String title,
    required File? image,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    return Container(
      height: 175.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: image != null ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: image != null
          ? Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: onClear,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconsaxPlusLinear.trash,
                        size: 16.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : CustomPaint(
              painter: DashedBorderPainter(
                color: const Color(0xFF0B5460),
                radius: 16.r,
                strokeWidth: 1.2.w,
                gap: 6.w,
                dashLength: 8.w,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4B5565),
                        height: 20 / 14,
                      ),
                    ),
                    14.verticalSpace,
                    InkWell(
                      onTap: onTap,
                      borderRadius: BorderRadius.circular(6.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF0B5460), width: 0.52.w),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              IconsaxPlusBold.camera,
                              size: 20.w,
                              color: const Color(0xFF0B5460),
                            ),
                            6.horizontalSpace,
                            Text(
                              'Click Photo',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF0B5460),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;
  final double radius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
    this.radius = 16.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(radius),
      ));

    final dashPath = Path();
    double distance = 0;
    for (final PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double end = distance + dashLength;
        dashPath.addPath(
          metric.extractPath(distance, end >= metric.length ? metric.length : end),
          Offset.zero,
        );
        distance = end + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dashLength != dashLength ||
        oldDelegate.radius != radius;
  }
}
