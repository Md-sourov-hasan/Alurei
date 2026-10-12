import 'package:alurei/src/imports/imports.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import '../controllers/my_offer_controller.dart';

class MyOfferCard extends StatelessWidget {
  const MyOfferCard({
    super.key,
    required this.offer,
    required this.onToggleSave,
    this.onRedeem,
    this.onViewDetails,
  });

  final RewardOffer offer;
  final VoidCallback onToggleSave;
  final VoidCallback? onRedeem;
  final VoidCallback? onViewDetails;

  @override
  Widget build(BuildContext context) {
    final hasHeaderImage = offer.imageUrl != null && offer.imageUrl!.isNotEmpty;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Optional Top Image Header ─────────────────────────────────────
          if (hasHeaderImage)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                  child: Image.asset(
                    offer.imageUrl!,
                    height: 192.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // Top Right Bookmark overlay
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      onToggleSave();
                    },
                    child: Obx(() {
                      final isSaved = offer.isSaved.value;
                      return Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.whiteColor.withOpacity(0.9),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.blackColor.withOpacity(0.08),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isSaved
                              ? Icon(
                                  IconsaxPlusBold.archive_minus,
                                  size: 16.w,
                                  color: const Color(0xFF0B5460),
                                )
                              : SvgPicture.asset(
                                  AppAssets.icBookmarkSave,
                                  width: 12.w,
                                  height: 16.h,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.mutedTextColor,
                                    BlendMode.srcIn,
                                  ),
                                ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),

          // ── Card Details Body ─────────────────────────────────────────────
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Partner Name & Points Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 36.w,
                            height: 36.w,
                            decoration: const BoxDecoration(
                              color: AppColors.brandTealLight,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                AppAssets.icSpa,
                                width: 18.w,
                                height: 18.w,
                              ),
                            ),
                          ),
                          8.horizontalSpace,
                          Expanded(
                            child: Text(
                              offer.partnerName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GlobalTextStyles.interTextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.headerTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    12.horizontalSpace,

                    // Bookmark button (if no header image) & Points Badge
                    Row(
                      children: [
                        if (!hasHeaderImage) ...[
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.selectionClick();
                              onToggleSave();
                            },
                            child: Obx(() {
                              final isSaved = offer.isSaved.value;
                              return Container(
                                width: 32.w,
                                height: 32.w,
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.primaryBackgroundColor,
                                ),
                                child: Center(
                                  child: isSaved
                                      ? Icon(
                                          IconsaxPlusBold.archive_minus,
                                          size: 16.w,
                                          color: const Color(0xFF0B5460),
                                        )
                                      : SvgPicture.asset(
                                          AppAssets.icBookmarkSave,
                                          width: 12.w,
                                          height: 16.h,
                                          colorFilter: const ColorFilter.mode(
                                            AppColors.mutedTextColor,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                ),
                              );
                            }),
                          ),
                        ],

                        // Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: offer.hasSufficientBalance
                                ? AppColors.rewardSuccessBadgeBg
                                : AppColors.rewardErrorBadgeBg,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            '${offer.pointsRequired} ALR',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: offer.hasSufficientBalance
                                  ? AppColors.rewardSuccessBadgeText
                                  : AppColors.rewardErrorBadgeText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                12.verticalSpace,

                // Title
                Text(
                  offer.title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mutedTextColor,
                  ),
                ),

                8.verticalSpace,

                // Expiry Date
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.icRewardCalendar,
                      width: 14.w,
                      height: 15.h,
                    ),
                    6.horizontalSpace,
                    Text(
                      offer.expiryDate,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.voucherBadgeBg,
                      ),
                    ),
                  ],
                ),

                16.verticalSpace,

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          onRedeem?.call();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Text(
                            'Redeem Offer',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          HapticFeedback.selectionClick();
                          onViewDetails?.call();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryBackgroundColor,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: AppColors.voucherBadgeBg,
                              width: 1.w,
                            ),
                          ),
                          child: Text(
                            'View Details',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.voucherBadgeBg,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
