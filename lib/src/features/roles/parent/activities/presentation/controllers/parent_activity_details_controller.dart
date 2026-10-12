import 'package:alurei/src/imports/imports.dart';
import '../../domain/entities/activity_item.dart';

class ParentActivityDetailsController extends GetxController {
  final activityItem = Rxn<ActivityItem>();

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments is ActivityItem) {
      activityItem.value = Get.arguments as ActivityItem;
    } else {
      activityItem.value = ParentActivitiesDummyData.suggestedActivities.first;
    }
  }

  void onAddSchedule() {
    showGlobalToast(
      message: LangKey.parentActivities.addedToSchedule,
    );
  }

  void onBack() {
    Get.back<void>();
  }
}
