import 'package:alurei/src/features/roles/parent/today/presentation/controllers/build_day_from_library_controller.dart';
import 'package:alurei/src/features/roles/parent/today/presentation/widgets/build_day_from_library_widgets.dart';
import 'package:alurei/src/imports/imports.dart';

class BuildDayFromLibraryScreen extends GetView<BuildDayFromLibraryController> {
  const BuildDayFromLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libraryResultsKey = GlobalKey();
    final formCardKey = GlobalKey();

    void scrollToLibraryResultsTop() {
      final targetContext = libraryResultsKey.currentContext;
      if (targetContext == null) return;
      Scrollable.ensureVisible(
        targetContext,
        duration: AppDurations.medium,
        curve: AppCurves.decelerate,
        alignment: 0.05,
      );
    }

    void goToNextLibraryPage() {
      controller.goToNextLibraryPage();
      scrollToLibraryResultsTop();
    }

    void goToPreviousLibraryPage() {
      controller.goToPreviousLibraryPage();
      scrollToLibraryResultsTop();
    }

    void scrollToFormTop() {
      final targetContext = formCardKey.currentContext;
      if (targetContext == null) return;
      Scrollable.ensureVisible(
        targetContext,
        duration: AppDurations.medium,
        curve: AppCurves.decelerate,
        alignment: 0.05,
      );
    }

    void editScheduleItem(BuildDayScheduleItem item) {
      controller.editScheduleItem(item);
      WidgetsBinding.instance.addPostFrameCallback((_) => scrollToFormTop());
    }

    Future<void> pickTime(
      TimeOfDay initial,
      ValueChanged<TimeOfDay> onSelected,
    ) async {
      final value = await showAppTimePicker(
        context: context,
        initialTime: initial,
      );
      if (value != null) onSelected(value);
    }

