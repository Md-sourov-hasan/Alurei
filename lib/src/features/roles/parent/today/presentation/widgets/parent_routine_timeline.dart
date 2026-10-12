import 'dart:async';
import 'dart:math' as math;

import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import 'parent_routine_timeline_cards.dart';

/// Curved daily routine timeline used by the Parent Today flow.
///
/// The path height, task positions, and milestone points are derived from the
/// selected child's routine list. Wake up is always promoted to the first
/// visible node and bedtime is always promoted to the last visible node.
class ParentRoutineTimeline extends HookWidget {
  const ParentRoutineTimeline({
    super.key,
    required this.items,
    required this.completedIds,
    required this.onRoutinePressed,
    this.onAddSchedule,
    this.isLoading = false,
  });

  final List<ParentRoutineItem> items;
  final Set<String> completedIds;
  final ValueChanged<String> onRoutinePressed;
  final VoidCallback? onAddSchedule;
  final bool isLoading;

  static const double designWidth = 440;

  @override
  Widget build(BuildContext context) {
    final localNow = useState(DateTime.now());
    useEffect(() {
      final timer = Timer.periodic(
        const Duration(minutes: 1),
        (_) => localNow.value = DateTime.now(),
      );
      return timer.cancel;
    }, const []);

    if (items.isEmpty && isLoading) {
      return const _RoutineTimelineLoadingSkeleton();
    }

    final routineItems = _orderedRoutineItems(items);
    if (routineItems.isEmpty) {
      return _RoutineTimelineEmptyState(onAddSchedule: onAddSchedule);
    }

    final rtl = Directionality.of(context) == TextDirection.rtl;
    final layout = _RoutineTimelineLayout.from(routineItems);
    final schedule = _RoutineSchedule(items: routineItems, now: localNow.value);

    return SkeletonWrapper(
      isLoading: isLoading,
      child: SizedBox(
        height: layout.height.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Skeleton.ignore(
                child: Transform.flip(
                  flipX: rtl,
                  child: CustomPaint(
                    painter: _RoutinePathPainter(
                      points: layout.points,
                      designHeight: layout.height,
                      elapsedProgress: isLoading ? 0 : schedule.elapsedProgress,
                    ),
                  ),
                ),
              ),
            ),
            for (final entry in layout.entries)
              _TimelineEntryView(
                entry: entry,
                completed: !isLoading && completedIds.contains(entry.item.id),
                isPast: !isLoading && schedule.isPast(entry.item),
                isFocused: !isLoading && schedule.isFocused(entry.item),
                onPressed: () => onRoutinePressed(entry.item.id),
              ),
          ],
        ),
      ),
    );
  }

  static List<ParentRoutineItem> _orderedRoutineItems(
    List<ParentRoutineItem> source,
  ) {
    if (source.isEmpty) return const [];

    final wake = _firstWhere(source, _isWakeMilestoneItem);
    final bedtime = _lastWhere(source, _isBedtimeMilestoneItem);
    final middle = source
        .where(
          (item) => item.id != wake?.id && item.id != bedtime?.id,
        )
        .toList()
      ..sort(_compareByTime);

    return [
      if (wake != null) wake,
      ...middle,
      if (bedtime != null) bedtime,
    ];
  }

  static ParentRoutineItem? _firstWhere(
    List<ParentRoutineItem> source,
    bool Function(ParentRoutineItem item) test,
  ) {
    for (final item in source) {
      if (test(item)) return item;
    }
    return null;
  }

  static ParentRoutineItem? _lastWhere(
    List<ParentRoutineItem> source,
    bool Function(ParentRoutineItem item) test,
  ) {
    for (var index = source.length - 1; index >= 0; index--) {
      if (test(source[index])) return source[index];
    }
    return null;
  }

  static bool _isWakeMilestoneItem(ParentRoutineItem item) {
    final type = item.type?.trim().toUpperCase();
    return type == null
        ? item.kind == ParentRoutineKind.wake
        : type == 'WAKE_UP';
  }

  static bool _isBedtimeMilestoneItem(ParentRoutineItem item) {
    final type = item.type?.trim().toUpperCase();
    return type == null
        ? item.kind == ParentRoutineKind.bedtime
        : type == 'BEDTIME';
  }

  static int _compareByTime(ParentRoutineItem a, ParentRoutineItem b) {
    final aMinutes = _RoutineSchedule.parseMinutes(a.startTime);
    final bMinutes = _RoutineSchedule.parseMinutes(b.startTime);
    if (aMinutes == null && bMinutes == null) return 0;
    if (aMinutes == null) return 1;
    if (bMinutes == null) return -1;
    return aMinutes.compareTo(bMinutes);
  }

  static const double pastOpacity = 0.5;
}

