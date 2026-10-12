part of 'todays_child_profile_widgets.dart';

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.title,
    required this.child,
    this.mutedTitle = false,
    this.elevated = false,
  });

  final String title;
  final Widget child;
  final bool mutedTitle;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: context.appColors.bottomNavBorder),
        borderRadius: AppBorders.lg,
        boxShadow: elevated ? AppShadows.subtle : AppShadows.none,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 13.h),
            child: Text(
              title,
              style: GlobalTextStyles.interTextStyle(
                fontSize: mutedTitle ? 14.sp : 18.sp,
                height: mutedTitle ? 20 / 14 : 28 / 18,
                fontWeight: FontWeight.w500,
                color: mutedTitle
                    ? context.appColors.mutedText
                    : context.appColors.primaryText,
              ),
            ),
          ),
          Divider(height: 1.h, color: context.appColors.bottomNavBorder),
          child,
        ],
      ),
    );
  }
}

class _QuickActionRow extends StatelessWidget {
  const _QuickActionRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isLast = false,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return _SectionRow(
      isLast: isLast,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.10),
                borderRadius: AppBorders.lg,
              ),
              child: Icon(icon, size: 20.sp, color: context.colors.primary),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.primaryText,
                    ),
                  ),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      height: 18 / 12,
                      fontWeight: FontWeight.w400,
                      color: context.appColors.mutedText,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              size: 16.sp,
              color: context.appColors.disabledText,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.appColors.warning.withValues(alpha: 0.10),
        borderRadius: AppBorders.full,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        child: Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 12.sp,
            height: 18 / 12,
            fontWeight: FontWeight.w500,
            color: context.appColors.warning,
          ),
        ),
      ),
    );
  }
}

class _EmptyRow extends StatelessWidget {
  const _EmptyRow({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Text(
        text,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 14.sp,
          height: 20 / 14,
          fontWeight: FontWeight.w500,
          color: context.appColors.mutedText,
        ),
      ),
    );
  }
}

class _DashedRoundedPainter extends CustomPainter {
  const _DashedRoundedPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(16.r),
        ),
      );
    final metric = path.computeMetrics().first;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const dash = 5.0;
    const gap = 4.0;
    for (var distance = 0.0; distance < metric.length; distance += dash + gap) {
      canvas.drawPath(
        metric.extractPath(distance, (distance + dash).clamp(0, metric.length)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRoundedPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

String _formatDate(DateTime? date) {
  if (date == null) return LangKey.parentToday.birthDateHint;
  return '${date.day.toString().padLeft(2, '0')}/'
      '${date.month.toString().padLeft(2, '0')}/${date.year}';
}

String _formatTimeOfDay(TimeOfDay time) {
  final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
  final minute = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '${hour.toString().padLeft(2, '0')}:$minute $period';
}
