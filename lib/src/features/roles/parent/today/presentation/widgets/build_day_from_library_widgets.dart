import 'dart:ui';

import 'package:alurei/src/features/roles/parent/today/presentation/controllers/build_day_from_library_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class BuildDayHeaderActionButton extends StatelessWidget {
  const BuildDayHeaderActionButton({
    super.key,
    this.onPressed,
    this.label,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final String? label;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 16.w),
      child: FilledButton.icon(
        onPressed: isLoading ? () {} : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colors.primary,
          foregroundColor: context.colors.onPrimary,
          minimumSize: Size.zero,
          padding: EdgeInsets.all(16.w),
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.lg),
        ),
        icon: isLoading
            ? SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.colors.onPrimary,
                ),
              )
            : SvgPicture.asset(
                AppAssets.buildDayPickaxe,
                width: 16.w,
                height: 16.w,
                colorFilter: ColorFilter.mode(
                  onPressed == null
                      ? context.colors.onSurface.withValues(alpha: 0.38)
                      : context.colors.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
        label: Text(
          label ?? LangKey.parentToday.buildDayAction,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w600,
            color: onPressed == null
                ? context.colors.onSurface.withValues(alpha: 0.38)
                : context.colors.onPrimary,
          ),
        ),
      ),
    );
  }
}

class BuildDayChildNameInput extends StatelessWidget {
  const BuildDayChildNameInput({
    super.key,
    required this.controller,
    required this.wakeUpTime,
    required this.bedTime,
    required this.onPickWakeUpTime,
    required this.onPickBedTime,
  });

