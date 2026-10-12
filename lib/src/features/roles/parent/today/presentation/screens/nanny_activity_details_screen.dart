import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../controllers/nanny_activity_details_controller.dart';

class NannyActivityDetailsScreen extends StatelessWidget {
  const NannyActivityDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NannyActivityDetailsController>();
    return Scaffold(
      backgroundColor: context.appColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: context.appColors.elevatedBackground,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back<void>,
          icon: Icon(
            IconsaxPlusLinear.arrow_left,
            size: 20.sp,
            color: context.colors.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          LangKey.parentToday.activityDetails,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            height: 28 / 18,
            fontWeight: FontWeight.w600,
            color: context.appColors.primaryText,
          ),
        ),
      ),
      body: Obx(() {
        final details = controller.details.value;
        if (controller.isLoading.value) {
          return AppLoading(
              message: LangKey.parentToday.loadingActivityDetails);
        }
        if (details == null) {
          return AppErrorWidget(
            message: controller.errorMessage.value ??
                LangKey.parentToday.unableToLoadActivityDetails,
            onRetry: controller.loadDetails,
          );
        }
        return RefreshIndicator(
          onRefresh: controller.loadDetails,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 28.h),
            children: [
              _ActivityHero(details: details),
              SizedBox(height: 24.h),
              _ProofSection(details: details),
              SizedBox(height: 28.h),
              Text(
                LangKey.parentToday.nutritionalFocus,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 24.sp,
                  height: 32 / 24,
                  fontWeight: FontWeight.w600,
                  color: context.colors.primary,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: details.focusTags
                    .map((tag) => _FocusChip(label: tag))
                    .toList(growable: false),
              ),
              SizedBox(height: 28.h),
              _FeedbackCard(details: details),
            ],
          ),
        );
      }),
    );
  }
}

class _ActivityHero extends StatelessWidget {
  const _ActivityHero({required this.details});

  final ParentNannyActivityDetailsData details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.supportingOrange.withValues(alpha: 0.18),
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: AppBorders.md,
                ),
                child: Icon(
                  IconsaxPlusLinear.cup,
                  size: 24.sp,
                  color: context.colors.onPrimary,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.title,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 24.sp,
                        height: 32 / 24,
                        fontWeight: FontWeight.w600,
                        color: context.appColors.primaryText,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      details.subtitle,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        height: 20 / 14,
                        color: context.appColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              _CategoryPill(label: details.category),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Icon(
                IconsaxPlusLinear.clock_1,
                size: 18.sp,
                color: context.colors.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  details.timeRange,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    height: 20 / 14,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.primaryText,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.groceryGreen.withValues(alpha: 0.12),
              borderRadius: AppBorders.full,
            ),
            child: Text(
              details.completedAt,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 13.sp,
                height: 18 / 13,
                fontWeight: FontWeight.w600,
                color: AppColors.groceryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProofSection extends StatelessWidget {
  const _ProofSection({required this.details});

  final ParentNannyActivityDetailsData details;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              IconsaxPlusLinear.gallery,
              size: 20.sp,
              color: context.colors.primary,
            ),
            SizedBox(width: 8.w),
            Text(
              '${LangKey.parentToday.activityProof} · '
              '${details.proofImages.length} ${LangKey.parentToday.item}',
              style: GlobalTextStyles.interTextStyle(
                fontSize: 16.sp,
                height: 24 / 16,
                fontWeight: FontWeight.w600,
                color: context.appColors.primaryText,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            for (var index = 0; index < details.proofImages.length; index++)
              InkWell(
                onTap: () => FullScreenImageViewer.open<void>(
                  imageUrl: details.proofImages[index],
                  imageUrls: details.proofImages,
                  initialIndex: index,
                ),
                borderRadius: BorderRadius.circular(18.r),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18.r),
                      child: Image.asset(
                        details.proofImages[index],
                        width: 104.w,
                        height: 104.w,
                        fit: BoxFit.cover,
                      ),
                    ),
                    PositionedDirectional(
                      start: 8.w,
                      bottom: 8.h,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withValues(alpha: 0.55),
                          borderRadius: AppBorders.full,
                        ),
                        child: Text(
                          index < details.proofTimes.length
                              ? details.proofTimes[index]
                              : '',
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 11.sp,
                            height: 16 / 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _FocusChip extends StatelessWidget {
  const _FocusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: AppColors.brandTealLight.withValues(alpha: 0.75),
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 13.sp,
          height: 18 / 13,
          fontWeight: FontWeight.w600,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class _FeedbackCard extends StatelessWidget {
  const _FeedbackCard({required this.details});

  final ParentNannyActivityDetailsData details;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(21.w),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        border: Border.all(color: context.appColors.bottomNavBorder),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                IconsaxPlusLinear.message_text,
                size: 22.sp,
                color: context.colors.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  LangKey.parentToday.feedback,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 20.sp,
                    height: 30 / 20,
                    fontWeight: FontWeight.w600,
                    color: context.colors.primary,
                  ),
                ),
              ),
              Text(
                details.feedbackDate,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 12.sp,
                  height: 18 / 12,
                  color: context.appColors.secondaryText,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Expanded(
                child: _FeedbackMetric(
                  label: LangKey.parentToday.enjoyment,
                  value: details.enjoyment,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _FeedbackMetric(
                  label: LangKey.parentToday.childMood,
                  value: details.mood,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          _CompletionRow(value: details.completion),
          SizedBox(height: 18.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14.w),
            decoration: const BoxDecoration(
              color: AppColors.brandTealGlassBg,
              borderRadius: AppBorders.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LangKey.parentToday.nannyNote,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 13.sp,
                    height: 18 / 13,
                    fontWeight: FontWeight.w700,
                    color: context.colors.primary,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  details.nannyNote,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 13.sp,
                    height: 18 / 13,
                    color: context.appColors.secondaryText,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.groceryGreen.withValues(alpha: 0.12),
              borderRadius: AppBorders.md,
            ),
            child: Text(
              details.completedAt,
              textAlign: TextAlign.center,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 13.sp,
                height: 18 / 13,
                fontWeight: FontWeight.w700,
                color: AppColors.groceryGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryPill extends StatelessWidget {
  const _CategoryPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: context.appColors.elevatedBackground,
        borderRadius: AppBorders.full,
      ),
      child: Text(
        label,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 12.sp,
          height: 18 / 12,
          fontWeight: FontWeight.w600,
          color: context.colors.primary,
        ),
      ),
    );
  }
}

class _FeedbackMetric extends StatelessWidget {
  const _FeedbackMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.groceryGreen.withValues(alpha: 0.10),
        borderRadius: AppBorders.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              color: context.appColors.secondaryText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 15.sp,
              height: 22 / 15,
              fontWeight: FontWeight.w700,
              color: context.colors.primary,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LangKey.parentToday.completion,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 14.sp,
            height: 20 / 14,
            fontWeight: FontWeight.w600,
            color: context.appColors.primaryText,
          ),
        ),
        const Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
          decoration: BoxDecoration(
            color: AppColors.groceryGreen.withValues(alpha: 0.12),
            borderRadius: AppBorders.full,
          ),
          child: Text(
            value,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.sp,
              height: 18 / 12,
              fontWeight: FontWeight.w700,
              color: AppColors.groceryGreen,
            ),
          ),
        ),
      ],
    );
  }
}
