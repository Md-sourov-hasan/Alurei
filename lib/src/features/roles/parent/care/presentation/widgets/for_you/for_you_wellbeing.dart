import 'package:alurei/src/imports/imports.dart';
import 'for_you_offer_bottom_sheet.dart';
class ForYouWellbeing extends StatelessWidget {
  const ForYouWellbeing({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> offers = [
      {
        'title': 'Serenity Spa',
        'subtitle': 'Holistic wellness & m...',
        'discount': '20% OFF',
        'icon': AppAssets.icSpa,
      },
      {
        'title': 'Wellness Studio',
        'subtitle': 'Mindfulness & yoga s...',
        'discount': '15% OFF',
        'icon': AppAssets.icThis,
      },
      {
        'title': 'Care Retreat',
        'subtitle': 'Relaxation & therapy...',
        'discount': '25% OFF',
        'icon': AppAssets.icSpa2,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LangKey.parentCare.yourWellBeing,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "You give care. Here's something back for you.",
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(8.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LangKey.parentCare.visitAllOffers,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryTeal,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      IconsaxPlusLinear.arrow_right_3,
                      size: 14.w,
                      color: AppColors.secondaryTeal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 175.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.w),
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return _buildOfferCard(
                context,
                title: offer['title']!,
                subtitle: offer['subtitle']!,
                discount: offer['discount']!,
                iconPath: offer['icon']!,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOfferCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String discount,
    required String iconPath,
  }) {
    return Container(
      width: 170.w,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            context.showAppBottomSheet(
              builder: (context) => const ForYouOfferBottomSheet(),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      width: 24.w,
                      height: 24.w,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColors.secondaryTeal.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        discount,
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  subtitle,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Text(
                    'View offer',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
