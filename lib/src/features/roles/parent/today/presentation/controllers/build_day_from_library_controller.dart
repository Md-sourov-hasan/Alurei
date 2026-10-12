import 'package:alurei/src/imports/imports.dart';

class BuildDayScheduleItem {
  BuildDayScheduleItem({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.title,
    required this.description,
    this.libraryItemId,
    this.libraryItemType,
    this.mode,
    this.category,
    this.date,
    this.scheduledDate,
  });

  final String id;
  final String startTime;
  final String endTime;
  final String title;
  final String description;
  final String? libraryItemId;
  final String? libraryItemType;
  final String? mode;
  final String? category;
  final String? date;
  final DateTime? scheduledDate;
}

class BuildDaySelectedLibraryItem {
  const BuildDaySelectedLibraryItem({
    required this.name,
    required this.libraryItemId,
    required this.libraryItemType,
  });

  final String name;
  final String libraryItemId;
  final String libraryItemType;
}

enum RecipeMealType { BREAKFAST, LUNCH, DINNER, SNACK, FAMILY, OTHER }

extension RecipeMealTypeApi on RecipeMealType {
  String get apiValue => switch (this) {
        RecipeMealType.BREAKFAST => 'BREAKFAST',
        RecipeMealType.LUNCH => 'LUNCH',
        RecipeMealType.DINNER => 'DINNER',
        RecipeMealType.SNACK => 'SNACK',
        RecipeMealType.FAMILY => 'FAMILY',
        RecipeMealType.OTHER => 'OTHER',
      };
}

enum ActivityLocation { INDOOR, OUTDOOR, GROUP }

extension ActivityLocationApi on ActivityLocation {
  String get apiValue => switch (this) {
        ActivityLocation.INDOOR => 'INDOOR',
        ActivityLocation.OUTDOOR => 'OUTDOOR',
        ActivityLocation.GROUP => 'GROUP',
      };
}

enum ScheduleCategory { RECIPE, ACTIVITY, HOME_STUDY, NAP, BEDTIME, OTHER }

extension ScheduleCategoryApi on ScheduleCategory {
  String get apiValue => switch (this) {
        ScheduleCategory.RECIPE => 'RECIPE',
        ScheduleCategory.ACTIVITY => 'ACTIVITY',
        ScheduleCategory.HOME_STUDY => 'HOME_STUDY',
        ScheduleCategory.NAP => 'NAP',
        ScheduleCategory.BEDTIME => 'BEDTIME',
        ScheduleCategory.OTHER => 'OTHER',
      };
}

class BuildDayFromLibraryController extends GetxController {
  BuildDayFromLibraryController({
    LibraryService? libraryService,
    ParentChildrenService? parentChildrenService,
    ParentScheduleService? parentScheduleService,
  })  : _libraryService = libraryService ?? LibraryService.instance,
        _parentChildrenService =
            parentChildrenService ?? ParentChildrenService.instance,
        _parentScheduleService =
            parentScheduleService ?? ParentScheduleService.instance;

  final LibraryService _libraryService;
  final ParentChildrenService _parentChildrenService;
  final ParentScheduleService _parentScheduleService;
  Worker? _searchWorker;
  int _latestLibraryRequestId = 0;
  String _originalChildName = '';
  String _originalWakeUpTime = '07:00';
  String _originalBedTime = '20:00';
  static const int _libraryPageLimit = 6;

  final TextEditingController childNameController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  final selectedTabIndex = 0.obs;
  final childName = ''.obs;
  final childWakeUpTime = const TimeOfDay(hour: 7, minute: 0).obs;
  final childBedTime = const TimeOfDay(hour: 20, minute: 0).obs;
  final isCreatingChild = false.obs;
  final isAddingSchedule = false.obs;
  final isSchedulesLoading = false.obs;
  final scheduleError = RxnString();
  final createdChildId = RxnString();
  final isFilterVisible = false.obs;
  final isCategoryMenuVisible = false.obs;
  final selectedFilterTag = ''.obs;
  final searchQuery = ''.obs;
  final libraryResult = BuildDayLibraryResult.empty.obs;
  final isLibraryLoading = false.obs;
  final libraryError = RxnString();
  final selectedLibraryItem = Rxn<BuildDaySelectedLibraryItem>();
  final editingScheduleItem = Rxn<BuildDayScheduleItem>();
  final deletingScheduleIds = <String>[].obs;
  final currentLibraryPage = 1.obs;
  final selectedCategory = ScheduleCategory.ACTIVITY.obs;
  final startTime = TimeOfDay.now().obs;
  final endTime = _addTimeOfDayHours(TimeOfDay.now(), 1).obs;