  final TextEditingController controller;
  final TimeOfDay wakeUpTime;
  final TimeOfDay bedTime;
  final VoidCallback onPickWakeUpTime;
  final VoidCallback onPickBedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: AppFormOutlinedPanel(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppFormField(
              label: LangKey.parentToday.childNameLabel,
              child: AppFormTextInput(
                controller: controller,
                hint: LangKey.parentToday.childNameHint,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _BuildDayChildTimeField(
                    label: LangKey.parentToday.wakeUpTime,
                    time: wakeUpTime,
                    onTap: onPickWakeUpTime,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _BuildDayChildTimeField(
                    label: LangKey.parentToday.bedtime,
                    time: bedTime,
                    onTap: onPickBedTime,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDayChildTimeField extends StatelessWidget {
  const _BuildDayChildTimeField({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorders.lg,
        child: Container(
          height: 56.h,
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: appFormInputBoxDecoration(context),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  formatAppTimeOfDay(context, time),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
              Icon(
                IconsaxPlusLinear.clock_1,
                size: 20.sp,
                color: context.appColors.mutedText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildDayTitle extends StatelessWidget {
  const BuildDayTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LangKey.parentToday.buildYourChildDay,
        textAlign: TextAlign.center,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 20.sp,
          height: 30 / 20,
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class BuildDayToggleTabs extends StatelessWidget {
  const BuildDayToggleTabs({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.bottomNavSelectedBackground,
          borderRadius: AppBorders.full,
        ),
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            _BuildDayTabButton(
              label: LangKey.parentToday.buildFromLibrary,
              selected: selectedIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            _BuildDayTabButton(
              label: LangKey.parentToday.buildYourOwn,
              selected: selectedIndex == 1,
              onTap: () => onTabSelected(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDayTabButton extends StatelessWidget {
  const _BuildDayTabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: AppBorders.full,
        child: AnimatedContainer(
          duration: AppDurations.fast,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            color:
                selected ? AppColors.secondaryTeal : AppColors.transparentColor,
            borderRadius: AppBorders.full,
          ),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: selected
                    ? AppColors.neutral50
                    : context.appColors.primaryText,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BuildDayFormCard extends StatelessWidget {
  const BuildDayFormCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: AppBorders.lg,
        ),
        child: child,
      ),
    );
  }
}

class BuildDayLibraryForm extends StatelessWidget {
  const BuildDayLibraryForm({
    super.key,
    required this.searchController,
    required this.isFilterVisible,
    required this.selectedFilterTag,
    required this.searchResults,
    required this.isLoading,
    required this.errorMessage,
    required this.hasQuery,
    required this.selectedLibraryItemName,
    required this.currentPage,
    required this.canShowNextPage,
    required this.canShowPreviousPage,
    required this.resultsAnchorKey,
    required this.startTime,
    required this.endTime,
    required this.notesController,
    required this.isAddingSchedule,
    required this.primaryActionLabel,
    required this.secondaryActionLabel,
    this.showSecondaryAction = true,
    required this.showCancelAction,
    required this.onToggleFilter,
    required this.onFilterTagSelected,
    required this.onClearSelectedLibraryItem,
    required this.onPickStartTime,
    required this.onPickEndTime,
    required this.onAddSchedule,
    required this.onAddDifferentDaySchedule,
    required this.onCancelEdit,
    required this.onAddSearchResult,
    required this.onRetry,
    required this.onNextPage,
    required this.onPreviousPage,
  });

  final TextEditingController searchController;
  final bool isFilterVisible;
  final String selectedFilterTag;
  final BuildDayLibraryResult searchResults;
  final bool isLoading;
  final String? errorMessage;
  final bool hasQuery;
  final String? selectedLibraryItemName;
  final int currentPage;
  final bool canShowNextPage;
  final bool canShowPreviousPage;
  final Key resultsAnchorKey;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final TextEditingController notesController;
  final bool isAddingSchedule;
  final String primaryActionLabel;
  final String secondaryActionLabel;
  final bool showSecondaryAction;
  final bool showCancelAction;
  final VoidCallback onToggleFilter;
  final ValueChanged<String> onFilterTagSelected;
  final VoidCallback onClearSelectedLibraryItem;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;
  final VoidCallback onAddSchedule;
  final VoidCallback onAddDifferentDaySchedule;
  final VoidCallback onCancelEdit;
  final ValueChanged<BuildDayLibrarySearchResultItem> onAddSearchResult;
  final VoidCallback onRetry;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildDayLibrarySearchFilter(
          searchController: searchController,
          isFilterVisible: isFilterVisible,
          selectedFilterTag: selectedFilterTag,
          selectedLibraryItemName: selectedLibraryItemName,
          onToggleFilter: onToggleFilter,
          onFilterTagSelected: onFilterTagSelected,
          onClearSelectedLibraryItem: onClearSelectedLibraryItem,
        ),
        if (hasQuery || isLoading || errorMessage != null) ...[
          SizedBox(height: 24.h),
          KeyedSubtree(
            key: resultsAnchorKey,
            child: BuildDaySearchResultsView(
              result: searchResults,
              isLoading: isLoading,
              errorMessage: errorMessage,
              hasQuery: hasQuery,
              currentPage: currentPage,
              canShowNextPage: canShowNextPage,
              canShowPreviousPage: canShowPreviousPage,
              onRetry: onRetry,
              onNextPage: onNextPage,
              onPreviousPage: onPreviousPage,
              onAddToSchedule: onAddSearchResult,
            ),
          ),
          SizedBox(height: 24.h),
        ] else
          SizedBox(height: 24.h),
        BuildDayTimeNotesForm(
          startTime: startTime,
          endTime: endTime,
          notesController: notesController,
          isLoading: isAddingSchedule,
          primaryActionLabel: primaryActionLabel,
          secondaryActionLabel: secondaryActionLabel,
          showSecondaryAction: showSecondaryAction,
          showCancelAction: showCancelAction,
          onPickStartTime: onPickStartTime,
          onPickEndTime: onPickEndTime,
          onAddSchedule: onAddSchedule,
          onAddDifferentDaySchedule: onAddDifferentDaySchedule,
          onCancelEdit: onCancelEdit,
        ),
      ],
    );
  }
}

class BuildDayLibrarySearchFilter extends StatelessWidget {
  const BuildDayLibrarySearchFilter({
    super.key,
    required this.searchController,
    required this.isFilterVisible,
    required this.selectedFilterTag,
    required this.selectedLibraryItemName,
    required this.onToggleFilter,
    required this.onFilterTagSelected,
    required this.onClearSelectedLibraryItem,
  });

  final TextEditingController searchController;
  final bool isFilterVisible;
  final String selectedFilterTag;
  final String? selectedLibraryItemName;
  final VoidCallback onToggleFilter;
  final ValueChanged<String> onFilterTagSelected;
  final VoidCallback onClearSelectedLibraryItem;

  @override
  Widget build(BuildContext context) {
    final recipes = [
      LangKey.parentToday.filterBreakfast,
      LangKey.parentToday.filterLunch,
      LangKey.parentToday.filterDinner,
      LangKey.parentToday.filterSnacks,
      LangKey.parentToday.filterFamily,
      LangKey.parentToday.filterOther,
    ];
    final activities = [
      LangKey.parentToday.filterIndoor,
      LangKey.parentToday.filterOutdoor,
      LangKey.parentToday.filterGroup,
      LangKey.parentToday.filterAgeZeroTwelveMonths,
      LangKey.parentToday.filterAgeTwelveTwentyFourMonths,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: AppColors.brandGray50,
            borderRadius: AppBorders.lg,
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: selectedLibraryItemName != null ? 16.h : 8.h),
          child: selectedLibraryItemName != null
              ? Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: _BuildDaySelectedLibraryChip(
                    label: selectedLibraryItemName!,
                    onClear: onClearSelectedLibraryItem,
                  ),
                )
              : Row(
                  children: [
                    Icon(
                      IconsaxPlusLinear.search_normal_1,
                      size: 18.sp,
                      color: context.appColors.disabledText,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 20 / 14,
                          color: context.appColors.primaryText,
                        ),
                        decoration: InputDecoration(
                          hintText: LangKey.parentToday.searchActivitiesRecipes,
                          hintStyle: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            color: context.appColors.disabledText,
                          ),
                          fillColor: AppColors.transparentColor,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onToggleFilter,
                      visualDensity: VisualDensity.compact,
                      icon: Icon(
                        IconsaxPlusLinear.filter,
                        size: 24.sp,
                        color: isFilterVisible
                            ? AppColors.secondaryTeal
                            : context.colors.primary,
                      ),
                    ),
                  ],
                ),
        ),
        AnimatedSwitcher(
          duration: AppDurations.fast,
          child: isFilterVisible
              ? Column(
                  key: const ValueKey('filters'),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12.h),
                    BuildDayFilterChipGroup(
                      title: LangKey.parentToday.recipes,
                      options: recipes,
                      selected: selectedFilterTag,
                      onSelected: onFilterTagSelected,
                    ),
                    SizedBox(height: 12.h),
                    BuildDayFilterChipGroup(
                      title: LangKey.parentToday.activities,
                      options: activities,
                      selected: selectedFilterTag,
                      onSelected: onFilterTagSelected,
                    ),
                  ],
                )
              : const SizedBox.shrink(key: ValueKey('filters-hidden')),
        ),
      ],
    );
  }
}

class _BuildDaySelectedLibraryChip extends StatelessWidget {
  const _BuildDaySelectedLibraryChip({
    required this.label,
    required this.onClear,
  });

  final String label;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 260.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppBorders.md,
          border: Border.all(color: AppColors.brandTealBorder),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  color: context.appColors.disabledText,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: onClear,
              borderRadius: AppBorders.full,
              child: Icon(
                IconsaxPlusLinear.close_circle,
                size: 16.sp,
                color: context.appColors.disabledText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDayFilterChipGroup extends StatelessWidget {
  const BuildDayFilterChipGroup({
    super.key,
    required this.title,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final String title;
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: context.appColors.primaryText,
          ),
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: options.map((option) {
              final isSelected = option == selected;
              return Padding(
                padding: EdgeInsetsDirectional.only(end: 11.w),
                child: ChoiceChip(
                  label: Text(option),
                  selected: isSelected,
                  onSelected: (_) => onSelected(option),
                  selectedColor: AppColors.secondaryTeal,
                  backgroundColor:
                      AppColors.secondaryTeal.withValues(alpha: 0.1),
                  side: BorderSide(
                    color: AppColors.secondaryTeal.withValues(alpha: 0.2),
                  ),
                  showCheckmark: false,
                  shape: const StadiumBorder(),
                  labelStyle: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    color: isSelected
                        ? context.colors.onPrimary
                        : context.colors.primary,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 17.w,
                    vertical: 9.h,
                  ),
                ),
              );
            }).toList(growable: false),
          ),
        ),
      ],
    );
  }
}

class BuildDayCustomForm extends StatelessWidget {
  const BuildDayCustomForm({
    super.key,
    required this.taskTitleController,
    required this.notesController,
    required this.selectedCategory,
    required this.isCategoryMenuVisible,
    required this.isAddingSchedule,
    this.showSecondaryAction = true,
    required this.startTime,
    required this.endTime,
    required this.onToggleCategoryMenu,
    required this.onCategorySelected,
    required this.onPickStartTime,
    required this.onPickEndTime,
    required this.onAddSchedule,
    required this.onAddDifferentDaySchedule,
  });

