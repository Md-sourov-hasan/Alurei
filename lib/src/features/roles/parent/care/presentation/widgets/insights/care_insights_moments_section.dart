import 'package:alurei/src/imports/imports.dart';

class CareInsightsMomentsSection extends StatelessWidget {
  const CareInsightsMomentsSection({
    super.key,
    required this.moments,
  });

  final List<Map<String, dynamic>> moments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.parentCare.momentsAndConnection,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF003D45),
          ),
        ),
        SizedBox(height: 16.h),
        Column(
          children: List.generate(moments.length, (index) {
            final m = moments[index];
            final dayStr = m['day'] as String;
            final textStr = m['text'] as String;
            final iconData = (m['icon'] as IconData?) ?? _getIconForDay(dayStr);

            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: const BoxDecoration(
                        color: Color(0xFF004D54),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          iconData,
                          size: 16.w,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 18.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dayStr,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF003D45),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            textStr,
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 13.5.sp,
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
            );
          }),
        ),
      ],
    );
  }

  IconData _getIconForDay(String day) {
    switch (day) {
      case 'Monday':
        return IconsaxPlusBold.tree;
      case 'Wednesday':
        return IconsaxPlusBold.brush_1;
      case 'Thursday':
        return IconsaxPlusBold.reserve;
      case 'Saturday':
      case 'Sunday':
      default:
        return IconsaxPlusBold.magicpen;
    }
  }
}
