import 'package:alurei/src/features/roles/parent/today/presentation/widgets/child_profile/todays_child_delete_button.dart';
import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../controllers/todays_child_profile_controller.dart';
import '../widgets/ai_setup/ai_setup_form_widgets.dart';
import '../widgets/ai_setup/ai_setup_section_widgets.dart';
import '../widgets/child_profile/todays_child_profile_widgets.dart';

class TodaysChildProfileScreen extends HookWidget {
  const TodaysChildProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TodaysChildProfileController>();
    final nameController = useTextEditingController();
    final activityNameController = useTextEditingController();
    final safetyController = useTextEditingController();
    final favoriteFoodsController = useTextEditingController();
    final favoriteActivitiesController = useTextEditingController();
    final currentChallengesController = useTextEditingController();
    final notesController = useTextEditingController();

    useEffect(() {
      void syncTextFields(ParentChildProfileData? value) {
        if (value == null) return;
        nameController.text = value.name;
        safetyController.text = value.safetyDetails;
        favoriteFoodsController.text = value.favoriteFoods;
        favoriteActivitiesController.text = value.favoriteActivities;
        currentChallengesController.text = value.currentChallenges;
        notesController.text = value.notes;
      }

      syncTextFields(controller.profile.value);
      final worker = ever<ParentChildProfileData?>(
        controller.profile,
        syncTextFields,
      );
      return worker.dispose;
    }, [controller]);

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
      final profile = controller.profile.value;
      return Scaffold(
        backgroundColor: context.appColors.primaryBackground,
        appBar: AppTopBar.withSubmit(
          title: profile == null
              ? LangKey.parentToday.childProfile
              : LangKey.parentToday.childProfileTitle
                  .replaceFirst('{}', controller.childName.value),
          submitLabel: LangKey.parentToday.save,
          showSubmitButton:
              profile != null && controller.hasUnsavedProfileChanges.value,
          submitEnabled: profile != null &&
              controller.hasUnsavedProfileChanges.value &&
              !controller.isSaving.value,
          onSubmit: controller.saveProfile,
          onPressed: Get.back<void>,
        ),
        body: _buildBody(
          context,
          controller,
          profile,
          nameController,
          activityNameController,
          safetyController,
          favoriteFoodsController,
          favoriteActivitiesController,
          currentChallengesController,
          notesController,
          pickTime,
        ),
      );
    });
  }

  Widget _buildBody(
    BuildContext context,
    TodaysChildProfileController controller,
    ParentChildProfileData? profile,
    TextEditingController nameController,
    TextEditingController activityNameController,
    TextEditingController safetyController,
    TextEditingController favoriteFoodsController,
    TextEditingController favoriteActivitiesController,
    TextEditingController currentChallengesController,
    TextEditingController notesController,
    Future<void> Function(TimeOfDay, ValueChanged<TimeOfDay>) pickTime,
  ) {
    if (controller.isLoading.value) {
      return SkeletonWrapper(
        isLoading: true,
        child: _buildProfileContent(
          context,
          controller,
          _loadingProfile,
          nameController,
          activityNameController,
          safetyController,
          favoriteFoodsController,
          favoriteActivitiesController,
          currentChallengesController,
          notesController,
          pickTime,
        ),
      );
    }
    if (profile == null) {
      return AppErrorWidget(
        message: controller.errorMessage.value ??
            LangKey.parentToday.unableToLoadChildProfile,
        onRetry: controller.loadProfile,
      );
    }

    return _buildProfileContent(
      context,
      controller,
      profile,
      nameController,
      activityNameController,
      safetyController,
      favoriteFoodsController,
      favoriteActivitiesController,
      currentChallengesController,
      notesController,
      pickTime,
    );
  }

  Widget _buildProfileContent(
    BuildContext context,
    TodaysChildProfileController controller,
    ParentChildProfileData profile,
    TextEditingController nameController,
    TextEditingController activityNameController,
    TextEditingController safetyController,
    TextEditingController favoriteFoodsController,
    TextEditingController favoriteActivitiesController,
    TextEditingController currentChallengesController,
    TextEditingController notesController,
    Future<void> Function(TimeOfDay, ValueChanged<TimeOfDay>) pickTime,
  ) {
    return RefreshIndicator(
      onRefresh: controller.loadProfile,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: Column(
                children: [
                  TodaysChildAvatar(
                    imageAsset: profile.avatarAsset,
                    imageUrl: controller.avatarUrl.value,
                    imageFile: controller.selectedProfileImage.value,
                    onEdit: () => _showProfileImageSourceSheet(
                      context,
                      controller,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TodaysChildAssignNannyButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: AppColors.transparentColor,
                        builder: (sheetContext) => Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(sheetContext).viewInsets.bottom,
                          ),
                          child: AssignNannyBottomSheet(
                            onInviteSent: (data) {
                              // Since this is the child profile screen, we could either implement the full flow
                              // or just show the dialog for now.
                              showDialog<void>(
                                context: context,
                                builder: (_) => const InvitationSentDialog(),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  TodaysChildNannyPanel(
                    nannies: profile.assignedNannies,
                    onNannyTap: (nanny) => Get.toNamed<void>(
                      AppRoutes.nannyProfile,
                      arguments: {'nanny_id': nanny.id},
                    ),
                    onManage: () => Navigator.of(context).pushNamed(
                      AppRoutes.parentManageCaregivers,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  TodaysChildDetailsCard(
                    editing: controller.isEditingProfileDetails.value,
                    childName: controller.childName.value,
                    nameController: nameController,
                    gender: controller.selectedGender.value,
                    birthDate: controller.selectedBirthDate.value,
                    onEditPressed: controller.toggleProfileDetailsEdit,
                    onNameChanged: controller.updateName,
                    onGenderSelected: (value) => controller.gender = value,
                    onBirthDateTap: () async {
                      final value = await showAppDatePicker(
                        context: context,
                        initialDate: controller.selectedBirthDate.value,
                      );
                      if (value != null) controller.birthDate = value;
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: AppFormOutlinedPanel(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AiSetupSectionTitle(
                      icon: IconsaxPlusLinear.teacher,
                      title: LangKey.parentToday.schoolSchedule,
                    ),
                    SizedBox(height: 16.h),
                    AiSetupSmallLabel(LangKey.parentToday.daysOfWeek),
                    SizedBox(height: 12.h),
                    _DaySelector(
                      selectedDays: controller.selectedSchoolDays.toSet(),
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
                            (value) => controller.schoolStart = value,
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
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: TodaysChildRecurringActivitySection(
                activityName: controller.activityName.value,
                nameController: activityNameController,
                selectedDays: controller.selectedActivityDays.toSet(),
                startTime: controller.activityStartTime.value,
                endTime: controller.activityEndTime.value,
                recurringActivities: controller.recurringActivities,
                isSettingActivity: controller.isAddingRecurringActivity.value,
                isEditingActivity: controller.isEditingRecurringActivity,
                deletingActivityIds:
                    controller.deletingRecurringActivityIds.toSet(),
                onActivityNameChanged: (value) =>
                    controller.activityName.value = value,
                onToggleDay: controller.toggleActivityDay,
                onPickStartTime: () => pickTime(
                  controller.activityStartTime.value,
                  (value) => controller.activityStart = value,
                ),
                onPickEndTime: () => pickTime(
                  controller.activityEndTime.value,
                  (value) => controller.activityEnd = value,
                ),
                onSetActivity: () async {
                  final didAdd = await controller.addRecurringActivity();
                  if (didAdd) activityNameController.clear();
                },
                onCancelEdit: () {
                  controller.cancelRecurringActivityEdit();
                  activityNameController.clear();
                },
                onSelectActivity: (activity) {
                  controller.selectRecurringActivity(activity);
                  activityNameController.text = activity.name;
                },
                onDeleteActivity: controller.removeRecurringActivity,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LangKey.parentToday.typicalDailyCycle,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      height: 28 / 18,
                      fontWeight: FontWeight.w600,
                      color: context.appColors.primaryText,
                    ),
                  ),
                  SizedBox(height: 12.h),
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
                  for (final nap in controller.napWindows) ...[
                    AiSetupRoutineCard(
                      icon: IconsaxPlusLinear.moon,
                      title: nap.title,
                      subtitle: nap.subtitle,
                      start: nap.startTime,
                      end: nap.endTime,
                      onStartTap: () => pickTime(
                        nap.startTime,
                        (value) => controller.updateNapStartTime(nap.id, value),
                      ),
                      onEndTap: () => pickTime(
                        nap.endTime,
                        (value) => controller.updateNapEndTime(nap.id, value),
                      ),
                      onDelete: () => controller.removeNapWindow(nap.id),
                    ),
                    SizedBox(height: 12.h),
                  ],
                  TodaysChildAddNapCard(
                    onPressed: controller.addNapWindow,
                  ),
                  SizedBox(height: 12.h),
                  AiSetupRoutineCard(
                    icon: IconsaxPlusLinear.moon,
                    title: LangKey.parentToday.bedtime,
                    subtitle: LangKey.parentToday.endsActiveAlerts,
                    start: controller.bedtime.value,
                    onStartTap: () => pickTime(
                      controller.bedtime.value,
                      (value) => controller.bedtimeValue = value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: TodaysChildSafetySection(
                selectedOption: controller.selectedSafetyOption.value,
                onOptionSelected: (value) => controller.safetyOption = value,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: Column(
                children: [
                  _NotesField(
                    label: LangKey.parentToday.favoriteFoodsLabel,
                    description: LangKey.parentToday.favoriteFoodsDescription,
                    controller: favoriteFoodsController,
                    hint: LangKey.parentToday.favoriteFoodsHint,
                    onChanged: (value) => controller.favoriteFoodNotes = value,
                  ),
                  SizedBox(height: 16.h),
                  _NotesField(
                    label: LangKey.parentToday.favoriteActivitiesLabel,
                    description:
                        LangKey.parentToday.favoriteActivitiesDescription,
                    controller: favoriteActivitiesController,
                    hint: LangKey.parentToday.favoriteActivitiesHint,
                    onChanged: (value) =>
                        controller.favoriteActivityNotes = value,
                  ),
                  SizedBox(height: 16.h),
                  _NotesField(
                    label: LangKey.parentToday.currentChallengesLabel,
                    description:
                        LangKey.parentToday.currentChallengesDescription,
                    controller: currentChallengesController,
                    hint: LangKey.parentToday.currentChallengesHint,
                    onChanged: (value) =>
                        controller.currentChallengeNotes = value,
                  ),
                  SizedBox(height: 16.h),
                  _NotesField(
                    label: LangKey.parentToday.anythingElseQuestion,
                    controller: notesController,
                    hint: LangKey.parentToday.anythingElseHint,
                    onChanged: (value) => controller.profileNotes = value,
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16.w),
              color: context.appColors.elevatedBackground,
              child: TodaysChildQuickActionsCard(
                onBuildNewDay: controller.buildNewDay,
                onEditDay: controller.editDay,
                onRegenerate: controller.regenerateTimeline,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 16.h)),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                () => TodaysChildDeleteButton(
                  isLoading: controller.isDeleting.value,
                  onPressed: () => _confirmDelete(controller),
                ),
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 24.h)),
        ],
      ),
    );
  }

  ParentChildProfileData get _loadingProfile => ParentChildProfileData(
        id: 'loading',
        name: 'Loading child profile',
        avatarAsset: AppAssets.parentTodayChildProfileAvatar,
        gender: 'Other',
        birthDate: DateTime.now(),
        weight: '12 kg',
        schoolDays: const ['Mon', 'Tue', 'Wed'],
        schoolStartTime: '08:30',
        schoolEndTime: '14:30',
        recurringActivities: const <ParentChildProfileRecurringActivity>[],
        wakeTime: '07:00',
        napWindows: const <ParentChildProfileNapWindow>[],
        bedtime: '19:00',
        safetyOption: 'None',
        safetyDetails: '',
        favoriteFoods: 'Favorite foods loading',
        favoriteActivities: 'Favorite activities loading',
        currentChallenges: 'Current challenges loading',
        notes: 'Notes loading',
        assignedNannies: const <ParentChildProfileNanny>[],
      );

  Future<void> _confirmDelete(
    TodaysChildProfileController controller,
  ) async {
    final confirmed = await showTodaysChildDeleteDialog(
      childName: controller.childName.value,
    );
    if (confirmed ?? false) await controller.deleteProfile();
  }

  Future<void> _showProfileImageSourceSheet(
    BuildContext context,
    TodaysChildProfileController controller,
  ) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.transparentColor,
      builder: (sheetContext) {
        return Container(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: sheetContext.appColors.elevatedBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: sheetContext.appColors.bottomNavBorder,
                    borderRadius: AppBorders.full,
                  ),
                ),
              ),
              20.verticalSpace,
              Text(
                'Update profile picture',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 18.sp,
                  height: 28 / 18,
                  fontWeight: FontWeight.w700,
                  color: sheetContext.appColors.primaryText,
                ),
              ),
              16.verticalSpace,
              _ImageSourceTile(
                icon: IconsaxPlusLinear.camera,
                title: 'Take photo',
                onTap: () async {
                  Navigator.of(sheetContext).pop();
                  await controller.pickProfileImage(ImageSource.camera);
                },
              ),
              10.verticalSpace,
              _ImageSourceTile(
                icon: IconsaxPlusLinear.gallery,
                title: 'Choose from gallery',
                onTap: () async {
                  Navigator.of(sheetContext).pop();
                  await controller.pickProfileImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ImageSourceTile extends StatelessWidget {
  const _ImageSourceTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.lg,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: context.appColors.primaryBackground,
          borderRadius: AppBorders.lg,
          border: Border.all(color: context.appColors.bottomNavBorder),
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
              child: Icon(icon, color: context.colors.primary, size: 20.sp),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                title,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 15.sp,
                  height: 22 / 15,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.primaryText,
                ),
              ),
            ),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              size: 18.sp,
              color: context.appColors.secondaryText,
            ),
          ],
        ),
      ),
    );
  }
}

class _NotesField extends StatelessWidget {
  const _NotesField({
    required this.label,
    required this.controller,
    required this.hint,
    required this.onChanged,
    this.description,
  });

  final String label;
  final String? description;
  final TextEditingController controller;
  final String hint;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppFormField(
      label: label,
      description: description,
      child: AppFormTextInput(
        controller: controller,
        hint: hint,
        minLines: 4,
        maxLines: 6,
        onChanged: onChanged,
      ),
    );
  }
}

class _DaySelector extends StatelessWidget {
  const _DaySelector({
    required this.selectedDays,
    required this.onToggle,
  });

  final Set<String> selectedDays;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TodaysChildProfileController.weekDays.map((day) {
        final isSelected = selectedDays.contains(day);
        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              end: day == TodaysChildProfileController.weekDays.last ? 0 : 6.w,
            ),
            child: InkWell(
              onTap: () => onToggle(day),
              borderRadius: AppBorders.md,
              child: AnimatedContainer(
                duration: AppDurations.fast,
                height: 42.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected
                      ? context.colors.primary
                      : context.appColors.elevatedBackground,
                  border: Border.all(color: AppColors.neutral100),
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
    );
  }
}
