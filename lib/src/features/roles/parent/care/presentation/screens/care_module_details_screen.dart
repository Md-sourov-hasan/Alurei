import 'package:alurei/src/imports/imports.dart';
import '../controllers/care_module_details_controller.dart';

class CareModuleDetailsScreen extends GetView<CareModuleDetailsController> {
  const CareModuleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FBFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            IconsaxPlusLinear.arrow_left_1,
            color: Color(0xFF003D45),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Module Details',
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF003D45),
          ),
        ),
        actions: [
          Obx(() {
            final isBookmarked = controller.isBookmarked.value;
            return IconButton(
              icon: SvgPicture.asset(
                isBookmarked
                    ? AppAssets.icBookmarkSaveFilled
                    : AppAssets.icBookmarkSave,
                width: 22.w,
                height: 22.w,
                colorFilter: ColorFilter.mode(
                  isBookmarked
                      ? AppColors.secondaryTeal
                      : const Color(0xFF004D54),
                  BlendMode.srcIn,
                ),
              ),
              onPressed: () => controller.toggleBookmark(),
            );
          }),
        ],
      ),
      body: Obx(() {
        final isLoading = controller.isLoading.value;
        final detail = controller.moduleDetail.value;

        if (isLoading) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: const SkeletonWrapper(
              isLoading: true,
              child: SizedBox(
                height: 300,
                width: double.infinity,
              ),
            ),
          );
        }

        if (detail == null) {
          return Center(
            child: Text(
              controller.errorMessage.value.isNotEmpty
                  ? controller.errorMessage.value
                  : 'No module detail found',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF8BA5A8),
              ),
            ),
          );
        }

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Cover Image Card
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Stack(
                        children: [
                          CommonImage(
                            imageUrl: detail.coverImageUrl,
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 12.h,
                            left: 12.w,
                            right: 12.w,
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF004D54),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Text(
                                    detail.category.replaceAll('_', ' '),
                                    style: GlobalTextStyles.interTextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor
                                        .withValues(alpha: 0.9),
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        IconsaxPlusLinear.clock,
                                        size: 12,
                                        color: Color(0xFF004D54),
                                      ),
                                      SizedBox(width: 4.w),
                                      Text(
                                        '${detail.estimatedMinutes}m',
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF004D54),
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
                    SizedBox(height: 18.h),

                    // Title & Subtitle
                    Text(
                      detail.title,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF003D45),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      detail.subtitle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4A686C),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      detail.description,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF5C797D),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Key Takeaway Section
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5F6),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFFBBE3E6),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: const BoxDecoration(
                              color: Color(0xFF004D54),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              IconsaxPlusBold.lamp_charge,
                              size: 16,
                              color: AppColors.whiteColor,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Key Takeaway',
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF003D45),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  detail.keyTakeaway,
                                  style: GlobalTextStyles.interTextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF003D45),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Content Sections / Care Response
                    ...detail.contentSections.map((sec) {
                      return Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(bottom: 20.h),
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              sec.heading,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF003D45),
                              ),
                            ),
                            SizedBox(height: 12.h),
                            ...sec.bullets.map((b) {
                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 6.h, right: 8.w),
                                      width: 6.r,
                                      height: 6.r,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF004D54),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        b,
                                        style: GlobalTextStyles.interTextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFF2C4C50),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),

                    // Questions Section
                    if (detail.questions.isNotEmpty) ...[
                      Text(
                        'Quiz & Questions',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF003D45),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      ...detail.questions.map((q) {
                        return Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 20.h),
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                q.question,
                                style: GlobalTextStyles.interTextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF003D45),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              ...q.options.map((opt) {
                                return Obx(() {
                                  final isSelected =
                                      controller.selectedOptionId.value ==
                                          opt.id;
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.selectOption(opt.id),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 14.w,
                                        vertical: 12.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFFE8F5F6)
                                            : const Color(0xFFF9FBFB),
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: Border.all(
                                          color: isSelected
                                              ? const Color(0xFF004D54)
                                              : const Color(0xFFE2ECEE),
                                          width: 1.2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            isSelected
                                                ? IconsaxPlusBold.tick_circle
                                                : IconsaxPlusLinear.task_square,
                                            size: 18,
                                            color: isSelected
                                                ? const Color(0xFF004D54)
                                                : const Color(0xFF8BA5A8),
                                          ),
                                          SizedBox(width: 10.w),
                                          Expanded(
                                            child: Text(
                                              opt.label,
                                              style: GlobalTextStyles
                                                  .interTextStyle(
                                                fontSize: 13.sp,
                                                fontWeight: isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w400,
                                                color: const Color(0xFF003D45),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              }),

                              // Explanation Banner when answered
                              Obx(() {
                                if (!controller.isAnswered.value) {
                                  return const SizedBox.shrink();
                                }
                                return Container(
                                  margin: EdgeInsets.only(top: 8.h),
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEBF7F0),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        IconsaxPlusBold.info_circle,
                                        size: 16,
                                        color: Color(0xFF1E7E45),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Text(
                                          q.explanation,
                                          style:
                                              GlobalTextStyles.interTextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            color: const Color(0xFF1E7E45),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Action Bar
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () => controller.assignModule(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004D54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Assign Module',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.whiteColor,
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
}
