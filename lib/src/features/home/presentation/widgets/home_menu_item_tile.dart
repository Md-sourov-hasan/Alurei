import 'package:alurei/src/imports/imports.dart';

class HomeMenuItemTile extends StatelessWidget {
  const HomeMenuItemTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
    this.showBadgeBackground = true,
    this.titleColor,
    this.iconColor,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool showBadgeBackground;
  final Color? titleColor;
  final Color? iconColor;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.lg.w,
              vertical: AppSpacing.md.h,
            ),
            child: Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.all(showBadgeBackground ? AppSpacing.sm.w : 0),
                  decoration: showBadgeBackground
                      ? BoxDecoration(
                          color: (iconColor ?? context.colors.primary)
                              .withValues(alpha: 0.1),
                          borderRadius: AppBorders.sm,
                        )
                      : null,
                  child: Icon(
                    icon,
                    color: iconColor ?? context.colors.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: AppSpacing.md.w),
                Expanded(
                  child: Text(
                    title,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: titleColor ?? context.appColors.primaryText,
                    ),
                  ),
                ),
                Icon(
                  IconsaxPlusLinear.arrow_right_3,
                  color: context.appColors.secondaryText,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1.h,
            thickness: 1.h,
            color: context.appColors.primaryBackground,
          ),
      ],
    );
  }
}
