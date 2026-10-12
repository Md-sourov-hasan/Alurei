part of 'todays_child_profile_widgets.dart';

class TodaysChildQuickActionsCard extends StatelessWidget {
  const TodaysChildQuickActionsCard({
    super.key,
    required this.onBuildNewDay,
    required this.onEditDay,
    required this.onRegenerate,
  });

  final VoidCallback onBuildNewDay;
  final VoidCallback onEditDay;
  final VoidCallback onRegenerate;

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      title: LangKey.parentToday.quickActions,
      elevated: true,
      child: Column(
        children: [
          _QuickActionRow(
            icon: IconsaxPlusLinear.calendar_add,
            title: LangKey.parentToday.buildNewDay,
            subtitle: LangKey.parentToday.buildNewDayDescription,
            onTap: onBuildNewDay,
          ),
          _QuickActionRow(
            icon: IconsaxPlusLinear.edit_2,
            title: LangKey.parentToday.editDay,
            subtitle: LangKey.parentToday.editDayDescription,
            onTap: onEditDay,
          ),
          _QuickActionRow(
            icon: IconsaxPlusLinear.magic_star,
            title: LangKey.parentToday.regenerateTimeline,
            subtitle: LangKey.parentToday.regenerateTimelineDescription,
            onTap: onRegenerate,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

Future<bool?> showTodaysChildDeleteDialog({required String childName}) {
  return showAppDialog<bool>(
    barrierColor: AppColors.black40,
    child: TodaysChildDeleteDialog(childName: childName),
  );
}

class TodaysChildDeleteDialog extends StatelessWidget {
  const TodaysChildDeleteDialog({super.key, required this.childName});

  final String childName;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 48.w),
      backgroundColor: AppColors.transparentColor,
      elevation: 0,
      child: Container(
        width: 345.w,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: context.colors.error.withValues(alpha: 0.10),
                borderRadius: AppBorders.md,
              ),
              child: SvgPicture.asset(
                AppAssets.parentTodayDeleteDialogIcon,
                width: 20.w,
                height: 20.w,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              LangKey.parentToday.removeChildTitle.replaceAll('{}', childName),
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              LangKey.parentToday.removeChildMessage
                  .replaceAll('{}', childName),
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: context.appColors.disabledText,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(result: false),
                    style: OutlinedButton.styleFrom(
                      fixedSize: Size.fromHeight(46.h),
                      foregroundColor: context.appColors.disabledText,
                      side:
                          BorderSide(color: context.appColors.bottomNavBorder),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppBorders.lg,
                      ),
                    ),
                    child: Text(
                      LangKey.parentToday.cancel,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.disabledText,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Get.back(result: true),
                    style: FilledButton.styleFrom(
                      fixedSize: Size.fromHeight(46.h),
                      backgroundColor: AppColors.deleteRed,
                      foregroundColor: AppColors.whiteColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppBorders.lg,
                      ),
                    ),
                    child: Text(
                      LangKey.parentToday.delete,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
