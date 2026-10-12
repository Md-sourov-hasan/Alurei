import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_activities_controller.dart';
import 'activities_child_chips.dart';
import 'activities_suggested_card.dart';

class ActivitiesSuggestedSection extends GetView<ParentActivitiesController> {
  const ActivitiesSuggestedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            LangKey.parentActivities.suggestedForYou,
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const ActivitiesChildChips(),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 280.h,
          child: Obx(
            () {
              final list = controller.suggestedList;
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: list.length,
                separatorBuilder: (_, __) => SizedBox(width: 14.w),
                itemBuilder: (context, i) {
                  final item = list[i];
                  return ActivitiesSuggestedCard(
                    item: item,
                    onAddSchedule: () => controller.addToSchedule(item),
                    onViewActivity: () => controller.viewActivity(item),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
