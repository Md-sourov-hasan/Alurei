import 'package:alurei/src/imports/imports.dart';
import '../controllers/cancel_membership_controller.dart';

class CancelMembershipSuccessScreen extends StatelessWidget {
  const CancelMembershipSuccessScreen({super.key});

  CancelMembershipController get controller {
    if (!Get.isRegistered<CancelMembershipController>()) {
      Get.put(CancelMembershipController());
    }
    return Get.find<CancelMembershipController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.membership.cancelMembershipTitle,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            padding: EdgeInsets.all(24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                16.verticalSpace,
                Center(
                  child: SizedBox(
                    width: 80.w,
                    height: 80.w,
                    child: Stack(
                      children: [
                        Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.whiteColor,
                            border: Border.all(
                              color: AppColors.brandGrayBorder,
                              width: 1.w,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            IconsaxPlusLinear.calendar,
                            size: 40.w,
                            color: const Color(
                                0xFF94A3B8), // Muted grey color for the icon as per design
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.whiteColor,
                            ),
                            padding: EdgeInsets.all(2.w),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                              ),
                              padding: EdgeInsets.all(4.w),
                              child: Icon(
                                Icons.check,
                                size: 12.w,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,
                Text(
                  LangKey.membership.membershipCancelled,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                  ),
                ),
                16.verticalSpace,
                Text(
                  LangKey.membership.membershipCancelledDesc,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.secondaryText,
                    height: 1.5,
                  ),
                ),
                32.verticalSpace,
                AppButton(
                  label: LangKey.membership.backToHome,
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: () => Get.until((route) =>
                      route.settings.name == AppRoutes.main ||
                      route.settings.name == AppRoutes.home),
                ),
                32.verticalSpace,
                Text(
                  LangKey.membership.changedYourMind,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.headerTextColor,
                  ),
                ),
                8.verticalSpace,
                Center(
                  child: TextButton(
                    onPressed: () => Get.until((route) =>
                        route.settings.name == AppRoutes.membershipAgreement ||
                        route.settings.name == AppRoutes.home),
                    child: Text(
                      LangKey.membership.reactivateMembership,
                      style: context.textTheme.labelLarge?.copyWith(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
