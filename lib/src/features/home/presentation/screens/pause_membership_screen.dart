import 'package:alurei/src/imports/imports.dart';
import '../controllers/pause_membership_controller.dart';

class PauseMembershipScreen extends StatelessWidget {
  const PauseMembershipScreen({super.key});

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
                  child: Icon(
                    IconsaxPlusLinear.pause_circle,
                    size: 48.w,
                    color: AppColors.primaryColor, // Teal color as per design
                  ),
                ),
                24.verticalSpace,
                Text(
                  LangKey.membership.pauseMembershipDesc,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: context.appColors.secondaryText,
                    height: 1.5,
                  ),
                ),
                32.verticalSpace,
                Text(
                  LangKey.membership.selectDuration,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.headerTextColor,
                  ),
                ),
                16.verticalSpace,
                Row(
                  children: [
                    Expanded(
                        child: _buildDurationChip(LangKey.membership.twoWeeks)),
                    8.horizontalSpace,
                    Expanded(
                        child:
                            _buildDurationChip(LangKey.membership.fourWeeks)),
                    8.horizontalSpace,
                    Expanded(
                        child:
                            _buildDurationChip(LangKey.membership.chooseDate)),
                  ],
                ),
                32.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      IconsaxPlusLinear.info_circle,
                      size: 20.w,
                      color: AppColors.primaryColor, // Teal color
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Text(
                          LangKey.membership.nextBillingDateNotice,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: context.appColors.secondaryText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                32.verticalSpace,
                AppButton(
                  label: LangKey.membership.pauseSubscriptionsBtn,
                  variant: ButtonVariant.primary,
                  isFullWidth: true,
                  onPressed: controller.onPauseSubscriptions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurationChip(String text) {
    return Obx(() {
      final isSelected = controller.selectedDuration.value == text;
      return GestureDetector(
        onTap: () => controller.selectDuration(text),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
            borderRadius: BorderRadius.circular(999.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primaryColor
                  : AppColors.brandGrayBorder,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              color:
                  isSelected ? AppColors.whiteColor : AppColors.headerTextColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    });
  }
}
