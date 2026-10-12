import 'package:alurei/src/imports/imports.dart';

import '../../controllers/ai_setup_guide_controller.dart';
import 'ai_setup_form_widgets.dart';

class AiSetupActivityPreviewList extends StatelessWidget {
  const AiSetupActivityPreviewList({
    super.key,
    required this.activities,
    required this.onDelete,
  });

  final List<AiSetupRecurringActivity> activities;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    if (activities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: activities
          .map(
            (activity) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: AiSetupActivityPreviewTile(
                activity: activity,
                onDelete: () => onDelete(activity.id),
              ),
            ),
          )
          .toList(growable: false),
    );
  }
}

class AiSetupActivityPreviewTile extends StatelessWidget {
  const AiSetupActivityPreviewTile({
    super.key,
    required this.activity,
    required this.onDelete,
  });

  final AiSetupRecurringActivity activity;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: context.appColors.primaryBackground,
        border: Border.all(color: AppColors.brandTealBorder),
        borderRadius: AppBorders.lg,
      ),
      child: Row(
        children: [
          Container(
            width: 34.w,
            height: 34.w,
            decoration: const BoxDecoration(
              color: AppColors.brandTealLight,
              borderRadius: AppBorders.md,
            ),
            child: Icon(
              IconsaxPlusLinear.book_1,
              size: 18.sp,
              color: context.colors.primary,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 12.sp,
                    height: 18 / 12,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.primaryText,
                  ),
                ),
                Text(
                  '${formatAiSetupTimeOfDay(context, activity.startTime)} - '
                  '${formatAiSetupTimeOfDay(context, activity.endTime)} - '
                  '${activity.days.join(', ')}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 11.sp,
                    height: 16 / 11,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.mutedText,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: Icon(
              IconsaxPlusLinear.trash,
              size: 18.sp,
              color: context.appColors.mutedText,
            ),
          ),
        ],
      ),
    );
  }
}
