import 'package:alurei/src/imports/imports.dart';

enum AppDatePickerMode { days, months, years }

Future<DateTime?> showAppDatePicker({
  required BuildContext context,
  required DateTime? initialDate,
  bool allowFutureDates = false,
}) async {
  final now = DateTime.now();
  var visibleMonth = DateTime(
    initialDate?.year ?? now.year,
    initialDate?.month ?? now.month,
  );
  var selectedDate = initialDate ?? DateTime(now.year, now.month, now.day);
  var mode = AppDatePickerMode.days;
  final selectedDates = <DateTime>{
    DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    )
  };

  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 32.w),
            shape: const RoundedRectangleBorder(borderRadius: AppBorders.lg),
            child: Padding(
              padding: EdgeInsets.fromLTRB(24.w, 22.h, 24.w, 24.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          LangKey.parentToday.selectDate,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 20.sp,
                            height: 30 / 20,
                            fontWeight: FontWeight.w500,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: Get.back<void>,
                        icon: const Icon(IconsaxPlusLinear.close_circle),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  AppDatePickerHeader(
                    visibleMonth: visibleMonth,
                    mode: mode,
                    onPrevious: () => setState(() {
                      visibleMonth = DateTime(
                        visibleMonth.year,
                        visibleMonth.month - 1,
                      );
                      mode = AppDatePickerMode.days;
                    }),
                    onNext:
                        _canGoNextMonth(visibleMonth, now) || allowFutureDates
                            ? () => setState(() {
                                  visibleMonth = DateTime(
                                    visibleMonth.year,
                                    visibleMonth.month + 1,
                                  );
                                  mode = AppDatePickerMode.days;
                                })
                            : null,
                    onMonthTap: () => setState(
                      () => mode = AppDatePickerMode.months,
                    ),
                    onYearTap: () => setState(
                      () => mode = AppDatePickerMode.years,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  AnimatedSwitcher(
                    duration: AppDurations.fast,
                    child: switch (mode) {
                      AppDatePickerMode.days => AppDatePickerDaysGrid(
                          key: const ValueKey('days'),
                          visibleMonth: visibleMonth,
                          allowFutureDates: allowFutureDates,
                          selectedDates: selectedDates,
                          onSelected: (date) => setState(() {
                            final normalized = _normalizeDate(date);
                            selectedDate = normalized;
                            selectedDates
                              ..clear()
                              ..add(normalized);
                          }),
                        ),
                      AppDatePickerMode.months => AppDatePickerMonthGrid(
                          key: const ValueKey('months'),
                          visibleMonth: visibleMonth,
                          allowFutureDates: allowFutureDates,
                          onSelected: (month) => setState(() {
                            visibleMonth = DateTime(visibleMonth.year, month);
                            if (!allowFutureDates &&
                                visibleMonth.year == now.year &&
                                visibleMonth.month > now.month) {
                              visibleMonth = DateTime(now.year, now.month);
                            }
                            mode = AppDatePickerMode.days;
                          }),
                        ),
                      AppDatePickerMode.years => AppDatePickerYearList(
                          key: const ValueKey('years'),
                          selectedYear: visibleMonth.year,
                          allowFutureDates: allowFutureDates,
                          onSelected: (year) => setState(() {
                            final nextMonth = year == now.year &&
                                    visibleMonth.month > now.month
                                ? now.month
                                : visibleMonth.month;
                            visibleMonth = DateTime(year, nextMonth);
                            mode = AppDatePickerMode.months;
                          }),
                        ),
                    },
                  ),
                  SizedBox(height: 22.h),
                  AppButton(
                    label: LangKey.parentToday.confirm,
                    onPressed: () => Navigator.of(context).pop(selectedDate),
                    height: ButtonSize.large,
                    isFullWidth: true,
                  ),
                  SizedBox(height: 8.h),
                  AppButton(
                    label: LangKey.parentToday.cancel,
                    onPressed: Get.back<void>,
                    variant: ButtonVariant.ghost,
                    height: ButtonSize.medium,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

class AppDatePickerHeader extends StatelessWidget {
  const AppDatePickerHeader({
    super.key,
    required this.visibleMonth,
    required this.mode,
    required this.onPrevious,
    required this.onNext,
    required this.onMonthTap,
    required this.onYearTap,
  });

  final DateTime visibleMonth;
  final AppDatePickerMode mode;
  final VoidCallback onPrevious;
  final VoidCallback? onNext;
  final VoidCallback onMonthTap;
  final VoidCallback onYearTap;

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    final monthName = localizations
        .formatMonthYear(visibleMonth)
        .replaceAll(RegExp(r'\s+\d{4}$'), '');
    return Row(
      children: [
        InkWell(
          onTap: onMonthTap,
          borderRadius: AppBorders.sm,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Text(
              monthName.toUpperCase(),
              style: _headerStyle(context),
            ),
          ),
        ),
        InkWell(
          onTap: onYearTap,
          borderRadius: AppBorders.sm,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
            child: Text('${visibleMonth.year}', style: _headerStyle(context)),
          ),
        ),
        const Spacer(),
        if (mode == AppDatePickerMode.days) ...[
          IconButton(
            onPressed: onPrevious,
            icon: const Icon(IconsaxPlusLinear.arrow_left_1),
          ),
          IconButton(
            onPressed: onNext,
            icon: const Icon(IconsaxPlusLinear.arrow_right_3),
          ),
        ],
      ],
    );
  }

  TextStyle _headerStyle(BuildContext context) {
    return GlobalTextStyles.interTextStyle(
      fontSize: 14.sp,
      height: 20 / 14,
      fontWeight: FontWeight.w700,
      color: context.appColors.primaryText,
    );
  }
}

class AppDatePickerDaysGrid extends StatelessWidget {
  const AppDatePickerDaysGrid({
    super.key,
    required this.visibleMonth,
    required this.allowFutureDates,
    required this.selectedDates,
    required this.onSelected,
  });

  final DateTime visibleMonth;
  final bool allowFutureDates;
  final Set<DateTime> selectedDates;
  final ValueChanged<DateTime> onSelected;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = _calendarDays(visibleMonth);
    return Column(
      children: [
        Row(
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
              .map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        SizedBox(height: 8.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: 40.h,
          ),
          itemCount: days.length,
          itemBuilder: (context, index) {
            final date = days[index];
            final normalized = _normalizeDate(date);
            final isCurrentMonth = date.month == visibleMonth.month;
            final isFuture = !allowFutureDates && date.isAfter(now);
            final isSelected = selectedDates.contains(normalized);
            return InkWell(
              onTap: isFuture ? null : () => onSelected(date),
              borderRadius: AppBorders.md,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primary
                      : AppColors.transparentColor,
                  borderRadius: AppBorders.md,
                ),
                child: Text(
                  '${date.day}',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isFuture || !isCurrentMonth
                        ? AppColors.neutral300
                        : isSelected
                            ? context.colors.onPrimary
                            : context.appColors.strongText,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class AppDatePickerMonthGrid extends StatelessWidget {
  const AppDatePickerMonthGrid({
    super.key,
    required this.visibleMonth,
    required this.allowFutureDates,
    required this.onSelected,
  });

  final DateTime visibleMonth;
  final bool allowFutureDates;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final months = List.generate(12, (index) => index + 1);
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2.2,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.h,
      ),
      itemCount: months.length,
      itemBuilder: (context, index) {
        final month = months[index];
        final isFuture = !allowFutureDates &&
            visibleMonth.year == now.year &&
            month > now.month;
        final isSelected = month == visibleMonth.month;
        final label = MaterialLocalizations.of(context)
            .formatMonthYear(DateTime(2024, month))
            .replaceAll(RegExp(r'\s+\d{4}$'), '');
        return AppDatePickerChip(
          label: label,
          selected: isSelected,
          disabled: !allowFutureDates && isFuture,
          onTap: () => onSelected(month),
        );
      },
    );
  }
}

class AppDatePickerYearList extends StatelessWidget {
  const AppDatePickerYearList({
    super.key,
    required this.selectedYear,
    required this.allowFutureDates,
    required this.onSelected,
  });

  final int selectedYear;
  final bool allowFutureDates;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final lastYear = allowFutureDates ? now.year + 10 : now.year;
    final years =
        List.generate(lastYear - 1950 + 1, (index) => lastYear - index);
    return SizedBox(
      height: 360.h,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
        ),
        itemCount: years.length,
        itemBuilder: (context, index) {
          final year = years[index];
          final isFuture = year > now.year;
          final isSelected = year == selectedYear;
          return AppDatePickerChip(
            label: '$year',
            selected: isSelected,
            disabled: isFuture,
            onTap: () => onSelected(year),
          );
        },
      ),
    );
  }
}

class AppDatePickerChip extends StatelessWidget {
  const AppDatePickerChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.disabled = false,
  });

  final String label;
  final bool selected;
  final bool disabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      borderRadius: AppBorders.md,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected
              ? context.colors.primary
              : context.appColors.primaryBackground,
          border: Border.all(color: AppColors.brandTealBorder),
          borderRadius: AppBorders.md,
        ),
        child: Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: disabled
                ? AppColors.neutral300
                : selected
                    ? context.colors.onPrimary
                    : context.appColors.primaryText,
          ),
        ),
      ),
    );
  }
}

List<DateTime> _calendarDays(DateTime month) {
  final first = DateTime(month.year, month.month);
  final start = first.subtract(Duration(days: first.weekday % 7));
  return List.generate(42, (index) => start.add(Duration(days: index)));
}

DateTime _normalizeDate(DateTime date) =>
    DateTime(date.year, date.month, date.day);

bool _canGoNextMonth(DateTime visibleMonth, DateTime now) {
  final next = DateTime(visibleMonth.year, visibleMonth.month + 1);
  return !next.isAfter(DateTime(now.year, now.month));
}
