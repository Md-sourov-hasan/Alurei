import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';

class SignupAccountStep extends StatelessWidget {
  final VoidCallback onNext;

  const SignupAccountStep({super.key, required this.onNext});

  void _showLanguageSelector(BuildContext context, AuthController controller) {
    FocusScope.of(context).unfocus();

    final renderBox =
        controller.signupLanguageFieldKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    OverlayEntry? overlayEntry;

    void closeMenu() {
      overlayEntry?.remove();
      overlayEntry = null;
    }

    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: closeMenu,
              behavior: HitTestBehavior.opaque,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 4.h,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLanguageOption(context, controller, 'English (EN)', 'en', closeMenu),
                    _buildLanguageOption(context, controller, 'Arabic', 'ar', closeMenu),
                    _buildLanguageOption(context, controller, 'Filipino', 'fil', closeMenu),
                    _buildLanguageOption(context, controller, 'Sinhala', 'si', closeMenu),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  Widget _buildLanguageOption(
    BuildContext context,
    AuthController controller,
    String name,
    String code,
    VoidCallback closeMenu,
  ) {
    final isSelected = controller.signupLanguageController.text == name;

    return InkWell(
      onTap: () {
        controller.signupLanguageController.text = name;
        closeMenu();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected ? null : Border.all(color: const Color(0xFFB3CACE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.blackTextColor,
              ),
            ),
            if (isSelected)
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.w),
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 10.w,
                  height: 10.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              )
            else
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF94ADAD), width: 1.5.w),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Form(
      key: controller.signupFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          30.verticalSpace,

          // Title
          Text(
            LangKey.auth.createNannyAccount,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          24.verticalSpace,

          // Photo Picker
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 96.w,
                  height: 96.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E5E5),
                      width: 1.169.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    AppAssets.cameraIcon,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: SvgPicture.asset(
                    AppAssets.plusBadge,
                    width: 32.w,
                    height: 32.h,
                  ),
                ),
              ],
            ),
          ),
          32.verticalSpace,

          // Full Name Field
          AppTextField(
            controller: controller.signupNameController,
            enabled: !controller.isLoading.value,
            label: LangKey.auth.fullName,
            isRequired: true,
            hint: 'Deepa Kumari',
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return LangKey.auth.nameRequired;
              }
              return null;
            },
          ),
          24.verticalSpace,

          // Phone Number Field
          AppTextField(
            controller: controller.signupPhoneController,
            enabled: !controller.isLoading.value,
            label: LangKey.auth.phoneNumber,
            isRequired: true,
            hint: LangKey.auth.phoneNumberOnlyHint,
            keyboardType: TextInputType.phone,
            prefixIcon: Row(
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
            ),
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return LangKey.auth.phoneRequired;
              }
              return null;
            },
          ),
          24.verticalSpace,

          // Preferred Language Dropdown
          AppTextField(
            key: controller.signupLanguageFieldKey,
            controller: controller.signupLanguageController,
            enabled: !controller.isLoading.value,
            label: LangKey.auth.preferredLanguage,
            isRequired: true,
            hint: LangKey.auth.enterPreferredLanguage,
            readOnly: true,
            onTap: () => _showLanguageSelector(context, controller),
            suffixIcon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.brandGrayHint,
              size: 24.w,
            ),
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return 'Preferred language is required';
              }
              return null;
            },
          ),
          24.verticalSpace,

          // Password Field
          Obx(() => AppTextField(
                controller: controller.signupPasswordController,
                enabled: !controller.isLoading.value,
                obscureText: controller.obscureSignupPassword.value,
                label: LangKey.auth.password,
                isRequired: true,
                hint: LangKey.auth.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureSignupPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.brandGrayHint,
                    size: 20.w,
                  ),
                  onPressed: controller.toggleObscureSignupPassword,
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
          24.verticalSpace,

          // Confirm Password Field
          Obx(() => AppTextField(
                controller: controller.signupConfirmPasswordController,
                enabled: !controller.isLoading.value,
                obscureText: controller.obscureSignupConfirmPassword.value,
                label: LangKey.auth.confirmPassword,
                isRequired: true,
                hint: LangKey.auth.confirmPassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscureSignupConfirmPassword.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.brandGrayHint,
                    size: 20.w,
                  ),
                  onPressed: controller.toggleObscureSignupConfirmPassword,
                ),
                validator: (v) {
                  if (AppUtils.isBlank(v)) {
                    return LangKey.auth.confirmPasswordRequired;
                  }
                  if (v != controller.signupPasswordController.text) {
                    return LangKey.auth.passwordsDoNotMatch;
                  }
                  return null;
                },
              )),
          32.verticalSpace,

          // Continue Button
          Obx(() => AppButton(
                label: LangKey.welcome.continueButton,
                isLoading: controller.isLoading.value,
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                        if (controller.signupFormKey.currentState?.validate() ?? false) {
                          onNext();
                        }
                      },
                isFullWidth: true,
                height: ButtonSize.large,
              )),
          32.verticalSpace,

          // Or Login With Google
          Center(
            child: Text(
              LangKey.auth.orText,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.brandGrayText,
              ),
            ),
          ),
          12.verticalSpace,

          // Google Button
          Center(
            child: InkWell(
              onTap: () {
                // Google Sign In
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.brandGrayBorder),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.socialIcon,
                      width: 24.w,
                      height: 24.w,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      LangKey.auth.signInWithGoogle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.brandGrayDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          32.verticalSpace,

          // Already have an account? Login
          Center(
            child: InkWell(
              onTap: () => Get.back<dynamic>(),
              child: RichText(
                text: TextSpan(
                  text: LangKey.auth.alreadyHaveAccount,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.brandGrayText,
                  ),
                  children: [
                    TextSpan(
                      text: LangKey.auth.logIn,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          40.verticalSpace,
        ],
      ),
    );
  }
}