  final RxList<BuildDayScheduleItem> todayScheduleList =
      <BuildDayScheduleItem>[].obs;

  final RxList<BuildDayScheduleItem> otherScheduleList =
      <BuildDayScheduleItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _resetScheduleTimesToNow();
    childNameController.addListener(_onChildNameChanged);
    searchController.addListener(_onSearchChanged);
    _hydrateInitialChildName();
    _searchWorker = debounce<String>(
      searchQuery,
      (_) => loadLibrary(),
      time: const Duration(milliseconds: 350),
    );
    if (effectiveChildId != null) {
      loadSchedules();
    }
  }

  String? get childId {
    final arguments = Get.arguments;
    if (arguments is Map && arguments['child_id'] is String) {
      final value = (arguments['child_id']! as String).trim();
      return value.isEmpty ? null : value;
    }
    if (arguments is Map && arguments['child'] is Map) {
      final child = (arguments['child']! as Map).cast<String, dynamic>();
      final value = child['id']?.toString().trim();
      return value == null || value.isEmpty ? null : value;
    }
    return null;
  }

  String? get effectiveChildId => childId ?? createdChildId.value;

  bool get shouldShowChildNameInput => true;

  bool get shouldShowBuilder => effectiveChildId != null;

  bool get isTodayEditOnly {
    final arguments = Get.arguments;
    return arguments is Map && arguments['today_edit_only'] == true;
  }

  bool get canCreateChild =>
      childName.value.trim().isNotEmpty && !isCreatingChild.value;

  set selectedChildWakeUpTime(TimeOfDay value) => childWakeUpTime.value = value;

  set selectedChildBedTime(TimeOfDay value) => childBedTime.value = value;

  bool get isEditingSchedule => editingScheduleItem.value != null;

  String get primaryScheduleActionLabel => isEditingSchedule
      ? LangKey.parentToday.updateSchedule
      : LangKey.parentToday.addToSchedule;

  String get secondaryScheduleActionLabel => isEditingSchedule
      ? LangKey.parentToday.rescheduleDifferentDays
      : LangKey.parentToday.addToDifferentDaysSchedule;

  DateTime get differentScheduleInitialDate =>
      editingScheduleItem.value?.scheduledDate ?? DateTime.now();

  bool isDeletingSchedule(String id) => deletingScheduleIds.contains(id);

  void _onChildNameChanged() {
    childName.value = childNameController.text.trim();
  }

  void _hydrateInitialChildName() {
    final arguments = Get.arguments;
    if (arguments is! Map) return;
    final rawName =
        arguments['child_name'] ?? arguments['generated_child_name'];
    final nestedChild = arguments['child'];
    final nestedName = nestedChild is Map ? nestedChild['name'] : null;
    final name = (rawName ?? nestedName)?.toString().trim() ?? '';
    final wakeUp = _readArgumentTime(
      arguments['wakeUpTime'] ??
          arguments['wake_up_time'] ??
          (nestedChild is Map ? nestedChild['wakeUpTime'] : null),
      fallback: childWakeUpTime.value,
    );
    final bed = _readArgumentTime(
      arguments['bedTime'] ??
          arguments['bed_time'] ??
          (nestedChild is Map ? nestedChild['bedTime'] : null),
      fallback: childBedTime.value,
    );
    childWakeUpTime.value = wakeUp;
    childBedTime.value = bed;
    _originalWakeUpTime = _formatScheduleTime(wakeUp);
    _originalBedTime = _formatScheduleTime(bed);
    if (name.isNotEmpty) {
      _originalChildName = name;
      childNameController.text = name;
      childName.value = name;
    }
  }

  void _onSearchChanged() {
    if (selectedLibraryItem.value != null) return;
    searchQuery.value = searchController.text;
    currentLibraryPage.value = 1;
  }

  bool get isSearching =>
      selectedLibraryItem.value == null &&
      (searchQuery.value.trim().isNotEmpty ||
          selectedFilterTag.value.isNotEmpty);

  BuildDayLibraryResult get searchResults => libraryResult.value;
  int get libraryPageLimit => _libraryPageLimit;
  bool get canShowPreviousLibraryPage => currentLibraryPage.value > 1;
  bool get canShowNextLibraryPage => libraryResult.value.hasNextPage(
        currentPage: currentLibraryPage.value,
        limit: _libraryPageLimit,
      );

  Future<void> loadLibrary({int? page}) async {
    final targetPage = page ?? currentLibraryPage.value;
    if (!isSearching) {
      _latestLibraryRequestId++;
      currentLibraryPage.value = 1;
      libraryResult.value = BuildDayLibraryResult.empty;
      libraryError.value = null;
      isLibraryLoading.value = false;
      return;
    }

    final filters = _selectedFilterQuery();
    final requestId = ++_latestLibraryRequestId;
    isLibraryLoading.value = true;
    libraryError.value = null;

    final result = await _libraryService.getLibrary(
      search: selectedFilterTag.value.isEmpty ? searchQuery.value : null,
      recipeMealType: filters.recipeMealType,
      location: filters.location,
      minAge: filters.minAge,
      maxAge: filters.maxAge,
      page: targetPage,
      limit: _libraryPageLimit,
    );
    if (requestId != _latestLibraryRequestId) return;

    result.fold(
      (failure) {
        libraryError.value = failure.message;
        libraryResult.value = BuildDayLibraryResult.empty;
      },
      (data) {
        currentLibraryPage.value = targetPage;
        libraryResult.value = data;
      },
    );

    isLibraryLoading.value = false;
  }

  Future<void> loadSchedules() async {
    final childId = effectiveChildId;
    if (childId == null || childId.isEmpty) return;

    isSchedulesLoading.value = true;
    scheduleError.value = null;
    final result = await _parentScheduleService.getSchedules(
      childId: childId,
      view: isTodayEditOnly ? 'TODAY' : 'ALL',
    );
    result.fold(
      (failure) {
        scheduleError.value = failure.message;
        AppLogger.error(
          '[BuildDayFromLibraryController] Schedule fetch failed: '
          '${failure.message}',
        );
      },
      (data) {
        final todaySchedules = _scheduleItemsFromList(data['todaySchedules']);
        todayScheduleList.assignAll(
          todaySchedules.isNotEmpty
              ? todaySchedules
              : _scheduleItemsFromList(data['dateSchedules']),
        );
        if (isTodayEditOnly) {
          otherScheduleList.clear();
        } else {
          final otherSchedules = _scheduleItemsFromList(data['otherSchedules']);
          otherScheduleList.assignAll(
            otherSchedules.isNotEmpty
                ? otherSchedules
                : _scheduleItemsFromList(data['upcomingSchedules']),
          );
        }
        _syncChildNameFromSchedules(data);
      },
    );
    isSchedulesLoading.value = false;
  }

  void _syncChildNameFromSchedules(Map<String, dynamic> data) {
    if (childNameController.text.trim().isNotEmpty) return;
    final schedule = _firstScheduleWithChild(data);
    final child = schedule?['child'];
    if (child is! Map) return;
    final name = child['name']?.toString().trim();
    if (name == null || name.isEmpty) return;
    _originalChildName = name;
    childNameController.text = name;
    childName.value = name;
  }

  Map<String, dynamic>? _firstScheduleWithChild(Map<String, dynamic> data) {
    for (final key in [
      'todaySchedules',
      'dateSchedules',
      'upcomingSchedules',
      'otherSchedules',
    ]) {
      final schedules = data[key];
      if (schedules is! List || schedules.isEmpty) continue;
      final first = schedules.first;
      if (first is Map) return first.cast<String, dynamic>();
    }
    return null;
  }

  void goToNextLibraryPage() {
    if (!canShowNextLibraryPage || isLibraryLoading.value) return;
    loadLibrary(page: currentLibraryPage.value + 1);
  }

  void goToPreviousLibraryPage() {
    if (!canShowPreviousLibraryPage || isLibraryLoading.value) return;
    loadLibrary(page: currentLibraryPage.value - 1);
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
    isCategoryMenuVisible.value = false;
  }

  void selectCategory(ScheduleCategory category) {
    selectedCategory.value = category;
    isCategoryMenuVisible.value = false;
  }

  void toggleCategoryMenu() {
    isCategoryMenuVisible.toggle();
  }

  set selectedStartTime(TimeOfDay value) {
    startTime.value = value;
    endTime.value = _addTimeOfDayHours(value, 1);
  }

  set selectedEndTime(TimeOfDay value) => endTime.value = value;

  void toggleFilterVisibility() {
    isFilterVisible.toggle();
  }

  void selectFilterTag(String tag) {
    selectedLibraryItem.value = null;
    if (selectedFilterTag.value == tag) {
      selectedFilterTag.value = '';
    } else {
      selectedFilterTag.value = tag;
    }
    currentLibraryPage.value = 1;
    loadLibrary();
  }

  Future<void> createChild() async {
    final name = childName.value.trim();
    if (name.isEmpty) {
      showGlobalToast(
        message: LangKey.parentToday.childNameRequired,
        status: 'error',
      );
      return;
    }

    isCreatingChild.value = true;
    final wake = _formatScheduleTime(childWakeUpTime.value);
    final bed = _formatScheduleTime(childBedTime.value);
    final result = await _parentChildrenService.createChild(
      name: name,
      wakeUpTime: wake,
      bedTime: bed,
    );
    result.fold(
      (failure) {
        showGlobalToast(message: failure.message, status: 'error');
      },
      (child) {
        final id = child['id']?.toString().trim();
        if (id != null && id.isNotEmpty) {
          createdChildId.value = id;
          _originalChildName = child['name']?.toString().trim() ?? name;
          _originalWakeUpTime = child['wakeUpTime']?.toString().trim() ?? wake;
          _originalBedTime = child['bedTime']?.toString().trim() ?? bed;
          loadSchedules();
        }
        showGlobalToast(message: LangKey.parentToday.childCreated);
      },
    );
    isCreatingChild.value = false;
  }

  Future<void> finishBuildDay() async {
    final childId = effectiveChildId;
    if (childId == null || childId.isEmpty) {
      showGlobalToast(
        message: LangKey.parentToday.childRequiredForSchedule,
        status: 'error',
      );
      return;
    }

    final currentName = childNameController.text.trim();
    final currentWake = _formatScheduleTime(childWakeUpTime.value);
    final currentBed = _formatScheduleTime(childBedTime.value);
    if (currentName.isEmpty) {
      showGlobalToast(
        message: LangKey.parentToday.childNameRequired,
        status: 'error',
      );
      return;
    }

    isCreatingChild.value = true;
    try {
      final shouldUpdateChild = currentName != _originalChildName.trim() ||
          currentWake != _originalWakeUpTime ||
          currentBed != _originalBedTime;
      if (shouldUpdateChild) {
        final result = await _parentChildrenService.updateChildProfile(
          childId: childId,
          data: {
            'name': currentName,
            'wakeUpTime': currentWake,
            'bedTime': currentBed,
          },
        );
        final didUpdate = result.fold(
          (failure) {
            showGlobalToast(message: failure.message, status: 'error');
            return false;
          },
          (child) {
            _originalChildName =
                child['name']?.toString().trim() ?? currentName;
            _originalWakeUpTime =
                child['wakeUpTime']?.toString().trim() ?? currentWake;
            _originalBedTime =
                child['bedTime']?.toString().trim() ?? currentBed;
            showGlobalToast(message: LangKey.parentToday.childProfileSaved);
            return true;
          },
        );
        if (!didUpdate) return;
      }
      Get.offAllNamed<void>(
        AppRoutes.main,
        arguments: {'initial_index': 0},
      );
    } finally {
      isCreatingChild.value = false;
    }
  }

  void addSearchResultToSchedule(BuildDayLibrarySearchResultItem item) {
    selectedLibraryItem.value = BuildDaySelectedLibraryItem(
      name: item.title,
      libraryItemId: item.id,
      libraryItemType: item.type.name,
    );
    selectedFilterTag.value = '';
    isFilterVisible.value = false;
    currentLibraryPage.value = 1;
    libraryResult.value = BuildDayLibraryResult.empty;
    libraryError.value = null;
    isLibraryLoading.value = false;
    _latestLibraryRequestId++;
    if (searchController.text.isNotEmpty) {
      searchController.clear();
    }
    searchQuery.value = '';
  }

  void clearSelectedLibraryItem() {
    selectedLibraryItem.value = null;
  }

  void cancelScheduleEdit() {
    _clearAfterAdd();
    searchController.clear();
    searchQuery.value = '';
    selectedFilterTag.value = '';
    isFilterVisible.value = false;
    libraryResult.value = BuildDayLibraryResult.empty;
    libraryError.value = null;
  }

  Future<void> addToSchedule() async {
    if (selectedTabIndex.value == 0) {
      final editingItem = editingScheduleItem.value;
      if (editingItem != null) {
        await _updateLibrarySchedule(
          editingItem.scheduledDate ?? DateTime.now(),
        );
      } else {
        await _createLibrarySchedule(DateTime.now());
      }
      return;
    }

    final title = _resolveCurrentTitle();
    if (title == null) return;
    await _createManualSchedule(DateTime.now(), title: title);
  }

  Future<void> addToDifferentDaysSchedule(DateTime date) async {
    if (isTodayEditOnly) return;

    if (selectedTabIndex.value == 0) {
      if (editingScheduleItem.value != null) {
        await _updateLibrarySchedule(date);
      } else {
        await _createLibrarySchedule(date);
      }
      return;
    }

    final title = _resolveCurrentTitle();
    if (title == null) return;
    await _createManualSchedule(date, title: title);
  }

  Future<void> _createManualSchedule(
    DateTime date, {
    required String title,
  }) async {
    if (isAddingSchedule.value) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Ignored manual schedule create: already loading',
      );
      return;
    }

    final childId = effectiveChildId;
    if (childId == null || childId.isEmpty) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Manual schedule create skipped: missing childId',
      );
      showGlobalToast(
        message: LangKey.parentToday.childRequiredForSchedule,
        status: 'error',
      );
      return;
    }

    final description = notesController.text.trim();
    final start = _formatScheduleTime(startTime.value);
    final end = _formatScheduleTime(endTime.value);
    final category = selectedCategory.value.apiValue;
    isAddingSchedule.value = true;
    AppLogger.debug(
      '[BuildDayFromLibraryController] Creating manual schedule '
      'date=${_formatApiDate(date)} category=$category',
    );

    try {
      final result = await _parentScheduleService.createManualSchedule(
        childId: childId,
        date: _formatApiDate(date),
        title: title,
        category: category,
        startTime: start,
        endTime: end,
        description: description,
      );

      result.fold(
        (failure) {
          AppLogger.error(
            '[BuildDayFromLibraryController] Manual schedule create failed: '
            '${failure.message}',
          );
          showGlobalToast(message: failure.message, status: 'error');
        },
        (_) {
          AppLogger.success(
            '[BuildDayFromLibraryController] Manual schedule create succeeded',
          );
          if (_isToday(date)) {
            showGlobalToast(message: LangKey.parentToday.addedToSchedule);
          } else {
            showGlobalToast(
              message: LangKey.parentToday.addedToDifferentSchedule,
            );
          }
          _clearAfterAdd();
          loadSchedules();
        },
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        '[BuildDayFromLibraryController] Unexpected manual schedule create error',
        error,
        stackTrace,
      );
      showGlobalToast(message: error.toString(), status: 'error');
    } finally {
      isAddingSchedule.value = false;
    }
  }

  Future<void> _createLibrarySchedule(DateTime date) async {
    if (isAddingSchedule.value) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Ignored schedule create: already loading',
      );
      return;
    }

    final childId = effectiveChildId;
    if (childId == null || childId.isEmpty) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Schedule create skipped: missing childId',
      );
      showGlobalToast(
        message: LangKey.parentToday.childRequiredForSchedule,
        status: 'error',
      );
      return;
    }

    final selectedItem = selectedLibraryItem.value;
    if (selectedItem == null) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Schedule create skipped: missing library item',
      );
      showGlobalToast(
        message: LangKey.parentToday.libraryItemRequiredForSchedule,
        status: 'error',
      );
      return;
    }

    final description = notesController.text.trim();
    final start = _formatScheduleTime(startTime.value);
    final end = _formatScheduleTime(endTime.value);
    isAddingSchedule.value = true;
    AppLogger.debug(
      '[BuildDayFromLibraryController] Creating library schedule '
      'date=${_formatApiDate(date)} itemType=${selectedItem.libraryItemType} '
      'itemId=${selectedItem.libraryItemId}',
    );

    try {
      final result = await _parentScheduleService.createLibrarySchedule(
        childId: childId,
        date: _formatApiDate(date),
        libraryItemId: selectedItem.libraryItemId,
        libraryItemType: selectedItem.libraryItemType,
        startTime: start,
        endTime: end,
        description: description,
      );

      result.fold(
        (failure) {
          AppLogger.error(
            '[BuildDayFromLibraryController] Schedule create failed: '
            '${failure.message}',
          );
          showGlobalToast(message: failure.message, status: 'error');
        },
        (_) {
          AppLogger.success(
            '[BuildDayFromLibraryController] Schedule create succeeded',
          );
          if (_isToday(date)) {
            showGlobalToast(message: LangKey.parentToday.addedToSchedule);
          } else {
            showGlobalToast(
              message: LangKey.parentToday.addedToDifferentSchedule,
            );
          }
          _clearAfterAdd();
          loadSchedules();
        },
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        '[BuildDayFromLibraryController] Unexpected schedule create error',
        error,
        stackTrace,
      );
      showGlobalToast(message: error.toString(), status: 'error');
    } finally {
      isAddingSchedule.value = false;
    }
  }

  Future<void> _updateLibrarySchedule(DateTime date) async {
    if (isAddingSchedule.value) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Ignored schedule update: already loading',
      );
      return;
    }

    final editingItem = editingScheduleItem.value;
    if (editingItem == null) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Schedule update skipped: missing editing item',
      );
      return;
    }

    final selectedItem = selectedLibraryItem.value;
    if (selectedItem == null || selectedItem.libraryItemId.isEmpty) {
      AppLogger.warning(
        '[BuildDayFromLibraryController] Schedule update skipped: missing library item',
      );
      showGlobalToast(
        message: LangKey.parentToday.libraryItemRequiredForSchedule,
        status: 'error',
      );
      return;
    }

    final description = notesController.text.trim();
    final start = _formatScheduleTime(startTime.value);
    final end = _formatScheduleTime(endTime.value);
    isAddingSchedule.value = true;
    AppLogger.debug(
      '[BuildDayFromLibraryController] Updating library schedule '
      'scheduleId=${editingItem.id} date=${_formatApiDate(date)} '
      'itemType=${selectedItem.libraryItemType} '
      'itemId=${selectedItem.libraryItemId}',
    );

    try {
      final result = await _parentScheduleService.updateLibrarySchedule(
        scheduleId: editingItem.id,
        date: _formatApiDate(date),
        libraryItemId: selectedItem.libraryItemId,
        libraryItemType: selectedItem.libraryItemType,
        startTime: start,
        endTime: end,
        description: description,
      );

      result.fold(
        (failure) {
          AppLogger.error(
            '[BuildDayFromLibraryController] Schedule update failed: '
            '${failure.message}',
          );
          showGlobalToast(message: failure.message, status: 'error');
        },
        (_) {
          AppLogger.success(
            '[BuildDayFromLibraryController] Schedule update succeeded',
          );
          _clearAfterAdd();
          showGlobalToast(message: LangKey.parentToday.scheduleUpdated);
          loadSchedules();
        },
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        '[BuildDayFromLibraryController] Unexpected schedule update error',
        error,
        stackTrace,
      );
      showGlobalToast(message: error.toString(), status: 'error');
    } finally {
      isAddingSchedule.value = false;
    }
  }

  void editScheduleItem(BuildDayScheduleItem item) {
    editingScheduleItem.value = item;
    final mode = item.mode?.trim().toUpperCase();
    taskTitleController.clear();
    selectedLibraryItem.value = null;

    if (mode == 'CUSTOM') {
      selectedTabIndex.value = 1;
      taskTitleController.text = item.title;
      selectedCategory.value = _categoryFromApi(item.category);
    } else {
      selectedTabIndex.value = 0;
      selectedLibraryItem.value = BuildDaySelectedLibraryItem(
        name: item.title,
        libraryItemId: item.libraryItemId ?? '',
        libraryItemType: item.libraryItemType ?? 'activity',
      );
    }
    notesController.text = item.description;
    startTime.value = _parseScheduleTime(item.startTime) ?? startTime.value;
    endTime.value = _parseScheduleTime(item.endTime) ?? endTime.value;
    searchController.clear();
    searchQuery.value = '';
    selectedFilterTag.value = '';
    isFilterVisible.value = false;
    libraryResult.value = BuildDayLibraryResult.empty;
    libraryError.value = null;
  }

  String? _resolveCurrentTitle() {
    if (selectedTabIndex.value == 1) {
      final title = taskTitleController.text.trim();
      if (title.isEmpty) {
        showGlobalToast(
          message: LangKey.parentToday.taskTitleRequired,
          status: 'error',
        );
        return null;
      }
      return title;
    }

    final selectedItem = selectedLibraryItem.value;
    if (selectedItem != null) return selectedItem.name;

    if (selectedFilterTag.value.isNotEmpty) return selectedFilterTag.value;
    final search = searchController.text.trim();
    return search.isNotEmpty ? search : LangKey.parentToday.activity;
  }

  void _clearAfterAdd() {
    taskTitleController.clear();
    notesController.clear();
    selectedLibraryItem.value = null;
    editingScheduleItem.value = null;
    _resetScheduleTimesToNow();
  }

  void _resetScheduleTimesToNow() {
    final now = TimeOfDay.now();
    startTime.value = now;
    endTime.value = _addTimeOfDayHours(now, 1);
  }

  String _formatScheduleTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static TimeOfDay _addTimeOfDayHours(TimeOfDay time, int hours) {
    final totalMinutes = ((time.hour + hours) * 60 + time.minute) % (24 * 60);
    return TimeOfDay(
      hour: totalMinutes ~/ 60,
      minute: totalMinutes % 60,
    );
  }

  String _formatScheduleDate(DateTime date) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _formatApiDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  List<BuildDayScheduleItem> _scheduleItemsFromList(Object? value) {
    if (value is! List) return const <BuildDayScheduleItem>[];
    return value
        .whereType<Map<Object?, Object?>>()
        .map(
          (item) => _scheduleItemFromFetchedMap(item.cast<String, dynamic>()),
        )
        .toList(growable: false);
  }

  BuildDayScheduleItem _scheduleItemFromFetchedMap(
    Map<String, dynamic> schedule,
  ) {
    final responseDate = _readScheduleDate(schedule['date']) ?? DateTime.now();
    final libraryRef = schedule['libraryRef'];
    final libraryMap =
        libraryRef is Map ? libraryRef.cast<String, dynamic>() : null;
    return BuildDayScheduleItem(
      id: schedule['id']?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: schedule['startTime']?.toString() ?? '',
      endTime: schedule['endTime']?.toString() ?? '',
      title: schedule['title']?.toString() ?? LangKey.parentToday.activity,
      description: schedule['description']?.toString() ?? '',
      libraryItemId: libraryMap?['id']?.toString(),
      libraryItemType: libraryMap?['type']?.toString(),
      mode: schedule['mode']?.toString(),
      category: schedule['category']?.toString(),
      date: _isToday(responseDate) ? null : _formatScheduleDate(responseDate),
      scheduledDate: responseDate,
    );
  }

  DateTime? _readScheduleDate(Object? value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString())?.toLocal();
  }

  TimeOfDay? _parseScheduleTime(String value) {
    final parts = value.split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;
    return TimeOfDay(hour: hour, minute: minute);
  }

  TimeOfDay _readArgumentTime(Object? value, {required TimeOfDay fallback}) {
    final raw = value?.toString().trim();
    if (raw == null || raw.isEmpty) return fallback;
    return _parseScheduleTime(raw) ?? fallback;
  }

  ScheduleCategory _categoryFromApi(String? category) {
    return switch (category) {
      'RECIPE' => ScheduleCategory.RECIPE,
      'ACTIVITY' => ScheduleCategory.ACTIVITY,
      'HOME_STUDY' => ScheduleCategory.HOME_STUDY,
      'NAP' => ScheduleCategory.NAP,
      'BEDTIME' => ScheduleCategory.BEDTIME,
      _ => ScheduleCategory.OTHER,
    };
  }

  Future<void> deleteTodayItem(String id) async {
    await _deleteSchedule(id);
  }

  Future<void> deleteOtherItem(String id) async {
    await _deleteSchedule(id);
  }

  Future<void> _deleteSchedule(String id) async {
    if (deletingScheduleIds.contains(id)) return;

    deletingScheduleIds.add(id);
    AppLogger.debug('[BuildDayFromLibraryController] Deleting schedule $id');

    try {
      final result = await _parentScheduleService.deleteSchedule(
        scheduleId: id,
      );
      result.fold(
        (failure) {
          AppLogger.error(
            '[BuildDayFromLibraryController] Schedule delete failed: '
            '${failure.message}',
          );
          showGlobalToast(message: failure.message, status: 'error');
        },
        (_) {
          if (editingScheduleItem.value?.id == id) {
            cancelScheduleEdit();
          }
          AppLogger.success(
            '[BuildDayFromLibraryController] Schedule delete succeeded',
          );
          showGlobalToast(message: LangKey.parentToday.scheduleDeleted);
          loadSchedules();
        },
      );
    } catch (error, stackTrace) {
      AppLogger.error(
        '[BuildDayFromLibraryController] Unexpected schedule delete error',
        error,
        stackTrace,
      );
      showGlobalToast(message: error.toString(), status: 'error');
    } finally {
      deletingScheduleIds.remove(id);
    }
  }

  @override
  void onClose() {
    _searchWorker?.dispose();
    childNameController.removeListener(_onChildNameChanged);
    searchController.removeListener(_onSearchChanged);
    childNameController.dispose();
    searchController.dispose();
    taskTitleController.dispose();
    notesController.dispose();
    super.onClose();
  }

  _BuildDayLibraryQuery _selectedFilterQuery() {
    final tag = selectedFilterTag.value;
    if (tag.isEmpty) return const _BuildDayLibraryQuery();
    if (tag == LangKey.parentToday.filterBreakfast) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.BREAKFAST.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterLunch) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.LUNCH.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterDinner) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.DINNER.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterSnacks) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.SNACK.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterFamily) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.FAMILY.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterOther) {
      return _BuildDayLibraryQuery(
        recipeMealType: RecipeMealType.OTHER.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterIndoor) {
      return _BuildDayLibraryQuery(
        location: ActivityLocation.INDOOR.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterOutdoor) {
      return _BuildDayLibraryQuery(
        location: ActivityLocation.OUTDOOR.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterGroup) {
      return _BuildDayLibraryQuery(
        location: ActivityLocation.GROUP.apiValue,
      );
    }
    if (tag == LangKey.parentToday.filterAgeZeroTwelveMonths) {
      return const _BuildDayLibraryQuery(minAge: 0, maxAge: 12);
    }
    if (tag == LangKey.parentToday.filterAgeTwelveTwentyFourMonths) {
      return const _BuildDayLibraryQuery(minAge: 12, maxAge: 24);
    }
    return const _BuildDayLibraryQuery();
  }
}

class _BuildDayLibraryQuery {
  const _BuildDayLibraryQuery({
    this.recipeMealType,
    this.location,
    this.minAge,
    this.maxAge,
  });

  final String? recipeMealType;
  final String? location;
  final int? minAge;
  final int? maxAge;
}
