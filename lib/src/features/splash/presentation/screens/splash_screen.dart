import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'dart:math';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashController>();

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Centered branding and welcome content
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Animated Logo Widget
                      BouncingLogo(
                        logoWidth: 253.w,
                        onAnimationCompleted: controller.completeAnimation,
                      ),
                      SizedBox(height: 8.h),
                      // Logo Subtext
                      Text(
                        LangKey.welcome.logoSubtitle.toUpperCase(),
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: context.colors.primary,
                          letterSpacing: 0.8.w,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.h),
                      // Welcome title
                      Text(
                        LangKey.welcome.welcomeTitle,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: context.appColors.strongText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Continue Button at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 16.h,
              child: Obx(() {
                final isCompleted = controller.isAnimationCompleted.value;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: isCompleted ? 1.0 : 0.0,
                  child: IgnorePointer(
                    ignoring: !isCompleted,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AppButton(
                        label: LangKey.welcome.continueButton,
                        onPressed: controller.onContinue,
                        isFullWidth: true,
                        height: ButtonSize.large,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class BouncingLogo extends HookWidget {
  final double logoWidth;
  final VoidCallback? onAnimationCompleted;

  const BouncingLogo({
    super.key,
    required this.logoWidth,
    this.onAnimationCompleted,
  });

  @override
  Widget build(BuildContext context) {
    // Coordinate specifications in SVG space (253.367 x 77.4008)
    const xCoords = <double>[28, 70, 110, 160, 202, 242];
    // Intermediate bounces are kept higher, final landing on 'i' is brought down to -4.0
    const yLands = <double>[11.2, -5.1, 9.6, 9.8, 9.6, -4];

    final controller = useAnimationController(
      duration:
          const Duration(milliseconds: 3200), // ~3.2 seconds total animation
    );

    final callbackRef = useRef(onAnimationCompleted);
    callbackRef.value = onAnimationCompleted;

    useEffect(() {
      void listener(AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          callbackRef.value?.call();
        }
      }

      controller.addStatusListener(listener);
      controller.forward();
      return () => controller.removeStatusListener(listener);
    }, [controller]);

    final double scale = logoWidth / 253.367;
    final double logoHeight = 77.4008 * scale;
    final double dotWidth = 23 * scale;
    final double dotHeight = 22 * scale;

    return SizedBox(
      width: logoWidth,
      height: logoHeight +
          50.h, // Add extra vertical space for the drop/bounce heights
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final t = controller.value;
          double currentX = xCoords[0];
          double currentY = yLands[0];

          const numPhases = 6;
          final phaseVal = t * numPhases;
          final phase = phaseVal.floor();
          final s = phaseVal - phase;

          if (phase == 0) {
            // Drop phase from top onto the letter 'a'
            currentX = xCoords[0];
            final dropProgress = Curves.bounceOut.transform(s);
            currentY = -120.0 + (yLands[0] - (-120.0)) * dropProgress;
          } else if (phase >= numPhases) {
            // Settled on the 'i'
            currentX = xCoords[xCoords.length - 1];
            currentY = yLands[yLands.length - 1];
          } else {
            // Bouncing phases between letters
            final fromIdx = phase - 1;
            final toIdx = phase;

            final startX = xCoords[fromIdx];
            final endX = xCoords[toIdx];
            currentX = startX + (endX - startX) * s;

            final startY = yLands[fromIdx];
            final endY = yLands[toIdx];
            final baseInterpolatedY = startY + (endY - startY) * s;

            // Bounce amplitude is 30.0 units
            const bounceAmplitude = 30.0;
            currentY = baseInterpolatedY - (bounceAmplitude * sin(s * pi));
          }

          final double left = (currentX - 10.5) * scale;
          final double top = (currentY) * scale + 50.h;

          return Stack(
            clipBehavior: Clip.none,
            children: [
              // Logo base letters
              Positioned(
                left: 0,
                top: 50.h,
                width: logoWidth,
                height: logoHeight,
                child: SvgPicture.asset(
                  'assets/images/logo_text.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              // Bouncing dot
              Positioned(
                left: left,
                top: top,
                width: dotWidth,
                height: dotHeight,
                child: SvgPicture.asset(
                  'assets/images/logo_dot.svg',
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
