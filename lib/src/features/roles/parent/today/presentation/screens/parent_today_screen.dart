import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/shared/widgets/parent_ai_assistant_button.dart';

import '../../domain/entities/parent_today_data.dart';
import '../controllers/parent_today_controller.dart';
import '../widgets/parent_child_switcher.dart';
import '../widgets/parent_routine_detail_sheet.dart';
import '../widgets/parent_routine_timeline.dart';
import '../widgets/parent_today_empty_state.dart';

/// Parent role landing screen for the selected child's daily routine.
class ParentTodayScreen extends GetView<ParentTodayController> {
  const ParentTodayScreen({
    super.key,
    this.showBottomNavigationBar = true,
  });

  /// Whether this screen owns its bottom navigation.
  ///
  /// The role main shell sets this to false because it supplies the shared
  /// navigation bar for every tab.
  final bool showBottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final today = controller.data.value;
      return Scaffold(
        backgroundColor: context.appColors.primaryBackground,
        appBar: AppDashboardTopBar(
          greeting: LangKey.parentToday.goodMorning,
          userName: today?.parentName ?? '',
          avatarUrl: today?.avatarAsset,
          notificationCount: controller.notificationCount.value,
          messageCount: controller.messageCount.value,
          toolbarHeight: 83,
          onNotifications: controller.openNotifications,
          onMessages: controller.openMessages,
        ),
        body: Stack(
          children: [
            _buildBody(context, today),
            if (today != null && today.children.isNotEmpty)
              PositionedDirectional(
                bottom: 90.h,
                end: 16.w,
                child: ParentAiAssistantButton(
                  menuOpen: controller.isAiMenuOpen.value,
                  onPressed: controller.toggleAiMenu,
                  onOptionSelected: controller.openParentAi,
                ),
              ),
          ],
        ),
        bottomNavigationBar: showBottomNavigationBar
            ? AppBottomNavBar(
                selectedIndex: controller.selectedBottomIndex.value,
                onDestinationSelected: (index) =>
                    controller.bottomDestination = index,
              )
            : null,
      );
    });
  }

  Widget _buildBody(BuildContext context, ParentTodayData? today) {
    if (controller.isLoading.value) {
      return _buildLoadingBody();
    }
    if (today == null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                IconsaxPlusLinear.danger,
                size: 48.sp,
                color: context.colors.error,
              ),
              SizedBox(height: AppSpacing.md),
              Text(
                LangKey.parentToday.unableToLoad,
                textAlign: TextAlign.center,
                style: context.textTheme.titleMedium,
              ),
              SizedBox(height: AppSpacing.md),
              AppButton(
                label: LangKey.parentToday.retry,
                onPressed: controller.loadToday,
              ),
            ],
          ),
        ),
      );
    }
    if (today.children.isEmpty) {
      return ParentTodayEmptyState(onPressed: controller.openChildSetupGuide);
    }

    return RefreshIndicator(
      onRefresh: controller.loadToday,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          /// -- Child Switcher
          SliverToBoxAdapter(
            child: ParentChildSwitcher(
              children: today.children,
              selectedChildId: controller.selectedChildId.value,
              onChildSelected: (id) => controller.selectedChild = id,
              onAddChild: controller.openChildSetupGuide,
            ),
          ),

          /// -- Routine Timeline
          SliverToBoxAdapter(
            child: controller.timelineErrorMessage.value == null
                ? ParentRoutineTimeline(
                    items: controller.selectedRoutine,
                    completedIds: controller.completedRoutineIds.toSet(),
                    onRoutinePressed: _handleRoutinePressed,
                    onAddSchedule: controller.openBuildDayForSelectedChild,
                    isLoading: controller.isTimelineLoading.value,
                  )
                : AppErrorWidget(
                    title: LangKey.parentToday.unableToLoad,
                    message: controller.timelineErrorMessage.value,
                    onRetry: controller.loadDailyTimeline,
                  ),
          ),

          /// -- Bottom Spacing for Floating AI Button
          SliverPadding(
            padding: EdgeInsets.only(bottom: 96.h),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingBody() {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: ParentChildSwitcher(
            children: const <ParentTodayChild>[],
            selectedChildId: null,
            onChildSelected: (_) {},
            onAddChild: () {},
            isLoading: true,
          ),
        ),
        SliverToBoxAdapter(
          child: ParentRoutineTimeline(
            items: const <ParentRoutineItem>[],
            completedIds: const <String>{},
            onRoutinePressed: (_) {},
            isLoading: true,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: 96.h),
        ),
      ],
    );
  }

  void _handleRoutinePressed(String id) {
    final routine = controller.selectedRoutine.firstWhereOrNull(
      (item) => item.id == id,
    );
    if (routine == null) return;
    if (routine.kind == ParentRoutineKind.story) {
      controller.openBedtimeStory();
      return;
    }
    if (_hasDetailSheet(routine.kind)) {
      showAppSheet<void>(
        child: ParentRoutineDetailSheet(
          data: ParentRoutineDetailSheetData.fromItem(routine),
        ),
      );
      return;
    }
    controller.toggleRoutineCompletion(id);
  }

  bool _hasDetailSheet(ParentRoutineKind kind) {
    return switch (kind) {
      ParentRoutineKind.breakfast ||
      ParentRoutineKind.outdoor ||
      ParentRoutineKind.study =>
        true,
      _ => false,
    };
  }
}
