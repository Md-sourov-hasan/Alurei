import 'package:alurei/src/imports/imports.dart';

class ChildProfileController extends GetxController
    with GetSingleTickerProviderStateMixin {
  ChildProfileController({
    ParentChildrenService? parentChildrenService,
  }) : _parentChildrenService =
            parentChildrenService ?? ParentChildrenService.instance;

  final ParentChildrenService _parentChildrenService;

  late final TabController tabController;

  final childProfile = <String, dynamic>{}.obs;
  final recurringActivities = <Map<String, dynamic>>[].obs;
  final memoriesPhotos = <String>[].obs;
  final storiesList = <Map<String, dynamic>>[].obs;
  final favoriteFoods = <String>[].obs;
  final frequentlyDeclined = <String>[].obs;
  final favoriteActivities = <String>[].obs;
  final lowEngagement = <String>[].obs;
  final personalitySnapshot = ''.obs;
  final selectedActivityDays = <String>{'MON'}.obs;
  final activityStartTime = const TimeOfDay(hour: 19, minute: 0).obs;
  final activityEndTime = const TimeOfDay(hour: 20, minute: 0).obs;
  final isLoadingProfile = true.obs;
  final isLoadingActivities = false.obs;
  final isAddingActivity = false.obs;
  final deletingActivityIds = <String>[].obs;
  final errorMessage = RxnString();

  static const weekDays = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];

  String? get childId {
    final arguments = Get.arguments;
    if (arguments is Map) {
      final value = arguments['child_id'] ?? arguments['id'];
      final id = value?.toString().trim();
      return id == null || id.isEmpty ? null : id;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    _hydrateFromArguments();
    loadChildProfile();
  }

  Future<void> loadChildProfile() async {
    final id = childId;
    if (id == null) {
      errorMessage.value = 'Child profile is missing a child id.';
      isLoadingProfile.value = false;
      return;
    }

    isLoadingProfile.value = true;
    errorMessage.value = null;
    final result = await _parentChildrenService.getChildById(id);
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (child) {
        _hydrateChild(child);
        final activities = child['recurringActivities'];
        if (activities is List) {
          recurringActivities.assignAll(_mapsFromList(activities));
        }
      },
    );
    isLoadingProfile.value = false;
    await loadRecurringActivities();
  }

  Future<void> loadRecurringActivities() async {
    final id = childId;
    if (id == null) return;

    isLoadingActivities.value = true;
    final result = await _parentChildrenService.getRecurringActivities(
      childId: id,
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      recurringActivities.assignAll,
    );
    isLoadingActivities.value = false;
  }

  Future<bool> addRecurringActivity({
    required String name,
  }) async {
    final id = childId;
    final activityName = name.trim();
    if (id == null) {
      showGlobalToast(message: 'Child id is required.', status: 'error');
      return false;
    }
    if (activityName.isEmpty) {
      showGlobalToast(message: 'Activity name is required.', status: 'error');
      return false;
    }

    var didSucceed = false;
    isAddingActivity.value = true;
    final result = await _parentChildrenService.addRecurringActivity(
      childId: id,
      name: activityName,
      days: selectedActivityDays.toList(growable: false),
      startTime: _formatTime(activityStartTime.value),
      endTime: _formatTime(activityEndTime.value),
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (activity) {
        recurringActivities.add(activity);
        didSucceed = true;
        showGlobalToast(message: 'Recurring activity added successfully');
      },
    );
    isAddingActivity.value = false;
    if (didSucceed) await loadRecurringActivities();
    return didSucceed;
  }

  Future<bool> deleteRecurringActivity(String activityId) async {
    final id = childId;
    if (id == null || deletingActivityIds.contains(activityId)) return false;

    var didSucceed = false;
    deletingActivityIds.add(activityId);
    final result = await _parentChildrenService.deleteRecurringActivity(
      childId: id,
      activityId: activityId,
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) {
        recurringActivities.removeWhere(
          (activity) => activity['id']?.toString() == activityId,
        );
        didSucceed = true;
        showGlobalToast(message: 'Recurring activity deleted successfully');
      },
    );
    deletingActivityIds.remove(activityId);
    if (didSucceed) await loadRecurringActivities();
    return didSucceed;
  }

  void toggleActivityDay(String day) {
    if (selectedActivityDays.contains(day)) {
      if (selectedActivityDays.length > 1) selectedActivityDays.remove(day);
    } else {
      selectedActivityDays.add(day);
    }
  }

  set selectedStartTime(TimeOfDay value) => activityStartTime.value = value;

  set selectedEndTime(TimeOfDay value) => activityEndTime.value = value;

  bool isDeletingActivity(String id) => deletingActivityIds.contains(id);

  void _hydrateFromArguments() {
    final arguments = Get.arguments;
    if (arguments is! Map) return;
    final name = arguments['name']?.toString();
    final avatar = arguments['avatar'] ?? arguments['image'];
    if (name == null && avatar == null) return;
    childProfile.value = {
      'name': name ?? 'Child',
      'age': arguments['age']?.toString() ?? '',
      'avatar': avatar?.toString(),
      'memoriesCount': 0,
      'storiesCount': 0,
    };
  }

  void _hydrateChild(Map<String, dynamic> child) {
    final birthDate = DateTime.tryParse(child['birthDate']?.toString() ?? '');
    final favoriteFoodValues = _stringList(child['favfood']);
    final favoriteActivityValues = _stringList(child['favActivites']);
    final challenges = _stringList(child['currentChallenges']);

    childProfile.value = {
      'id': child['id']?.toString(),
      'name': child['name']?.toString() ?? 'Child',
      'age': _ageText(birthDate),
      'avatar': child['avatar']?.toString(),
      'gender': child['gender']?.toString(),
      'weight': child['weight']?.toString() ?? '',
      'wakeUpTime': child['wakeUpTime']?.toString(),
      'bedTime': child['bedTime']?.toString(),
      'healthConditions': _stringList(child['healthConditions']),
      'schoolSchedule': child['schoolSchedule'],
      'naps': child['naps'],
      'memoriesCount': memoriesPhotos.length,
      'storiesCount': storiesList.length,
    };
    favoriteFoods.assignAll(favoriteFoodValues);
    favoriteActivities.assignAll(favoriteActivityValues);
    frequentlyDeclined.assignAll(challenges);
    lowEngagement.assignAll(challenges);
    personalitySnapshot.value = child['extraNote']?.toString() ??
        child['additionalNotes']?.toString() ??
        'No personality snapshot is available yet.';
  }

  List<Map<String, dynamic>> _mapsFromList(List<Object?> values) {
    return values
        .whereType<Map<Object?, Object?>>()
        .map((item) => item.cast<String, dynamic>())
        .toList(growable: false);
  }

  List<String> _stringList(Object? value) {
    if (value == null) return const <String>[];
    if (value is List) {
      return value
          .map((item) => item?.toString().trim() ?? '')
          .where((item) => item.isNotEmpty)
          .toList(growable: false);
    }
    return value
        .toString()
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  String _ageText(DateTime? birthDate) {
    if (birthDate == null) return '';
    final now = DateTime.now();
    var years = now.year - birthDate.year;
    var months = now.month - birthDate.month;
    if (now.day < birthDate.day) months--;
    if (months < 0) {
      years--;
      months += 12;
    }
    final parts = <String>[];
    if (years > 0) parts.add('$years ${years == 1 ? 'year' : 'years'}');
    if (months > 0) parts.add('$months ${months == 1 ? 'month' : 'months'}');
    return parts.isEmpty ? 'Less than 1 month' : parts.join(' ');
  }

  String formatDays(Object? days) {
    if (days is! List) return '';
    return days.map((day) => day.toString()).join(', ');
  }

  String formatActivityTime(Map<String, dynamic> activity) {
    final start = activity['startTime']?.toString() ?? '';
    final end = activity['endTime']?.toString() ?? '';
    if (start.isEmpty && end.isEmpty) return '';
    return '$start - $end';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
