import 'package:alurei/src/imports/imports.dart';
import '../bindings/parent_activity_details_binding.dart';
import '../screens/parent_activity_details_screen.dart';
import '../../domain/entities/activity_item.dart';

class ParentActivitiesController extends GetxController {
  final notificationCount = 1.obs;
  final messageCount = 1.obs;
  final searchQuery = ''.obs;
  final showFilters = true.obs;
  final isLoading = false.obs;

  final selectedFilterIndex = 0.obs;
  final selectedChildIndex = 0.obs;
  final isAiMenuOpen = false.obs;

  void toggleAiMenu() {
    isAiMenuOpen.toggle();
  }

  final suggestedList = <ActivityItem>[].obs;
  final allList = <ActivityItem>[].obs;

  List<ActivityItem> get filteredAllList {
    var result = allList.toList();

    if (searchQuery.value.trim().isNotEmpty) {
      final q = searchQuery.value.trim().toLowerCase();
      result = result
          .where((item) =>
              item.title.toLowerCase().contains(q) ||
              item.description.toLowerCase().contains(q))
          .toList();
    }

    final filterIndex = selectedFilterIndex.value;
    if (filterIndex == 1) {
      // Indoor
      result = result
          .where((item) => item.category.toUpperCase().contains('INDOOR'))
          .toList();
    } else if (filterIndex == 2) {
      // Outdoor
      result = result
          .where((item) => item.category.toUpperCase().contains('OUTDOOR'))
          .toList();
    }
    return result;
  }

  List<String> get filterLabels => [
        LangKey.parentActivities.filterAll,
        LangKey.parentActivities.filterIndoor,
        LangKey.parentActivities.filterOutdoor,
        LangKey.parentActivities.filter012Months,
        LangKey.parentActivities.filter1224Months,
      ];

  List<String> get childLabels => [
        LangKey.parentActivities.childEve,
        LangKey.parentActivities.childRose,
      ];

  @override
  void onInit() {
    super.onInit();
    suggestedList.assignAll(ParentActivitiesDummyData.suggestedActivities);
    allList.assignAll(ParentActivitiesDummyData.allActivities);
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    isLoading.value = true;
    final result = await LibraryService.instance.getActivities(page: 1, limit: 20);
    isLoading.value = false;
    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch activities: ${failure.message}');
      },
      (activities) {
        if (activities.isNotEmpty) {
          allList.assignAll(activities);
        }
      },
    );
  }

  void openNotifications() {
    showGlobalToast(message: LangKey.shared.notificationsTapped);
  }

  void openMessages() {
    showGlobalToast(message: LangKey.shared.messagesTapped);
  }

  void updateSearch(String query) {
    searchQuery.value = query;
  }

  void toggleFilters() {
    showFilters.toggle();
  }

  void selectFilter(int index) {
    selectedFilterIndex.value = index;
  }

  void selectChild(int index) {
    selectedChildIndex.value = index;
  }

  void addToSchedule(ActivityItem item) {
    showGlobalToast(message: '${item.title} added to schedule');
  }

  void viewActivity(ActivityItem item) {
    Get.to<dynamic>(
      () => const ParentActivityDetailsScreen(),
      binding: ParentActivityDetailsBinding(),
      arguments: item,
    );
  }
}
