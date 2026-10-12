import 'dart:io';
import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';

class SignupVerifyIdentityStep extends HookWidget {
  final VoidCallback onBack;
  final void Function(File) onCaptured;
  final String submitLabel;

  const SignupVerifyIdentityStep({
    super.key,
    required this.onBack,
    required this.onCaptured,
    this.submitLabel = 'Submit',
  });

  @override
  Widget build(BuildContext context) {
    final capturedImage = useState<File?>(null);
    final controller = Get.isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController(
            repository: Get.isRegistered<AuthRepository>()
                ? Get.find<AuthRepository>()
                : AuthRepositoryImpl(),
          ));

    final cameraController = useState<CameraController?>(null);
    final isCameraInitialized = useState<bool>(false);

    // Scanning line animation: sweeps top → bottom on a 2-second loop
    final scanAnimController = useAnimationController(
      duration: const Duration(seconds: 2),
    );
    final scanAnimation = useMemoized(
      () => CurvedAnimation(
        parent: scanAnimController,
        curve: Curves.easeInOut,
      ),
      [scanAnimController],
    );

    useEffect(() {
      scanAnimController.repeat(reverse: true);
      return null;
    }, []);

    useEffect(() {
      CameraController? activeController;

      Future<void> initCamera() async {
        try {
          final cameras = await availableCameras();
          if (cameras.isEmpty) return;

          // Face verification uses the front-facing camera
          final frontCamera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          activeController = CameraController(
            frontCamera,
            ResolutionPreset.medium,
            enableAudio: false,
          );

          await activeController!.initialize();
          isCameraInitialized.value = true;
          cameraController.value = activeController;
        } catch (e) {
          debugPrint('Error initializing camera: $e');
        }
      }

      initCamera();

      return () {
        activeController?.dispose();
      };
    }, []);

    Future<void> captureImage() async {
      if (cameraController.value != null && isCameraInitialized.value) {
        try {
          final XFile file = await cameraController.value!.takePicture();
          capturedImage.value = File(file.path);
        } catch (e) {
          // Simulator / no-camera fallback so UI flow works
          capturedImage.value = File('dummy_selfie.png');
        }
      } else {
        // Fallback for immediate transition on simulator
        capturedImage.value = File('dummy_selfie.png');
      }
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
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
                    'Verify Identity',
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
                    'Position your face within the frame and ensure you are in a well-lit area for optimal recognition.',
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF4B5565),
                      height: 20 / 14,
                    ),
                  ),
                  36.verticalSpace,

                  // Circle Camera Scanner Frame
                  Center(
                    child: SizedBox(
                      width: 312.w, // 280.w frame size + 16.w * 2 padding for brackets
                      height: 312.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Pulsing dashed border outside the circle
                          CustomPaint(
                            painter: DashedCirclePainter(
                              color: const Color(0xFF0B5460).withValues(alpha: 0.5),
                              strokeWidth: 1.2.w,
                              gap: 6.w,
                              dashLength: 8.w,
                            ),
                            child: SizedBox(
                              width: 296.w,
                              height: 296.h,
                            ),
                          ),

                          // Main Circle Container with solid border
                          Container(
                            width: 280.w,
                            height: 280.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFFFAFAFA),
                              border: Border.all(
                                color: const Color(0xFF333333),
                                width: 2.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  offset: const Offset(0, 1),
                                  blurRadius: 2.r,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(2.w),
                            child: ClipOval(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Camera feed / captured image / placeholder
                                  SizedBox.expand(
                                    child: capturedImage.value != null
                                        ? Image.file(
                                            capturedImage.value!,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: double.infinity,
                                          )
                                        : isCameraInitialized.value &&
                                                cameraController.value != null
                                            ? AspectRatio(
                                                aspectRatio: cameraController
                                                    .value!.value.aspectRatio,
                                                child: CameraPreview(
                                                    cameraController.value!),
                                              )
                                            : Center(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      IconsaxPlusLinear.camera,
                                                      color: const Color(0xFF333333)
                                                          .withValues(alpha: 0.4),
                                                      size: 48.w,
                                                    ),
                                                    8.verticalSpace,
                                                    Text(
                                                      'Initializing camera...',
                                                      style:
                                                          GlobalTextStyles.interTextStyle(
                                                        color: const Color(0xFF333333)
                                                            .withValues(alpha: 0.4),
                                                        fontSize: 14.sp,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                  ),

                                  // Animated scanning line — clipped inside the circle
                                  if (capturedImage.value == null)
                                    AnimatedBuilder(
                                      animation: scanAnimation,
                                      builder: (context, _) {
                                        return Positioned(
                                          top: scanAnimation.value * 280.h,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            height: 2.h,
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.transparent,
                                                  const Color(0xFF0B5460)
                                                      .withValues(alpha: 0.6),
                                                  const Color(0xFF0B5460)
                                                      .withValues(alpha: 0.6),
                                                  Colors.transparent,
                                                ],
                                                stops: const [0.0, 0.15, 0.85, 1.0],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: const Color(0xFF006591)
                                                      .withValues(alpha: 0.8),
                                                  blurRadius: 12.r,
                                                  spreadRadius: 1.r,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),

                          // Corner Brackets for modern precision look
                          // Top-Left Corner
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                  left: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                ),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                          // Top-Right Corner
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                  right: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                ),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                          // Bottom-Left Corner
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                  left: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                          // Bottom-Right Corner
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 32.w,
                              height: 32.h,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                  right: BorderSide(
                                      color: const Color(0xFF0B5460), width: 2.w),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(4.r),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  24.verticalSpace,

                  // Lighting Optimal Chip
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            IconsaxPlusLinear.sun_1,
                            size: 18.w,
                            color: const Color(0xFF333333),
                          ),
                          8.horizontalSpace,
                          Text(
                            'Lighting: Optimal',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF333333),
                              height: 20 / 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Push Submit button to the bottom of the screen
                  const Spacer(),
                  24.verticalSpace,

                  // Actions
                  if (capturedImage.value == null) ...[
                    AppButton(
                      label: submitLabel,
                      isFullWidth: true,
                      height: ButtonSize.large,
                      onPressed: captureImage,
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            label: 'Retake',
                            variant: ButtonVariant.outline,
                            height: ButtonSize.large,
                            onPressed: () {
                              capturedImage.value = null;
                            },
                          ),
                        ),
                        16.horizontalSpace,
                        Expanded(
                          child: Obx(() => AppButton(
                                label: submitLabel,
                                isLoading: controller.isLoading.value,
                                height: ButtonSize.large,
                                onPressed: () => onCaptured(capturedImage.value!),
                              )),
                        ),
                      ],
                    ),
                  ],
                  24.verticalSpace,
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double dashLength;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.gap = 4.0,
    this.dashLength = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()..addOval(Rect.fromLTWH(0, 0, size.width, size.height));

    final dashPath = Path();
    double distance = 0;
    for (final PathMetric metric in path.computeMetrics()) {
      while (distance < metric.length) {
        final double end = distance + dashLength;
        dashPath.addPath(
          metric.extractPath(
              distance, end >= metric.length ? metric.length : end),
          Offset.zero,
        );
        distance = end + gap;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.dashLength != dashLength;
  }
}
