import 'package:alurei/src/imports/imports.dart';
import '../controllers/cancel_membership_controller.dart';

class CancelMembershipScreen extends StatelessWidget {
  const CancelMembershipScreen({super.key});

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
                  LangKey.membership.beforeYouGo,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.headerTextColor,
                  ),
                ),
                16.verticalSpace,
                Text(
                  LangKey.membership.cancelReasonDesc,
                  textAlign: TextAlign.center,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.secondaryText,
                    height: 1.5,
                  ),
                ),
                24.verticalSpace,
                _buildReasonOption(LangKey.membership.reasonTooExpensive),
                12.verticalSpace,
                _buildReasonOption(LangKey.membership.reasonNotUsing),
                12.verticalSpace,
                _buildReasonOption(LangKey.membership.reasonSwitching),
                12.verticalSpace,
                _buildReasonOption(LangKey.membership.reasonSomethingElse),
                24.verticalSpace,
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.whiteBackgroundColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: TextField(
                    controller: controller.detailsController,
                    maxLines: 5,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      color: AppColors.headerTextColor,
                    ),
                    decoration: InputDecoration(
                      hintText: LangKey.membership.describeIssueHint,
                      hintStyle: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(16.w),
                    ),
                  ),
                ),
                24.verticalSpace,
                AppButton(
                  label: LangKey.membership.continueButton,
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: controller.onContinue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReasonOption(String text) {
    return Obx(() {
      final isSelected = controller.selectedReason.value == text;
      return GestureDetector(
        onTap: () => controller.selectReason(text),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.brandLogoLight : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color:
                  isSelected ? AppColors.primaryColor : const Color(0xFFE2E8F0),
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: AppColors.headerTextColor,
            ),
          ),
        ),
      );
    });
  }
}
