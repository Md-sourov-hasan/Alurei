import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class MyOfferDetailsHeroCard extends StatelessWidget {
  const MyOfferDetailsHeroCard({
    super.key,
    required this.offer,
  });

  final RewardOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black05,
            blurRadius: 10.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: SizedBox(
              height: 200.h,
              width: double.infinity,
              child: Image.asset(
                AppAssets.rewardItemDetails,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  AppAssets.rewardItemDetails,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Partner & Details Box
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Partner Name & Points Pill
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.brandTealIce,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.brandTealBorder.withOpacity(0.4),
                          width: 1.w,
                        ),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.icSpa,
                        width: 20.w,
                        height: 20.w,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Text(
                        offer.partnerName,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.headerTextColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.rewardSuccessBadgeBg,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        '${offer.pointsRequired} ALR',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.rewardSuccessBadgeText,
                        ),
                      ),
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
                    color: AppColors.primaryTextColor,
                  ),
                ),

                10.verticalSpace,

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
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.voucherBadgeBg,
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
