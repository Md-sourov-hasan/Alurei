import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';

class ParentTodayController extends GetxController {
  ParentTodayController(this._repository);

  final ParentTodayRepository _repository;

  final data = Rxn<ParentTodayData>();
  final isLoading = true.obs;
  final errorMessage = RxnString();
  final selectedChildId = RxnString();
  final selectedBottomIndex = 0.obs;
  final isAiMenuOpen = false.obs;
  final timelineItems = <ParentRoutineItem>[].obs;
  final isTimelineLoading = false.obs;
  final timelineErrorMessage = RxnString();
  final completedRoutineIds = <String>{}.obs;
  final notificationCount = 0.obs;
  final messageCount = 0.obs;

  List<ParentRoutineItem> get selectedRoutine => timelineItems;

  @override
  void onInit() {
    super.onInit();
    loadToday();
  }

  Future<void> loadToday() async {
    final previousSelectedChildId = selectedChildId.value;
    isLoading.value = true;
    errorMessage.value = null;
    final result = await _repository.loadToday();
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (value) {
        final nextValue = _withGeneratedChild(value);
        data.value = nextValue;
        notificationCount.value = value.notificationCount;
        messageCount.value = value.messageCount;
        final selectedChildStillExists = nextValue.children.any(
          (child) => child.id == previousSelectedChildId,
        );
        selectedChildId.value = selectedChildStillExists
            ? previousSelectedChildId
            : nextValue.children.firstOrNull?.id;
        final childId = selectedChildId.value;
        if (childId != null && childId.isNotEmpty) {
          loadDailyTimeline(childId);
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> loadDailyTimeline([String? childId]) async {
    final id = childId ?? selectedChildId.value;
    if (id == null || id.isEmpty || id == 'generated-child') {
      timelineItems.clear();
      timelineErrorMessage.value = null;
      return;
    }

    isTimelineLoading.value = true;
    timelineErrorMessage.value = null;
    final result = await _repository.loadDailyTimeline(id);
    if (selectedChildId.value != id) return;
    result.fold(
      (failure) {
        timelineItems.clear();
        timelineErrorMessage.value = failure.message;
      },
      (items) {
        timelineItems.assignAll(items);
        completedRoutineIds.clear();
      },
    );
    isTimelineLoading.value = false;
  }

  set selectedChild(String id) {
    if (selectedChildId.value == id) {
      openChildProfile(id);
      return;
    }
    selectedChildId.value = id;
    loadDailyTimeline(id);
  }

  Future<void> openChildProfile(String id) async {
    final today = data.value;
    final selectedChild = today?.children.firstWhereOrNull(
      (child) => child.id == id,
    );
    final shouldRefresh = await Get.toNamed<dynamic>(
      AppRoutes.todaysChildProfile,
      arguments: {
        'child_id': id,
        'id': id,
        'name': selectedChild?.name ?? '',
        'avatar': selectedChild?.avatarAsset,
        'hasAllergy': selectedChild?.hasAllergy ?? false,
      },
    );
    if (shouldRefresh == true) {
      await loadToday();
    }
  }

  void openBuildDayForSelectedChild() {
    final today = data.value;
    final selectedChild = today?.children.firstWhereOrNull(
      (child) => child.id == selectedChildId.value,
    );
    final childId = selectedChild?.id ?? selectedChildId.value;
    if (childId == null || childId.isEmpty) {
      openChildSetupGuide();
      return;
    }
    Get.toNamed<void>(
      AppRoutes.buildDayFromLibrary,
      arguments: {
        'child_id': childId,
        'child_name': selectedChild?.name ?? '',
        'child': {
          'id': childId,
          'name': selectedChild?.name ?? '',
          'avatar': selectedChild?.avatarAsset,
          'hasAllergy': selectedChild?.hasAllergy ?? false,
        },
      },
    );
  }

  Future<void> addChild() async {
    final result = await _repository.addChild();
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (child) {
        final current = data.value;
        if (current == null) return;
        data.value = current.copyWith(children: [...current.children, child]);
        selectedChildId.value = child.id;
      },
    );
  }

  void openChildSetupGuide() => Get.toNamed<void>(AppRoutes.childSetupGuide);

  void handleRoutinePressed(String id) {
    final routine = selectedRoutine.firstWhereOrNull((item) => item.id == id);
    if (routine?.kind == ParentRoutineKind.story) {
      openBedtimeStory();
      return;
    }
    toggleRoutineCompletion(id);
  }

  void toggleRoutineCompletion(String id) {
    completedRoutineIds.contains(id)
        ? completedRoutineIds.remove(id)
        : completedRoutineIds.add(id);
  }

  void openBedtimeStory() {
    final today = data.value;
    final selectedChild = today?.children.firstWhereOrNull(
      (child) => child.id == selectedChildId.value,
    );
    Get.toNamed<void>(
      AppRoutes.bedtimeStory,
      arguments: {
        'child_id': selectedChild?.id ?? 'child-eve',
        'child_name': selectedChild?.name ?? 'Eve',
      },
    );
  }

  set bottomDestination(int index) => selectedBottomIndex.value = index;

  void toggleAiMenu() => isAiMenuOpen.toggle();

  void openParentAi() => Get.toNamed<void>(AppRoutes.parentAi);

  void openNotifications() {
    notificationCount.value = 0;
    Get.toNamed<void>(AppRoutes.parentNotification);
  }

  void openMessages() {
    messageCount.value = 0;
    Get.toNamed<void>(AppRoutes.parentMessage);
  }

  ParentTodayData _withGeneratedChild(ParentTodayData value) {
    final arguments = Get.arguments;
    if (arguments is! Map) return value;
    final generatedName = arguments['generated_child_name'];
    if (generatedName is! String || generatedName.trim().isEmpty) {
      return value;
    }
    final existing =
        value.children.any((child) => child.id == 'generated-child');
    if (existing) return value;
    return value.copyWith(
      children: [
        ParentTodayChild(
          id: 'generated-child',
          name: generatedName.trim(),
          hasAllergy: false,
        ),
        ...value.children,
      ],
    );
  }
}
