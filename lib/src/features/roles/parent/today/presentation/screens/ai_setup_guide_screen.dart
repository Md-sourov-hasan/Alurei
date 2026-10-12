import 'dart:ui';

import 'package:alurei/src/imports/imports.dart';

import '../controllers/ai_setup_guide_controller.dart';
import '../widgets/ai_setup/ai_setup_guide_widgets.dart';

class AiSetupGuideScreen extends HookWidget {
  const AiSetupGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AiSetupGuideController>();
    final childNameController = useTextEditingController();
    final notesController = useTextEditingController();
    final safetyDetailsController = useTextEditingController();
    final favoriteFoodsController = useTextEditingController();
    final favoriteActivitiesController = useTextEditingController();
    final currentChallengesController = useTextEditingController();

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

    return Obx(() {
      if (controller.isCompleted.value) {
        return AiGeneratedDayCompletedView(
          childName: controller.childName.value,
          onViewToday: controller.viewTodayCareFlow,
        );
      }

      return Scaffold(
        backgroundColor: context.appColors.primaryBackground,
        body: Stack(
          children: [
            SafeArea(
              bottom: false,
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 96.h, 16.w, 16.h),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LangKey.parentToday.aiSetupTitle,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 30.sp,
                              height: 38 / 30,
                              fontWeight: FontWeight.w700,
                              color: context.colors.primary,
                            ),
                          ),
                          SizedBox(height: 7.h),
                          Text(
                            LangKey.parentToday.aiSetupDescription,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w400,
                              color: context.appColors.mutedText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AiSetupCard(
                      child: Column(
                        children: [
                          AiSetupField(
                            label: LangKey.parentToday.childNameLabel,
                            child: AiSetupTextInput(
                              controller: childNameController,
                              hint: LangKey.parentToday.childNameHint,
                              onChanged: controller.updateName,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.genderLabel,
                            child: AiSetupSelectField(
                              value: controller.selectedGender.value,
                              hint: LangKey.parentToday.genderHint,
                              onTap: () async {
                                final value = await showAiSetupOptionMenu(
                                  context: context,
                                  options: controller.genders,
                                  selected: controller.selectedGender.value,
                                );
                                if (value != null)
                                  controller.selectGender(value);
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.weightLabel,
                            child: AiSetupSelectField(
                              value: controller.selectedWeight.value,
                              hint: LangKey.parentToday.weightHint,
                              onTap: () async {
                                final value = await showAiSetupOptionMenu(
                                  context: context,
                                  options: controller.weights,
                                  selected: controller.selectedWeight.value,
                                );
                                if (value != null) controller.weight = value;
                              },
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.birthDateLabel,
                            child: AiSetupSelectField(
                              value: _formatDate(
                                  controller.selectedBirthDate.value),
                              hint: LangKey.parentToday.birthDateHint,
                              icon: IconsaxPlusLinear.calendar,
                              onTap: () async {
                                final value = await showAppDatePicker(
                                  context: context,
                                  initialDate:
                                      controller.selectedBirthDate.value,
                                );
                                if (value != null) {
                                  controller.selectBirthDate(value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (controller.showSchoolSchedule)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      sliver: SliverToBoxAdapter(
                        child: AiSetupCard(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 24.h,
                          ),
                          child: AiSetupOutlinedPanel(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AiSetupSectionTitle(
                                  icon: IconsaxPlusLinear.teacher,
                                  title: LangKey.parentToday.schoolSchedule,
                                ),
                                SizedBox(height: 16.h),
                                AiSetupSmallLabel(
                                    LangKey.parentToday.daysOfWeek),
                                SizedBox(height: 12.h),
                                AiSetupDaySelector(
                                  selectedDays:
                                      controller.selectedSchoolDays.toSet(),
                                  onToggle: controller.toggleSchoolDay,
                                ),
                                SizedBox(height: 16.h),
                                Row(
                                  children: [
                                    AiSetupTimeBox(
                                      label: LangKey.parentToday.startTime,
                                      time: controller.schoolStartTime.value,
                                      onTap: () => pickTime(
                                        controller.schoolStartTime.value,
                                        (value) =>
                                            controller.schoolStart = value,
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    AiSetupTimeBox(
                                      label: LangKey.parentToday.endTime,
                                      time: controller.schoolEndTime.value,
                                      onTap: () => pickTime(
                                        controller.schoolEndTime.value,
                                        (value) => controller.schoolEnd = value,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: AiSetupCard(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 24.h,
                      ),
                      child: AiSetupOutlinedPanel(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LangKey.parentToday.weeklyRecurringActivity,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 18.sp,
                                height: 28 / 18,
                                fontWeight: FontWeight.w600,
                                color: context.colors.primary,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            AiSetupField(
                              label: LangKey.parentToday.activityName,
                              child: AiSetupSelectField(
                                value: controller.activityName.value,
                                hint: LangKey.parentToday.activityNameHint,
                                onTap: () async {
                                  final value = await showAiSetupCategorySheet(
                                    context: context,
                                    groups: controller.activityGroups,
                                  );
                                  if (value != null) {
                                    controller.activity = value;
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            AiSetupSmallLabel(LangKey.parentToday.daysOfWeek),
                            SizedBox(height: 12.h),
                            AiSetupDaySelector(
                              selectedDays: controller.activityDays.toSet(),
                              onToggle: controller.toggleActivityDay,
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              children: [
                                AiSetupTimeBox(
                                  label: LangKey.parentToday.startTime,
                                  time: controller.activityStartTime.value,
                                  onTap: () => pickTime(
                                    controller.activityStartTime.value,
                                    (value) => controller.activityStart = value,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                AiSetupTimeBox(
                                  label: LangKey.parentToday.endTime,
                                  time: controller.activityEndTime.value,
                                  onTap: () => pickTime(
                                    controller.activityEndTime.value,
                                    (value) => controller.activityEnd = value,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            AppButton(
                              label: LangKey.parentToday.setActivity,
                              onPressed: controller.setRecurringActivity,
                              height: ButtonSize.medium,
                              isFullWidth: true,
                            ),
                            SizedBox(height: 16.h),
                            AiSetupActivityPreviewList(
                              activities:
                                  controller.recurringActivities.toList(),
                              onDelete: controller.removeRecurringActivity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    sliver: SliverToBoxAdapter(
                      child: AiSetupCard(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 24.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LangKey.parentToday.typicalDailyCycle,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 16.sp,
                                height: 24 / 16,
                                fontWeight: FontWeight.w700,
                                color: context.appColors.primaryText,
                              ),
                            ),
                            SizedBox(height: 16.h),
                            AiSetupRoutineCard(
                              icon: IconsaxPlusLinear.sun_1,
                              title: LangKey.parentToday.wakeUpTime,
                              subtitle: LangKey.parentToday.startWithDailyLog,
                              start: controller.wakeTime.value,
                              onStartTap: () => pickTime(
                                controller.wakeTime.value,
                                (value) => controller.wake = value,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            AiSetupRoutineCard(
                              icon: IconsaxPlusLinear.moon,
                              title: LangKey.parentToday.napWindow,
                              subtitle: LangKey.parentToday.afternoonRestPeriod,
                              start: controller.napStartTime.value,
                              end: controller.napEndTime.value,
                              tint: AppColors.brandTealLight,
                              onStartTap: () => pickTime(
                                controller.napStartTime.value,
                                (value) => controller.napStart = value,
                              ),
                              onEndTap: () => pickTime(
                                controller.napEndTime.value,
                                (value) => controller.napEnd = value,
                              ),
                            ),
                            ...controller.additionalNaps.toList().map(
                                  (nap) => Padding(
                                    padding: EdgeInsets.only(top: 12.h),
                                    child: AiSetupRoutineCard(
                                      icon: IconsaxPlusLinear.moon,
                                      title: nap.title,
                                      subtitle: nap.subtitle,
                                      start: nap.startTime,
                                      end: nap.endTime,
                                      tint: AppColors.brandTealLight,
                                      onDelete: () =>
                                          controller.removeNapWindow(nap.id),
                                      onStartTap: () => pickTime(
                                        nap.startTime,
                                        (value) => controller
                                            .updateNapStartTime(nap.id, value),
                                      ),
                                      onEndTap: () => pickTime(
                                        nap.endTime,
                                        (value) => controller.updateNapEndTime(
                                            nap.id, value),
                                      ),
                                    ),
                                  ),
                                ),
                            SizedBox(height: 12.h),
                            InkWell(
                              onTap: controller.addNapWindow,
                              borderRadius: AppBorders.lg,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.brandTealBorder,
                                  ),
                                  borderRadius: AppBorders.lg,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        LangKey.parentToday.moreThanOneNap,
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 14.sp,
                                          height: 20 / 14,
                                          fontWeight: FontWeight.w400,
                                          color: context.colors.primary,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      IconsaxPlusLinear.add,
                                      color: context.colors.primary,
                                      size: 28.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            AiSetupRoutineCard(
                              icon: IconsaxPlusLinear.moon,
                              title: LangKey.parentToday.bedtime,
                              subtitle: LangKey.parentToday.endsActiveAlerts,
                              start: controller.bedtime.value,
                              tint: const Color(0xFFFEF2F2),
                              iconColor: const Color(0xFFF87171),
                              onStartTap: () => pickTime(
                                controller.bedtime.value,
                                (value) => controller.bedtimeValue = value,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AiSetupCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AiSetupOutlinedPanel(
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
                                SizedBox(height: 12.h),
                                ...AiSetupGuideController.safetyOptions.map(
                                  (option) => Padding(
                                    padding: EdgeInsets.only(bottom: 8.h),
                                    child: AiSetupSafetyOption(
                                      label: option,
                                      selected: controller
                                              .selectedSafetyOption.value ==
                                          option,
                                      onTap: () =>
                                          controller.safetyOption = option,
                                    ),
                                  ),
                                ),
                                if (controller.selectedSafetyOption.value !=
                                    'None') ...[
                                  SizedBox(height: 12.h),
                                  AiSetupTextInput(
                                    controller: safetyDetailsController,
                                    hint: controller
                                                .selectedSafetyOption.value ==
                                            'Food allergies'
                                        ? 'Specify food allergies (e.g., peanuts, dairy)...'
                                        : 'Specify mobility considerations...',
                                    minLines: 2,
                                    maxLines: 3,
                                    onChanged: (value) =>
                                        controller.safetyDetails.value = value,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          AiSetupField(
                            label: LangKey.parentToday.favoriteFoodsLabel,
                            description:
                                LangKey.parentToday.favoriteFoodsDescription,
                            child: AiSetupTextInput(
                              controller: favoriteFoodsController,
                              hint: LangKey.parentToday.favoriteFoodsHint,
                              minLines: 4,
                              maxLines: 5,
                              onChanged: (value) =>
                                  controller.favoriteFoodNotes = value,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.favoriteActivitiesLabel,
                            description: LangKey
                                .parentToday.favoriteActivitiesDescription,
                            child: AiSetupTextInput(
                              controller: favoriteActivitiesController,
                              hint: LangKey.parentToday.favoriteActivitiesHint,
                              minLines: 4,
                              maxLines: 5,
                              onChanged: (value) =>
                                  controller.favoriteActivityNotes = value,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.currentChallengesLabel,
                            description: LangKey
                                .parentToday.currentChallengesDescription,
                            child: AiSetupTextInput(
                              controller: currentChallengesController,
                              hint: LangKey.parentToday.currentChallengesHint,
                              minLines: 4,
                              maxLines: 5,
                              onChanged: (value) =>
                                  controller.currentChallengeNotes = value,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          AiSetupField(
                            label: LangKey.parentToday.anythingElseQuestion,
                            child: AiSetupTextInput(
                              controller: notesController,
                              hint: LangKey.parentToday.anythingElseHint,
                              minLines: 4,
                              maxLines: 5,
                              onChanged: (value) =>
                                  controller.setupNotes = value,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          if (controller.validationMessage.value != null) ...[
                            Text(
                              controller.validationMessage.value!,
                              textAlign: TextAlign.center,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 13.sp,
                                height: 18 / 13,
                                fontWeight: FontWeight.w600,
                                color: context.colors.error,
                              ),
                            ),
                            SizedBox(height: 12.h),
                          ],
                          AppButton(
                            label: LangKey.parentToday.continueButton,
                            onPressed: controller.continueSetup,
                            height: ButtonSize.large,
                            isFullWidth: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      height: 72.h,
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      decoration: BoxDecoration(
                        color: context.appColors.elevatedBackground
                            .withValues(alpha: 0.82),
                        border: Border(
                          bottom: BorderSide(
                            color: context.appColors.bottomNavBorder,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.centerStart,
                      child: IconButton(
                        onPressed: Get.back<void>,
                        icon: Icon(
                          IconsaxPlusLinear.arrow_left,
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            if (controller.isGenerating.value) const AiGeneratingOverlay(),
          ],
        ),
      );
    });
  }

  String? _formatDate(DateTime? date) {
    if (date == null) return null;
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}
