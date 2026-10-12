import 'package:alurei/src/imports/imports.dart';

class MyOfferDetailsLocations extends StatelessWidget {
  const MyOfferDetailsLocations({super.key});

  @override
  Widget build(BuildContext context) {
    final locations = [
      {'name': 'Dubai Mall', 'address': 'Downtown Dubai, Level LG'},
      {'name': 'Dubai Mall', 'address': 'Downtown Dubai, Level LG'},
      {'name': 'Dubai Mall', 'address': 'Downtown Dubai, Level LG'},
      {'name': 'Dubai Mall', 'address': 'Downtown Dubai, Level LG'},
    ];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LangKey.parentMyOffer.availableLocations,
              style: GlobalTextStyles.interTextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryTextColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 6.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.brandTealBorder,
                    width: 1.w,
                  ),
                ),
                child: Text(
                  LangKey.parentMyOffer.visitWebsite,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        16.verticalSpace,
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: locations.length,
          separatorBuilder: (_, __) => 12.verticalSpace,
          itemBuilder: (context, index) {
            final loc = locations[index];
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: AppColors.neutral200.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      IconsaxPlusLinear.location,
                      size: 20.w,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  12.horizontalSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc['name']!,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryTextColor,
                          ),
                        ),
                        4.verticalSpace,
                        Text(
                          loc['address']!,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.disabledTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                    },
                    child: Text(
                      LangKey.parentMyOffer.viewLocation,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
