import 'package:alurei/src/imports/imports.dart';

class ActivityDetailsStepsList extends StatelessWidget {
  const ActivityDetailsStepsList({super.key});

  @override
  Widget build(BuildContext context) {
    final steps = [
      LangKey.parentActivities.step1.tr(),
      LangKey.parentActivities.step2.tr(),
      LangKey.parentActivities.step3.tr(),
      LangKey.parentActivities.step4.tr(),
      LangKey.parentActivities.step5.tr(),
      LangKey.parentActivities.step6.tr(),
      LangKey.parentActivities.step7.tr(),
      LangKey.parentActivities.step8.tr(),
    ];

    return Column(
      children: List.generate(
        steps.length,
        (index) => Padding(
          padding: EdgeInsets.only(bottom: 14.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: const BoxDecoration(
                  color: Color(0xFF004D54),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${index + 1}',
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    steps[index],
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.sp,
                      height: 1.4,
                      color: const Color(0xFF2C3E40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
