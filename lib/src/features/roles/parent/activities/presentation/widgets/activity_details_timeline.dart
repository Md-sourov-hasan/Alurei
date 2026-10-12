import 'package:alurei/src/imports/imports.dart';

class ActivityDetailsTimeline extends StatelessWidget {
  const ActivityDetailsTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = [
      (
        title: LangKey.parentActivities.level1Title.tr(),
        desc: LangKey.parentActivities.level1Desc.tr(),
      ),
      (
        title: LangKey.parentActivities.level2Title.tr(),
        desc: LangKey.parentActivities.level2Desc.tr(),
      ),
      (
        title: LangKey.parentActivities.level3Title.tr(),
        desc: LangKey.parentActivities.level3Desc.tr(),
      ),
      (
        title: LangKey.parentActivities.level4Title.tr(),
        desc: LangKey.parentActivities.level4Desc.tr(),
      ),
    ];

    return Column(
      children: List.generate(
        levels.length,
        (index) {
          final isLast = index == levels.length - 1;
          final item = levels[index];

          return IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Timeline vertical dot & connecting line column
                SizedBox(
                  width: 20.w,
                  child: Column(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF004D54),
                          shape: BoxShape.circle,
                        ),
                      ),
                      if (!isLast)
                        Expanded(
                          child: Container(
                            width: 2.w,
                            color: const Color(0xFF004D54).withValues(alpha: 0.3),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 12.w),

                // Content block
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F2F2),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            item.title,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF004D54),
                            ),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          item.desc,
                          style: GlobalTextStyles.interTextStyle(
                            fontSize: 13.sp,
                            height: 1.4,
                            color: const Color(0xFF334A4D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