  final TextEditingController taskTitleController;
  final TextEditingController notesController;
  final ScheduleCategory selectedCategory;
  final bool isCategoryMenuVisible;
  final bool isAddingSchedule;
  final bool showSecondaryAction;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final VoidCallback onToggleCategoryMenu;
  final ValueChanged<ScheduleCategory> onCategorySelected;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;
  final VoidCallback onAddSchedule;
  final VoidCallback onAddDifferentDaySchedule;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppFormField(
          label: LangKey.parentToday.taskTitle,
          child: AppFormTextInput(
            controller: taskTitleController,
            hint: LangKey.parentToday.taskTitleHint,
          ),
        ),
        SizedBox(height: 24.h),
        BuildDayCategorySelector(
          selectedCategory: selectedCategory,
          expanded: isCategoryMenuVisible,
          onTap: onToggleCategoryMenu,
          onSelected: onCategorySelected,
        ),
        SizedBox(height: 24.h),
        BuildDayTimeNotesForm(
          startTime: startTime,
          endTime: endTime,
          notesController: notesController,
          isLoading: isAddingSchedule,
          showSecondaryAction: showSecondaryAction,
          onPickStartTime: onPickStartTime,
          onPickEndTime: onPickEndTime,
          onAddSchedule: onAddSchedule,
          onAddDifferentDaySchedule: onAddDifferentDaySchedule,
        ),
      ],
    );
  }
}

class BuildDayCategorySelector extends StatelessWidget {
  const BuildDayCategorySelector({
    super.key,
    required this.selectedCategory,
    required this.expanded,
    required this.onTap,
    required this.onSelected,
  });

  final ScheduleCategory selectedCategory;
  final bool expanded;
  final VoidCallback onTap;
  final ValueChanged<ScheduleCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: LangKey.parentToday.category,
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: AppBorders.lg,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: appFormInputBoxDecoration(context),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _categoryLabel(selectedCategory),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ),
                  AnimatedRotation(
                    turns: expanded ? 0.5 : 0,
                    duration: AppDurations.fast,
                    child: Icon(
                      IconsaxPlusLinear.arrow_down,
                      size: 24.sp,
                      color: context.appColors.strongText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedSwitcher(
            duration: AppDurations.fast,
            child: expanded
                ? BuildDayCategoryMenu(
                    key: const ValueKey('category-menu'),
                    selectedCategory: selectedCategory,
                    onSelected: onSelected,
                  )
                : const SizedBox.shrink(key: ValueKey('category-menu-hidden')),
          ),
        ],
      ),
    );
  }
}