class _RoutineTimelineLoadingSkeleton extends StatelessWidget {
  const _RoutineTimelineLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      isLoading: true,
      child: SizedBox(
        height: 720.h,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PositionedDirectional(
              top: 52.h,
              start: 50.w,
              child: const _SkeletonMilestone(),
            ),
            PositionedDirectional(
              top: 198.h,
              end: 16.w,
              child: const _SkeletonRoutineCard(),
            ),
            PositionedDirectional(
              top: 390.h,
              start: 150.w,
              child: const _SkeletonMilestone(),
            ),
            PositionedDirectional(
              top: 520.h,
              start: 16.w,
              child: const _SkeletonRoutineCard(),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonMilestone extends StatelessWidget {
  const _SkeletonMilestone();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.w,
          height: 24.w,
          decoration: const BoxDecoration(
            color: AppColors.neutral200,
            borderRadius: AppBorders.full,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 56.w,
              height: 14.h,
              decoration: const BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: AppBorders.full,
              ),
            ),
            SizedBox(height: 8.h),
            Container(
              width: 120.w,
              height: 22.h,
              decoration: const BoxDecoration(
                color: AppColors.neutral200,
                borderRadius: AppBorders.full,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SkeletonRoutineCard extends StatelessWidget {
  const _SkeletonRoutineCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 248.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 104.w,
            height: 14.h,
            decoration: const BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: AppBorders.full,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 128.h,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: AppBorders.full,
              border: Border.all(color: AppColors.neutral100, width: 2.w),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoutineTimelineEmptyState extends StatelessWidget {
  const _RoutineTimelineEmptyState({required this.onAddSchedule});

  final VoidCallback? onAddSchedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 96.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 28.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: AppBorders.xl,
          border: Border.all(color: context.appColors.bottomNavBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.black12,
              blurRadius: 24.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.10),
                borderRadius: AppBorders.full,
              ),
              child: Icon(
                IconsaxPlusLinear.calendar_add,
                size: 32.sp,
                color: context.colors.primary,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              LangKey.parentToday.noScheduleItems,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 20.sp,
                height: 30 / 20,
                fontWeight: FontWeight.w700,
                color: context.appColors.primaryText,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              LangKey.parentToday.noScheduleItemsDescription,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 22 / 14,
                fontWeight: FontWeight.w400,
                color: context.appColors.secondaryText,
              ),
            ),
            SizedBox(height: 22.h),
            AppButton(
              label: LangKey.parentToday.addToSchedule,
              onPressed: onAddSchedule,
              height: ButtonSize.medium,
              prefixIcon: Icon(
                IconsaxPlusLinear.add,
                size: 18.sp,
                color: context.colors.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineEntryView extends HookWidget {
  const _TimelineEntryView({
    required this.entry,
    required this.completed,
    required this.isPast,
    required this.isFocused,
    required this.onPressed,
  });

  final _TimelineEntry entry;
  final bool completed;
  final bool isPast;
  final bool isFocused;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final child = switch (entry.style) {
      _TimelineEntryStyle.milestone => RoutineMilestone(item: entry.item),
      _TimelineEntryStyle.offer => const TodayOfferRoutineCard(),
      _TimelineEntryStyle.external => ExternalRoutineCard(
          item: entry.item,
          completed: completed,
          isPast: isPast,
          onPressed: onPressed,
        ),
      _TimelineEntryStyle.card => RoutineTimeCard(
          item: entry.item,
          completed: completed,
          isPast: isPast,
          onPressed: onPressed,
        ),
    };
    final opacity = isPast ? ParentRoutineTimeline.pastOpacity : 1.0;
    final visibleChild = isFocused ? _PulseFocus(child: child) : child;

    return PositionedDirectional(
      top: entry.top.h,
      start: entry.start?.w,
      end: entry.end?.w,
      child: Opacity(
        opacity: opacity,
        child: visibleChild,
      ),
    );
  }
}

class _PulseFocus extends HookWidget {
  const _PulseFocus({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 900),
    );
    useEffect(() {
      controller.repeat(reverse: true);
      return controller.stop;
    }, [controller]);

    return AnimatedBuilder(
      animation: controller,
      child: child,
      builder: (context, child) {
        final value = Curves.easeInOut.transform(controller.value);
        return Transform.scale(
          scale: 1 + (value * 0.025),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppBorders.full,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(
                    alpha: 0.12 + (value * 0.16),
                  ),
                  blurRadius: 18 + (value * 12),
                  spreadRadius: value * 2,
                ),
              ],
            ),
            child: child,
          ),
        );
      },
    );
  }
}

enum _TimelineEntryStyle { milestone, card, external, offer }

enum _TimelineSide { left, right }

class _RoutineTimelineLayout {
  const _RoutineTimelineLayout({
    required this.entries,
    required this.points,
    required this.height,
  });

