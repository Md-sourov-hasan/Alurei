import 'package:alurei/src/imports/imports.dart';

/// Reusable confirmation dialog widget with customizable title, message, and action buttons.
class AppConfirmationDialog extends StatelessWidget {
  const AppConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
    required this.onConfirm,
    required this.onCancel,
    this.primaryConfirm = false,
    this.headerIcon,
    this.confirmButtonColor,
    this.confirmButtonTextColor,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  final bool primaryConfirm;
  final Widget? headerIcon;
  final Color? confirmButtonColor;
  final Color? confirmButtonTextColor;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.appColors.elevatedBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 28.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (headerIcon != null) ...[
              headerIcon!,
              20.verticalSpace,
            ],
            Text(
              title,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.headerTextColor,
                height: 28 / 22,
              ),
            ),
            12.verticalSpace,
            Text(
              message,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.mutedTextColor,
                height: 24 / 16,
              ),
            ),
            28.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: cancelLabel,
                    variant: primaryConfirm
                        ? ButtonVariant.outline
                        : ButtonVariant.primary,
                    color: primaryConfirm ? null : AppColors.primaryColor,
                    textColor: primaryConfirm
                        ? AppColors.headerTextColor
                        : AppColors.whiteColor,
                    borderColor: primaryConfirm ? AppColors.inputBorder : null,
                    onPressed: onCancel,
                    height: ButtonSize.medium,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: AppButton(
                    label: confirmLabel,
                    variant: primaryConfirm
                        ? ButtonVariant.primary
                        : ButtonVariant.outline,
                    color: confirmButtonColor ?? (primaryConfirm ? AppColors.primaryColor : null),
                    textColor: confirmButtonTextColor ?? (primaryConfirm
                        ? AppColors.whiteColor
                        : AppColors.headerTextColor),
                    borderColor: primaryConfirm ? null : AppColors.inputBorder,
                    onPressed: onConfirm,
                    height: ButtonSize.medium,
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

/// Helper function to display the reusable confirmation dialog
Future<bool?> showAppConfirmationDialog({
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
  bool primaryConfirm = false,
  Widget? headerIcon,
  Color? confirmButtonColor,
  Color? confirmButtonTextColor,
}) {
  return showAppDialog<bool>(
    child: AppConfirmationDialog(
      title: title,
      message: message,
      confirmLabel: confirmLabel ?? LangKey.parentKitchen.yes,
      cancelLabel: cancelLabel ?? LangKey.parentKitchen.no,
      primaryConfirm: primaryConfirm,
      onConfirm: () => Get.back(result: true),
      onCancel: () => Get.back(result: false),
    ),
  );
}
