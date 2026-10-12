import 'package:alurei/src/imports/imports.dart';
import '../controllers/parent_care_controller.dart';
import 'care_module_card.dart';

class CareSuggestedSection extends StatelessWidget {
  const CareSuggestedSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ParentCareController>()
        ? Get.find<ParentCareController>()
        : Get.put(ParentCareController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Text(
            LangKey.parentCare.suggestedForChild.tr(
              args: [controller.currentChildName],
            ),
            style: GlobalTextStyles.interTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF003D45),
            ),
          );
        }),
        SizedBox(height: 14.h),
        Obx(() {
          final list = controller.filteredSuggestedList;
          return Column(
            children: List.generate(list.length, (i) {
              final item = list[i];
              return Padding(
                padding: EdgeInsets.only(bottom: i < list.length - 1 ? 14.h : 0),
                child: CareModuleCard(
                  item: item,
                  onAddToWeek: () => controller.addToWeek(item),
                  onVisitModule: () => controller.visitModule(item),
                  onBookmark: () => controller.toggleBookmark(item),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