class BuildDayCategoryMenu extends StatelessWidget {
  const BuildDayCategoryMenu({
    super.key,
    required this.selectedCategory,
    required this.onSelected,
  });

  final ScheduleCategory selectedCategory;
  final ValueChanged<ScheduleCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        borderRadius: AppBorders.md,
      ),
      child: Column(
        children: ScheduleCategory.values.map((category) {
          final isSelected = category == selectedCategory;
          return Padding(
            padding: EdgeInsets.only(
                bottom: category == ScheduleCategory.values.last ? 0 : 8.h),
            child: InkWell(
              onTap: () => onSelected(category),
              borderRadius: AppBorders.md,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primary
                      : context.appColors.primaryBackground,
                  border: isSelected
                      ? null
                      : Border.all(color: AppColors.brandTealTrack),
                  borderRadius: AppBorders.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _categoryLabel(category),
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          height: 24 / 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? context.colors.onPrimary
                              : context.appColors.primaryText,
                        ),
                      ),
                    ),
                    Container(
                      width: 20.w,
                      height: 20.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? context.colors.onPrimary
                              : AppColors.brandTealBorder,
                          width: 1.4.w,
                        ),
                      ),
                      child: isSelected
                          ? Center(
                              child: Container(
                                width: 10.w,
                                height: 10.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: context.colors.onPrimary,
                                ),
                              ),
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(growable: false),
      ),
    );
  }
}

class BuildDayTimeNotesForm extends StatelessWidget {
  const BuildDayTimeNotesForm({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.notesController,
    this.isLoading = false,
    this.primaryActionLabel,
    this.secondaryActionLabel,
    this.showSecondaryAction = true,
    this.showCancelAction = false,
    required this.onPickStartTime,
    required this.onPickEndTime,
    required this.onAddSchedule,
    required this.onAddDifferentDaySchedule,
    this.onCancelEdit,
  });

  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final TextEditingController notesController;
  final bool isLoading;
  final String? primaryActionLabel;
  final String? secondaryActionLabel;
  final bool showSecondaryAction;
  final bool showCancelAction;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;
  final VoidCallback onAddSchedule;
  final VoidCallback onAddDifferentDaySchedule;
  final VoidCallback? onCancelEdit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            BuildDayTimeField(
              label: LangKey.parentToday.startTimeRequired,
              time: startTime,
              onTap: onPickStartTime,
            ),
            SizedBox(width: 16.w),
            BuildDayTimeField(
              label: LangKey.parentToday.endTimeOptional,
              time: endTime,
              onTap: onPickEndTime,
            ),
          ],
        ),
        SizedBox(height: 16.h),
        AppFormField(
          label: LangKey.parentToday.descriptionNotesOptional,
          child: AppFormTextInput(
            controller: notesController,
            hint: LangKey.parentToday.descriptionNotesHint,
            minLines: 4,
            maxLines: 4,
            inputFormatters: const [_MaxWordsInputFormatter(20)],
          ),
        ),
        SizedBox(height: 8.h),
        Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Text(
            LangKey.parentToday.maxTwentyWords,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              height: 24 / 16,
              color: context.appColors.disabledText,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        AppButton(
          label: primaryActionLabel ?? LangKey.parentToday.addToSchedule,
          onPressed: onAddSchedule,
          isLoading: isLoading,
          color: AppColors.secondaryTeal,
          height: ButtonSize.large,
          isFullWidth: true,
          prefixIcon: Icon(
            IconsaxPlusLinear.add_circle,
            size: 18.sp,
            color: context.colors.onPrimary,
          ),
        ),
        if (showSecondaryAction) ...[
          SizedBox(height: 12.h),
          AppButton(
            label: secondaryActionLabel ??
                LangKey.parentToday.addToDifferentDaysSchedule,
            onPressed: onAddDifferentDaySchedule,
            isLoading: isLoading,
            variant: ButtonVariant.outline,
            borderColor: AppColors.brandTealBorder,
            textColor: context.colors.primary,
            height: ButtonSize.large,
            isFullWidth: true,
            prefixIcon: Icon(
              IconsaxPlusLinear.add_circle,
              size: 18.sp,
              color: context.colors.primary,
            ),
          ),
        ],
        if (showCancelAction) ...[
          SizedBox(height: 12.h),
          AppButton(
            label: LangKey.parentToday.cancel,
            onPressed: isLoading ? null : onCancelEdit,
            variant: ButtonVariant.ghost,
            textColor: context.colors.primary,
            height: ButtonSize.medium,
            isFullWidth: true,
          ),
        ],
      ],
    );
  }
}

class _MaxWordsInputFormatter extends TextInputFormatter {
  const _MaxWordsInputFormatter(this.maxWords);

  final int maxWords;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (_wordCount(newValue.text) <= maxWords) return newValue;
    return oldValue;
  }

  int _wordCount(String value) {
    return RegExp(r'\S+').allMatches(value.trim()).length;
  }
}

