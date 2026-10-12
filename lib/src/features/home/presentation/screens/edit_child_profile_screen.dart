import 'package:alurei/src/imports/imports.dart';
import '../controllers/edit_child_profile_controller.dart';

class EditChildProfileScreen extends GetView<EditChildProfileController> {
  const EditChildProfileScreen({super.key});

  Future<void> _pickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      controller.birthDateController.text =
          "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
    }
  }

  Future<void> _pickTime(
      BuildContext context, TextEditingController textController) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (time != null && context.mounted) {
      textController.text = time.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppTopBar(
        title: 'parent_home.edit_child_profile'
            .tr(args: [controller.nameController.text]),
        onPressed: () => Get.back(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: AppButton(
              label: LangKey.editProfile.save,
              height: ButtonSize.small,
              onPressed: () => controller.saveProfile(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfileImage(context),
            24.verticalSpace,
            _buildProfileDetails(context),
            16.verticalSpace,
            _buildSchoolSchedule(context),
            16.verticalSpace,
            _buildRecurringActivity(context),
            16.verticalSpace,
            _buildTypicalDailyCycle(context),
            16.verticalSpace,
            _buildSafetyHealth(context),
            16.verticalSpace,
            _buildOptionalNotes(context),
            16.verticalSpace,
            _buildQuickActions(context),
            32.verticalSpace,
            _buildDeleteButton(context),
            32.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 96.w,
        height: 96.w,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 3.w,
                ),
              ),
              child: ClipOval(
                child: CommonImage(
                  imageUrl: 'assets/images/Monica_child1.png',
                  width: 90.w,
                  height: 90.w,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.appColors.primaryBackground,
                    width: 2.w,
                  ),
                ),
                child: Icon(
                  IconsaxPlusBold.edit,
                  color: AppColors.whiteColor,
                  size: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDetails(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              LangKey.editChildProfile.profileDetails,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.inputBorder),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: AppTextField(
              label: LangKey.editProfile.name,
              controller: controller.nameController,
              suffixIcon: Icon(
                IconsaxPlusLinear.edit,
                color: AppColors.mutedTextColor,
                size: 20.sp,
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.inputBorder),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.editChildProfile.gender,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
                8.verticalSpace,
                Obx(() => Row(
                      children: [
                        _buildPill(
                            LangKey.editChildProfile.girl,
                            controller.selectedGender.value ==
                                LangKey.editChildProfile.girl,
                            () => controller.selectedGender.value =
                                LangKey.editChildProfile.girl),
                        8.horizontalSpace,
                        _buildPill(
                            LangKey.editChildProfile.boy,
                            controller.selectedGender.value ==
                                LangKey.editChildProfile.boy,
                            () => controller.selectedGender.value =
                                LangKey.editChildProfile.boy),
                        8.horizontalSpace,
                        _buildPill(
                            LangKey.editChildProfile.other,
                            controller.selectedGender.value ==
                                LangKey.editChildProfile.other,
                            () => controller.selectedGender.value =
                                LangKey.editChildProfile.other),
                      ],
                    )),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.inputBorder),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextField(
                  label: LangKey.parentToday.birthDateLabel,
                  controller: controller.birthDateController,
                  hint: 'dd/mm/yyyy',
                  readOnly: true,
                  onTap: () => _pickDate(context),
                  suffixIcon: Icon(
                    IconsaxPlusLinear.calendar_1,
                    color: AppColors.mutedTextColor,
                    size: 20.sp,
                  ),
                ),
                16.verticalSpace,
                AppTextField(
                  label: LangKey.editChildProfile.weight,
                  controller: controller.weightController,
                  hint: 'e:g 20 kg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSchoolSchedule(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(IconsaxPlusBold.teacher,
                  size: 20.sp, color: AppColors.primaryColor),
              8.horizontalSpace,
              Text(
                LangKey.editChildProfile.schoolSchedule,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          Text(
            LangKey.editChildProfile.daysOfTheWeek,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          8.verticalSpace,
          Obx(() {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
            return Row(
              children: [
                for (int i = 0; i < days.length; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: i == days.length - 1 ? 0 : 4.w),
                      child: _buildFlexiblePill(
                        days[i],
                        controller.schoolDays.contains(days[i]),
                        () => controller.toggleSchoolDay(days[i]),
                      ),
                    ),
                  ),
              ],
            );
          }),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: LangKey.editChildProfile.startTime,
                  controller: controller.schoolStartTimeController,
                  readOnly: true,
                  onTap: () =>
                      _pickTime(context, controller.schoolStartTimeController),
                  suffixIcon: Icon(IconsaxPlusLinear.clock,
                      color: AppColors.mutedTextColor, size: 20.sp),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: AppTextField(
                  label: LangKey.editChildProfile.endTime,
                  controller: controller.schoolEndTimeController,
                  readOnly: true,
                  onTap: () =>
                      _pickTime(context, controller.schoolEndTimeController),
                  suffixIcon: Icon(IconsaxPlusLinear.clock,
                      color: AppColors.mutedTextColor, size: 20.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecurringActivity(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentHome.dailyRecurringActivity,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          16.verticalSpace,
          AppTextField(
            label: LangKey.editChildProfile.nameOfTheActivity,
            controller: controller.activityNameController,
            hint: 'e:g: home education schedule',
            suffixIcon: Icon(IconsaxPlusLinear.arrow_down_1,
                color: AppColors.mutedTextColor, size: 20.sp),
          ),
          16.verticalSpace,
          Text(
            LangKey.editChildProfile.daysOfTheWeek,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          8.verticalSpace,
          Obx(() {
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            return Row(
              children: [
                for (int i = 0; i < days.length; i++)
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: i == days.length - 1 ? 0 : 4.w),
                      child: _buildFlexiblePill(
                        days[i],
                        controller.activityDays.contains(days[i]),
                        () => controller.toggleActivityDay(days[i]),
                      ),
                    ),
                  ),
              ],
            );
          }),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: AppTextField(
                  label: LangKey.editChildProfile.startTime,
                  controller: controller.activityStartTimeController,
                  readOnly: true,
                  onTap: () => _pickTime(
                      context, controller.activityStartTimeController),
                  suffixIcon: Icon(IconsaxPlusLinear.clock,
                      color: AppColors.mutedTextColor, size: 20.sp),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: AppTextField(
                  label: LangKey.editChildProfile.endTime,
                  controller: controller.activityEndTimeController,
                  readOnly: true,
                  onTap: () =>
                      _pickTime(context, controller.activityEndTimeController),
                  suffixIcon: Icon(IconsaxPlusLinear.clock,
                      color: AppColors.mutedTextColor, size: 20.sp),
                ),
              ),
            ],
          ),
          16.verticalSpace,
          AppButton(
            label: LangKey.editChildProfile.setActivity,
            isFullWidth: true,
            onPressed: () => controller.setActivity(),
          ),
          16.verticalSpace,
          Obx(() {
            if (controller.recurringActivities.isEmpty)
              return const SizedBox.shrink();
            return Column(
              children:
                  List.generate(controller.recurringActivities.length, (index) {
                final activity = controller.recurringActivities[index];
                return _buildActivityCard(
                    context, activity, () => controller.removeActivity(index));
              }),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, Map<String, dynamic> activity,
      VoidCallback onDelete) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.appColors
            .primaryBackground, // Using mainBackground for the slightly darker grey effect on light theme
        borderRadius: AppBorders.md,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: AppBorders.sm,
            ),
            child: Icon(IconsaxPlusBold.book,
                color: AppColors.primaryColor, size: 20.sp), // Default icon
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
                4.verticalSpace,
                Text(
                  '${activity['time']} • ${activity['days']}',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedTextColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(IconsaxPlusLinear.trash,
                color: context.appColors.primaryText, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildTypicalDailyCycle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.editChildProfile.typicalDailyCycle,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: context.appColors.primaryText,
          ),
        ),
        16.verticalSpace,
        _buildCycleCard(
          context,
          icon: IconsaxPlusLinear.sun,
          iconColor: AppColors.primaryColor,
          title: LangKey.editChildProfile.wakeUpTime,
          subtitle: LangKey.editChildProfile.startWithDailyLog,
          trailing: _buildTimeChip('07:00'),
        ),
        8.verticalSpace,
        _buildCycleCard(
          context,
          icon: IconsaxPlusLinear.moon,
          iconColor: AppColors.primaryColor,
          title: LangKey.editChildProfile.napWindow,
          subtitle: LangKey.editChildProfile.afternoonRestPeriod,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text(LangKey.editChildProfile.from,
                      style: GlobalTextStyles.interTextStyle(
                          fontSize: 10.sp,
                          color: AppColors.mutedTextColor,
                          fontWeight: FontWeight.w600)),
                  4.verticalSpace,
                  _buildTimeChip('13:00'),
                ],
              ),
              8.horizontalSpace,
              Column(
                children: [
                  Text(LangKey.editChildProfile.to,
                      style: GlobalTextStyles.interTextStyle(
                          fontSize: 10.sp,
                          color: AppColors.mutedTextColor,
                          fontWeight: FontWeight.w600)),
                  4.verticalSpace,
                  _buildTimeChip('15:00'),
                ],
              ),
            ],
          ),
        ),
        8.verticalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: context.appColors.elevatedBackground,
            borderRadius: AppBorders.md,
            border: Border.all(color: AppColors.inputBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LangKey.editChildProfile.moreThanOneNap,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                ),
              ),
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(IconsaxPlusLinear.add,
                    color: AppColors.primaryColor, size: 16.sp),
              ),
            ],
          ),
        ),
        8.verticalSpace,
        _buildCycleCard(
          context,
          icon: IconsaxPlusLinear.moon,
          iconColor: AppColors.errorColor,
          iconBgColor: AppColors.errorColor.withValues(alpha: 0.1),
          title: LangKey.editChildProfile.bedtime,
          subtitle: LangKey.parentHome.endsActiveAlerts,
          trailing: Column(
            children: [
              Text(LangKey.editChildProfile.from,
                  style: GlobalTextStyles.interTextStyle(
                      fontSize: 10.sp,
                      color: AppColors.mutedTextColor,
                      fontWeight: FontWeight.w600)),
              4.verticalSpace,
              _buildTimeChip('19:30'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCycleCard(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    Color? iconBgColor,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.md,
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconBgColor ?? iconColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.primaryText,
                  ),
                ),
                4.verticalSpace,
                Text(
                  subtitle,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.mutedTextColor,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildTimeChip(String time) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.inputBorder),
        borderRadius: AppBorders.sm,
      ),
      child: Text(
        time,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildSafetyHealth(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.05),
        borderRadius: AppBorders.lg,
        border:
            Border.all(color: AppColors.primaryColor.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.editChildProfile.safetyHealthReasons,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              height: 1.4,
            ),
          ),
          16.verticalSpace,
          Obx(() => Column(
                children: [
                  _buildRadioOption(context, LangKey.editChildProfile.none),
                  8.verticalSpace,
                  _buildRadioOption(
                      context, LangKey.editChildProfile.foodAllergies),
                  8.verticalSpace,
                  _buildRadioOption(
                      context, LangKey.editChildProfile.mobilityConsiderations),
                  8.verticalSpace,
                  _buildRadioOption(
                      context, LangKey.editChildProfile.physicalChallenges),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildRadioOption(BuildContext context, String value) {
    final isSelected = controller.safetyReason.value == value;
    return GestureDetector(
      onTap: () => controller.safetyReason.value = value,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: context.appColors.elevatedBackground,
          borderRadius: AppBorders.md,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryColor : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.inputBorder,
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionalNotes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.editChildProfile.anythingElseNotes,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: context.appColors.primaryText,
            height: 1.4,
          ),
        ),
        16.verticalSpace,
        AppTextField(
          controller: controller.notesController,
          hint:
              'e:g: Eve has homework after school, enjoys sensory play,\nand should avoid sugary snacks today',
          maxLines: 4,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.lg,
        border: Border.all(color: AppColors.inputBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              LangKey.editChildProfile.quickActions,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
          ),
          Divider(color: AppColors.inputBorder, height: 1.h),
          _buildQuickActionTile(
              context,
              IconsaxPlusLinear.calendar_1,
              LangKey.editChildProfile.buildNewDay,
              LangKey.editChildProfile.createFreshTimeline),
          _buildQuickActionTile(
              context,
              IconsaxPlusLinear.edit,
              LangKey.editChildProfile.editDay,
              LangKey.editChildProfile.editTodaysTimeline),
          _buildQuickActionTile(
              context,
              IconsaxPlusLinear.magic_star,
              LangKey.editChildProfile.regenerateTimeline,
              LangKey.editChildProfile.getNewSchedule,
              isLast: true),
        ],
      ),
    );
  }

  Widget _buildQuickActionTile(
      BuildContext context, IconData icon, String title, String subtitle,
      {bool isLast = false}) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 22.sp),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.primaryText,
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      subtitle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(IconsaxPlusLinear.arrow_right_3,
                  color: AppColors.mutedTextColor, size: 20.sp),
            ],
          ),
        ),
        if (!isLast) Divider(color: AppColors.inputBorder, height: 1.h),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFFF6B6B)),
        shape: RoundedRectangleBorder(borderRadius: AppBorders.md),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LangKey.editChildProfile.deleteChildsProfile,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFFFF6B6B),
            ),
          ),
          Icon(IconsaxPlusLinear.trash,
              color: const Color(0xFFFF6B6B), size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildPill(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.inputBorder,
          ),
          borderRadius: AppBorders.full,
        ),
        child: Text(
          text,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.whiteColor : AppColors.mutedTextColor,
          ),
        ),
      ),
    );
  }

  Widget _buildFlexiblePill(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.inputBorder,
          ),
          borderRadius: AppBorders.md,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : AppColors.mutedTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