  final List<_TimelineEntry> entries;
  final List<Offset> points;
  final double height;

  factory _RoutineTimelineLayout.from(List<ParentRoutineItem> items) {
    const firstPointY = 82.0;
    const slotGap = 220.0;
    const bottomPadding = 96.0;

    final entries = <_TimelineEntry>[];
    final lastIndex = items.length - 1;
    final lastPointY = firstPointY + (lastIndex * slotGap);
    final waveCount = _waveCountForSlots(lastIndex);

    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      final style = _styleFor(item);
      final pointY = firstPointY + (index * slotGap);
      final pointX = _pathXForY(
        y: pointY,
        startY: firstPointY,
        endY: lastPointY,
        waveCount: waveCount,
      );
      final fallbackSide = _fallbackSideForPoint(
        pointX: pointX,
        index: index,
      );
      final side = _sideForItemWithSpace(
        item: item,
        pointX: pointX,
        fallback: fallbackSide,
      );
      entries.add(
        _TimelineEntry(
          item: item,
          top: _topFor(style, pointY),
          start: _startFor(
            pointX: pointX,
            side: side,
            style: style,
          ),
          end: _endFor(
            pointX: pointX,
            side: side,
            style: style,
          ),
          point: Offset(pointX, pointY),
          style: style,
        ),
      );
    }

    final points = entries.map((entry) => entry.point).toList(growable: false);
    final height = points.isEmpty ? 0.0 : points.last.dy + bottomPadding;
    return _RoutineTimelineLayout(
      entries: entries,
      points: points,
      height: height,
    );
  }

  static _TimelineEntryStyle _styleFor(ParentRoutineItem item) {
    final type = item.type?.trim().toUpperCase();

    if (type == 'SCHEDULE') {
      return _TimelineEntryStyle.card;
    }

    if (type == 'WAKE_UP' ||
        type == 'SCHOOL' ||
        type == 'NAP' ||
        type == 'BEDTIME') {
      return _TimelineEntryStyle.milestone;
    }

    return switch (item.kind) {
      ParentRoutineKind.wake ||
      ParentRoutineKind.school ||
      ParentRoutineKind.bedtime ||
      ParentRoutineKind.nap =>
        _TimelineEntryStyle.milestone,
      ParentRoutineKind.offer => _TimelineEntryStyle.offer,
      ParentRoutineKind.external => _TimelineEntryStyle.external,
      _ => _TimelineEntryStyle.card,
    };
  }

  static double _topFor(_TimelineEntryStyle style, double pointY) {
    return switch (style) {
      _TimelineEntryStyle.milestone => pointY - 30,
      _TimelineEntryStyle.external => pointY - 43,
      _TimelineEntryStyle.offer => pointY - 44,
      _TimelineEntryStyle.card => pointY - 82,
    };
  }

  static double? _startFor({
    required double pointX,
    required _TimelineSide side,
    required _TimelineEntryStyle style,
  }) {
    if (style == _TimelineEntryStyle.card) {
      return (pointX - (_scheduleCardWidth / 2))
          .clamp(
            _screenPadding,
            ParentRoutineTimeline.designWidth -
                _screenPadding -
                _scheduleCardWidth,
          )
          .toDouble();
    }

    if (side == _TimelineSide.right) {
      if (style == _TimelineEntryStyle.milestone) {
        return (pointX + _milestoneGap).clamp(_screenPadding, 260.0).toDouble();
      }
      return null;
    }
    return style == _TimelineEntryStyle.milestone ? null : _screenPadding;
  }

  static double? _endFor({
    required double pointX,
    required _TimelineSide side,
    required _TimelineEntryStyle style,
  }) {
    if (style == _TimelineEntryStyle.card) return null;

    if (side == _TimelineSide.left) {
      if (style == _TimelineEntryStyle.milestone) {
        final end = ParentRoutineTimeline.designWidth - pointX + _milestoneGap;
        return end.clamp(_screenPadding, 260.0).toDouble();
      }
      return null;
    }
    return style == _TimelineEntryStyle.milestone ? null : _screenPadding;
  }

