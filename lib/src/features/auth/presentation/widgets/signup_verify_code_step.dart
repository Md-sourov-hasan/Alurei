import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';
import 'package:alurei/src/features/auth/presentation/providers/auth_controller.dart';

class SignupVerifyCodeStep extends HookWidget {
  final VoidCallback onNext;

  const SignupVerifyCodeStep({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final controller = Get.find<AuthController>();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusNode.requestFocus();
      });
      return null;
    }, []);

    useListenable(controller.verifyCodeController);

    return Stack(
      children: [
        // Hidden text field to capture input
        Opacity(
          opacity: 0,
          child: SizedBox(
            width: 0,
            height: 0,
            child: TextFormField(
              focusNode: focusNode,
              controller: controller.verifyCodeController,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
          ),
        ),

        // UI elements
        Form(
          key: controller.verifyCodeFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.verticalSpace,
              Text(
                LangKey.auth.enterCodeTitle,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w600,
                  height: 44 / 36,
                  letterSpacing: -0.72,
                  color: AppColors.primaryColor,
                ),
              ),
              12.verticalSpace,
              Text(
                LangKey.auth.enterCodeSubtitle,
                textAlign: TextAlign.center,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 20 / 14,
                  color: AppColors.brandGrayText,
                ),
              ),
              48.verticalSpace,

              // OTP Fields
              GestureDetector(
                onTap: () => focusNode.requestFocus(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    final text = controller.verifyCodeController.text;
                    final char = text.length > index ? text[index] : '';
                    final isActive = text.length == index ||
                        (text.length == 4 && index == 3 && focusNode.hasFocus);

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12.w),
                      width: 64.w,
                      height: 64.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAFEFE),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: isActive ? const Color(0xFFB4CACE) : const Color(0xFFD5D7DA),
                          width: 1,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        char.isNotEmpty ? char : '0',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w500,
                          color: char.isNotEmpty
                              ? AppColors.primaryColor
                              : const Color(0xFFD5D7DA),
                          height: 1,
                        ),
                      ),
                    );
                  }),
                ),
              ),
              32.verticalSpace,

              // Timer / Resend Code
              Center(
                child: Obx(() {
                  final seconds = controller.secondsRemaining.value;
                  return seconds > 0
                      ? RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.blackTextColor,
                            ),
                            children: [
                              TextSpan(text: LangKey.auth.resendCodeIn),
                              TextSpan(
                                text: '${seconds}s',
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : TextButton(
                          onPressed: () => controller.resendOtp(context),
                          child: Text(
                            LangKey.auth.resendCodeAction,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        );
                }),
              ),
              48.verticalSpace,

              // Confirm Code Button
              Obx(() => AppButton(
                    label: LangKey.auth.confirmCode,
                    isLoading: controller.isLoading.value,
                    onPressed: controller.verifyCodeController.text.length == 4
                        ? () {
                            controller.verifyCodeController.clear();
                            onNext();
                          }
                        : null,
                    isFullWidth: true,
                    height: ButtonSize.large,
                  )),
              40.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
