part of 'todays_child_profile_widgets.dart';

class TodaysChildAvatar extends StatelessWidget {
  const TodaysChildAvatar({
    super.key,
    required this.imageAsset,
    required this.onEdit,
    this.imageUrl,
    this.imageFile,
  });

  final String imageAsset;
  final VoidCallback onEdit;
  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 128.w,
            height: 128.w,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: context.colors.primary, width: 4.w),
            ),
            child: ClipOval(
              child: _AvatarImage(
                imageAsset: imageAsset,
                imageUrl: imageUrl,
                imageFile: imageFile,
              ),
            ),
          ),
          PositionedDirectional(
            end: 0.w,
            bottom: 0.w,
            child: Skeleton.keep(
              child: IconButton.filled(
                onPressed: onEdit,
                icon: Icon(IconsaxPlusLinear.camera, size: 16.sp),
                style: IconButton.styleFrom(
                  fixedSize: Size(32.w, 32.w),
                  backgroundColor: context.colors.secondary,
                  foregroundColor: context.colors.onSecondary,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({
    required this.imageAsset,
    this.imageUrl,
    this.imageFile,
  });

  final String imageAsset;
  final String? imageUrl;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    if (imageFile != null) {
      return Image.file(imageFile!, fit: BoxFit.cover);
    }

    final url = imageUrl?.trim();
    if (url != null && url.isNotEmpty) {
      return CommonImage(
        imageUrl: url,
        fit: BoxFit.cover,
        errorWidget: const _AvatarIconFallback(),
        placeholder: const _AvatarIconFallback(),
      );
    }

    return const _AvatarIconFallback();
  }
}

class _AvatarIconFallback extends StatelessWidget {
  const _AvatarIconFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.primary.withValues(alpha: 0.10),
      child: Center(
        child: Icon(
          IconsaxPlusLinear.user,
          size: 46.sp,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class TodaysChildAssignNannyButton extends StatelessWidget {
  const TodaysChildAssignNannyButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRoundedPainter(color: context.appColors.mutedText),
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppBorders.lg,
        child: SizedBox(
          width: double.infinity,
          height: 74.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                IconsaxPlusLinear.profile_add,
                size: 22.sp,
                color: context.appColors.mutedText,
              ),
              SizedBox(height: 4.h),
              Text(
                LangKey.parentToday.assignNanny,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.mutedText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TodaysChildNannyPanel extends StatelessWidget {
  const TodaysChildNannyPanel({
    super.key,
    required this.nannies,
    required this.onManage,
    required this.onNannyTap,
  });

  final List<ParentChildProfileNanny> nannies;
  final VoidCallback onManage;
  final ValueChanged<ParentChildProfileNanny> onNannyTap;

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      title: LangKey.parentToday.assignedNannies,
      mutedTitle: true,
      child: Column(
        children: [
          if (nannies.isEmpty)
            _EmptyRow(text: LangKey.parentToday.noAssignedNannies)
          else
            for (final nanny in nannies)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => onNannyTap(nanny),
                      customBorder: const CircleBorder(),
                      child: ClipOval(
                        child: Image.asset(
                          nanny.avatarAsset,
                          width: 36.w,
                          height: 36.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    /// -- Nanny Info
                    Expanded(
                      child: InkWell(
                        onTap: () => onNannyTap(nanny),
                        borderRadius: AppBorders.sm,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      nanny.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 14.sp,
                                        height: 20 / 14,
                                        fontWeight: FontWeight.w600,
                                        color: context.appColors.primaryText,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  _StatusBadge(label: nanny.status),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Icon(
                                    IconsaxPlusLinear.calendar,
                                    size: 12.sp,
                                    color: context.appColors.disabledText,
                                  ),
                                  SizedBox(width: 4.w),
                                  Expanded(
                                    child: Text(
                                      nanny.since,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: context.appColors.disabledText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// -- Manage Permissions Button
                    TextButton(
                      onPressed: onManage,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 6.w),
                      ),
                      child: Text(
                        LangKey.parentToday.managePermissions,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class TodaysChildDetailsCard extends StatelessWidget {
  const TodaysChildDetailsCard({
    super.key,
    required this.editing,
    required this.childName,
    required this.nameController,
    required this.gender,
    required this.birthDate,
    required this.onEditPressed,
    required this.onNameChanged,
    required this.onGenderSelected,
    required this.onBirthDateTap,
  });

  final bool editing;
  final String childName;
  final TextEditingController nameController;
  final String? gender;
  final DateTime? birthDate;
  final VoidCallback onEditPressed;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onGenderSelected;
  final VoidCallback onBirthDateTap;

  @override
  Widget build(BuildContext context) {
    return _ProfileCard(
      title: LangKey.parentToday.childProfileDetails,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionRow(
            isLast: false,
            child: Row(
              children: [
                Expanded(
                  child: editing
                      ? AppFormTextInput(
                          controller: nameController,
                          hint: LangKey.parentToday.childNameHint,
                          onChanged: onNameChanged,
                        )
                      : Text(
                          childName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 18.sp,
                            height: 28 / 18,
                            fontWeight: FontWeight.w400,
                            color: context.appColors.primaryText,
                          ),
                        ),
                ),
                IconButton(
                  onPressed: onEditPressed,
                  icon: Icon(
                    editing
                        ? IconsaxPlusLinear.tick_circle
                        : IconsaxPlusLinear.edit_2,
                    size: 18.sp,
                    color: editing
                        ? context.colors.primary
                        : context.appColors.disabledText,
                  ),
                  style: IconButton.styleFrom(
                    fixedSize: Size(32.w, 32.w),
                    padding: EdgeInsets.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
          ),
          _SectionRow(
            isLast: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.parentToday.genderLabel.replaceAll(' *', ''),
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    _GenderPill(
                      label: LangKey.parentToday.girl,
                      value: 'Girl',
                      selectedGender: gender,
                      onTap: () => onGenderSelected('Girl'),
                    ),
                    SizedBox(width: 8.w),
                    _GenderPill(
                      label: LangKey.parentToday.boy,
                      value: 'Boy',
                      selectedGender: gender,
                      onTap: () => onGenderSelected('Boy'),
                    ),
                    SizedBox(width: 8.w),
                    _GenderPill(
                      label: LangKey.parentToday.other,
                      value: 'Other',
                      selectedGender: gender,
                      onTap: () => onGenderSelected('Other'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _SectionRow(
            isLast: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.parentToday.birthDateLabel,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
                SizedBox(height: 8.h),
                InkWell(
                  onTap: onBirthDateTap,
                  borderRadius: AppBorders.lg,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
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
                          _formatDate(birthDate),
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 14.sp,
                            height: 20 / 14,
                            fontWeight: FontWeight.w400,
                            color: birthDate != null
                                ? context.appColors.primaryText
                                : context.appColors.mutedText,
                          ),
                        ),
                        Icon(
                          IconsaxPlusLinear.calendar,
                          size: 20.sp,
                          color: context.appColors.mutedText,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GenderPill extends StatelessWidget {
  const _GenderPill({
    required this.label,
    required this.value,
    required this.selectedGender,
    required this.onTap,
  });

  final String label;
  final String value;
  final String? selectedGender;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedGender?.toLowerCase() == value.toLowerCase();
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.full,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: isSelected
              ? context.colors.primary
              : context.appColors.elevatedBackground,
          border: Border.all(
            color: isSelected ? context.colors.primary : AppColors.neutral200,
            width: 1.3.w,
          ),
          borderRadius: AppBorders.full,
        ),
        child: Text(
          label,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w500,
            color: isSelected
                ? context.colors.onPrimary
                : context.appColors.mutedText,
          ),
        ),
      ),
    );
  }
}
