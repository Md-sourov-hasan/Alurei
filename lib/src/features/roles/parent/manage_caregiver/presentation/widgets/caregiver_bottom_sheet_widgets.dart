import 'package:cached_network_image/cached_network_image.dart';
import 'package:alurei/src/imports/imports.dart';

class CaregiverBottomSheetContainer extends StatelessWidget {
  const CaregiverBottomSheetContainer({
    super.key,
    required this.title,
    required this.child,
    this.onClose,
    this.showBackButton = false,
    this.onBack,
  });

  final String title;
  final Widget child;
  final VoidCallback? onClose;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10.h),
            Center(
              child: Container(
                width: 36.w,
                height: 5.h,
                decoration: const BoxDecoration(
                  color: AppColors.neutral200,
                  borderRadius: AppBorders.full,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  if (showBackButton) ...[
                    InkWell(
                      onTap: onBack ?? () => Navigator.of(context).pop(),
                      borderRadius: AppBorders.full,
                      child: Icon(
                        IconsaxPlusLinear.arrow_left,
                        size: 20.sp,
                        color: context.appColors.primaryText,
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                  Expanded(
                    child: Text(
                      title,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 18.sp,
                        height: 28 / 18,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.primaryText,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onClose ?? () => Navigator.of(context).pop(),
                    borderRadius: AppBorders.full,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: context.appColors.primaryBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconsaxPlusLinear.close_square,
                        size: 20.sp,
                        color: context.appColors.mutedText,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WhoAreYouInvitingBottomSheet extends StatelessWidget {
  const WhoAreYouInvitingBottomSheet({
    super.key,
    required this.onSelectNanny,
    required this.onSelectParents,
    required this.onSelectFamilyMember,
  });

  final VoidCallback onSelectNanny;
  final VoidCallback onSelectParents;
  final VoidCallback onSelectFamilyMember;

  @override
  Widget build(BuildContext context) {
    return CaregiverBottomSheetContainer(
      title: LangKey.parentToday.whoAreYouInviting,
      child: Column(
        children: [
          _InvitingOptionCard(
            title: LangKey.parentToday.nanny,
            icon: IconsaxPlusLinear.user,
            onTap: onSelectNanny,
          ),
          SizedBox(height: 12.h),
          _InvitingOptionCard(
            title: LangKey.parentToday.parents,
            icon: IconsaxPlusLinear.people,
            onTap: onSelectParents,
          ),
          SizedBox(height: 12.h),
          _InvitingOptionCard(
            title: LangKey.parentToday.familyMember,
            icon: IconsaxPlusLinear.profile_2user,
            onTap: onSelectFamilyMember,
          ),
        ],
      ),
    );
  }
}

class _InvitingOptionCard extends StatelessWidget {
  const _InvitingOptionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorders.lg,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: context.appColors.primaryBackground,
          borderRadius: AppBorders.lg,
          border: Border.all(color: AppColors.brandTealBorder),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.1),
                borderRadius: AppBorders.md,
              ),
              child: Icon(
                icon,
                size: 20.sp,
                color: context.colors.primary,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.primaryText,
                ),
              ),
            ),
            Icon(
              IconsaxPlusLinear.arrow_right_3,
              size: 18.sp,
              color: context.appColors.primaryText,
            ),
          ],
        ),
      ),
    );
  }
}

class MemberIdentityBottomSheet extends HookWidget {
  const MemberIdentityBottomSheet({
    super.key,
    required this.childName,
    required this.onNext,
  });

  final String childName;
  final ValueChanged<Map<String, String>> onNext;

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final selectedRelation = useState<String>('Grandmother');

    final relations = [
      LangKey.parentToday.grandmother,
      LangKey.parentToday.guardian,
      LangKey.parentToday.godparent,
      LangKey.parentToday.grandfather,
      LangKey.parentToday.uncle,
      LangKey.parentToday.sibling,
      LangKey.parentToday.aunt,
      LangKey.parentToday.other,
    ];

