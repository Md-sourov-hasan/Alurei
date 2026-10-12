import 'package:alurei/src/imports/imports.dart';
import '../controllers/cancel_membership_controller.dart';

class CancelMembershipConfirmScreen extends StatelessWidget {
  const CancelMembershipConfirmScreen({super.key});

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
                Text(
                  LangKey.membership.whatHappensWhenYouCancel,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                  ),
                ),
                24.verticalSpace,
                _buildInfoRow(
                  context: context,
                  icon: IconsaxPlusLinear.calendar,
                  text: LangKey.membership.accessContinuesUntil,
                ),
                16.verticalSpace,
                _buildInfoRow(
                  context: context,
                  icon: IconsaxPlusLinear.document_download,
                  text: LangKey.membership.savedStoriesDownloadable,
                ),
                16.verticalSpace,
                _buildInfoRow(
                  context: context,
                  icon: IconsaxPlusLinear.profile_2user,
                  text: LangKey.membership.householdLoseAccess,
                ),
                32.verticalSpace,
                AppButton(
                  label: LangKey.membership.cancelMembership,
                  variant: ButtonVariant.primary,
                  color: AppColors.errorColor,
                  isFullWidth: true,
                  onPressed: controller.onConfirmCancellation,
                ),
                16.verticalSpace,
                Center(
                  child: TextButton(
                    onPressed: controller.onKeepMembership,
                    child: Text(
                      LangKey.membership.keepMyMembership,
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

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String text,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: const BoxDecoration(
            color: AppColors.brandLogoLight,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 20.w,
            color: AppColors.primaryColor,
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Text(
              text,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: context.appColors.secondaryText,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
