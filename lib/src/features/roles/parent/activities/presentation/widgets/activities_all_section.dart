import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_activities_controller.dart';
import 'activities_item_card.dart';

class ActivitiesAllSection extends GetView<ParentActivitiesController> {
  const ActivitiesAllSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangKey.parentActivities.allActivities,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 14.h),
          Obx(
            () {
              if (controller.isLoading.value && controller.allList.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: const CircularProgressIndicator(),
                  ),
                );
              }
              final list = controller.filteredAllList;
              if (list.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.h),
                    child: Text(
                      'No activities found',
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 14.sp,
                        color: AppColors.brandGrayHint,
                      ),
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  for (var i = 0; i < list.length; i++) ...[
                    ActivitiesItemCard(
                      item: list[i],
                      onAddSchedule: () => controller.addToSchedule(list[i]),
                      onViewActivity: () => controller.viewActivity(list[i]),
                    ),
                    if (i < list.length - 1) SizedBox(height: 16.h),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
