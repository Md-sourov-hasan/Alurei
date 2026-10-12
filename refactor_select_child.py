import re

file_path = '/Users/shakil/Downloads/Shakil/evaturner1/lib/src/features/roles/parent/manage_caregiver/presentation/widgets/caregiver_bottom_sheet_widgets.dart'

with open(file_path, 'r') as f:
    content = f.read()

# Replace the entire SelectChildBottomSheet class
old_class_pattern = r"class SelectChildBottomSheet extends StatelessWidget \{[\s\S]*?\n\}"

new_class = """class SelectChildBottomSheet extends StatelessWidget {
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
      child: FutureBuilder<FutureEither<List<dynamic>>>(
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
                    color: context.appColors.errorText,
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
}"""

content = re.sub(old_class_pattern, new_class, content)

with open(file_path, 'w') as f:
    f.write(content)

print("Done")
