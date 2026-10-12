import 'package:alurei/src/imports/imports.dart';

class AppErrorDialog extends StatelessWidget {
  const AppErrorDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonLabel = 'Got it',
  });

  final String title;
  final String message;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.appColors.elevatedBackground,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 68.w,
              height: 68.w,
              decoration: BoxDecoration(
                color: context.colors.error.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  width: 46.w,
                  height: 46.w,
                  decoration: BoxDecoration(
                    color: context.colors.error.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    IconsaxPlusLinear.warning_2,
                    color: context.colors.error,
                    size: 26.sp,
                  ),
                ),
              ),
            ),
            20.verticalSpace,
            Text(
              title,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                height: 28 / 20,
                fontWeight: FontWeight.w700,
                color: context.appColors.primaryText,
              ),
            ),
            10.verticalSpace,
            Text(
              message,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 22 / 14,
                fontWeight: FontWeight.w400,
                color: context.appColors.secondaryText,
              ),
            ),
            24.verticalSpace,
            AppButton(
              label: buttonLabel,
              onPressed: Get.back<void>,
              isFullWidth: true,
              color: context.colors.error,
              textColor: context.colors.onError,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showAppErrorDialog({
  required String title,
  required String message,
  String buttonLabel = 'Got it',
}) {
  return showAppDialog<void>(
    child: AppErrorDialog(
      title: title,
      message: message,
      buttonLabel: buttonLabel,
    ),
  );
}
