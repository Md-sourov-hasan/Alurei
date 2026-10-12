import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';

class CareModuleFilterTabs extends StatelessWidget {
  const CareModuleFilterTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    return Obx(() {
      final filters = controller.moduleFilters;
      final selected = controller.selectedModuleFilterIndex.value;

      return Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Baseline subtle divider line
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 1.h,
              color: const Color(0xFFE2ECEC),
            ),
          ),
          // Scrollable Tab Items Row
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(filters.length, (index) {
                final isSelected = selected == index;

                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: GestureDetector(
                    onTap: () => controller.selectModuleFilter(index),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Text(
                            filters[index],
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                              color: isSelected ? const Color(0xFF003D45) : const Color(0xFF334B4E),
                            ),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 3.h,
                          width: isSelected ? 110.w : 0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF004D54),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      );
    });
  }
}
