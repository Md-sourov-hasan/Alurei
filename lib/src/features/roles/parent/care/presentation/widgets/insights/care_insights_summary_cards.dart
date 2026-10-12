import 'package:alurei/src/imports/imports.dart';

class CareInsightsNutritionVarietyCard extends StatelessWidget {
  const CareInsightsNutritionVarietyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5.w, color: const Color(0xFF004D54)),
            Expanded(
              child: Container(
                color: const Color(0xFFF8FAFC),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nutrition Variety',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF004D54),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Balanced across developmental pillars with increased intake of green fibrous vegetables like steamed broccoli.',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        height: 1.45,
                        color: const Color(0xFF526668),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CareInsightsGrowthPlayCard extends StatelessWidget {
  const CareInsightsGrowthPlayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.r),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(width: 5.w, color: const Color(0xFF00BFA5)),
            Expanded(
              child: Container(
                color: const Color(0xFFF8FAFC),
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Growth & Play',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF00BFA5),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Current Focus',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Balanced across developmental pillars with increased intake of green fibrous vegetables like steamed broccoli.',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        height: 1.45,
                        color: const Color(0xFF526668),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'New experiences tried',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Balanced across developmental pillars with increased intake of green fibrous vegetables like steamed broccoli.',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        height: 1.45,
                        color: const Color(0xFF526668),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CareInsightsEvolvingPreferencesBanner extends StatelessWidget {
  const CareInsightsEvolvingPreferencesBanner({
    super.key,
    required this.childName,
  });

  final String childName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFF004D54),
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                IconsaxPlusLinear.magicpen,
                size: 18.w,
                color: AppColors.whiteColor,
              ),
              SizedBox(width: 8.w),
              Text(
                LangKey.parentCare.evolvingPreferences,
                style: GlobalTextStyles.interTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'This week, $childName showed higher interest in sensory play, favoring meals with berries and newly introduced textures.',
            style: GlobalTextStyles.interTextStyle(
              fontSize: 13.sp,
              height: 1.4,
              color: const Color(0xFFD0E8EA),
            ),
          ),
        ],
      ),
    );
  }
}
