import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/activity_item.dart';

class ActivityDetailsMetricsGrid extends StatelessWidget {
  const ActivityDetailsMetricsGrid({
    super.key,
    required this.item,
  });

  final ActivityItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: LangKey.parentActivities.metricAge,
                value: item.ageTag,
                svgPath: AppAssets.icBaby,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricTile(
                title: LangKey.parentActivities.metricDuration,
                value: '15-30 min',
                svgPath: AppAssets.icDuration,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildMetricTile(
                title: LangKey.parentActivities.metricEnergy,
                value: 'Med-High',
                icon: IconsaxPlusLinear.flash_1,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildMetricTile(
                title: LangKey.parentActivities.metricLocation,
                value: item.category.isNotEmpty
                    ? '${item.category} / Group'
                    : 'Indoor / Outdoor / Group',
                icon: IconsaxPlusLinear.location,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricTile({
    required String title,
    required String value,
    IconData? icon,
    String? svgPath,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEDF4F4),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          if (svgPath != null)
            SvgPicture.asset(
              svgPath,
              width: 20.w,
              height: 20.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF004D54),
                BlendMode.srcIn,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              size: 20.w,
              color: const Color(0xFF004D54),
            ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF6C7E80),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  value,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF003D45),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
