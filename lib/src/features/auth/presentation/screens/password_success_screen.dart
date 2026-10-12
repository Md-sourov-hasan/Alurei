import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.successBg,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  300.verticalSpace,

                  // Success SVG
                  Center(
                    child: SvgPicture.asset(
                      AppAssets.passwordSuccess,
                      width: 150.w,
                      height: 130.h,
                    ),
                  ),
                  5.verticalSpace,

                  // Success Title
                  Text(
                    LangKey.auth.passwordSuccessTitle,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.brandGrayLight,
                      letterSpacing: -0.72,
                    ),
                  ),
                  8.verticalSpace,

                  // Success Subtitle
                  Text(
                    LangKey.auth.passwordSuccessSubtitle,
                    textAlign: TextAlign.center,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.brandGrayLight,
                    ),
                  ),

                  const Spacer(),

                  // Continue Button
                  AppButton(
                    label: LangKey.welcome.continueButton,
                    onPressed: () {
                      final args = Get.arguments as Map<String, dynamic>?;
                      if (args != null &&
                          args['fromAcceptInvitation'] == true) {
                        Get.offAllNamed<dynamic>(AppRoutes.parentToday);
                      } else {
                        Get.offAllNamed<dynamic>(AppRoutes.login);
                      }
                    },
                    isFullWidth: true,
                    height: ButtonSize.large,
                    color: AppColors.primaryColor,
                    textColor: AppColors.brandGrayLight,
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
