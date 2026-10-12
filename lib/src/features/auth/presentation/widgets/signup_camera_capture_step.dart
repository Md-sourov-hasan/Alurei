import 'dart:io';
import 'package:camera/camera.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:alurei/src/features/auth/data/repositories/auth_repository_impl.dart';

class SignupCameraCaptureStep extends HookWidget {
  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final void Function(File) onCaptured;

  const SignupCameraCaptureStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onBack,
    required this.onCaptured,
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

    useEffect(() {
      CameraController? activeController;

      Future<void> initCamera() async {
        try {
          final cameras = await availableCameras();
          if (cameras.isEmpty) return;

          final backCamera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
            orElse: () => cameras.first,
          );

          activeController = CameraController(
            backCamera,
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
          capturedImage.value = File('dummy_nid.png');
        }
      } else {
        capturedImage.value = File('dummy_nid.png');
      }
    }

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
          title,
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
          subtitle,
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF4B5565),
            height: 20 / 14,
          ),
        ),
        48.verticalSpace,

        // Frame
        GestureDetector(
          onTap: capturedImage.value == null ? captureImage : null,
          child: Container(
            height: 213.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: capturedImage.value != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.file(
                      capturedImage.value!,
                      width: double.infinity,
                      height: 213.h,
                      fit: BoxFit.cover,
                    ),
                  )
                : isCameraInitialized.value && cameraController.value != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: CameraPreview(cameraController.value!),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconsaxPlusLinear.camera,
                              color: Colors.white.withOpacity(0.6),
                              size: 48.w,
                            ),
                            8.verticalSpace,
                            Text(
                              'Initializing camera...',
                              style: GlobalTextStyles.interTextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ),
        48.verticalSpace,

        // Actions
        AppButton(
          label: 'Capture',
          isFullWidth: true,
          height: ButtonSize.large,
          onPressed: capturedImage.value == null ? captureImage : null, // Disable if already captured
        ),
        if (capturedImage.value != null) ...[
          50.verticalSpace,
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
                      label: 'Submit',
                      isLoading: controller.isLoading.value,
                      height: ButtonSize.large,
                      onPressed: () => onCaptured(capturedImage.value!),
                    )),
              ),
            ],
          ),
        ],
        40.verticalSpace,
      ],
    );
  }
}
