import 'package:alurei/src/features/settings/presentation/controllers/change_password_controller.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      appBar: AppTopBar(
        title: LangKey.changePasswordScreen.title,
      ),
      body: Container(
        height: double.infinity,
        margin: EdgeInsets.only(top: 12.h),
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Form(
            key: controller.changePasswordFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.changePasswordScreen.updateSecurity,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  LangKey.changePasswordScreen.subtitle,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.mutedText,
                  ),
                ),
                SizedBox(height: 24.h),

                // Current Password Field
                Obx(
                  () => AppTextField(
                    label: LangKey.changePasswordScreen.currentPassword,
                    isRequired: true,
                    hint: LangKey.changePasswordScreen.enterPasswordHint,
                    controller: controller.changePasswordCurrentController,
                    obscureText: controller.obscureCurrentPassword.value,
                    enabled: !controller.isLoading.value,
                    validator: (v) {
                      if (AppUtils.isBlank(v)) {
                        return LangKey
                            .changePasswordScreen.currentPasswordRequired;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureCurrentPassword.value
                            ? IconsaxPlusLinear.eye_slash
                            : IconsaxPlusLinear.eye,
                        color: context.appColors.disabledText,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleObscureCurrentPassword,
                    ),
                  ),
                ),
                SizedBox(height: 6.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      showGlobalToast(
                        message: 'Reset password link sent to your email.',
                      );
                    },
                    borderRadius: BorderRadius.circular(4.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        LangKey.changePasswordScreen.forgotPassword,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Divider(
                  height: 1.h,
                  thickness: 1.r,
                  color: context.appColors.bottomNavBorder,
                ),
                SizedBox(height: 16.h),

                // New Password Field
                Obx(
                  () => AppTextField(
                    label: LangKey.changePasswordScreen.newPassword,
                    isRequired: true,
                    hint: LangKey.changePasswordScreen.enterPasswordHint,
                    controller: controller.changePasswordNewController,
                    obscureText: controller.obscureNewPassword.value,
                    enabled: !controller.isLoading.value,
                    validator: (v) {
                      if (AppUtils.isBlank(v)) {
                        return LangKey.changePasswordScreen.newPasswordRequired;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureNewPassword.value
                            ? IconsaxPlusLinear.eye_slash
                            : IconsaxPlusLinear.eye,
                        color: context.appColors.disabledText,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleObscureNewPassword,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Confirm Password Field
                Obx(
                  () => AppTextField(
                    label: LangKey.changePasswordScreen.confirmNewPassword,
                    isRequired: true,
                    hint: LangKey.changePasswordScreen.enterPasswordHint,
                    controller: controller.changePasswordConfirmController,
                    obscureText: controller.obscureConfirmPassword.value,
                    enabled: !controller.isLoading.value,
                    validator: (v) {
                      if (AppUtils.isBlank(v)) {
                        return LangKey
                            .changePasswordScreen.confirmPasswordRequired;
                      }
                      if (v != controller.changePasswordNewController.text) {
                        return LangKey.changePasswordScreen.passwordsDoNotMatch;
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value
                            ? IconsaxPlusLinear.eye_slash
                            : IconsaxPlusLinear.eye,
                        color: context.appColors.disabledText,
                        size: 20.sp,
                      ),
                      onPressed: controller.toggleObscureConfirmPassword,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Password Requirements Box
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: context.appColors.elevatedBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(
                      color: context.appColors.bottomNavBorder,
                      width: 1.r,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LangKey.changePasswordScreen.passwordRequirements,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Obx(
                        () => _buildRequirementItem(
                          context,
                          label: LangKey.changePasswordScreen.req8Chars,
                          isMet: controller.changePasswordHas8Chars.value,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => _buildRequirementItem(
                          context,
                          label: LangKey.changePasswordScreen.reqSpecialChar,
                          isMet: controller.changePasswordHasSpecialChar.value,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => _buildRequirementItem(
                          context,
                          label: LangKey.changePasswordScreen.reqNumber,
                          isMet: controller.changePasswordHasNumber.value,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => _buildRequirementItem(
                          context,
                          label: LangKey.changePasswordScreen.reqMatch,
                          isMet: controller.changePasswordPasswordsMatch.value,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),

                // Save Password Button
                Obx(
                  () => AppButton(
                    label: LangKey.changePasswordScreen.savePassword,
                    isFullWidth: true,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.saveNewPassword(context),
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRequirementItem(
    BuildContext context, {
    required String label,
    required bool isMet,
  }) {
    return Row(
      children: [
        Icon(
          isMet ? IconsaxPlusBold.tick_circle : IconsaxPlusLinear.record_circle,
          color:
              isMet ? AppColors.supportingGreen : context.appColors.mutedText,
          size: 18.sp,
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: isMet
                  ? context.colors.onSurface
                  : context.appColors.mutedText,
            ),
          ),
        ),
      ],
    );
  }
}
