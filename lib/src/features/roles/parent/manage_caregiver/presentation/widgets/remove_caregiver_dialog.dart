import 'package:alurei/src/imports/imports.dart';

class RemoveCaregiverDialog extends StatelessWidget {
  const RemoveCaregiverDialog({
    super.key,
    required this.name,
    required this.roleCategory,
    required this.onConfirm,
  });

  final String name;
  final String roleCategory;
  final VoidCallback onConfirm;

  String _getDialogTitle() {
    switch (roleCategory) {
      case 'nanny':
        return LangKey.parentToday.removeNannyTitle;
      default:
        return LangKey.parentToday.removeCaregiverTitle;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: context.appColors.elevatedBackground,
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16.r),
                color: const Color(0xFFFEE4E2),
              ),
              child: Icon(
                IconsaxPlusLinear.trash,
                size: 28.sp,
                color: const Color(0xFFD92D20),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              _getDialogTitle(),
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 18.sp,
                height: 28 / 18,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              LangKey.parentToday.removeCaregiverDescription,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w400,
                color: context.appColors.mutedText,
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: context.appColors.bottomNavBorder,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppBorders.lg,
                        ),
                      ),
                      child: Text(
                        LangKey.parentToday.cancel,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          color: context.appColors.primaryText,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: SizedBox(
                    height: 48.h,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFD92D20),
                        shape: RoundedRectangleBorder(
                          borderRadius: AppBorders.lg,
                        ),
                      ),
                      child: Text(
                        LangKey.parentToday.remove,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
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
