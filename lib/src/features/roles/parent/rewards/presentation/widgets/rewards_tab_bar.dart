import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_rewards_controller.dart';

class RewardsTabBar extends StatelessWidget {
  const RewardsTabBar({
    super.key,
    required this.controller,
  });

  final ParentRewardsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.bottomNavSelectedBackground,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              final isSelected = controller.selectedCategoryTab.value == 0;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  controller.changeCategoryTab(0);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.transparentColor,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Text(
                    LangKey.parentActivities.filterAll,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.brandDarkAsterisk,
                    ),
                  ),
                ),
              );
            }),
          ),
          Expanded(
            child: Obx(() {
              final isSelected = controller.selectedCategoryTab.value == 1;
              return GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  controller.changeCategoryTab(1);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.transparentColor,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Text(
                    LangKey.rewards.filterSaved,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.brandDarkAsterisk,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