class BuildDayTimeField extends StatelessWidget {
  const BuildDayTimeField({
    super.key,
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          SizedBox(height: 8.h),
          InkWell(
            onTap: onTap,
            borderRadius: AppBorders.md,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 9.h),
              decoration: BoxDecoration(
                borderRadius: AppBorders.md,
                border: Border.all(color: AppColors.brandTealBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      formatAppTimeOfDay(context, time),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        height: 24 / 16,
                        color: AppColors.brandGrayHint,
                      ),
                    ),
                  ),
                  Icon(
                    IconsaxPlusLinear.clock_1,
                    size: 20.sp,
                    color: AppColors.brandGrayHint,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildDayScheduleSection extends StatelessWidget {
  const BuildDayScheduleSection({
    super.key,
    required this.title,
    required this.items,
    required this.isLoading,
    required this.onEdit,
    required this.onDelete,
    required this.isItemDeleting,
  });

  final String title;
  final List<BuildDayScheduleItem> items;
  final bool isLoading;
  final ValueChanged<BuildDayScheduleItem> onEdit;
  final ValueChanged<String> onDelete;
  final bool Function(String id) isItemDeleting;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              title,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 24.sp,
                height: 32 / 24,
                fontWeight: FontWeight.w600,
                color: context.colors.primary,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          if (isLoading && items.isEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return BuildDayScheduleItemCard(
                  item: BuildDayScheduleItem(
                    id: 'schedule-loading-$index',
                    startTime: '09:15',
                    endTime: '10:00',
                    title: 'Loading schedule item',
                    description: 'Loading schedule description',
                  ),
                  isLoading: true,
                  onEdit: () {},
                  onDelete: () {},
                );
              },
            )
          else if (items.isEmpty)
            AppEmptyState(
              title: LangKey.parentToday.noScheduleItems,
              subtitle: LangKey.parentToday.noScheduleItemsDescription,
              icon: IconsaxPlusLinear.calendar_remove,
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final item = items[index];
                return BuildDayScheduleItemCard(
                  item: item,
                  isLoading: isItemDeleting(item.id),
                  onEdit: () => onEdit(item),
                  onDelete: () => onDelete(item.id),
                );
              },
            ),
        ],
      ),
    );
  }
}

class BuildDayScheduleItemCard extends StatelessWidget {
  const BuildDayScheduleItemCard({
    super.key,
    required this.item,
    required this.isLoading,
    required this.onEdit,
    required this.onDelete,
  });

  final BuildDayScheduleItem item;
  final bool isLoading;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SkeletonWrapper(
      isLoading: isLoading,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 8.w, right: 4.w, bottom: 8.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: AppBorders.md,
          border: Border.all(
            color: AppColors.brandTealTrack.withValues(alpha: 0.1),
          ),
          boxShadow: AppShadows.subtle,
        ),
        child: Column(
          children: [
            Row(
              children: [
                BuildDayScheduleTimeColumn(item: item),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          height: 28 / 18,
                          fontWeight: FontWeight.w600,
                          color: context.appColors.primaryText,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      if (item.description.trim().isNotEmpty) ...[
                        Text(
                          item.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            color: context.appColors.mutedText,
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                      if (item.date != null) ...[
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            LangKey.parentToday.scheduleDate
                                .replaceFirst('{}', item.date!),
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              height: 18 / 12,
                              color: context.appColors.mutedText,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                BuildDayScheduleActions(
                  onEdit: isLoading ? () {} : onEdit,
                  onDelete: isLoading ? () {} : onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildDayScheduleTimeColumn extends StatelessWidget {
  const BuildDayScheduleTimeColumn({super.key, required this.item});

  final BuildDayScheduleItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 70.w),
      padding: EdgeInsetsDirectional.only(end: 1.w),
      decoration: BoxDecoration(
        border: BorderDirectional(
          end: BorderSide(
            color: AppColors.brandTealTrack.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          _timeText(context, item.startTime),
          SizedBox(height: 8.h),
          Container(width: 12.w, height: 1.h, color: AppColors.brandTealTrack),
          SizedBox(height: 8.h),
          _timeText(context, item.endTime),
        ],
      ),
    );
  }

  Widget _timeText(BuildContext context, String value) {
    return Text(
      value,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 12.sp,
        height: 18 / 12,
        fontWeight: FontWeight.w500,
        color: context.appColors.mutedText,
      ),
    );
  }
}

class BuildDayScheduleActions extends StatelessWidget {
  const BuildDayScheduleActions({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onEdit,
          visualDensity: VisualDensity.compact,
          icon: Icon(
            IconsaxPlusLinear.edit_2,
            size: 16.sp,
            color: context.appColors.disabledText,
          ),
        ),
        IconButton(
          onPressed: onDelete,
          visualDensity: VisualDensity.compact,
          icon: Icon(
            IconsaxPlusLinear.trash,
            size: 16.sp,
            color: context.colors.error,
          ),
        ),
      ],
    );
  }
}

class BuildDaySearchResultsView extends StatelessWidget {
  const BuildDaySearchResultsView({
    super.key,
    required this.result,
    required this.isLoading,
    required this.errorMessage,
    required this.hasQuery,
    required this.currentPage,
    required this.canShowNextPage,
    required this.canShowPreviousPage,
    required this.onRetry,
    required this.onNextPage,
    required this.onPreviousPage,
    required this.onAddToSchedule,
  });

  final BuildDayLibraryResult result;
  final bool isLoading;
  final String? errorMessage;
  final bool hasQuery;
  final int currentPage;
  final bool canShowNextPage;
  final bool canShowPreviousPage;
  final VoidCallback onRetry;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  final ValueChanged<BuildDayLibrarySearchResultItem> onAddToSchedule;

  @override
  Widget build(BuildContext context) {
    if (!hasQuery && !isLoading && errorMessage == null) {
      return const SizedBox.shrink();
    }

    if (isLoading) {
      return AbsorbPointer(
        child: Skeletonizer(
          enabled: true,
          child: _BuildDaySearchResultsContent(
            result: _BuildDayLibrarySkeletonData.result,
            currentPage: currentPage,
            canShowNextPage: false,
            canShowPreviousPage: false,
            onNextPage: onNextPage,
            onPreviousPage: onPreviousPage,
            onAddToSchedule: onAddToSchedule,
          ),
        ),
      );
    }

    if (errorMessage != null && result.isEmpty) {
      return AppErrorWidget(
        title: LangKey.parentToday.unableToLoadLibraryItems,
        message: errorMessage,
        onRetry: onRetry,
      );
    }

    if (result.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h),
        child: Center(
          child: Text(
            LangKey.parentToday.noMatchingLibraryItems,
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              color: context.appColors.disabledText,
            ),
          ),
        ),
      );
    }

    return _BuildDaySearchResultsContent(
      result: result,
      currentPage: currentPage,
      canShowNextPage: canShowNextPage,
      canShowPreviousPage: canShowPreviousPage,
      onNextPage: onNextPage,
      onPreviousPage: onPreviousPage,
      onAddToSchedule: onAddToSchedule,
      errorMessage: errorMessage,
      onRetry: onRetry,
    );
  }
}

class _BuildDayPaginationControls extends StatelessWidget {
  const _BuildDayPaginationControls({
    required this.currentPage,
    required this.canShowPreviousPage,
    required this.canShowNextPage,
    required this.onPreviousPage,
    required this.onNextPage,
  });

