import 'package:alurei/src/imports/imports.dart';

class CareInsightsConsistencyCard extends StatelessWidget {
  const CareInsightsConsistencyCard({
    super.key,
    this.scorePercentage = 95,
  });

  final int scorePercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 140.w,
            height: 140.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 140.w,
                  height: 140.w,
                  child: CircularProgressIndicator(
                    value: scorePercentage / 100.0,
                    strokeWidth: 12.w,
                    backgroundColor: const Color(0xFFE5EFEF),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF079455), // Darker green from image
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$scorePercentage%',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF079455),
                      ),
                    ),
                    Text(
                      'SCORE',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF475467),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(height: 12.h),
          Text(
            LangKey.parentCare.careConsistency,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF101828),
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'This score is based on your activity,\nengagement, and the quality of care\nprovided to your child through Alurei.',
            textAlign: TextAlign.center,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 14.sp,
              height: 1.5,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF475467),
            ),
          ),
        ],
      ),
    );
  }
}
