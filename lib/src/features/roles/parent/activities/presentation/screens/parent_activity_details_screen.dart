import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_activity_details_controller.dart';
import '../widgets/activity_details_benefits_grid.dart';
import '../widgets/activity_details_metrics_grid.dart';
import '../widgets/activity_details_steps_list.dart';
import '../widgets/activity_details_timeline.dart';

class ParentActivityDetailsScreen
    extends GetView<ParentActivityDetailsController> {
  const ParentActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: context.appColors.primaryBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(
            IconsaxPlusLinear.arrow_left,
            size: 24.w,
            color: const Color(0xFF004D54),
          ),
          onPressed: controller.onBack,
        ),
      ),
      body: Obx(() {
        final item = controller.activityItem.value;
        if (item == null) {
          return const Center(child: AppLoading());
        }

        return Stack(
          children: [
            // Scrollable Content Body
            SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 100.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Hero Image Header
                  SizedBox(
                    width: double.infinity,
                    height: 240.h,
                    child: Image.asset(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => CommonImage(
                        imageUrl: item.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Main Content Area
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Activity Title
                        Text(
                          item.title,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF003D45),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Key Metrics 2x2 Grid
                        ActivityDetailsMetricsGrid(item: item),
                        SizedBox(height: 24.h),

                        // Connection Moment Section
                        _buildSectionHeader(LangKey.parentActivities.connectionMoment),
                        SizedBox(height: 8.h),
                        Text(
                          LangKey.parentActivities.connectionMomentSub,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 13.sp,
                            height: 1.45,
                            color: const Color(0xFF55686A),
                          ),
                        ),
                        SizedBox(height: 28.h),

                        // Developmental Benefits Section
                        _buildSectionHeader(LangKey.parentActivities.developmentalBenefits),
                        SizedBox(height: 14.h),
                        const ActivityDetailsBenefitsGrid(),
                        SizedBox(height: 28.h),

                        // How To Do It Section
                        _buildSectionHeader(LangKey.parentActivities.howToDoIt),
                        SizedBox(height: 14.h),
                        const ActivityDetailsStepsList(),
                        SizedBox(height: 16.h),

                        // CAREGIVER PROMPTS Card
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            width: double.infinity,
                            color: const Color(0xFFE2F0F0),
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Dark Teal Left Accent Line
                                  Container(
                                    width: 4.w,
                                    color: const Color(0xFF004D54),
                                  ),
                                  // Content Padding Area
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 18.w,
                                        vertical: 16.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            LangKey.parentActivities.caregiverPrompts,
                                            style: GlobalTextStyles.interTextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xFF004D54),
                                              letterSpacing: 0.6,
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Text(
                                            LangKey.parentActivities.prompt1.tr(),
                                            style: GlobalTextStyles.interTextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF334B4E),
                                            ).copyWith(fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            LangKey.parentActivities.prompt2.tr(),
                                            style: GlobalTextStyles.interTextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF334B4E),
                                            ).copyWith(fontStyle: FontStyle.italic),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            LangKey.parentActivities.prompt3.tr(),
                                            style: GlobalTextStyles.interTextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xFF334B4E),
                                            ).copyWith(fontStyle: FontStyle.italic),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),

                        // Progression Levels Section
                        _buildSectionHeader(LangKey.parentActivities.progressionLevels),
                        SizedBox(height: 14.h),
                        const ActivityDetailsTimeline(),
                        SizedBox(height: 16.h),

                        // Why this activity? Card
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(18.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE5ECE8),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LangKey.parentActivities.whyThisActivity,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF003D45),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                LangKey.parentActivities.whyThisActivityDesc,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 13.sp,
                                  height: 1.45,
                                  color: const Color(0xFF2C3E40),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Fixed Bottom Action Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.blackColor.withValues(alpha: 0.08),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: GestureDetector(
                    onTap: controller.onAddSchedule,
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF005C66),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            IconsaxPlusLinear.add_circle,
                            size: 18.w,
                            color: AppColors.whiteColor,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            LangKey.parentActivities.addToSchedule,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 3.5.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: const Color(0xFF004D54),
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF003D45),
          ),
        ),
      ],
    );
  }
}