  final int currentPage;
  final bool canShowPreviousPage;
  final bool canShowNextPage;
  final VoidCallback onPreviousPage;
  final VoidCallback onNextPage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (canShowPreviousPage)
          TextButton.icon(
            onPressed: onPreviousPage,
            icon: Icon(IconsaxPlusLinear.arrow_left, size: 16.sp),
            label: Text(LangKey.parentToday.previous),
          )
        else
          const Spacer(),
        Expanded(
          child: Text(
            LangKey.parentToday.pageNumber
                .replaceFirst('{}', currentPage.toString()),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w600,
              color: context.appColors.mutedText,
            ),
          ),
        ),
        if (canShowNextPage)
          TextButton.icon(
            onPressed: onNextPage,
            iconAlignment: IconAlignment.end,
            icon: Icon(IconsaxPlusLinear.arrow_right_3, size: 16.sp),
            label: Text(LangKey.parentToday.next),
          )
        else
          const Spacer(),
      ],
    );
  }
}

abstract final class _BuildDayLibrarySkeletonData {
  static const result = BuildDayLibraryResult(
    recipes: [
      BuildDayLibrarySearchResultItem(
        id: 'skeleton-recipe-1',
        type: BuildDaySearchResultType.recipe,
        title: 'Blueberry Oat Porridge',
        category: 'Breakfast',
        subtitle: '6 months - 2 years',
        tags: ['10 min', 'Easy', 'Balanced'],
        imageAsset: 'assets/images/parent_today_child_profile_avatar.png',
      ),
    ],
    activities: [
      BuildDayLibrarySearchResultItem(
        id: 'skeleton-activity-1',
        type: BuildDaySearchResultType.activity,
        title: 'Kitchen Band',
        category: 'Music',
        subtitle: '1 year - 4 years',
        tags: ['10-20 min', 'High', 'Indoor'],
        description:
            'Making joyful noise and dancing together in the heart of the home.',
        imageAsset: 'assets/images/child_setup_guide_bg.png',
      ),
    ],
  );
}

class _BuildDaySearchResultsContent extends StatelessWidget {
  const _BuildDaySearchResultsContent({
    required this.result,
    required this.currentPage,
    required this.canShowNextPage,
    required this.canShowPreviousPage,
    required this.onNextPage,
    required this.onPreviousPage,
    required this.onAddToSchedule,
    this.errorMessage,
    this.onRetry,
  });

