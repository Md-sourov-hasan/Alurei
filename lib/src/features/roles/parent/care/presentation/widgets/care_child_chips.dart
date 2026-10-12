import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';

class CareChildChips extends StatelessWidget {
  const CareChildChips({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: Obx(() {
            final selectedIndex = controller.selectedChildIndex.value;
            final childrenData = controller.childrenList;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(childrenData.length, (i) {
                  final isSelected = selectedIndex == i;
                  final item = childrenData[i];

                  return Padding(
                    padding: EdgeInsets.only(right: 20.w),
                    child: GestureDetector(
                      onTap: () => controller.selectChild(i),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 54.w,
                            height: 54.w,
                            padding: EdgeInsets.all(2.5.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF004D54)
                                    : const Color(0xFFDCE4E4),
                                width: isSelected ? 2.5 : 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(27.r),
                              child: CommonImage(
                                imageUrl: item['avatar'] ?? '',
                                fit: BoxFit.cover,
                                errorWidget: Image.asset(
                                  AppAssets.monicaChild1,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            item['name'] ?? '',
                            style: GlobalTextStyles.interTextStyle(
                              fontSize: 14.sp,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                              color: isSelected
                                  ? const Color(0xFF004D54)
                                  : const Color(0xFF7A8E90),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
        Container(
          height: 1.h,
          width: double.infinity,
          color: const Color(0xFFE0E8E8),
        ),
      ],
    );
  }
}