  static _TimelineSide _sideForItemWithSpace({
    required ParentRoutineItem item,
    required double pointX,
    required _TimelineSide fallback,
  }) {
    if (ParentRoutineTimeline._isWakeMilestoneItem(item)) {
      return _TimelineSide.left;
    }
    if (ParentRoutineTimeline._isBedtimeMilestoneItem(item)) {
      return _TimelineSide.right;
    }

    final isSchool = item.type?.trim().toUpperCase() == 'SCHOOL' ||
        item.kind == ParentRoutineKind.school;
    if (!isSchool) return fallback;

    const cardWidth = 190.0;
    const horizontalPadding = 16.0;
    const gapFromLine = 16.0;
    final leftSpace = pointX - horizontalPadding - gapFromLine;
    final rightSpace = ParentRoutineTimeline.designWidth -
        pointX -
        horizontalPadding -
        gapFromLine;
    final canFitLeft = leftSpace >= cardWidth;
    final canFitRight = rightSpace >= cardWidth;

    if (pointX >= ParentRoutineTimeline.designWidth / 2 && canFitLeft) {
      return _TimelineSide.left;
    }
    if (pointX < ParentRoutineTimeline.designWidth / 2 && canFitRight) {
      return _TimelineSide.right;
    }
    if (canFitLeft) return _TimelineSide.left;
    if (canFitRight) return _TimelineSide.right;
    return fallback;
  }

  static _TimelineSide _fallbackSideForPoint({
    required double pointX,
    required int index,
  }) {
    if (pointX < _centerPathX) return _TimelineSide.right;
    if (pointX > _centerPathX) return _TimelineSide.left;
    return index.isEven ? _TimelineSide.left : _TimelineSide.right;
  }

  static double pathXForY({
    required double y,
    required double startY,
    required double endY,
    required int waveCount,
  }) =>
      _pathXForY(
        y: y,
        startY: startY,
        endY: endY,
        waveCount: waveCount,
      );

  static int waveCountForPointCount(int pointCount) {
    if (pointCount <= 1) return 1;
    return _waveCountForSlots(pointCount - 1);
  }

  static int _waveCountForSlots(int lastIndex) {
    if (lastIndex <= 0) return 1;
    return math.max(1, (lastIndex / 4).ceil());
  }

  static double _pathXForY({
    required double y,
    required double startY,
    required double endY,
    required int waveCount,
  }) {
    if (endY <= startY) return _centerPathX;
    final progress = ((y - startY) / (endY - startY)).clamp(0.0, 1.0);
    final wave = math.sin(progress * waveCount * math.pi * 2);
    return _centerPathX - (_pathAmplitude * wave);
  }

  static const double _centerPathX = 220;
  static const double _pathAmplitude = 76;
  static const double _scheduleCardWidth = 248;
  static const double _milestoneGap = 24;
  static const double _screenPadding = 16;
}

class _TimelineEntry {
  const _TimelineEntry({
    required this.item,
    required this.top,
    required this.point,
    required this.style,
    this.start,
    this.end,
  });

  final ParentRoutineItem item;
  final double top;
  final double? start;
  final double? end;
  final Offset point;
  final _TimelineEntryStyle style;
}

class _RoutineSchedule {
  _RoutineSchedule({required this.items, required DateTime now})
      : _currentMinutes = now.hour * 60 + now.minute,
        _focusedItemId = _findFocusedItemId(
          items,
          now.hour * 60 + now.minute,
        );

  final List<ParentRoutineItem> items;
  final int _currentMinutes;
  final String? _focusedItemId;

  bool isPast(ParentRoutineItem item) {
    final comparisonTime = parseMinutes(item.endTime ?? item.startTime);
    return comparisonTime != null && comparisonTime < _currentMinutes;
  }

  bool isFocused(ParentRoutineItem item) => item.id == _focusedItemId;

  double get elapsedProgress {
    final scheduledMinutes = items
        .map((item) => parseMinutes(item.startTime))
        .whereType<int>()
        .toList(growable: false)
      ..sort();
    if (scheduledMinutes.length < 2) return 0;

    final first = scheduledMinutes.first;
    final last = scheduledMinutes.last;
    if (last == first) return _currentMinutes >= last ? 1 : 0;
    return ((_currentMinutes - first) / (last - first)).clamp(0.0, 1.0);
  }

