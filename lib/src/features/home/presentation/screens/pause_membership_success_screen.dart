import 'package:alurei/src/imports/imports.dart';
import '../controllers/pause_membership_controller.dart';

class PauseMembershipSuccessScreen extends StatelessWidget {
  const PauseMembershipSuccessScreen({super.key});

  PauseMembershipController get controller {
    if (!Get.isRegistered<PauseMembershipController>()) {
      Get.put(PauseMembershipController());
    }
    return Get.find<PauseMembershipController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: LangKey.membership.pauseMembershipTitle,
        titleColor: AppColors.headerTextColor,
        showBackButton: true,
        showDivider: false,
        onPressed: () => Get.back<void>(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                LangKey.membership.subscriptionPausedMessage,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: context.appColors.secondaryText,
                  height: 1.5,
                ),
              ),
              64.verticalSpace,
              Center(
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.primaryColor,
                      width: 4.w,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Transform.flip(
                    flipX: true,
                    child: Icon(
                      Icons.play_arrow_rounded, // or IconsaxPlusBold.play
                      size: 40.w,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              64.verticalSpace,
              AppButton(
                label: LangKey.membership.resumeSubscriptionsBtn,
                variant: ButtonVariant.primary,
                isFullWidth: true,
                onPressed: () {
                  // Pop back to home after resuming
                  Get.until((route) =>
                      route.settings.name == AppRoutes.main ||
                      route.settings.name == AppRoutes.home);
                  showGlobalToast(
                      message: LangKey.parentHome.subscriptionsResumed);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
