import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';

class CareTopicChips extends StatelessWidget {
  const CareTopicChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    return Obx(() {
      final topics = controller.topicLabels;
      final selected = controller.selectedTopicIndex.value;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(topics.length, (index) {
            final isSelected = selected == index;

            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: GestureDetector(
                onTap: () => controller.selectTopic(index),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.secondaryTeal : AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(14.r),
                    boxShadow: [
                      if (!isSelected)
                        BoxShadow(
                          color: AppColors.blackColor.withValues(alpha: 0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Text(
                    topics[index],
                    style: GlobalTextStyles.interTextStyle(
                      fontSize: 13.5.sp,
                      fontWeight: FontWeight.w700,
                      color: isSelected ? AppColors.whiteColor : const Color(0xFF004D54),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }
}
