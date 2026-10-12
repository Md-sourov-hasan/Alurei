import 'package:alurei/src/imports/imports.dart';

class ForYouActivityIdeas extends StatelessWidget {
  const ForYouActivityIdeas({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LangKey.parentCare.familyActivityIdeas,
          style: GlobalTextStyles.interTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF7F8F9),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              _buildActivityItem(
                title: 'Drawing & Colouring',
                subtitle: 'Children co-create a shared imagi.........',
              ),
              _buildDivider(),
              _buildActivityItem(
                title: 'Colour Hunt Discovery',
                subtitle: 'Children co-create a shared imagi.........',
              ),
              _buildDivider(),
              _buildActivityItem(
                title: 'Story Time',
                subtitle: 'Children co-create a shared imagi.........',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h),
      height: 1.h,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildActivityItem({
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.secondaryTeal,
              width: 1.5.w,
            ),
          ),
          child: CircleAvatar(
            radius: 20.w,
            backgroundImage: const AssetImage(AppAssets.activityPlayground),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Icon(
          IconsaxPlusLinear.arrow_right_3,
          size: 18.w,
          color: const Color(0xFF64748B),
        ),
      ],
    );
  }
}
