part of 'todays_child_profile_widgets.dart';

class TodaysChildRecurringActivitySection extends StatelessWidget {
  const TodaysChildRecurringActivitySection({
    super.key,
    required this.activityName,
    required this.nameController,
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
    required this.recurringActivities,
    required this.isSettingActivity,
    required this.isEditingActivity,
    required this.deletingActivityIds,
    required this.onActivityNameChanged,
    required this.onToggleDay,
    required this.onPickStartTime,
    required this.onPickEndTime,
    required this.onSetActivity,
    required this.onCancelEdit,
    required this.onSelectActivity,
    required this.onDeleteActivity,
  });

  final String activityName;
  final TextEditingController nameController;
  final Set<String> selectedDays;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final List<ParentChildProfileRecurringActivityUi> recurringActivities;
  final bool isSettingActivity;
  final bool isEditingActivity;
  final Set<String> deletingActivityIds;
  final ValueChanged<String> onActivityNameChanged;
  final ValueChanged<String> onToggleDay;
  final VoidCallback onPickStartTime;
  final VoidCallback onPickEndTime;
  final VoidCallback onSetActivity;
  final VoidCallback onCancelEdit;
  final ValueChanged<ParentChildProfileRecurringActivityUi> onSelectActivity;
  final ValueChanged<String> onDeleteActivity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(17.w),
          decoration: BoxDecoration(
            color: context.appColors.elevatedBackground,
            border: Border.all(
              color: context.colors.primary.withValues(alpha: 0.3),
            ),
            borderRadius: AppBorders.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LangKey.parentToday.dailyRecurringActivity,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                LangKey.parentToday.activityName,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.primaryText,
                ),
              ),
              SizedBox(height: 8.h),
              AppFormTextInput(
                controller: nameController,
                hint: LangKey.parentToday.activityHintExample,
                onChanged: onActivityNameChanged,
              ),
              SizedBox(height: 16.h),
              Text(
                LangKey.parentToday.daysOfWeek,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.primaryText,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: TodaysChildProfileController.weekDays.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        end: day == TodaysChildProfileController.weekDays.last
                            ? 0
                            : 6.w,
                      ),
                      child: InkWell(
                        onTap: () => onToggleDay(day),
                        borderRadius: AppBorders.md,
                        child: AnimatedContainer(
                          duration: AppDurations.fast,
                          height: 42.h,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? context.colors.primary
                                : context.appColors.elevatedBackground,
                            border: Border.all(
                              color: isSelected
                                  ? context.colors.primary
                                  : AppColors.neutral100,
                            ),
                            borderRadius: AppBorders.md,
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              day,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 12.sp,
                                height: 18 / 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? context.colors.onPrimary
                                    : context.appColors.mutedText,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(growable: false),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: _TimePickerBox(
                      label: LangKey.parentToday.startTime,
                      time: startTime,
                      onTap: onPickStartTime,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _TimePickerBox(
                      label: LangKey.parentToday.endTime,
                      time: endTime,
                      onTap: onPickEndTime,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  onPressed: isSettingActivity ? null : onSetActivity,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colors.primary,
                    foregroundColor: context.colors.onPrimary,
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppBorders.lg,
                    ),
                  ),
                  child: isSettingActivity
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.colors.onPrimary,
                          ),
                        )
                      : Text(
                          isEditingActivity
                              ? 'Update Activity'
                              : LangKey.parentToday.setActivity,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            height: 24 / 16,
                            fontWeight: FontWeight.w600,
                            color: context.colors.onPrimary,
                          ),
                        ),
                ),
              ),
              if (isEditingActivity) ...[
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.infinity,
                  height: 46.h,
                  child: OutlinedButton(
                    onPressed: isSettingActivity ? null : onCancelEdit,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: context.colors.primary,
                      side: BorderSide(color: context.colors.primary),
                      shape: const RoundedRectangleBorder(
                        borderRadius: AppBorders.lg,
                      ),
                    ),
                    child: Text(
                      LangKey.parentToday.cancel,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (recurringActivities.isNotEmpty) ...[
          SizedBox(height: 16.h),
          for (final activity in recurringActivities) ...[
            InkWell(
              onTap: () => onSelectActivity(activity),
              borderRadius: AppBorders.lg,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(17.w),
                decoration: BoxDecoration(
                  color: context.appColors.elevatedBackground,
                  border: Border.all(
                    color: context.colors.primary.withValues(alpha: 0.2),
                  ),
                  borderRadius: AppBorders.lg,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: context.colors.primary.withValues(alpha: 0.10),
                        borderRadius: AppBorders.md,
                      ),
                      child: Icon(
                        IconsaxPlusLinear.teacher,
                        size: 20.sp,
                        color: context.colors.primary,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.primaryText,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${_formatTimeOfDay(activity.startTime)} - ${_formatTimeOfDay(activity.endTime)} • ${activity.days.join(', ')}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              height: 18 / 12,
                              fontWeight: FontWeight.w400,
                              color: context.appColors.primaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: deletingActivityIds.contains(activity.id)
                          ? null
                          : () => onDeleteActivity(activity.id),
                      icon: deletingActivityIds.contains(activity.id)
                          ? SizedBox(
                              width: 18.w,
                              height: 18.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(
                              IconsaxPlusLinear.trash,
                              size: 20.sp,
                              color: context.appColors.disabledText,
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ],
      ],
    );
  }
}

class _TimePickerBox extends StatelessWidget {
  const _TimePickerBox({
    required this.label,
    required this.time,
    required this.onTap,
  });

  final String label;
  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            decoration: BoxDecoration(
              color: context.appColors.elevatedBackground,
              borderRadius: AppBorders.md,
              border: Border.all(color: context.appColors.bottomNavBorder),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTimeOfDay(time),
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.colors.primary,
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
      ],
    );
  }
}

class TodaysChildAddNapCard extends StatelessWidget {
  const TodaysChildAddNapCard({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: AppBorders.lg,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          border: Border.all(
            color: context.colors.primary.withValues(alpha: 0.3),
          ),
          borderRadius: AppBorders.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LangKey.parentToday.moreThanOneNap,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w500,
                color: context.colors.primary,
              ),
            ),
            Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colors.primary.withValues(alpha: 0.10),
              ),
              child: Icon(
                IconsaxPlusLinear.add,
                size: 18.sp,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TodaysChildSafetySection extends StatelessWidget {
  const TodaysChildSafetySection({
    super.key,
    required this.selectedOption,
    required this.onOptionSelected,
  });

  final String selectedOption;
  final ValueChanged<String> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        border: Border.all(
          color: context.colors.primary.withValues(alpha: 0.3),
        ),
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentToday.safetyQuestion,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w600,
              color: context.colors.primary,
            ),
          ),
          SizedBox(height: 16.h),
          for (final option in TodaysChildProfileController.safetyOptions) ...[
            _SafetyOptionCard(
              label: option,
              isSelected: selectedOption == option,
              onTap: () => onOptionSelected(option),
            ),
            if (option != TodaysChildProfileController.safetyOptions.last)
              SizedBox(height: 12.h),
          ],
        ],
      ),
    );
  }
}

class _SafetyOptionCard extends StatelessWidget {
  const _SafetyOptionCard({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.lg,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          border: isSelected
              ? Border.all(color: context.colors.primary, width: 1.w)
              : Border.all(color: AppColors.transparentColor, width: 0),
          borderRadius: AppBorders.lg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                height: 20 / 14,
                fontWeight: FontWeight.w600,
                color: context.colors.primary,
              ),
            ),
            if (isSelected)
              Container(
                width: 22.w,
                height: 22.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.colors.primary,
                ),
                alignment: Alignment.center,
                child: Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.colors.onPrimary,
                  ),
                ),
              )
            else
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.appColors.disabledText,
                    width: 1.5.w,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SectionRow extends StatelessWidget {
  const _SectionRow({required this.child, required this.isLast});

  final Widget child;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: isLast
            ? null
            : Border(
                bottom: BorderSide(color: context.appColors.bottomNavBorder)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: child,
      ),
    );
  }
}
