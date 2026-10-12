import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';

String _textOrFallback(String? value, String fallback) {
  final trimmed = value?.trim();
  return trimmed == null || trimmed.isEmpty ? fallback : trimmed;
}

/// Reusable time-based routine card. Past activities are subdued while current
/// and upcoming activities retain full visual emphasis.
class RoutineTimeCard extends StatelessWidget {
  const RoutineTimeCard({
    super.key,
    required this.item,
    required this.completed,
    required this.isPast,
    required this.onPressed,
  });

  final ParentRoutineItem item;
  final bool completed;
  final bool isPast;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final presentation = _RoutinePresentation.from(item.kind);
    final title = _textOrFallback(item.title, presentation.title);
    final description = item.description?.trim() ?? '';

    return SizedBox(
      width: 248.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.startTime != null)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _TimeRange(item: item),
            ),
          Material(
            color: presentation.background,
            elevation: 5,
            shadowColor: AppColors.black16,
            shape: RoundedRectangleBorder(
              borderRadius: AppBorders.full,
              side: BorderSide(color: presentation.border, width: 2.w),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: onPressed,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: 128.h),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 96.h,
                    child: Stack(
                      children: [
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _ScheduleCardIcon(
                                item: item,
                                fallbackIcon: presentation.icon,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  height: 20 / 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.neutral900,
                                ),
                              ),
                              if (description.isNotEmpty) ...[
                                SizedBox(height: 2.h),
                                Text(
                                  description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 12.sp,
                                    height: 18 / 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.neutral700,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                        PositionedDirectional(
                          top: 0,
                          end: 0,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: _actionIcons(presentation),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _actionIcons(_RoutinePresentation presentation) {
    if (item.kind == ParentRoutineKind.story) return const [];
    if (item.kind == ParentRoutineKind.breakfast) {
      return [
        Icon(
          IconsaxPlusLinear.tick_circle,
          size: 22.sp,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 8.w),
        Icon(
          IconsaxPlusLinear.eye,
          size: 22.sp,
          color: AppColors.primaryColor,
        ),
      ];
    }

    return [
      Icon(
        completed ? IconsaxPlusBold.tick_circle : presentation.actionIcon,
        size: 22.sp,
        color: AppColors.primaryColor,
      ),
    ];
  }
}

class _ScheduleCardIcon extends StatelessWidget {
  const _ScheduleCardIcon({
    required this.item,
    required this.fallbackIcon,
  });

  final ParentRoutineItem item;
  final IconData fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final asset = _scheduleIconAsset(item);
    if (asset == null) {
      return Icon(
        fallbackIcon,
        size: 22.sp,
        color: AppColors.primaryColor,
      );
    }

    return SvgPicture.asset(
      asset,
      width: 28.w,
      height: 28.w,
      fit: BoxFit.contain,
    );
  }

  static String? _scheduleIconAsset(ParentRoutineItem item) {
    final type = item.type?.trim().toUpperCase();
    if (type != 'SCHEDULE') return null;

    return switch (item.category?.trim().toUpperCase()) {
      'RECIPE' => AppAssets.icRecipe,
      'ACTIVITY' => AppAssets.icOutdoor,
      'HOME_STUDY' => AppAssets.icCap,
      'NAP' => AppAssets.icMoon,
      'BEDTIME' => AppAssets.icBook,
      _ => null,
    };
  }
}

class ExternalRoutineCard extends StatelessWidget {
  const ExternalRoutineCard({
    super.key,
    required this.item,
    required this.completed,
    required this.isPast,
    required this.onPressed,
  });

  final ParentRoutineItem item;
  final bool completed;
  final bool isPast;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final presentation = _RoutinePresentation.from(item.kind);
    final title = _textOrFallback(item.title, presentation.title);
    final description =
        _textOrFallback(item.description, presentation.description);
    final itemTypeLabel = _textOrFallback(item.itemTypeLabel, '');

    return Material(
      color: AppColors.primaryColor,
      elevation: 5,
      shadowColor: AppColors.black16,
      borderRadius: AppBorders.lg,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 231.w,
          height: 86.h,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      item.startTime ?? '',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.neutral50,
                      ),
                    ),
                    const Spacer(),
                    if (itemTypeLabel.isNotEmpty)
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          color: AppColors.black12,
                          borderRadius: AppBorders.full,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 4.h,
                          ),
                          child: Text(
                            itemTypeLabel,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              height: 18 / 12,
                              fontWeight: FontWeight.w400,
                              color: AppColors.neutral50,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(
                      presentation.icon,
                      size: 22.sp,
                      color: AppColors.neutral50,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              height: 20 / 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.neutral50,
                            ),
                          ),
                          if (description.isNotEmpty)
                            Text(
                              description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 12.sp,
                                height: 18 / 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.neutral300,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (completed)
                      Icon(
                        IconsaxPlusBold.tick_circle,
                        size: 18.sp,
                        color: AppColors.neutral50,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RoutineMilestone extends StatelessWidget {
  const RoutineMilestone({super.key, required this.item});

  final ParentRoutineItem item;

  @override
  Widget build(BuildContext context) {
    final presentation = _RoutinePresentation.from(item.kind);
    final milestone = _TimelineMilestonePresentation.from(item, context);
    final title = _textOrFallback(item.title, presentation.title);
    final timeText = milestone.showEndTime
        ? _formatTimeRange(item.startTime, item.endTime)
        : item.startTime?.trim() ?? '';
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.kind != ParentRoutineKind.nap) ...[
          SizedBox.square(
            dimension: milestone.iconBoxSize.w,
            child: Center(
              child: milestone.icon,
            ),
          ),
          SizedBox(width: 12.w),
        ],
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (timeText.isNotEmpty)
              Text(
                timeText,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.secondaryText,
                ),
              ),
            Row(
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize:
                        item.kind == ParentRoutineKind.bedtime ? 20.sp : 18.sp,
                    height: item.kind == ParentRoutineKind.bedtime
                        ? 30 / 20
                        : 28 / 18,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryText,
                  ),
                ),
                if (item.kind == ParentRoutineKind.nap) ...[
                  SizedBox(width: 8.w),
                  Skeleton.ignore(
                    child: SizedBox.square(
                      dimension: milestone.iconBoxSize.w,
                      child: Center(
                        child: milestone.icon,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ],
    );
  }
}

String _formatTimeRange(String? startTime, String? endTime) {
  final start = startTime?.trim() ?? '';
  final end = endTime?.trim() ?? '';
  if (start.isEmpty) return '';
  if (end.isEmpty) return start;
  return '$start ${LangKey.parentToday.to} $end';
}

class _TimelineMilestonePresentation {
  const _TimelineMilestonePresentation({
    required this.showEndTime,
    required this.icon,
    this.iconBoxSize = 32,
  });

  final bool showEndTime;
  final Widget icon;
  final double iconBoxSize;

  factory _TimelineMilestonePresentation.from(
    ParentRoutineItem item,
    BuildContext context,
  ) {
    final type = item.type?.trim().toUpperCase();
    final category = item.category?.trim().toUpperCase();
    if (type == 'WAKE_UP') {
      final presentation = _RoutinePresentation.from(item.kind);
      return _TimelineMilestonePresentation(
        showEndTime: false,
        iconBoxSize: 24,
        icon: Icon(
          presentation.icon,
          size: 24.sp,
          color: context.colors.primary,
        ),
      );
    }
    if (type == 'SCHOOL') {
      return _TimelineMilestonePresentation(
        showEndTime: true,
        iconBoxSize: 22,
        icon: Image.asset(
          AppAssets.imgSchool,
          width: 22.w,
          height: 22.w,
          fit: BoxFit.contain,
        ),
      );
    }
    if (type == 'NAP' && category == 'NAP') {
      return _TimelineMilestonePresentation(
        showEndTime: true,
        icon: SvgPicture.asset(
          AppAssets.icMoon,
          width: 22.w,
          height: 22.w,
        ),
      );
    }
    if (type == 'BEDTIME' && category == 'BEDTIME') {
      final presentation = _RoutinePresentation.from(item.kind);
      return _TimelineMilestonePresentation(
        showEndTime: false,
        iconBoxSize: 24,
        icon: Icon(
          presentation.icon,
          size: 24.sp,
          color: context.colors.primary,
        ),
      );
    }
    return _TimelineMilestonePresentation(
      showEndTime: item.endTime?.trim().isNotEmpty ?? false,
      icon: Icon(
        _RoutinePresentation.from(item.kind).icon,
        size: 24.sp,
        color: context.colors.primary,
      ),
    );
  }
}

class TodayOfferRoutineCard extends StatelessWidget {
  const TodayOfferRoutineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorders.full,
      child: SizedBox(
        width: 247.w,
        height: 88.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              AppAssets.parentTodayOfferBackground,
              fit: BoxFit.cover,
            ),
            const ColoredBox(color: AppColors.black26),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: SizedBox(
                  width: 130.w,
                  child: Text(
                    LangKey.parentToday.bestOffer,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.neutral50,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeRange extends StatelessWidget {
  const _TimeRange({required this.item});

  final ParentRoutineItem item;

  @override
  Widget build(BuildContext context) {
    final start = item.startTime;
    final end = item.endTime;
    final text = _formatTimeRange(start, end);

    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 14.sp,
        height: 20 / 14,
        fontWeight: FontWeight.w500,
        color: context.appColors.secondaryText,
      ),
    );
  }
}

class _RoutinePresentation {
  const _RoutinePresentation({
    required this.title,
    required this.description,
    required this.icon,
    required this.actionIcon,
    required this.background,
    required this.border,
  });

  final String title;
  final String description;
  final IconData icon;
  final IconData actionIcon;
  final Color background;
  final Color border;

  factory _RoutinePresentation.from(ParentRoutineKind kind) {
    return switch (kind) {
      ParentRoutineKind.wake => _RoutinePresentation(
          title: LangKey.parentToday.wakeUp,
          description: '',
          icon: IconsaxPlusLinear.sun_1,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineBreakfast,
          border: AppColors.routineOrangeBorder,
        ),
      ParentRoutineKind.breakfast => _RoutinePresentation(
          title: LangKey.parentToday.breakfast,
          description: '',
          icon: IconsaxPlusBold.reserve,
          actionIcon: IconsaxPlusLinear.eye,
          background: AppColors.routineBreakfast,
          border: AppColors.routineOrangeBorder,
        ),
      ParentRoutineKind.school => _RoutinePresentation(
          title: LangKey.parentToday.schoolTime,
          description: '',
          icon: IconsaxPlusLinear.buildings_2,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStudy,
          border: AppColors.routinePurpleBorder,
        ),
      ParentRoutineKind.nap => _RoutinePresentation(
          title: LangKey.parentToday.nap,
          description: '',
          icon: IconsaxPlusLinear.moon,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStudy,
          border: AppColors.routinePurpleBorder,
        ),
      ParentRoutineKind.outdoor => _RoutinePresentation(
          title: LangKey.parentToday.outdoorPlay,
          description: '',
          icon: IconsaxPlusBold.tree,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineOutdoor,
          border: AppColors.routineGreenBorder,
        ),
      ParentRoutineKind.pasta => _RoutinePresentation(
          title: LangKey.parentToday.softVegPasta,
          description: '',
          icon: IconsaxPlusBold.reserve,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineBreakfast,
          border: AppColors.routineOrangeBorder,
        ),
      ParentRoutineKind.study => _RoutinePresentation(
          title: LangKey.parentToday.studyTime,
          description: '',
          icon: IconsaxPlusBold.teacher,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStudy,
          border: AppColors.routinePurpleBorder,
        ),
      ParentRoutineKind.offer => _RoutinePresentation(
          title: LangKey.parentToday.bestOffer,
          description: '',
          icon: IconsaxPlusLinear.ticket_discount,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineOutdoor,
          border: AppColors.routineGreenBorder,
        ),
      ParentRoutineKind.external => const _RoutinePresentation(
          title: '',
          description: '',
          icon: IconsaxPlusLinear.calendar_2,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.primaryColor,
          border: AppColors.primaryColor,
        ),
      ParentRoutineKind.story => _RoutinePresentation(
          title: LangKey.parentToday.bedtimeStory,
          description: '',
          icon: IconsaxPlusBold.book_1,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStory,
          border: AppColors.routineYellowBorder,
        ),
      ParentRoutineKind.bedtime => _RoutinePresentation(
          title: LangKey.parentToday.bedtime,
          description: '',
          icon: IconsaxPlusLinear.book_1,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStory,
          border: AppColors.routineYellowBorder,
        ),
      ParentRoutineKind.task => const _RoutinePresentation(
          title: '',
          description: '',
          icon: IconsaxPlusBold.note_2,
          actionIcon: IconsaxPlusLinear.edit_2,
          background: AppColors.routineStudy,
          border: AppColors.routinePurpleBorder,
        ),
    };
  }
}
