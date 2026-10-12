import 'package:alurei/src/features/roles/parent/care/domain/entities/care_module_item.dart';
import 'package:alurei/src/imports/imports.dart';

class ParentCareController extends GetxController {
  final notificationCount = 1.obs;
  final messageCount = 1.obs;
  final searchQuery = ''.obs;

  final selectedHubIndex = 0.obs;
  final selectedModuleFilterIndex = 0.obs;
  final selectedTopicIndex = 0.obs;
  final selectedChildIndex = 0.obs;

  final suggestedList = <CareModuleItem>[].obs;
  final allList = <CareModuleItem>[].obs;
  final inProgressList = <CareModuleItem>[].obs;
  final completedList = <CareModuleItem>[].obs;
  final savedList = <CareModuleItem>[].obs;

  List<String> get hubTabs => [
        LangKey.parentCare.caregivingHub,
        LangKey.parentCare.insights,
        LangKey.parentCare.forYou,
      ];

  List<String> get moduleFilters => [
        'parent_care.all_modules_count'.tr(args: ['${filteredAllList.length}']),
        'parent_care.in_progress_count'
            .tr(args: ['${filteredInProgressList.length}']),
        'parent_care.completed_count'
            .tr(args: ['${filteredCompletedList.length}']),
        'parent_care.saved_count'.tr(args: ['${filteredSavedList.length}']),
      ];

  final topicsList = <Map<String, String>>[
    {'id': 'ALL', 'label': 'All Topics'},
    {'id': 'CHILD_SAFETY', 'label': 'Child Safety'},
    {'id': 'NUTRITION_FEEDING', 'label': 'Nutrition & Feeding'},
    {'id': 'SLEEP_ROUTINES', 'label': 'Sleep & Routines'},
    {'id': 'CHILD_DEVELOPMENT', 'label': 'Child Development'},
    {'id': 'FIRST_AID', 'label': 'First Aid'},
    {'id': 'PLAY_LEARNING', 'label': 'Play & Learning'},
    {'id': 'COMMUNICATION', 'label': 'Communication'},
    {'id': 'HEALTH_HYGIENE', 'label': 'Health & Hygiene'},
    {'id': 'OTHER', 'label': 'Other'},
  ].obs;

  List<String> get topicLabels => topicsList.map((e) => e['label']!).toList();

  final childrenRawList = <Map<String, dynamic>>[].obs;
  final childrenList = <Map<String, String>>[].obs;

  List<String> get childLabels => childrenList.map((e) => e['name']!).toList();

  String get selectedChildId => selectedChildIndex.value < childrenList.length
      ? childrenList[selectedChildIndex.value]['id']!
      : '';

  String get currentChildName => selectedChildIndex.value < childrenList.length
      ? childrenList[selectedChildIndex.value]['name']!
      : '';

  final selectedNannyUserId = ''.obs;

  String get currentNannyUserId => selectedNannyUserId.value;

  void setNannyUserId(String nannyId) {
    selectedNannyUserId.value = nannyId;
  }

  String get selectedTopicId => selectedTopicIndex.value < topicsList.length
      ? topicsList[selectedTopicIndex.value]['id']!
      : 'ALL';

