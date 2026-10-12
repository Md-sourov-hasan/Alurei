import 'package:alurei/src/imports/imports.dart';

class ForYouAskAlurei extends StatelessWidget {
  const ForYouAskAlurei({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF144D53), // Dark teal background
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background decorative icon (right side)
          Positioned(
            right: -10.w,
            top: -20.h,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                AppAssets.parentTodayAiAssistant,
                width: 100.w,
                height: 100.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    AppAssets.parentTodayAiAssistant,
                    width: 52.w,
                    height: 52.w,
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: Text(
                        '${LangKey.parentCare.askAlurei} (Recommended questions)',
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _buildQuestionPill('"My child refuses naps. What should I do?"'),
              SizedBox(height: 12.h),
              _buildQuestionPill('"How can I encourage my child to eat vegetables?"'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionPill(String question) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1.w,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        question,
        style: GlobalTextStyles.interTextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