    return CaregiverBottomSheetContainer(
      title: LangKey.parentToday.membersIdentity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentToday.fullName,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: nameController,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
            decoration: appFormInputDecoration(
              context,
              LangKey.parentToday.fullNameHint,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            LangKey.parentToday.relationshipToChild.tr(args: [childName]),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 20 / 14,
              fontWeight: FontWeight.w500,
              color: context.appColors.primaryText,
            ),
          ),
          SizedBox(height: 12.h),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: relations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 48.h,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemBuilder: (context, index) {
              final relation = relations[index];
              final isSelected = selectedRelation.value == relation;
              return InkWell(
                onTap: () => selectedRelation.value = relation,
                borderRadius: AppBorders.lg,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? context.colors.primary
                        : context.appColors.elevatedBackground,
                    borderRadius: AppBorders.lg,
                    border: Border.all(
                      color: isSelected
                          ? context.colors.primary
                          : AppColors.brandTealBorder,
                    ),
                  ),
                  child: Text(
                    relation,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      height: 20 / 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? context.colors.onPrimary
                          : context.appColors.primaryText,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: FilledButton(
              onPressed: () {
                onNext({
                  'name': nameController.text.trim(),
                  'relation': selectedRelation.value,
                });
              },
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
              ),
              child: Text(
                LangKey.parentToday.next,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w600,
                  color: context.colors.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PermissionItemModel {
  const PermissionItemModel({
    required this.key,
    required this.title,
    required this.description,
    this.initialValue = false,
  });

  final String key;
  final String title;
  final String description;
  final bool initialValue;
}

class CaregiverPermissionsBottomSheet extends HookWidget {
  const CaregiverPermissionsBottomSheet({
    super.key,
    required this.title,
    required this.permissions,
    this.onNext,
    this.showNoticeBanner = true,
    this.showNextButton = true,
    this.showBackButton = false,
    this.onBack,
    this.onPermissionToggled,
  });

  final String title;
  final List<PermissionItemModel> permissions;
  final ValueChanged<Map<String, bool>>? onNext;
  final bool showNoticeBanner;
  final bool showNextButton;
  final bool showBackButton;
  final VoidCallback? onBack;
  final ValueChanged<Map<String, bool>>? onPermissionToggled;

  @override
  Widget build(BuildContext context) {
    final toggleStates = useState<Map<String, bool>>({
      for (final p in permissions) p.key: p.initialValue,
    });

    return CaregiverBottomSheetContainer(
      title: title,
      showBackButton: showBackButton,
      onBack: onBack,
      child: Column(
        children: [
          if (showNoticeBanner) ...[
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: context.colors.primary.withValues(alpha: 0.08),
                borderRadius: AppBorders.lg,
                border: Border.all(
                  color: context.colors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    IconsaxPlusLinear.info_circle,
                    size: 20.sp,
                    color: context.colors.primary,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      LangKey.parentToday.permissionsReviewNotice,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 12.sp,
                        height: 18 / 12,
                        fontWeight: FontWeight.w400,
                        color: context.colors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],
          ...permissions.map((p) {
            final isEnabled = toggleStates.value[p.key] ?? false;
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: context.appColors.primaryBackground,
                  borderRadius: AppBorders.lg,
                  border: Border.all(color: AppColors.brandTealBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            p.title,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              height: 24 / 16,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.primaryText,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            p.description,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              height: 18 / 12,
                              fontWeight: FontWeight.w400,
                              color: context.appColors.mutedText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Switch(
                      value: isEnabled,
                      activeThumbColor: context.colors.primary,
                      activeTrackColor: context.colors.primary.withValues(alpha: 0.2),
                      onChanged: (val) {
                        final nextMap = Map<String, bool>.from(toggleStates.value);
                        nextMap[p.key] = val;
                        toggleStates.value = nextMap;
                        if (onPermissionToggled != null) {
                          onPermissionToggled!(nextMap);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
          if (showNextButton && onNext != null) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: FilledButton(
                onPressed: onNext != null ? () => onNext!(toggleStates.value) : null,
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: AppBorders.lg),
                ),
                child: Text(
                  LangKey.parentToday.next,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    height: 24 / 16,
                    fontWeight: FontWeight.w600,
                    color: context.colors.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SelectChildBottomSheet extends StatelessWidget {
  const SelectChildBottomSheet({
    super.key,
    required this.onChildSelected,
    this.onBack,
  });

  final ValueChanged<Map<String, dynamic>> onChildSelected;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return CaregiverBottomSheetContainer(
      title: 'Select Child',
      showBackButton: true,
      onBack: onBack,
      child: FutureBuilder(
        future: ManageCaregiverService.instance.fetchChildren(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: CircularProgressIndicator(color: context.colors.primary),
              ),
            );
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: Text(
                  'Failed to load children',
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    color: context.appColors.mutedText,
                  ),
                ),
              ),
            );
          }

          return snapshot.data!.fold(
            (l) => Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Center(
                child: Text(
                  l.message,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    color: context.colors.error,
                  ),
                ),
              ),
            ),
            (children) {
              if (children.isEmpty) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Center(
                    child: Text(
                      'No children found',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        color: context.appColors.mutedText,
                      ),
                    ),
                  ),
                );
              }

              return Column(
                children: children.map((child) {
                  final c = child as Map<String, dynamic>;
                  final name = c['name'] as String? ?? '';
                  final avatar = c['avatar'] as String? ?? c['image'] as String?;
                  final ageLabel = c['ageLabel'] as String? ?? '';
                  
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: InkWell(
                      onTap: () => onChildSelected(c),
                      borderRadius: AppBorders.lg,
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: context.appColors.elevatedBackground,
                          borderRadius: AppBorders.lg,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.05),
                              blurRadius: 10.r,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: avatar != null && avatar.isNotEmpty && avatar.startsWith('http')
                                  ? CachedNetworkImage(
                                      imageUrl: avatar,
                                      width: 56.w,
                                      height: 56.w,
                                      fit: BoxFit.cover,
                                      errorWidget: (_, __, ___) => Image.asset(
                                        AppAssets.parentTodayChildProfileAvatar,
                                        width: 56.w,
                                        height: 56.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Image.asset(
                                      AppAssets.parentTodayChildProfileAvatar,
                                      width: 56.w,
                                      height: 56.w,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 16.sp,
                                      height: 24 / 16,
                                      fontWeight: FontWeight.w600,
                                      color: context.appColors.primaryText,
                                    ),
                                  ),
                                  if (ageLabel.isNotEmpty) ...[
                                    SizedBox(height: 4.h),
                                    Text(
                                      ageLabel,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 12.sp,
                                        height: 18 / 12,
                                        fontWeight: FontWeight.w400,
                                        color: context.appColors.mutedText,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                            Icon(
                              IconsaxPlusLinear.arrow_right_3,
                              size: 20.sp,
                              color: context.appColors.mutedText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
