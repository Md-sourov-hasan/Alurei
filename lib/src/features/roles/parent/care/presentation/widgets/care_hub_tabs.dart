import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';

class CareHubTabs extends StatelessWidget {
  const CareHubTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    return Container(
      width: double.infinity,
      color: const Color(0xFFEDF4F4),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
      child: Obx(() {
        final tabs = controller.hubTabs;
        final selected = controller.selectedHubIndex.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(tabs.length, (index) {
            final isSelected = selected == index;

            return GestureDetector(
              onTap: () => controller.selectHubTab(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF004D54) : Colors.transparent,
                  borderRadius: BorderRadius.circular(9999.r),
                ),
                child: Text(
                  tabs[index],
                  style: GlobalTextStyles.interTextStyle(
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w700,
                    color: isSelected ? AppColors.whiteColor : const Color(0xFF1C2E30),
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
