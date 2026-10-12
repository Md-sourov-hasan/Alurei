import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_activities_controller.dart';

class ActivitiesChildChips extends GetView<ParentActivitiesController> {
  const ActivitiesChildChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Obx(
        () {
          final selectedIndex = controller.selectedChildIndex.value;
          final labels = controller.childLabels;
          return Row(
            children: [
              for (var i = 0; i < labels.length; i++) ...[
                GestureDetector(
                  onTap: () => controller.selectChild(i),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: selectedIndex == i
                          ? AppColors.primaryColor
                          : const Color(0xFFE2F1F1),
                      borderRadius: BorderRadius.circular(9999.r),
                    ),
                    child: Center(
                      child: Text(
                        labels[i],
                        style: GlobalTextStyles.interTextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: selectedIndex == i
                              ? AppColors.whiteColor
                              : AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                if (i < labels.length - 1) SizedBox(width: 8.w),
              ],
            ],
          );
        },
      ),
    );
  }
}
