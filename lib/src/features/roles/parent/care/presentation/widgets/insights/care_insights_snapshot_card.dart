import 'package:alurei/src/imports/imports.dart';

class CareInsightsSnapshotCard extends StatelessWidget {
  const CareInsightsSnapshotCard({
    super.key,
    required this.childName,
    required this.trackedDays,
    required this.mealsLogged,
  });

  final String childName;
  final String trackedDays;
  final String mealsLogged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFF004D54),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$childName's Development Snapshot",
            style: GlobalTextStyles.interTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _MetricTile(
                  number: trackedDays,
                  label: LangKey.parentCare.trackedDays,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _MetricTile(
                  number: mealsLogged,
                  label: LangKey.parentCare.mealsLogged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({
    required this.number,
    required this.label,
  });

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: const Color(0xFF003D43),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF005E66)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 30.sp,
              fontWeight: FontWeight.w800,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 12.5.sp,
              color: const Color(0xFFB2D8DB),
            ),
          ),
        ],
      ),
    );
  }
}
