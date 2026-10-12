import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final isNanny = args?['role'] == 'nanny';

    return Scaffold(
      backgroundColor: AppColors.primaryBackgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppAssets.loginBg,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Form(
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 70.h),

                    // Title
                    Text(
                      LangKey.auth.logIn,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        height: 44 / 36,
                        letterSpacing: -0.72,
                        color: AppColors.brandGrayLight,
                      ),
                    ),
                    Text(
                      LangKey.auth.enterPhoneOrEmail,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        height: 44 / 36,
                        letterSpacing: -0.72,
                        color: AppColors.brandGrayLight,
                      ),
                    ),

                    SizedBox(height: 50.h),

                    // Phone/Email Field
                    Obx(() => AppTextField(
                          label: LangKey.auth.emailOrPhone,
                          labelStyle: GlobalTextStyles.interTextStyle(
                            fontSize: 17.sp,
                            color: AppColors.brandGrayLight,
                          ),
                          asteriskColor: AppColors.brandGrayLight,
                          isRequired: true,
                          controller: controller.loginPhoneOrEmailController,
                          hint: LangKey.auth.phoneNumberHint,
                          enabled: !controller.isLoading.value,
                          validator: (v) {
                            if (AppUtils.isBlank(v)) {
                              return LangKey.auth.emailOrPhoneRequired;
                            }
                            return null;
                          },
                        )),

                    SizedBox(height: 24.h),

                    // Password Field
                    Obx(() => AppTextField(
                          label: LangKey.auth.password,
                          labelStyle: GlobalTextStyles.interTextStyle(
                            fontSize: 17.sp,
                            color: AppColors.brandGrayLight,
                          ),
                          asteriskColor: AppColors.brandGrayLight,
                          isRequired: true,
                          controller: controller.loginPasswordController,
                          hint: LangKey.auth.logInSubtitle,
                          obscureText: controller.obscurePassword.value,
                          enabled: !controller.isLoading.value,
                          suffixIcon: GestureDetector(
                            onTap: controller.toggleObscurePassword,
                            child: Icon(
                              controller.obscurePassword.value
                                  ? IconsaxPlusLinear.eye_slash
                                  : IconsaxPlusLinear.eye,
                              color: AppColors.brandGrayHint,
                              size: 24.w,
                            ),
                          ),
                          validator: (v) {
                            if (AppUtils.isBlank(v)) {
                              return LangKey.auth.passwordRequired;
                            }
                            if (v!.length < 6) {
                              return LangKey.auth.passwordTooShort;
                            }
                            return null;
                          },
                        )),

                    SizedBox(height: 12.h),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () =>
                            Get.toNamed<dynamic>(AppRoutes.forgotPassword),
                        child: Text(
                          LangKey.auth.forgotPassword,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.brandGrayLight,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 48.h),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: Obx(() => AppButton(
                            label: LangKey.auth.loginButton,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.brandGrayLight,
                            ),
                            isLoading: controller.isLoading.value,
                            onPressed: () => controller.loginWithForm(context),
                            color: AppColors.primaryColor,
                            textColor: AppColors.brandGrayLight,
                            isFullWidth: true,
                          )),
                    ),

                    SizedBox(height: 24.h),

                    // Register Link
                    InkWell(
                      onTap: () {
                        if (isNanny) {
                          Get.toNamed<dynamic>(AppRoutes.nannySignup);
                        } else {
                          Get.toNamed<dynamic>(AppRoutes.parentSignup);
                        }
                      },
                      child: RichText(
                        text: TextSpan(
                          text: LangKey.auth.dontHaveAccount,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.brandGrayLight,
                          ),
                          children: [
                            TextSpan(
                              text: LangKey.auth.register,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.brandGrayLight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
