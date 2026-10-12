import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final title = args?['title'] as String? ?? 'Verification Successful!';
    final subtitle = args?['subtitle'] as String? ??
        'Your identity document and face scan have been successfully verified.';

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F8),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // Success SVG Icon
              Center(
                child: SvgPicture.asset(
                  AppAssets.passwordSuccess,
                  width: 140.w,
                  height: 120.h,
                ),
              ),
              24.verticalSpace,

              // Success Title
              Text(
                title,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B5460),
                  height: 32 / 24,
                ),
              ),
              12.verticalSpace,

              // Success Subtitle
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

              const Spacer(),

              // Continue Button
              AppButton(
                label: LangKey.welcome.continueButton,
                onPressed: () {
                  final targetRoute = args?['targetRoute'] as String?;
                  if (targetRoute != null && targetRoute.isNotEmpty) {
                    Get.offAllNamed<dynamic>(targetRoute);
                  } else {
                    Get.offAllNamed<dynamic>(AppRoutes.parentToday);
                  }
                },
                isFullWidth: true,
                height: ButtonSize.large,
              ),
              24.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