  final BuildDayLibraryResult result;
  final int currentPage;
  final bool canShowNextPage;
  final bool canShowPreviousPage;
  final VoidCallback onNextPage;
  final VoidCallback onPreviousPage;
  final ValueChanged<BuildDayLibrarySearchResultItem> onAddToSchedule;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (errorMessage != null && onRetry != null) ...[
          _BuildDayInlineError(message: errorMessage!, onRetry: onRetry!),
          SizedBox(height: 16.h),
        ],
        if (result.recipes.isNotEmpty) ...[
          _BuildDayResultSectionTitle(title: LangKey.parentToday.recipes),
          SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: result.recipes.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = result.recipes[index];
              return BuildDayRecipeLibraryCard(
                item: item,
                onAddToSchedule: () => onAddToSchedule(item),
              );
            },
          ),
        ],
        if (result.recipes.isNotEmpty && result.activities.isNotEmpty)
          SizedBox(height: 24.h),
        if (result.activities.isNotEmpty) ...[
          _BuildDayResultSectionTitle(title: LangKey.parentToday.activities),
          SizedBox(height: 12.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: result.activities.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final item = result.activities[index];
              return BuildDayActivityLibraryCard(
                item: item,
                onAddToSchedule: () => onAddToSchedule(item),
              );
            },
          ),
        ],
        if (canShowPreviousPage || canShowNextPage) ...[
          SizedBox(height: 16.h),
          _BuildDayPaginationControls(
            currentPage: currentPage,
            canShowPreviousPage: canShowPreviousPage,
            canShowNextPage: canShowNextPage,
            onPreviousPage: onPreviousPage,
            onNextPage: onNextPage,
          ),
        ],
      ],
    );
  }
}

class _BuildDayResultSectionTitle extends StatelessWidget {
  const _BuildDayResultSectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GlobalTextStyles.interTextStyle(
        fontSize: 18.sp,
        height: 28 / 18,
        fontWeight: FontWeight.w600,
        color: context.appColors.primaryText,
      ),
    );
  }
}

class _BuildDayInlineError extends StatelessWidget {
  const _BuildDayInlineError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.colors.errorContainer,
        borderRadius: AppBorders.md,
      ),
      child: Row(
        children: [
          Icon(
            IconsaxPlusLinear.danger,
            size: 18.sp,
            color: context.colors.onErrorContainer,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                color: context.colors.onErrorContainer,
              ),
            ),
          ),
          TextButton(
            onPressed: onRetry,
            child: Text(LangKey.parentToday.tryAgain),
          ),
        ],
      ),
    );
  }
}

class BuildDayRecipeLibraryCard extends StatelessWidget {
  const BuildDayRecipeLibraryCard({
    super.key,
    required this.item,
    required this.onAddToSchedule,
  });

  final BuildDayLibrarySearchResultItem item;
  final VoidCallback onAddToSchedule;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(color: AppColors.brandTealBorder),
        boxShadow: const [
          BoxShadow(
            color: AppColors.recipeCardShadow,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: _BuildDayBadge(
                  label: item.category.toUpperCase(),
                  backgroundColor: AppColors.mealTypeBadgeBg,
                  foregroundColor: context.colors.primary,
                ),
              ),
              SizedBox(width: 8.w),
              _BuildDayReadyBadge(isReady: item.isReady),
            ],
          ),
          SizedBox(height: 16.h),
          _BuildDayResultImage(
            imageUrl: item.imageUrl,
            imageAsset: item.imageAsset,
            height: 219.h,
            borderRadius: AppBorders.lg,
          ),
          SizedBox(height: 8.h),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            LangKey.parentToday.ageSuitability
                .replaceFirst('{}', item.subtitle),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              color: context.appColors.mutedText,
            ),
          ),
          if (item.tags.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: item.tags.take(3).map((tag) {
                  return _BuildDayBadge(
                    label: tag.toUpperCase(),
                    backgroundColor: AppColors.bottomNavSelectedBackground,
                    foregroundColor: context.appColors.mutedText,
                  );
                }).toList(growable: false),
              ),
            ),
          ] else
            SizedBox(height: 20.h),
          _BuildDayOutlineActionButton(
            label: LangKey.parentToday.viewRecipe,
            onPressed: _showDetailsPlaceholder,
          ),
          SizedBox(height: 8.h),
          _BuildDayFilledActionButton(
            label: LangKey.parentToday.addToSchedule,
            onPressed: onAddToSchedule,
            iconSize: 16.667.sp,
            fontSize: 18.sp,
            lineHeight: 28 / 18,
            height: 62.h,
            borderRadius: AppBorders.lg,
          ),
        ],
      ),
    );
  }
}

class BuildDayActivityLibraryCard extends StatelessWidget {
  const BuildDayActivityLibraryCard({
    super.key,
    required this.item,
    required this.onAddToSchedule,
  });

