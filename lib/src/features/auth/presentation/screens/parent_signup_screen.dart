import 'dart:io';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';
import 'package:alurei/src/features/auth/presentation/widgets/auth_progress_header.dart';
import 'package:alurei/src/features/auth/presentation/widgets/signup_verify_code_step.dart';
import 'package:alurei/src/features/auth/presentation/widgets/membership_card.dart';
import 'package:alurei/src/services/media_service.dart';
import 'package:image_picker/image_picker.dart';

import 'package:alurei/src/features/auth/presentation/providers/parent_signup_controller.dart';

class ParentSignupScreen extends StatelessWidget {
  const ParentSignupScreen({super.key});

  void _showRelationshipSelector(
    BuildContext context,
    TextEditingController controller,
    GlobalKey fieldKey,
  ) {
    FocusScope.of(context).unfocus();

    final renderBox = fieldKey.currentContext?.findRenderObject() as RenderBox?;
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
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildOption(controller, 'Father', closeMenu),
                    _buildOption(controller, 'Mother', closeMenu),
                    _buildOption(controller, 'Guardian', closeMenu),
                    _buildOption(controller, 'Other', closeMenu),
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

  void _showLanguageSelector(
    BuildContext context,
    TextEditingController controller,
    GlobalKey fieldKey,
  ) {
    FocusScope.of(context).unfocus();

    final renderBox = fieldKey.currentContext?.findRenderObject() as RenderBox?;
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
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildLanguageOption(context, controller, 'English (EN)', const Locale('en'), closeMenu),
                    _buildLanguageOption(context, controller, 'Arabic', const Locale('ar'), closeMenu),
                    _buildLanguageOption(context, controller, 'Filipino', const Locale('fil'), closeMenu),
                    _buildLanguageOption(context, controller, 'Sinhala', const Locale('si'), closeMenu),
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

  Widget _buildOption(
    TextEditingController controller,
    String value,
    VoidCallback closeMenu,
  ) {
    final isSelected = controller.text == value;

    return InkWell(
      onTap: () {
        controller.text = value;
        closeMenu();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border:
              isSelected ? null : Border.all(color: const Color(0xFFB3CACE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
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
                  border:
                      Border.all(color: const Color(0xFF94ADAD), width: 1.5.w),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    TextEditingController controller,
    String value,
    Locale locale,
    VoidCallback closeMenu,
  ) {
    final isSelected = controller.text == value;

    return InkWell(
      onTap: () {
        controller.text = value;
        context.setLocale(locale);
        closeMenu();
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.h),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor
              : AppColors.primaryBackgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border:
              isSelected ? null : Border.all(color: const Color(0xFFB3CACE)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
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
                  border:
                      Border.all(color: const Color(0xFF94ADAD), width: 1.5.w),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountStep(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController nameController,
    TextEditingController relationshipController,
    GlobalKey relationshipFieldKey,
    TextEditingController emailController,
    TextEditingController languageController,
    GlobalKey languageFieldKey,
    TextEditingController passwordController,
    TextEditingController confirmPasswordController,
    RxBool obscurePassword,
    RxBool obscureConfirmPassword,
    Rx<File?> profileImage,
    AuthController authController, {
    required VoidCallback onNext,
  }) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          30.verticalSpace,

          // Title
          Text(
            LangKey.auth.createParentAccount,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          28.verticalSpace,

          // Profile Image Upload Container
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await MediaService.instance
                        .pickImage(source: ImageSource.gallery);
                    result.fold(
                      (failure) => showToast(context,
                          message: failure.message, status: 'error'),
                      (file) {
                        if (file != null) {
                          profileImage.value = file;
                        }
                      },
                    );
                  },
                  child: Container(
                    width: 96.w,
                    height: 96.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryBackgroundColor,
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1.169.w,
                      ),
                    ),
                    child: ClipOval(
                      child: profileImage.value != null
                          ? Image.file(
                              profileImage.value!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Icon(
                                IconsaxPlusLinear.camera,
                                color: AppColors.brandGrayHint,
                                size: 32.w,
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final result = await MediaService.instance
                          .pickImage(source: ImageSource.gallery);
                      result.fold(
                        (failure) => showToast(context,
                            message: failure.message, status: 'error'),
                        (file) {
                          if (file != null) {
                            profileImage.value = file;
                          }
                        },
                      );
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconsaxPlusLinear.add,
                        color: Colors.white,
                        size: 18.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          32.verticalSpace,

          // Full Name
          AppTextField(
            controller: nameController,
            enabled: !authController.isLoading.value,
            label: 'Full Name',
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: 'Enter your full name',
            borderColor: AppColors.brandTealBorder,
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return LangKey.auth.nameRequired;
              }
              return null;
            },
          ),
          24.verticalSpace,

          // Relationship with children
          AppTextField(
            key: relationshipFieldKey,
            controller: relationshipController,
            enabled: !authController.isLoading.value,
            label: LangKey.auth.relationshipWithChildren,
            isRequired: false,
            hint: LangKey.auth.selectRelationship,
            readOnly: true,
            borderColor: AppColors.brandTealBorder,
            onTap: () => _showRelationshipSelector(
                context, relationshipController, relationshipFieldKey),
            suffixIcon: Icon(
              IconsaxPlusLinear.arrow_down,
              color: AppColors.brandGrayHint,
              size: 24.w,
            ),
          ),
          24.verticalSpace,

          // Email
          AppTextField(
            controller: emailController,
            enabled: !authController.isLoading.value,
            label: 'Email',
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: 'Enter your email',
            keyboardType: TextInputType.emailAddress,
            borderColor: AppColors.brandTealBorder,
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return LangKey.auth.emailRequired;
              }
              return null;
            },
          ),
          24.verticalSpace,

          // Preferred Language
          AppTextField(
            key: languageFieldKey,
            controller: languageController,
            enabled: !authController.isLoading.value,
            label: LangKey.auth.preferredLanguage,
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: LangKey.auth.enterPreferredLanguage,
            readOnly: true,
            borderColor: AppColors.brandTealBorder,
            onTap: () => _showLanguageSelector(
                context, languageController, languageFieldKey),
            suffixIcon: Icon(
              IconsaxPlusLinear.arrow_down,
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

          // Password
          AppTextField(
            controller: passwordController,
            enabled: !authController.isLoading.value,
            obscureText: obscurePassword.value,
            label: LangKey.auth.password,
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: LangKey.auth.enterYourPassword,
            borderColor: AppColors.brandTealBorder,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword.value
                    ? IconsaxPlusLinear.eye_slash
                    : IconsaxPlusLinear.eye,
                color: AppColors.brandGrayHint,
                size: 20.w,
              ),
              onPressed: () => obscurePassword.value = !obscurePassword.value,
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
          ),
          24.verticalSpace,

          // Confirm Password
          AppTextField(
            controller: confirmPasswordController,
            enabled: !authController.isLoading.value,
            obscureText: obscureConfirmPassword.value,
            label: LangKey.auth.confirmPassword,
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: LangKey.auth.reEnterYourPassword,
            borderColor: AppColors.brandTealBorder,
            suffixIcon: IconButton(
              icon: Icon(
                obscureConfirmPassword.value
                    ? IconsaxPlusLinear.eye_slash
                    : IconsaxPlusLinear.eye,
                color: AppColors.brandGrayHint,
                size: 20.w,
              ),
              onPressed: () =>
                  obscureConfirmPassword.value = !obscureConfirmPassword.value,
            ),
            validator: (v) {
              if (AppUtils.isBlank(v)) {
                return LangKey.auth.confirmPasswordRequired;
              }
              if (v != passwordController.text) {
                return LangKey.auth.passwordsDoNotMatch;
              }
              return null;
            },
          ),
          32.verticalSpace,

          // Continue Button
          Obx(() => AppButton(
                label: LangKey.welcome.continueButton,
                isLoading: authController.isLoading.value,
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        if (formKey.currentState?.validate() ?? false) {
                          onNext();
                        }
                      },
                isFullWidth: true,
                height: ButtonSize.large,
              )),
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
                      text: ' ${LangKey.auth.logIn}',
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

  Widget _buildAddressStep(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TextEditingController addressController,
    TextEditingController streetController,
    TextEditingController postalCodeController,
    TextEditingController cityController,
    TextEditingController stateController,
    TextEditingController phoneController,
    Rx<String> otpOption,
    Rx<File?> profileImage,
    AuthController authController, {
    required VoidCallback onNext,
  }) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          30.verticalSpace,

          // Title
          Text(
            LangKey.auth.createParentAccount,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          28.verticalSpace,

          // Profile Image Upload Container
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () async {
                    final result = await MediaService.instance
                        .pickImage(source: ImageSource.gallery);
                    result.fold(
                      (failure) => showToast(context,
                          message: failure.message, status: 'error'),
                      (file) {
                        if (file != null) {
                          profileImage.value = file;
                        }
                      },
                    );
                  },
                  child: Container(
                    width: 96.w,
                    height: 96.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryBackgroundColor,
                      border: Border.all(
                        color: const Color(0xFFE5E5E5),
                        width: 1.169.w,
                      ),
                    ),
                    child: ClipOval(
                      child: profileImage.value != null
                          ? Image.file(
                              profileImage.value!,
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Icon(
                                IconsaxPlusLinear.camera,
                                color: AppColors.brandGrayHint,
                                size: 32.w,
                              ),
                            ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: () async {
                      final result = await MediaService.instance
                          .pickImage(source: ImageSource.gallery);
                      result.fold(
                        (failure) => showToast(context,
                            message: failure.message, status: 'error'),
                        (file) {
                          if (file != null) {
                            profileImage.value = file;
                          }
                        },
                      );
                    },
                    child: Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconsaxPlusLinear.edit,
                        color: Colors.white,
                        size: 18.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          32.verticalSpace,

          // Enter Address
          AppTextField(
            controller: addressController,
            enabled: !authController.isLoading.value,
            label: LangKey.auth.enterAddress,
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: LangKey.auth.addressHint,
            borderColor: AppColors.brandTealBorder,
            validator: (v) {
              if (AppUtils.isBlank(v)) return 'Address is required';
              return null;
            },
          ),
          24.verticalSpace,

          // Street and Postal Code
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: streetController,
                  enabled: !authController.isLoading.value,
                  label: LangKey.auth.enterStreet,
                  isRequired: true,
                  asteriskColor: AppColors.brandDarkAsterisk,
                  hint: LangKey.auth.streetHint,
                  borderColor: AppColors.brandTealBorder,
                  validator: (v) {
                    if (AppUtils.isBlank(v)) return 'Street is required';
                    return null;
                  },
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: AppTextField(
                  controller: postalCodeController,
                  enabled: !authController.isLoading.value,
                  label: LangKey.auth.postalCode,
                  isRequired: true,
                  asteriskColor: AppColors.brandDarkAsterisk,
                  hint: LangKey.auth.postalCodeHint,
                  borderColor: AppColors.brandTealBorder,
                  keyboardType: TextInputType.number,
                  validator: (v) {
                    if (AppUtils.isBlank(v)) return 'Postal Code is required';
                    return null;
                  },
                ),
              ),
            ],
          ),
          24.verticalSpace,

          // City and State
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  controller: cityController,
                  enabled: !authController.isLoading.value,
                  label: LangKey.auth.enterCity,
                  isRequired: true,
                  asteriskColor: AppColors.brandDarkAsterisk,
                  hint: LangKey.auth.cityHint,
                  borderColor: AppColors.brandTealBorder,
                  validator: (v) {
                    if (AppUtils.isBlank(v)) return 'City is required';
                    return null;
                  },
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: AppTextField(
                  controller: stateController,
                  enabled: !authController.isLoading.value,
                  label: LangKey.auth.enterState,
                  isRequired: true,
                  asteriskColor: AppColors.brandDarkAsterisk,
                  hint: LangKey.auth.cityHint,
                  borderColor: AppColors.brandTealBorder,
                  validator: (v) {
                    if (AppUtils.isBlank(v)) return 'State is required';
                    return null;
                  },
                ),
              ),
            ],
          ),
          24.verticalSpace,

          // Phone Number
          AppTextField(
            controller: phoneController,
            enabled: !authController.isLoading.value,
            label: LangKey.auth.enterPhoneNumber,
            isRequired: true,
            asteriskColor: AppColors.brandDarkAsterisk,
            hint: LangKey.auth.phoneHint,
            borderColor: AppColors.brandTealBorder,
            keyboardType: TextInputType.phone,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 24.w,
                    height: 16.h,
                    color: Colors.green.shade800,
                    alignment: Alignment.center,
                    child: Container(
                      width: 8.w,
                      height: 8.h,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  8.horizontalSpace,
                  Text(
                    '+880',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackTextColor,
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(Icons.arrow_drop_down,
                      color: AppColors.brandGrayHint, size: 20.w),
                  8.horizontalSpace,
                ],
              ),
            ),
            validator: (v) {
              if (AppUtils.isBlank(v)) return 'Phone number is required';
              return null;
            },
          ),
          24.verticalSpace,

          // OTP Options
          Row(
            children: [
              Text(
                LangKey.auth.selectOtpOptions,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackTextColor,
                ),
              ),
              Text(
                '*',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.brandDarkAsterisk,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Row(
            children: [
              GestureDetector(
                onTap: () => otpOption.value = 'E-mail',
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: otpOption.value == 'E-mail'
                              ? AppColors.primaryColor
                              : const Color(0xFF94ADAD),
                          width: 1.5.w,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: otpOption.value == 'E-mail'
                          ? Container(
                              width: 10.w,
                              height: 10.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    8.horizontalSpace,
                    Text(
                      LangKey.auth.email,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              24.horizontalSpace,
              GestureDetector(
                onTap: () => otpOption.value = 'Phone',
                child: Row(
                  children: [
                    Container(
                      width: 20.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: otpOption.value == 'Phone'
                              ? AppColors.primaryColor
                              : const Color(0xFF94ADAD),
                          width: 1.5.w,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: otpOption.value == 'Phone'
                          ? Container(
                              width: 10.w,
                              height: 10.h,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ),
                    8.horizontalSpace,
                    Text(
                      'Phone',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          32.verticalSpace,

          // Continue Button
          Obx(() => AppButton(
                label: LangKey.welcome.continueButton,
                isLoading: authController.isLoading.value,
                onPressed: authController.isLoading.value
                    ? null
                    : () {
                        if (formKey.currentState?.validate() ?? false) {
                          onNext();
                        }
                      },
                isFullWidth: true,
                height: ButtonSize.large,
              )),
          40.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildMembershipStep(AuthController authController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        30.verticalSpace,
        // Title
        Text(
          LangKey.auth.chooseMembershipPlan,
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.blackTextColor,
            height: 1.3,
          ),
        ),
        8.verticalSpace,
        // Subtitle
        Text(
          LangKey.auth.membershipSubtitle,
          textAlign: TextAlign.center,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.brandGrayText,
          ),
        ),
        32.verticalSpace,

        // Plan Cards
        MembershipCard(
          childCount: 2,
          price: 60,
          onSelect: () {
            Get.toNamed<dynamic>(AppRoutes.membershipAgreement);
          },
          onComplimentarySelect: () {
            Get.offAllNamed<dynamic>(AppRoutes.parentToday);
          },
        ),
        24.verticalSpace,
        MembershipCard(
          childCount: 4,
          price: 120,
          onSelect: () {
            Get.toNamed<dynamic>(AppRoutes.membershipAgreement);
          },
          onComplimentarySelect: () {
            Get.offAllNamed<dynamic>(AppRoutes.parentToday);
          },
        ),
        24.verticalSpace,
        MembershipCard(
          childCount: 10,
          price: 300,
          onSelect: () {
            Get.toNamed<dynamic>(AppRoutes.membershipAgreement);
          },
          onComplimentarySelect: () {
            Get.offAllNamed<dynamic>(AppRoutes.parentToday);
          },
        ),
        24.verticalSpace,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ParentSignupController());
    final authController = Get.find<AuthController>();

    return Obx(() => PopScope(
          canPop: controller.currentStep.value == 0,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && controller.currentStep.value > 0) {
              controller.previousStep();
            }
          },
          child: Scaffold(
            backgroundColor: AppColors.primaryBackgroundColor,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    16.verticalSpace,

                    // Top Progress Bar
                    AuthProgressHeader(
                      activeSteps: controller.currentStep.value + 1,
                      totalSteps: 4,
                    ),

                    // Animated step body based on index
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: KeyedSubtree(
                        key: ValueKey<int>(controller.currentStep.value),
                        child: switch (controller.currentStep.value) {
                          0 => _buildAccountStep(
                              context,
                              controller.formKey,
                              controller.nameController,
                              controller.relationshipController,
                              controller.relationshipFieldKey,
                              controller.emailController,
                              controller.languageController,
                              controller.languageFieldKey,
                              controller.passwordController,
                              controller.confirmPasswordController,
                              controller.obscurePassword,
                              controller.obscureConfirmPassword,
                              controller.profileImage,
                              authController,
                              onNext: () {
                                controller.nextStep();
                              },
                            ),
                          1 => _buildAddressStep(
                              context,
                              controller.addressFormKey,
                              controller.addressController,
                              controller.streetController,
                              controller.postalCodeController,
                              controller.cityController,
                              controller.stateController,
                              controller.phoneController,
                              controller.otpOption,
                              controller.profileImage,
                              authController,
                              onNext: () {
                                authController.startVerifyTimer();
                                controller.nextStep();
                              },
                            ),
                          2 => SignupVerifyCodeStep(
                              onNext: () {
                                controller.nextStep();
                              },
                            ),
                          3 => _buildMembershipStep(authController),
                          _ => const SizedBox.shrink(),
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