    Future<void> addToDifferentDaySchedule() async {
      final value = await showAppDatePicker(
        context: context,
        initialDate: controller.differentScheduleInitialDate,
        allowFutureDates: true,
      );
      if (value != null) {
        AppLogger.debug(
          '[BuildDayFromLibraryScreen] Selected different schedule date: '
          '${value.year}-${value.month.toString().padLeft(2, '0')}-'
          '${value.day.toString().padLeft(2, '0')}',
        );
        await controller.addToDifferentDaysSchedule(value);
      }
    }

    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: '',
        isTransparent: true,
        showBackButton: true,
        actions: [
          Obx(
            () => BuildDayHeaderActionButton(
              label: controller.shouldShowBuilder
                  ? LangKey.parentToday.buildDayAction
                  : LangKey.parentToday.createChild,
              isLoading: controller.isCreatingChild.value,
              onPressed: controller.shouldShowBuilder
                  ? controller.finishBuildDay
                  : controller.canCreateChild
                      ? controller.createChild
                      : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => BuildDayChildNameInput(
                controller: controller.childNameController,
                wakeUpTime: controller.childWakeUpTime.value,
                bedTime: controller.childBedTime.value,
                onPickWakeUpTime: () => pickTime(
                  controller.childWakeUpTime.value,
                  (value) => controller.selectedChildWakeUpTime = value,
                ),
                onPickBedTime: () => pickTime(
                  controller.childBedTime.value,
                  (value) => controller.selectedChildBedTime = value,
                ),
              ),
            ),
            Obx(
              () {
                if (!controller.shouldShowBuilder) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    const BuildDayTitle(),
                    SizedBox(height: 12.h),
                    BuildDayToggleTabs(
                      selectedIndex: controller.selectedTabIndex.value,
                      onTabSelected: controller.selectTab,
                    ),
                    SizedBox(height: 16.h),
                    BuildDayFormCard(
                      key: formCardKey,
                      child: controller.selectedTabIndex.value == 0
                          ? BuildDayLibraryForm(
                              searchController: controller.searchController,
                              isFilterVisible: controller.isFilterVisible.value,
                              selectedFilterTag:
                                  controller.selectedFilterTag.value,
                              searchResults: controller.searchResults,
                              isLoading: controller.isLibraryLoading.value,
                              errorMessage: controller.libraryError.value,
                              hasQuery: controller.isSearching,
                              selectedLibraryItemName:
                                  controller.selectedLibraryItem.value?.name,
                              currentPage: controller.currentLibraryPage.value,
                              canShowNextPage:
                                  controller.canShowNextLibraryPage,
                              canShowPreviousPage:
                                  controller.canShowPreviousLibraryPage,
                              resultsAnchorKey: libraryResultsKey,
                              startTime: controller.startTime.value,
                              endTime: controller.endTime.value,
                              notesController: controller.notesController,
                              isAddingSchedule:
                                  controller.isAddingSchedule.value,
                              primaryActionLabel:
                                  controller.primaryScheduleActionLabel,
                              secondaryActionLabel:
                                  controller.secondaryScheduleActionLabel,
                              showSecondaryAction: !controller.isTodayEditOnly,
                              showCancelAction: controller.isEditingSchedule,
                              onToggleFilter: controller.toggleFilterVisibility,
                              onFilterTagSelected: controller.selectFilterTag,
                              onClearSelectedLibraryItem:
                                  controller.clearSelectedLibraryItem,
                              onPickStartTime: () => pickTime(
                                controller.startTime.value,
                                (value) => controller.selectedStartTime = value,
                              ),
                              onPickEndTime: () => pickTime(
                                controller.endTime.value,
                                (value) => controller.selectedEndTime = value,
                              ),
                              onAddSchedule: () => controller.addToSchedule(),
                              onAddDifferentDaySchedule:
                                  addToDifferentDaySchedule,
                              onCancelEdit: controller.cancelScheduleEdit,
                              onAddSearchResult:
                                  controller.addSearchResultToSchedule,
                              onRetry: controller.loadLibrary,
                              onNextPage: goToNextLibraryPage,
                              onPreviousPage: goToPreviousLibraryPage,
                            )
                          : BuildDayCustomForm(
                              taskTitleController:
                                  controller.taskTitleController,
                              notesController: controller.notesController,
                              selectedCategory:
                                  controller.selectedCategory.value,
                              isCategoryMenuVisible:
                                  controller.isCategoryMenuVisible.value,
                              isAddingSchedule:
                                  controller.isAddingSchedule.value,
                              showSecondaryAction: !controller.isTodayEditOnly,
                              startTime: controller.startTime.value,
                              endTime: controller.endTime.value,
                              onToggleCategoryMenu:
                                  controller.toggleCategoryMenu,
                              onCategorySelected: controller.selectCategory,
                              onPickStartTime: () => pickTime(
                                controller.startTime.value,
                                (value) => controller.selectedStartTime = value,
                              ),
                              onPickEndTime: () => pickTime(
                                controller.endTime.value,
                                (value) => controller.selectedEndTime = value,
                              ),
                              onAddSchedule: () => controller.addToSchedule(),
                              onAddDifferentDaySchedule:
                                  addToDifferentDaySchedule,
                            ),
                    ),
                    SizedBox(height: 24.h),
                    BuildDayScheduleSection(
                      title: LangKey.parentToday.todaySchedule,
                      items: controller.todayScheduleList.toList(),
                      isLoading: controller.isSchedulesLoading.value,
                      onEdit: editScheduleItem,
                      onDelete: controller.deleteTodayItem,
                      isItemDeleting: controller.isDeletingSchedule,
                    ),
                    SizedBox(height: 24.h),
                    if (!controller.isTodayEditOnly) ...[
                      BuildDayScheduleSection(
                        title: LangKey.parentToday.otherSchedules,
                        items: controller.otherScheduleList.toList(),
                        isLoading: controller.isSchedulesLoading.value,
                        onEdit: editScheduleItem,
                        onDelete: controller.deleteOtherItem,
                        isItemDeleting: controller.isDeletingSchedule,
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