  final BuildDayLibrarySearchResultItem item;
  final VoidCallback onAddToSchedule;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorders.lg,
      child: SizedBox(
        width: double.infinity,
        height: 312.h,
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BuildDayResultImage(
              imageUrl: item.imageUrl,
              imageAsset: item.imageAsset,
              height: 312.h,
              borderRadius: BorderRadius.zero,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blackColor.withValues(alpha: 0),
                    AppColors.blackColor.withValues(alpha: 0.8),
                  ],
                  stops: const [0.0, 0.72],
                ),
              ),
            ),
            PositionedDirectional(
              start: 16.w,
              top: 18.h,
              child: _BuildDayOverlayBadge(
                icon: IconsaxPlusLinear.calendar_1,
                label: item.subtitle,
              ),
            ),
            PositionedDirectional(
              start: 16.w,
              end: 16.w,
              bottom: 21.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 20.sp,
                      height: 30 / 20,
                      fontWeight: FontWeight.w600,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  if (item.description != null)
                    Text(
                      item.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  SizedBox(height: 15.h),
                  ClipRRect(
                    borderRadius: AppBorders.lg,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        padding: EdgeInsets.all(9.w),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor.withValues(alpha: 0.1),
                          borderRadius: AppBorders.lg,
                          border: Border.all(
                            color: AppColors.whiteColor.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: _BuildDayFilledActionButton(
                                label: LangKey.parentToday.addToSchedule,
                                onPressed: onAddToSchedule,
                                iconSize: 12.sp,
                                fontSize: 12.sp,
                                lineHeight: 18 / 12,
                                height: 42.h,
                                borderRadius: AppBorders.md,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(width: 8.w),
                            _BuildDayGlassActionButton(
                              label: LangKey.parentToday.viewActivity,
                              onPressed: _showDetailsPlaceholder,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildDayResultImage extends StatelessWidget {
  const _BuildDayResultImage({
    required this.imageUrl,
    required this.imageAsset,
    required this.height,
    required this.borderRadius,
  });

  final String? imageUrl;
  final String? imageAsset;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    final source = imageUrl ?? imageAsset;
    if (source == null || source.isEmpty) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: AppColors.bottomNavSelectedBackground,
          borderRadius: borderRadius,
        ),
        child: Icon(
          IconsaxPlusLinear.gallery,
          size: 32.sp,
          color: context.colors.primary,
        ),
      );
    }
    return CommonImage(
      imageUrl: source,
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      borderRadius: borderRadius,
    );
  }
}

class _BuildDayBadge extends StatelessWidget {
  const _BuildDayBadge({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          height: 18 / 12,
          fontWeight: FontWeight.w500,
          color: foregroundColor,
        ),
      ),
    );
  }
}

class _BuildDayReadyBadge extends StatelessWidget {
  const _BuildDayReadyBadge({required this.isReady});

  final bool isReady;

  @override
  Widget build(BuildContext context) {
    if (!isReady) return const SizedBox.shrink();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: const BoxDecoration(
        color: AppColors.rewardSuccessBadgeText,
        borderRadius: AppBorders.full,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            IconsaxPlusLinear.tick_circle,
            size: 12.sp,
            color: AppColors.whiteColor,
          ),
          SizedBox(width: 4.w),
          Text(
            LangKey.parentToday.ready,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildDayOverlayBadge extends StatelessWidget {
  const _BuildDayOverlayBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 220.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.blackColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: AppColors.whiteColor),
          SizedBox(width: 6.w),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 12.sp,
                height: 18 / 12,
                fontWeight: FontWeight.w700,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildDayFilledActionButton extends StatelessWidget {
  const _BuildDayFilledActionButton({
    required this.label,
    required this.onPressed,
    required this.iconSize,
    required this.fontSize,
    required this.lineHeight,
    required this.height,
    required this.borderRadius,
    this.fontWeight = FontWeight.w500,
  });

  final String label;
  final VoidCallback onPressed;
  final double iconSize;
  final double fontSize;
  final double lineHeight;
  final double height;
  final BorderRadius borderRadius;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: context.colors.primary,
          foregroundColor: AppColors.neutral50,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          side: BorderSide(color: context.colors.primary),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(IconsaxPlusLinear.add_circle, size: iconSize),
              SizedBox(width: 8.w),
              Text(
                label,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: fontSize,
                  height: lineHeight,
                  fontWeight: fontWeight,
                  color: AppColors.neutral50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildDayOutlineActionButton extends StatelessWidget {
  const _BuildDayOutlineActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: context.colors.primary,
          side: const BorderSide(color: AppColors.brandTealBorder),
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.lg),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              height: 28 / 18,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildDayGlassActionButton extends StatelessWidget {
  const _BuildDayGlassActionButton({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.whiteColor,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          shape: const RoundedRectangleBorder(borderRadius: AppBorders.md),
          backgroundColor: AppColors.whiteColor.withValues(alpha: 0.1),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            maxLines: 1,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w600,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}

void _showDetailsPlaceholder() {
  showGlobalToast(message: LangKey.parentToday.detailsComingSoon);
}

String _categoryLabel(ScheduleCategory category) {
  return switch (category) {
    ScheduleCategory.RECIPE => LangKey.parentToday.buildDayCategoryRecipe,
    ScheduleCategory.ACTIVITY => LangKey.parentToday.buildDayCategoryActivity,
    ScheduleCategory.HOME_STUDY =>
      LangKey.parentToday.buildDayCategoryHomeStudy,
    ScheduleCategory.NAP => LangKey.parentToday.buildDayCategoryNap,
    ScheduleCategory.BEDTIME => LangKey.parentToday.buildDayCategoryBedtime,
    ScheduleCategory.OTHER => LangKey.parentToday.buildDayCategoryOther,
  };
}
