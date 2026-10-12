import 'package:alurei/src/features/roles/parent/care/domain/entities/care_module_item.dart';
import 'package:alurei/src/imports/imports.dart';

class CareModuleCard extends StatelessWidget {
  const CareModuleCard({
    super.key,
    required this.item,
    required this.onAddToWeek,
    required this.onVisitModule,
    required this.onBookmark,
    this.isInProgressMode = false,
  });

  final CareModuleItem item;
  final VoidCallback onAddToWeek;
  final VoidCallback onVisitModule;
  final VoidCallback onBookmark;
  final bool isInProgressMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFE6EEEE)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Thumbnail Image with Dark Teal Accent Ring Border
          Container(
            width: 90.w,
            height: 90.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF004D54),
                width: 1.2,
              ),
            ),
            padding: EdgeInsets.all(2.w),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(17.r),
              child: item.imageUrl.startsWith('http')
                  ? CommonImage(
                      imageUrl: item.imageUrl
                              .contains('photo-1595454038955-4d80d06358b2')
                          ? 'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?q=80&w=1200&auto=format&fit=crop'
                          : item.imageUrl,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CommonImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          SizedBox(width: 14.w),

          // Right Content Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Circular Bookmark Badge Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF003D45),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!isInProgressMode) ...[
                      SizedBox(width: 8.w),
                      GestureDetector(
                        onTap: onBookmark,
                        child: Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFF7F7),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              item.isBookmarked
                                  ? AppAssets.icBookmarkSaveFilled
                                  : AppAssets.icBookmarkSave,
                              width: 18.w,
                              height: 18.w,
                              colorFilter: ColorFilter.mode(
                                item.isBookmarked
                                    ? AppColors.secondaryTeal
                                    : const Color(0xFF004D54),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 4.h),

                // Meta Info (Duration • Coins)
                Text(
                  item.coinsText.isNotEmpty
                      ? '${item.durationText} • ${item.coinsText}'
                      : item.durationText,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF6C7E80),
                  ),
                ),
                SizedBox(height: isInProgressMode ? 10.h : 12.h),

                if (isInProgressMode) ...[
                  // Progress Percentage Text ("65% Complete")
                  Text(
                    item.progressText,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004D54),
                    ),
                  ),
                  SizedBox(height: 6.h),

                  // Linear Progress Bar
                  Container(
                    height: 5.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EEEE),
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: item.progressPercentage.clamp(0.0, 1.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF004D54),
                          borderRadius: BorderRadius.circular(3.r),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  // Standard Action Buttons Row (Capsule Pill Buttons)
                  Row(
                    children: [
                      // Assign Module
                      Expanded(
                        flex: 13,
                        child: GestureDetector(
                          onTap: onAddToWeek,
                          child: Container(
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: const Color(0xFF004D54),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                LangKey.parentCare.addToWeek,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.whiteColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),

                      // Visit module
                      Expanded(
                        flex: 12,
                        child: GestureDetector(
                          onTap: onVisitModule,
                          child: Container(
                            height: 38.h,
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              border: Border.all(
                                color: const Color(0xFF004D54),
                                width: 1.2,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Center(
                              child: Text(
                                LangKey.parentCare.visitModule,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF004D54),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
