import 'package:alurei/src/imports/imports.dart';

import '../../controllers/ai_setup_guide_controller.dart';

Future<String?> showAiSetupCategorySheet({
  required BuildContext context,
  required List<AiSetupActivityGroup> groups,
}) {
  final expanded =
      (groups.isNotEmpty ? <String>{groups.first.title} : <String>{}).obs;
  final showManualInput = false.obs;
  final manualController = TextEditingController();

  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparentColor,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.78,
        maxChildSize: 0.92,
        minChildSize: 0.42,
        builder: (context, scrollController) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 8.w),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.appColors.elevatedBackground,
              borderRadius: AppBorders.lg,
              boxShadow: AppShadows.modal,
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Center(
                  child: Container(
                    width: 44.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.neutral300,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  child: Obx(
                    () => ListView(
                      controller: scrollController,
                      padding: EdgeInsets.only(bottom: 16.h),
                      children: [
                        ...groups.expand((group) {
                          final isExpanded = expanded.contains(group.title);
                          return [
                            AiSetupCategoryGroupTile(
                              group: group,
                              isExpanded: isExpanded,
                              onTap: () => isExpanded
                                  ? expanded.remove(group.title)
                                  : expanded.add(group.title),
                            ),
                            if (isExpanded)
                              ...group.activities.map(
                                (activity) => AiSetupCategoryActivityTile(
                                  label: activity,
                                  onTap: () =>
                                      Navigator.of(context).pop(activity),
                                ),
                              ),
                          ];
                        }),
                        AiSetupManualActivityTile(
                          expanded: showManualInput.value,
                          controller: manualController,
                          onToggle: () => showManualInput.toggle(),
                          onSubmit: () {
                            final value = manualController.text.trim();
                            if (value.isEmpty) return;
                            Navigator.of(context).pop(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

class AiSetupCategoryGroupTile extends StatelessWidget {
  const AiSetupCategoryGroupTile({
    super.key,
    required this.group,
    required this.isExpanded,
    required this.onTap,
  });

  final AiSetupActivityGroup group;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.appColors.primaryBackground),
          ),
        ),
        child: Row(
          children: [
            Image.asset(group.icon, height: 24.sp, width: 24.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                group.title,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  height: 24 / 16,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.strongText,
                ),
              ),
            ),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0,
              duration: AppDurations.fast,
              child: Icon(
                IconsaxPlusLinear.arrow_down,
                size: 22.sp,
                color: context.appColors.strongText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiSetupCategoryActivityTile extends StatelessWidget {
  const AiSetupCategoryActivityTile({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.fromSTEB(50.w, 10.h, 16.w, 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.appColors.primaryBackground),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: const BoxDecoration(
                color: AppColors.brandTealTrack,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 14.sp,
                  height: 20 / 14,
                  fontWeight: FontWeight.w400,
                  color: context.appColors.secondaryText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiSetupManualActivityTile extends StatelessWidget {
  const AiSetupManualActivityTile({
    super.key,
    required this.expanded,
    required this.controller,
    required this.onToggle,
    required this.onSubmit,
  });

  final bool expanded;
  final TextEditingController controller;
  final VoidCallback onToggle;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            borderRadius: AppBorders.md,
            child: Row(
              children: [
                Icon(
                  IconsaxPlusLinear.add,
                  size: 18.sp,
                  color: context.colors.primary,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    LangKey.parentToday.enterActivityManually,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      height: 24 / 16,
                      fontWeight: FontWeight.w500,
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AnimatedSwitcher(
            duration: AppDurations.fast,
            child: expanded
                ? Padding(
                    key: const ValueKey('manual-input'),
                    padding: EdgeInsets.only(top: 12.h),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: controller,
                          hint: LangKey.parentToday.activityNameHint,
                          borderColor: AppColors.brandTealBorder,
                        ),
                        SizedBox(height: 10.h),
                        AppButton(
                          label: LangKey.parentToday.setActivity,
                          onPressed: onSubmit,
                          isFullWidth: true,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
