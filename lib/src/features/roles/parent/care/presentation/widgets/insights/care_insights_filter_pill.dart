import 'package:alurei/src/imports/imports.dart';

class CareInsightsFilterPill extends StatelessWidget {
  const CareInsightsFilterPill({
    super.key,
    required this.monthKey,
    required this.weekKey,
    required this.selectedMonth,
    required this.selectedWeek,
  });

  final GlobalKey monthKey;
  final GlobalKey weekKey;
  final ValueNotifier<String> selectedMonth;
  final ValueNotifier<String> selectedWeek;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE5EEEE),
        borderRadius: BorderRadius.circular(9999.r),
        border: Border.all(
          color: const Color(0xFFB5D0D2),
          width: 1.2.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Left Item: Selected Month
          GestureDetector(
            key: monthKey,
            onTap: () => _showMonthPicker(context, monthKey, selectedMonth),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.icCalendar,
                  width: 18.w,
                  height: 18.w,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF004D54),
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 6.w),
                ValueListenableBuilder<String>(
                  valueListenable: selectedMonth,
                  builder: (context, value, _) => Text(
                    value,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004D54),
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  IconsaxPlusLinear.arrow_down,
                  size: 13.w,
                  color: const Color(0xFF203E42),
                ),
              ],
            ),
          ),
          SizedBox(width: 18.w),

          // Right Item: Selected Week
          GestureDetector(
            key: weekKey,
            onTap: () => _showWeekPicker(context, weekKey, selectedWeek),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.icWeeks,
                  width: 18.w,
                  height: 18.w,
                  colorFilter: const ColorFilter.mode(
                    AppColors.secondaryTeal,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 6.w),
                ValueListenableBuilder<String>(
                  valueListenable: selectedWeek,
                  builder: (context, value, _) => Text(
                    value,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryTeal,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  IconsaxPlusLinear.arrow_down,
                  size: 13.w,
                  color: const Color(0xFF203E42),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showMonthPicker(
    BuildContext context,
    GlobalKey monthKey,
    ValueNotifier<String> selectedMonth,
  ) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final renderBox = monthKey.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final size = renderBox?.size ?? Size.zero;

    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        final screenWidth = MediaQuery.of(ctx).size.width;
        double left = offset.dx - 10.w;
        if (left + 220.w > screenWidth - 16.w) {
          left = screenWidth - 236.w;
        }
        if (left < 16.w) left = 16.w;

        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
            Positioned(
              left: left,
              top: offset.dy + size.height + 6.h,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 220.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFA),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: const Color(0xFFB5D0D2),
                      width: 1.2.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 8.h),
                        child: Text(
                          'Select Month',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 320.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: months.map((month) {
                              final isSelected = selectedMonth.value == month;
                              return GestureDetector(
                                onTap: () {
                                  selectedMonth.value = month;
                                  Navigator.of(ctx).pop();
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 18.w,
                                    vertical: 10.h,
                                  ),
                                  color: isSelected
                                      ? const Color(0xFFEAF2F2)
                                      : Colors.transparent,
                                  child: Text(
                                    month,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 14.5.sp,
                                      fontWeight: isSelected
                                          ? FontWeight.w800
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? const Color(0xFF004D54)
                                          : const Color(0xFF334155),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showWeekPicker(
    BuildContext context,
    GlobalKey weekKey,
    ValueNotifier<String> selectedWeek,
  ) {
    final weeks = ['Week 1', 'Week 2', 'Week 3', 'Week 4'];

    final renderBox = weekKey.currentContext?.findRenderObject() as RenderBox?;
    final offset = renderBox?.localToGlobal(Offset.zero) ?? Offset.zero;
    final size = renderBox?.size ?? Size.zero;

    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) {
        final screenWidth = MediaQuery.of(ctx).size.width;
        double left = offset.dx - 10.w;
        if (left + 200.w > screenWidth - 16.w) {
          left = screenWidth - 216.w;
        }

        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(ctx).pop(),
              behavior: HitTestBehavior.opaque,
              child: const SizedBox.expand(),
            ),
            Positioned(
              left: left,
              top: offset.dy + size.height + 6.h,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 200.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFA),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: const Color(0xFFB5D0D2),
                      width: 1.2.w,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(18.w, 14.h, 18.w, 8.h),
                        child: Text(
                          'Select Week',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      Column(
                        children: weeks.map((week) {
                          final isSelected = selectedWeek.value == week;
                          return GestureDetector(
                            onTap: () {
                              selectedWeek.value = week;
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: 18.w,
                                vertical: 10.h,
                              ),
                              color: isSelected
                                  ? const Color(0xFFEAF2F2)
                                  : Colors.transparent,
                              child: Text(
                                week,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.5.sp,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.secondaryTeal
                                      : const Color(0xFF334155),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: 6.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
