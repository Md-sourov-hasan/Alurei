import 'package:alurei/src/imports/imports.dart';
import '../controllers/base_kitchen_controller.dart';

class KitchenFilterChips extends GetView<BaseKitchenController> {
  const KitchenFilterChips({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.h,
      child: Obx(
        () {
          final selectedIndex = controller.selectedFilterIndex.value;
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: controller.filterCount,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, i) {
              final isSelected = selectedIndex == i;
              final label = controller.filterLabel(i);
              return GestureDetector(
                onTap: () => controller.selectFilter(i),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primaryColor
                        : context.appColors.bottomNavSelectedBackground,
                    borderRadius: BorderRadius.circular(9999.r),
                  ),
                  child: Text(
                    label,
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor,
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
