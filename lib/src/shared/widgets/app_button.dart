import '../../imports/imports.dart';

/// A fully themed button supporting all [ButtonVariant]s and [ButtonSize]s.
///
/// Usage:
/// ```dart
/// AppButton(
///   label: 'Save',
///   onPressed: _save,
///   variant: ButtonVariant.primary,
///   size: ButtonSize.large,
///   isLoading: state.isLoading,
/// )
/// ```
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.style,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.color,
    this.textColor,
    this.borderColor,
    this.height = ButtonSize.medium,
    this.width,
    this.isLoading = false,
    this.isFullWidth = false,
    this.prefixIcon,
    this.suffixIcon,
    this.isVertical = false,
  });

  final String label;
  final TextStyle? style;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final ButtonSize height;
  final ButtonSize? width;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    final cs = context.theme.colorScheme;
    final appColors = context.theme.extension<AppColorsExtension>()!;
    final isDisabled = onPressed == null || isLoading;

    final double buttonHeight = isVertical
        ? 74.h
        : switch (height) {
            ButtonSize.small => 36.h,
            ButtonSize.medium => 48.h,
            ButtonSize.large => 56.h,
          };

    final double? buttonWidth = switch (width) {
      ButtonSize.small => 100.w,
      ButtonSize.medium => 150.w,
      ButtonSize.large => 200.w,
      null => null,
    };

    final double horizontalPadding = switch (height) {
      ButtonSize.small => 12.w,
      ButtonSize.medium => 20.w,
      ButtonSize.large => 28.w,
    };

    final double fontSize = switch (height) {
      ButtonSize.small => 12.sp,
      ButtonSize.medium => 14.sp,
      ButtonSize.large => 16.sp,
    };

    final (bg, fg, border) = switch (variant) {
      ButtonVariant.primary => (
          color ?? AppColors.primaryButtonColor,
          textColor ?? cs.onPrimary,
          null
        ),
      ButtonVariant.secondary => (
          cs.secondaryContainer,
          cs.onSecondaryContainer,
          null
        ),
      ButtonVariant.outline => (
          AppColors.transparentColor,
          textColor ?? cs.primary,
          BorderSide(color: borderColor ?? cs.outline, width: 1.5)
        ),
      ButtonVariant.ghost => (AppColors.transparentColor, cs.primary, null),
      ButtonVariant.danger => (cs.error, cs.onError, null),
      ButtonVariant.success => (appColors.success, appColors.onSuccess, null),
    };

    final child = AnimatedSwitcher(
      duration: AppDurations.fast,
      switchInCurve: AppCurves.decelerate,
      child: isLoading
          ? SizedBox(
              key: const ValueKey('loader'),
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: fg,
              ),
            )
          : isVertical
              ? Column(
                  key: const ValueKey('content_vertical'),
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (prefixIcon != null) ...[
                      prefixIcon!,
                      6.verticalSpace,
                    ],
                    Text(
                      label,
                      style: (style ??
                              TextStyle(
                                fontSize: fontSize,
                                fontWeight: FontWeight.bold,
                              ))
                          .copyWith(
                        color: isDisabled
                            ? fg.withValues(alpha: 0.5)
                            : textColor ?? style?.color ?? fg,
                      ),
                    ),
                    if (suffixIcon != null) ...[
                      6.verticalSpace,
                      suffixIcon!,
                    ],
                  ],
                )
              : Row(
                  key: const ValueKey('content'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                if (prefixIcon != null) ...[
                  prefixIcon!,
                  SizedBox(width: 8.w),
                ],
                Text(
                  label,
                  style: (style ??
                          TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ))
                      .copyWith(
                    color: isDisabled
                        ? fg.withValues(alpha: 0.5)
                        : textColor ?? style?.color ?? fg,
                  ),
                ),
                if (suffixIcon != null) ...[
                  SizedBox(width: 8.w),
                  suffixIcon!,
                ],
              ],
            ),
    );

    return AnimatedOpacity(
      duration: AppDurations.fast,
      opacity: isDisabled ? 0.6 : 1.0,
      child: SizedBox(
        width: isFullWidth ? double.infinity : buttonWidth,
        height: buttonHeight,
        child: TextButton(
          onPressed: isDisabled ? null : onPressed,
          style: TextButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: isVertical ? 10.h : 0,
            ),
            shape: border != null
                ? RoundedRectangleBorder(
                    borderRadius: AppBorders.button,
                    side: border,
                  )
                : const RoundedRectangleBorder(borderRadius: AppBorders.button),
          ),
          child: child,
        ),
      ),
    );
  }
}
