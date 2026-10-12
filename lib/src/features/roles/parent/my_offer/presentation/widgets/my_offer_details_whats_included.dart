import 'package:alurei/src/features/roles/parent/my_offer/presentation/controllers/my_offer_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class MyOfferDetailsWhatsIncluded extends StatelessWidget {
  const MyOfferDetailsWhatsIncluded({
    super.key,
    required this.offer,
  });

  final RewardOffer offer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.parentMyOffer.whatsIncluded,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryTextColor,
          ),
        ),
        12.verticalSpace,
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.neutral200,
              width: 1.w,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                IconsaxPlusLinear.tick_circle,
                size: 24.w,
                color: AppColors.voucherBadgeBg,
              ),
              12.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      offer.title,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryTextColor,
                      ),
                    ),
                    6.verticalSpace,
                    Text(
                      'AED 30 Instant Discount. Applied directly at checkout on your total bill. AED 30 Instant Discount. Applied directly at checkout on your total bill.',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.mutedTextColor,
                        height: 18 / 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
