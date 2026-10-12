// ignore_for_file: deprecated_member_use

import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';

class ForgotPasswordScreen extends GetView<AuthController> {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                key: controller.forgotPasswordFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    110.verticalSpace,

                    // Title
                    Text(
                      LangKey.auth.forgotPasswordTitle,
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 36.sp,
                        fontWeight: FontWeight.w600,
                        height: 44 / 36,
                        letterSpacing: -0.72,
                        color: AppColors.brandGrayLight,
                      ),
                    ),
                    12.verticalSpace,

                    // Subtitle
                    Text(
                      LangKey.auth.forgotPasswordPhoneSubtitle,
                      textAlign: TextAlign.center,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                        color: AppColors.brandGrayLight,
                      ),
                    ),
                    48.verticalSpace,

                    // Select OTP options
                    RichText(
                      text: TextSpan(
                        text: LangKey.auth.selectOtpOptions,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.brandGrayLight,
                        ),
                        children: [
                          TextSpan(
                            text: '*',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.brandGrayLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                    12.verticalSpace,
                    Row(
                      children: [
                        Obx(() => Radio<String>(
                              value: 'phone',
                              groupValue: controller.selectedOtpOption.value,
                              onChanged: (val) =>
                                  controller.selectedOtpOption.value = val!,
                              activeColor: AppColors.brandGrayLight,
                              fillColor:
                                  WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected))
                                  return AppColors.primaryColor;
                                return AppColors.brandGrayLight;
                              }),
                            )),
                        Text(
                          LangKey.auth.phone,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            color: AppColors.brandGrayLight,
                          ),
                        ),
                        10.horizontalSpace,
                        Obx(() => Radio<String>(
                              value: 'email',
                              groupValue: controller.selectedOtpOption.value,
                              onChanged: (val) =>
                                  controller.selectedOtpOption.value = val!,
                              activeColor: AppColors.brandGrayLight,
                              fillColor:
                                  WidgetStateProperty.resolveWith((states) {
                                if (states.contains(WidgetState.selected))
                                  return AppColors.primaryColor;
                                return AppColors.brandGrayLight;
                              }),
                            )),
                        Text(
                          LangKey.auth.email,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            color: AppColors.brandGrayLight,
                          ),
                        ),
                      ],
                    ),
                    32.verticalSpace,

                    // Phone Input
                    Obx(() => AppTextField(
                          controller: controller.forgotPasswordPhoneController,
                          enabled: !controller.isLoading.value,
                          keyboardType: TextInputType.phone,
                          label: controller.selectedOtpOption.value == 'phone'
                              ? LangKey.auth.phoneNumber
                              : LangKey.auth.email,
                          labelStyle: GlobalTextStyles.interTextStyle(
                            fontSize: 17.sp,
                            color: AppColors.brandGrayLight,
                          ),
                          isRequired: true,
                          hint: controller.selectedOtpOption.value == 'phone'
                              ? LangKey.auth.phoneNumberOnlyHint
                              : LangKey.auth.emailOrPhoneHint,
                          prefixIcon: controller.selectedOtpOption.value ==
                                  'phone'
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset(
                                      AppAssets.flagBangladesh,
                                      width: 20.w,
                                      height: 20.h,
                                    ),
                                    8.horizontalSpace,
                                    Text(
                                      '+880',
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackTextColor,
                                      ),
                                    ),
                                    4.horizontalSpace,
                                    SvgPicture.asset(
                                      AppAssets.dropIcon,
                                      width: 8.w,
                                      height: 5.h,
                                    ),
                                  ],
                                )
                              : null,
                          validator: (v) {
                            if (AppUtils.isBlank(v)) {
                              return LangKey.auth.phoneRequired;
                            }
                            // Validation relaxed as per user request to allow any number
                            return null;
                          },
                        )),
                    60.verticalSpace,

                    // Button
                    Obx(() => AppButton(
                          label: LangKey.auth.sendCode,
                          isLoading: controller.isLoading.value,
                          onPressed: controller.isLoading.value
                              ? null
                              : () => controller.sendOtp(context),
                          isFullWidth: true,
                          height: ButtonSize.large,
                        )),
                    40.verticalSpace,
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