  List<CareModuleItem> filterByTopic(List<CareModuleItem> list) {
    final topicId = selectedTopicId;
    final nannyId = currentNannyUserId;
    final query = searchQuery.value.trim().toLowerCase();

    return list.where((item) {
      final matchesNanny = nannyId.isEmpty ||
          item.nannyUserId.isEmpty ||
          item.nannyUserId == nannyId;
      final matchesTopic = topicId == 'ALL' || item.category == topicId;
      final matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);
      return matchesNanny && matchesTopic && matchesSearch;
    }).toList();
  }

  List<CareModuleItem> get filteredSuggestedList {
    final query = searchQuery.value.trim().toLowerCase();
    if (query.isEmpty) return suggestedList;
    return suggestedList
        .where((item) =>
            item.title.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query))
        .toList();
  }

  List<CareModuleItem> get filteredAllList => filterByTopic(allList);
  List<CareModuleItem> get filteredInProgressList =>
      filterByTopic(inProgressList);
  List<CareModuleItem> get filteredCompletedList =>
      filterByTopic(completedList);
  List<CareModuleItem> get filteredSavedList => filterByTopic(savedList);

  final isLoading = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initCareData();
  }

  Future<void> initCareData() async {
    await fetchChildren();
    await fetchCareHome();
    await fetchSuggestedCareModules();
  }

  Future<void> fetchChildren() async {
    final result = await CareService.instance.getChildren();
    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch children: ${failure.message}');
        childrenRawList.clear();
        childrenList.clear();
      },
      (fetchedChildren) {
        if (fetchedChildren.isNotEmpty) {
          childrenRawList.assignAll(fetchedChildren);
          final mapped = fetchedChildren.map((c) {
            return {
              'id': c['id']?.toString() ?? '',
              'name': c['name']?.toString() ?? '',
              'avatar': c['avatar']?.toString() ??
                  c['profilePictureUrl']?.toString() ??
                  '',
            };
          }).toList();
          childrenList.assignAll(mapped);
          _updateNannyUserIdForCurrentChild();
        } else {
          childrenRawList.clear();
          childrenList.clear();
        }
      },
    );
  }

  void _updateNannyUserIdForCurrentChild() {
    if (selectedChildIndex.value < childrenRawList.length) {
      final childObj = childrenRawList[selectedChildIndex.value];
      selectedNannyUserId.value = _extractNannyUserId(childObj);
    } else {
      selectedNannyUserId.value = '';
    }
  }

  String _extractNannyUserId(Map<String, dynamic> childObj) {
    if (childObj['caregiverAccesses'] is List) {
      final list = childObj['caregiverAccesses'] as List;
      for (final c in list) {
        if (c is Map) {
          final id = c['id']?.toString();
          if (id != null && id.isNotEmpty) {
            return id;
          }
        }
      }
    }
    if (childObj['assignedUsers'] is List) {
      final list = childObj['assignedUsers'] as List;
      for (final u in list) {
        if (u is Map) {
          final accessId = u['accessId']?.toString();
          if (accessId != null && accessId.isNotEmpty) {
            return accessId;
          }
          final userId = u['userId']?.toString();
          if (userId != null && userId.isNotEmpty) {
            return userId;
          }
        }
      }
    }
    return '';
  }

  Future<void> fetchCareHome() async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await CareService.instance.getCareHome(
      tab: 'ALL',
      topicId: selectedTopicId,
      childId: selectedChildId,
      nannyUserId: selectedNannyUserId.value,
    );
    isLoading.value = false;

    result.fold(
      (failure) {
        AppLogger.error('Failed to fetch care home: ${failure.message}');
        errorMessage.value = failure.message;
        _populateModules([]);
      },
      (dataMap) {
        if (dataMap['modules'] is List) {
          final rawModules = (dataMap['modules'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) =>
                  CareModuleItem.fromJson(item.cast<String, dynamic>()))
              .toList();
          _populateModules(rawModules);
        } else {
          _populateModules([]);
        }
      },
    );
  }

  Future<void> fetchSuggestedCareModules() async {
    final childId = selectedChildId;
    if (childId.isEmpty) {
      suggestedList.clear();
      return;
    }

    AppLogger.info(
      '🚀 [ParentCareController] Fetching suggested modules API for childId=$childId, '
      'nannyUserId=${selectedNannyUserId.value}',
    );

    final result = await CareService.instance.getSuggestedCareModules(
      childId,
      nannyUserId: selectedNannyUserId.value,
    );

    result.fold(
      (failure) {
        AppLogger.error(
            'Failed to fetch suggested care modules: ${failure.message}');
        suggestedList.clear();
      },
      (modules) {
        AppLogger.info(
          '✨ [ParentCareController] Received ${modules.length} suggested care modules for childId=$childId',
        );
        suggestedList.assignAll(modules);
      },
    );
  }

  Future<void> fetchCareModules() async {
    await fetchCareHome();
    await fetchSuggestedCareModules();
  }

  void _populateModules(List<CareModuleItem> modules) {
    allList.assignAll(modules);
    inProgressList.assignAll(
      modules.where((m) => m.status.toLowerCase() == 'in_progress').toList(),
    );
    completedList.assignAll(
      modules.where((m) => m.status.toLowerCase() == 'completed').toList(),
    );
    savedList.assignAll(
      modules.where((m) => m.isBookmarked).toList(),
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

  void selectHubTab(int index) {
    selectedHubIndex.value = index;
  }

  void selectModuleFilter(int index) {
    selectedModuleFilterIndex.value = index;
  }

  void selectTopic(int index) {
    selectedTopicIndex.value = index;
    fetchCareHome();
  }

  void selectChild(int index) {
    selectedChildIndex.value = index;
    _updateNannyUserIdForCurrentChild();
    fetchCareHome();
    fetchSuggestedCareModules();
  }

  Future<void> addToWeek(CareModuleItem item) async {
    final targetChildId =
        item.childId.isNotEmpty ? item.childId : selectedChildId;
    final targetNannyId =
        item.nannyUserId.isNotEmpty ? item.nannyUserId : currentNannyUserId;

    if (targetChildId.isEmpty) {
      showGlobalToast(message: 'Please select a child first');
      return;
    }

    final result = await CareService.instance.assignCareModule(
      moduleId: item.id,
      childId: targetChildId,
      nannyUserId: targetNannyId,
    );

    result.fold(
      (failure) {
        showGlobalToast(message: failure.message);
      },
      (assignment) {
        final updatedItem = item.copyWith(
          status: 'in_progress',
          progressPercentage: 0.0,
          progressText: '0% Complete',
        );

        final indexInAll = allList.indexWhere((e) => e.id == item.id);
        if (indexInAll != -1) {
          allList[indexInAll] = updatedItem;
        }
        if (!inProgressList.any((e) => e.id == item.id)) {
          inProgressList.add(updatedItem);
        }

        showGlobalToast(
          message: '${item.title} ${LangKey.parentCare.addedToWeek}',
        );
      },
    );
  }

  void visitModule(CareModuleItem item) {
    Get.toNamed(
      AppRoutes.parentCareModuleDetails,
      arguments: item,
    );
  }

  Future<void> toggleBookmark(CareModuleItem item) async {
    final bool newBookmarkStatus = !item.isBookmarked;

    final targetChildId = item.childId.isNotEmpty
        ? item.childId
        : selectedChildId;

    final result = newBookmarkStatus
        ? await CareService.instance.saveCareModule(
            item.id,
            childId: targetChildId.isNotEmpty ? targetChildId : null,
          )
        : await CareService.instance.unsaveCareModule(
            item.id,
            childId: targetChildId.isNotEmpty ? targetChildId : null,
          );

    result.fold(
      (failure) {
        showGlobalToast(message: failure.message);
      },
      (resMap) {
        final index = suggestedList.indexWhere((e) => e.id == item.id);
        if (index != -1) {
          suggestedList[index] =
              suggestedList[index].copyWith(isBookmarked: newBookmarkStatus);
        }
        final allIndex = allList.indexWhere((e) => e.id == item.id);
        if (allIndex != -1) {
          allList[allIndex] =
              allList[allIndex].copyWith(isBookmarked: newBookmarkStatus);
        }
        final inpIndex = inProgressList.indexWhere((e) => e.id == item.id);
        if (inpIndex != -1) {
          inProgressList[inpIndex] = inProgressList[inpIndex]
              .copyWith(isBookmarked: newBookmarkStatus);
        }
        final compIndex = completedList.indexWhere((e) => e.id == item.id);
        if (compIndex != -1) {
          completedList[compIndex] = completedList[compIndex]
              .copyWith(isBookmarked: newBookmarkStatus);
        }

        savedList.assignAll(allList.where((e) => e.isBookmarked).toList());

        final message = resMap['message'] as String? ??
            (newBookmarkStatus
                ? 'Care module saved successfully'
                : 'Care module removed from saved list');
        showGlobalToast(message: message);
      },
    );
  }
}
