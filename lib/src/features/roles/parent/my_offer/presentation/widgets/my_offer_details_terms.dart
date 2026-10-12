import 'package:alurei/src/imports/imports.dart';

class MyOfferDetailsTerms extends StatelessWidget {
  const MyOfferDetailsTerms({
    super.key,
    required this.isExpanded,
  });

  final ValueNotifier<bool> isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.neutral200,
          width: 1.w,
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              isExpanded.value = !isExpanded.value;
            },
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    LangKey.parentMyOffer.termsAndConditions,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  Icon(
                    isExpanded.value
                        ? IconsaxPlusLinear.arrow_up_1
                        : IconsaxPlusLinear.arrow_down_1,
                    size: 20.w,
                    color: AppColors.primaryTextColor,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded.value) ...[
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: AppColors.neutral200,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'AED 30 Instant Discount. Applied directly at checkout on your total bill. AED 30 Instant Discount. Applied directly at checkout on your total bill.',
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.mutedTextColor,
                  height: 18 / 13,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