  static int? parseMinutes(String? value) {
    if (value == null) return null;
    final parts = value.split(':');
    if (parts.length != 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null || hour > 23 || minute > 59) {
      return null;
    }
    return hour * 60 + minute;
  }

  static String? _findFocusedItemId(
    List<ParentRoutineItem> items,
    int currentMinutes,
  ) {
    for (final item in items) {
      final start = parseMinutes(item.startTime);
      if (start == null) continue;
      final end = parseMinutes(item.endTime);
      final isRunning = end == null
          ? start == currentMinutes
          : start <= currentMinutes && currentMinutes <= end;
      if (isRunning) return item.id;
    }

    ParentRoutineItem? nextItem;
    int? nextStart;
    for (final item in items) {
      final start = parseMinutes(item.startTime);
      if (start == null || start <= currentMinutes) continue;
      if (nextStart == null || start < nextStart) {
        nextStart = start;
        nextItem = item;
      }
    }
    return nextItem?.id;
  }
}

class _RoutinePathPainter extends CustomPainter {
  const _RoutinePathPainter({
    required this.points,
    required this.designHeight,
    required this.elapsedProgress,
  });

  final List<Offset> points;
  final double designHeight;
  final double elapsedProgress;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2 || designHeight <= 0) return;

    final scaleX = size.width / ParentRoutineTimeline.designWidth;
    final scaleY = size.height / designHeight;
    final scaledPoints = points
        .map((point) => Offset(point.dx * scaleX, point.dy * scaleY))
        .toList(growable: false);
    final path = _buildPath(
      size: size,
      scaleX: scaleX,
      scaleY: scaleY,
    );

    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.routinePathActive.withValues(alpha: 0.14)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 13 * scaleX
        ..strokeCap = StrokeCap.round,
    );

    canvas.drawPath(
      path,
      Paint()
        ..shader = _pathGradient(size)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 7 * scaleX
        ..strokeCap = StrokeCap.round,
    );

    for (final point in scaledPoints) {
      canvas.drawCircle(
        point,
        15 * scaleX,
        Paint()..color = contextSafeWhite,
      );
      canvas.drawCircle(
        point,
        11 * scaleX,
        Paint()
          ..color = point.dy / size.height <= elapsedProgress
              ? AppColors.routinePathPast
              : AppColors.routinePathActive,
      );
      canvas.drawCircle(
        point,
        4 * scaleX,
        Paint()..color = contextSafeWhite,
      );
    }
  }

  Path _buildPath({
    required Size size,
    required double scaleX,
    required double scaleY,
  }) {
    final startY = points.first.dy;
    final endY = points.last.dy;
    final waveCount = _RoutineTimelineLayout.waveCountForPointCount(
      points.length,
    );
    final path = Path();
    const sampleCountPerWave = 48;
    final sampleCount = math.max(48, waveCount * sampleCountPerWave);

    for (var index = 0; index <= sampleCount; index++) {
      final progress = index / sampleCount;
      final designY = startY + ((endY - startY) * progress);
      final designX = _RoutineTimelineLayout.pathXForY(
        y: designY,
        startY: startY,
        endY: endY,
        waveCount: waveCount,
      );
      final point = Offset(designX * scaleX, designY * scaleY);
      if (index == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    return path;
  }

  static const Color contextSafeWhite = AppColors.neutral50;

  Shader _pathGradient(Size size) {
    if (elapsedProgress <= 0) {
      return const LinearGradient(
        colors: [
          AppColors.routinePathActive,
          AppColors.routinePathActive,
        ],
      ).createShader(Offset.zero & size);
    }
    if (elapsedProgress >= 1) {
      return const LinearGradient(
        colors: [
          AppColors.routinePathPast,
          AppColors.routinePathPast,
        ],
      ).createShader(Offset.zero & size);
    }

    const transitionWidth = 0.045;
    final transitionStart = (elapsedProgress - transitionWidth).clamp(0.0, 1.0);
    final transitionEnd = (elapsedProgress + transitionWidth).clamp(0.0, 1.0);
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: const [
        AppColors.routinePathPast,
        AppColors.routinePathPast,
        AppColors.routinePathActive,
        AppColors.routinePathActive,
      ],
      stops: [0, transitionStart, transitionEnd, 1],
    ).createShader(Offset.zero & size);
  }

  @override
  bool shouldRepaint(covariant _RoutinePathPainter oldDelegate) =>
      oldDelegate.elapsedProgress != elapsedProgress ||
      oldDelegate.points != points ||
      oldDelegate.designHeight != designHeight;
}
