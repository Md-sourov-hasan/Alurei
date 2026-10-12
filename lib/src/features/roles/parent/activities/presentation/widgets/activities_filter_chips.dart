import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_activities_controller.dart';

class ActivitiesFilterChips extends GetView<ParentActivitiesController> {
  const ActivitiesFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36.h,
      child: Obx(
        () {
          final selectedIndex = controller.selectedFilterIndex.value;
          final labels = controller.filterLabels;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: labels.length,
            separatorBuilder: (_, __) => SizedBox(width: 8.w),
            itemBuilder: (context, i) {
              final isSelected = selectedIndex == i;
              final label = labels[i];
              return GestureDetector(
                onTap: () => controller.selectFilter(i),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : context.appColors.bottomNavBackground,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.brandTealBorder,
                    ),
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GlobalTextStyles.interTextStyle(
                        fontSize: 13.sp,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.whiteColor
                            : AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
