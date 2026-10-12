import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/activity_item.dart';

class ActivitiesSuggestedCard extends StatelessWidget {
  const ActivitiesSuggestedCard({
    super.key,
    required this.item,
    required this.onAddSchedule,
    required this.onViewActivity,
  });

  final ActivityItem item;
  final VoidCallback onAddSchedule;
  final VoidCallback onViewActivity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onViewActivity,
      child: Container(
        width: 300.w,
        height: 280.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: AppShadows.subtle,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: item.imageUrl.startsWith('http')
                    ? CommonImage(
                        imageUrl: item.imageUrl,
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

              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.blackColor.withValues(alpha: 0.25),
                        AppColors.blackColor.withValues(alpha: 0.4),
                        AppColors.blackColor.withValues(alpha: 0.95),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),

              // Content Padding
              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top tag pill ("1 Year Old")
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 5.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withValues(alpha: 0.65),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 10.w,
                              height: 10.w,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              item.ageTag,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Title
                      Text(
                        item.title,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),

                      // Description
                      Text(
                        item.description,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 14.sp,
                          height: 1.3,
                          color: AppColors.whiteColor.withValues(alpha: 0.88),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 14.h),

                      // Outer wrapping rounded container for buttons (matching exact image shape)
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withValues(alpha: 0.55),
                          border: Border.all(
                            color: AppColors.whiteColor.withValues(alpha: 0.2),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 16,
                              child: GestureDetector(
                                onTap: onAddSchedule,
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        IconsaxPlusLinear.add_circle,
                                        size: 15.w,
                                        color: AppColors.whiteColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Flexible(
                                        child: Text(
                                          LangKey
                                              .parentActivities.addToSchedule,
                                          style:
                                              GlobalTextStyles.interTextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.whiteColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              flex: 9,
                              child: GestureDetector(
                                onTap: onViewActivity,
                                child: Container(
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor
                                        .withValues(alpha: 0.18),
                                    border: Border.all(
                                      color: AppColors.whiteColor
                                          .withValues(alpha: 0.5),
                                      width: 1.2,
                                    ),
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      LangKey.parentActivities.viewActivity,
                                      style: GlobalTextStyles.interTextStyle(
                                        fontSize: 11.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.whiteColor,
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
