import 'dart:math' as math;

import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';

/// Horizontal child selector with the dashed add-child affordance from Figma.
class ParentChildSwitcher extends HookWidget {
  const ParentChildSwitcher({
    super.key,
    required this.children,
    required this.selectedChildId,
    required this.onChildSelected,
    required this.onAddChild,
    this.isLoading = false,
  });

  final List<ParentTodayChild> children;
  final String? selectedChildId;
  final ValueChanged<String> onChildSelected;
  final VoidCallback onAddChild;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final visibleChildren =
        children.isEmpty && isLoading ? _loadingChildren : children;
    final visibleSelectedId =
        selectedChildId ?? visibleChildren.firstOrNull?.id;
    final scrollController = useScrollController();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!scrollController.hasClients || visibleSelectedId == null) return;
        final index = visibleChildren.indexWhere(
          (child) => child.id == visibleSelectedId,
        );
        if (index <= 0) {
          scrollController.animateTo(
            0,
            duration: AppDurations.medium,
            curve: AppCurves.decelerate,
          );
          return;
        }
        final targetOffset = (index * 120.w).clamp(
          0.0,
          scrollController.position.maxScrollExtent,
        );
        scrollController.animateTo(
          targetOffset,
          duration: AppDurations.medium,
          curve: AppCurves.decelerate,
        );
      });
      return null;
    }, [
      visibleSelectedId,
      visibleChildren.length,
      isLoading,
    ]);

    return SkeletonWrapper(
      isLoading: isLoading,
      child: SizedBox(
        height: 72.h,
        child: SingleChildScrollView(
          controller: scrollController,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (var index = 0; index < visibleChildren.length; index++) ...[
                if (index > 0) SizedBox(width: 12.w),
                _ChildButton(
                  child: visibleChildren[index],
                  selected: visibleChildren[index].id == visibleSelectedId,
                  onPressed: () => onChildSelected(visibleChildren[index].id),
                ),
              ],
              SizedBox(width: 12.w),
              Skeleton.keep(
                child: _DashedAddChildButton(onPressed: onAddChild),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static const _loadingChildren = [
    ParentTodayChild(
      id: 'loading-child-1',
      name: 'Loading child',
      hasAllergy: false,
    ),
    ParentTodayChild(
      id: 'loading-child-2',
      name: 'Another child',
      hasAllergy: false,
    ),
    ParentTodayChild(
      id: 'loading-child-3',
      name: 'Another child',
      hasAllergy: false,
    ),
  ];
}

class _ChildButton extends StatelessWidget {
  const _ChildButton({
    required this.child,
    required this.selected,
    required this.onPressed,
  });

  final ParentTodayChild child;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          backgroundColor:
              selected ? context.colors.primary : context.colors.surface,
          foregroundColor:
              selected ? context.colors.onPrimary : context.colors.onSurface,
          side: BorderSide(
            color: selected
                ? context.colors.primary
                : context.colors.outlineVariant,
          ),
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child.hasAllergy) ...[
              Image.asset(AppAssets.icAllergies),
              SizedBox(width: 4.w),
            ],
            Text(
              child.name,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: selected
                    ? context.colors.onPrimary
                    : context.colors.onSurface,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(IconsaxPlusLinear.arrow_right_3, size: 14.sp),
          ],
        ),
      ),
    );
  }
}

class _DashedAddChildButton extends StatelessWidget {
  const _DashedAddChildButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: LangKey.parentToday.addChild,
      child: CustomPaint(
        painter: _DashedStadiumPainter(color: context.colors.primary),
        child: InkWell(
          onTap: onPressed,
          borderRadius: AppBorders.full,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LangKey.parentToday.addChild,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  IconsaxPlusLinear.add,
                  size: 20.sp,
                  color: context.colors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedStadiumPainter extends CustomPainter {
  const _DashedStadiumPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Offset.zero & size,
          Radius.circular(size.height / 2),
        ),
      );
    final metric = path.computeMetrics().first;
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    const dash = 4.0;
    const gap = 3.0;
    for (var distance = 0.0; distance < metric.length; distance += dash + gap) {
      canvas.drawPath(
        metric.extractPath(distance, math.min(distance + dash, metric.length)),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DashedStadiumPainter oldDelegate) =>
      oldDelegate.color != color;
}
