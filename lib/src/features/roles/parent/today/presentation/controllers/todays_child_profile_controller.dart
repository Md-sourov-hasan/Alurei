import 'dart:convert';
import 'dart:io';

import 'package:alurei/src/imports/imports.dart';

import '../../domain/entities/parent_today_data.dart';
import '../../domain/repositories/parent_today_repository.dart';

class TodaysChildProfileController extends GetxController {
  TodaysChildProfileController(
    this._repository, {
    ParentChildrenService? parentChildrenService,
  }) : _parentChildrenService =
            parentChildrenService ?? ParentChildrenService.instance;

  final ParentTodayRepository _repository;
  final ParentChildrenService _parentChildrenService;

  final profile = Rxn<ParentChildProfileData>();
  final isLoading = true.obs;
  final isSaving = false.obs;
  final isDeleting = false.obs;
  final hasUnsavedProfileChanges = false.obs;
  final isEditingProfileDetails = false.obs;
  final errorMessage = RxnString();

  final childName = ''.obs;
  final selectedGender = RxnString();
  final selectedWeight = RxnString();
  final selectedBirthDate = Rxn<DateTime>();
  final selectedSchoolDays = <String>{}.obs;
  final schoolStartTime = const TimeOfDay(hour: 8, minute: 30).obs;
  final schoolEndTime = const TimeOfDay(hour: 14, minute: 30).obs;
  final recurringActivities = <ParentChildProfileRecurringActivityUi>[].obs;
  final activityName = ''.obs;
  final editingRecurringActivityId = RxnString();
  final isAddingRecurringActivity = false.obs;
  final deletingRecurringActivityIds = <String>[].obs;
  final selectedActivityDays = <String>{'Mon'}.obs;
  final activityStartTime = const TimeOfDay(hour: 8, minute: 30).obs;
  final activityEndTime = const TimeOfDay(hour: 9, minute: 30).obs;
  final wakeTime = const TimeOfDay(hour: 7, minute: 0).obs;
  final napWindows = <ParentChildProfileNapWindowUi>[].obs;
  final bedtime = const TimeOfDay(hour: 19, minute: 0).obs;
  final selectedSafetyOption = 'None'.obs;
  final safetyDetails = ''.obs;
  final favoriteFoods = ''.obs;
  final favoriteActivities = ''.obs;
  final currentChallenges = ''.obs;
  final notes = ''.obs;
  final avatarUrl = RxnString();
  final selectedProfileImage = Rxn<File>();
  var _hasBirthDate = false;
  String _savedProfileFingerprint = '';

  static const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const genders = ['Girl', 'Boy', 'Other'];
  static const weights = ['12 kg', '15 kg', '18 kg', '20 kg', '22 kg'];
  static const safetyOptions = [
    'None',
    'Food allergies',
    'Mobility considerations',
  ];

  String get childId {
    final arguments = Get.arguments;
    if (arguments is Map && arguments['child_id'] is String) {
      return (arguments['child_id']! as String).trim();
    }
    return '';
  }

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    if (childId.isEmpty) {
      profile.value = null;
      errorMessage.value = LangKey.parentToday.unableToLoadChildProfile;
      isLoading.value = false;
      return;
    }

    isLoading.value = true;
    errorMessage.value = null;
    final result = await _parentChildrenService.getChildById(childId);
    result.fold(
      (failure) => errorMessage.value = failure.message,
      (payload) {
        final value = _profileFromChildMap(payload);
        _hydrate(value);
        profile.value = value;
      },
    );
    isLoading.value = false;
  }

  void updateName(String value) {
    childName.value = value.trim();
    _refreshProfileDirtyState();
  }

  void toggleProfileDetailsEdit() {
    isEditingProfileDetails.toggle();
  }

  Future<void> pickProfileImage(ImageSource source) async {
    final result = await MediaService.instance.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 88,
    );
    result.fold(
      (failure) => showAppErrorDialog(
        title: 'Photo Selection Failed',
        message: failure.message,
      ),
      (file) {
        if (file == null) return;
        selectedProfileImage.value = file;
        _refreshProfileDirtyState();
      },
    );
  }

  set gender(String value) {
    selectedGender.value = value;
    _refreshProfileDirtyState();
  }

  set weight(String value) {
    selectedWeight.value = value;
    _refreshProfileDirtyState();
  }

  set birthDate(DateTime value) {
    _hasBirthDate = true;
    selectedBirthDate.value = value;
    _refreshProfileDirtyState();
  }

  void toggleSchoolDay(String day) {
    selectedSchoolDays.contains(day)
        ? selectedSchoolDays.remove(day)
        : selectedSchoolDays.add(day);
    if (selectedSchoolDays.isEmpty) selectedSchoolDays.add(day);
    _refreshProfileDirtyState();
  }

  set schoolStart(TimeOfDay value) {
    schoolStartTime.value = value;
    _refreshProfileDirtyState();
  }

  set schoolEnd(TimeOfDay value) {
    schoolEndTime.value = value;
    _refreshProfileDirtyState();
  }

  void toggleActivityDay(String day) {
    if (selectedActivityDays.contains(day)) {
      if (selectedActivityDays.length > 1) {
        selectedActivityDays.remove(day);
      }
    } else {
      selectedActivityDays.add(day);
    }
  }

  set activityStart(TimeOfDay value) {
    activityStartTime.value = value;
    activityEndTime.value = _addTimeOfDayHours(value, 1);
  }

  set activityEnd(TimeOfDay value) => activityEndTime.value = value;

  bool get isEditingRecurringActivity =>
      editingRecurringActivityId.value?.isNotEmpty ?? false;

  void selectRecurringActivity(ParentChildProfileRecurringActivityUi activity) {
    editingRecurringActivityId.value = activity.id;
    activityName.value = activity.name;
    selectedActivityDays.assignAll(activity.days);
    activityStartTime.value = activity.startTime;
    activityEndTime.value = activity.endTime;
  }

  void cancelRecurringActivityEdit() {
    editingRecurringActivityId.value = null;
    activityName.value = '';
    selectedActivityDays.assignAll({'Mon'});
    activityStartTime.value = const TimeOfDay(hour: 8, minute: 30);
    activityEndTime.value = const TimeOfDay(hour: 9, minute: 30);
  }

  Future<bool> addRecurringActivity() async {
    final name = activityName.value.trim();
    if (childId.isEmpty) {
      showGlobalToast(
        message: LangKey.parentToday.unableToLoadChildProfile,
        status: 'error',
      );
      return false;
    }
    if (name.isEmpty) {
      showGlobalToast(
        message: 'Name of the activity is required.',
        status: 'error',
      );
      return false;
    }
    if (isAddingRecurringActivity.value) return false;

    isAddingRecurringActivity.value = true;
    var didSucceed = false;
    final editingId = editingRecurringActivityId.value;
    final wasEditing = isEditingRecurringActivity;
    final apiDays = selectedActivityDays.map(_dayToApi).toList(growable: false);
    final startTime = _formatTime(activityStartTime.value);
    final endTime = _formatTime(activityEndTime.value);
    final result = wasEditing
        ? await _parentChildrenService.updateRecurringActivity(
            childId: childId,
            activityId: editingId!,
            name: name,
            days: apiDays,
            startTime: startTime,
            endTime: endTime,
          )
        : await _parentChildrenService.addRecurringActivity(
            childId: childId,
            name: name,
            days: apiDays,
            startTime: startTime,
            endTime: endTime,
          );
    result.fold(
      (failure) => showAppErrorDialog(
        title: wasEditing ? 'Update Activity Failed' : 'Set Activity Failed',
        message: failure.message,
      ),
      (payload) {
        final activity = _recurringActivityUiFromApi(payload);
        final existingIndex =
            recurringActivities.indexWhere((item) => item.id == activity.id);
        if (existingIndex == -1) {
          recurringActivities.add(activity);
        } else {
          recurringActivities[existingIndex] = activity;
        }
        cancelRecurringActivityEdit();
        didSucceed = true;
        showGlobalToast(
          message: wasEditing
              ? 'Recurring activity updated successfully'
              : 'Recurring activity added successfully',
        );
      },
    );
    isAddingRecurringActivity.value = false;
    return didSucceed;
  }

  Future<void> removeRecurringActivity(String id) async {
    if (childId.isEmpty || deletingRecurringActivityIds.contains(id)) return;

    deletingRecurringActivityIds.add(id);
    final result = await _parentChildrenService.deleteRecurringActivity(
      childId: childId,
      activityId: id,
    );
    result.fold(
      (failure) => showGlobalToast(message: failure.message, status: 'error'),
      (_) {
        recurringActivities.removeWhere((item) => item.id == id);
        if (editingRecurringActivityId.value == id) {
          cancelRecurringActivityEdit();
        }
        showGlobalToast(message: 'Recurring activity deleted successfully');
      },
    );
    deletingRecurringActivityIds.remove(id);
  }

  set wake(TimeOfDay value) {
    wakeTime.value = value;
    _refreshProfileDirtyState();
  }

  set bedtimeValue(TimeOfDay value) {
    bedtime.value = value;
    _refreshProfileDirtyState();
  }

  void updateNapStartTime(String id, TimeOfDay time) {
    final index = napWindows.indexWhere((nap) => nap.id == id);
    if (index == -1) return;
    napWindows[index] = napWindows[index].copyWith(
      startTime: time,
      endTime: _addTimeOfDayHours(time, 1),
    );
    _refreshProfileDirtyState();
  }

  void updateNapEndTime(String id, TimeOfDay time) {
    final index = napWindows.indexWhere((nap) => nap.id == id);
    if (index == -1) return;
    napWindows[index] = napWindows[index].copyWith(endTime: time);
    _refreshProfileDirtyState();
  }

  void addNapWindow() {
    final count = napWindows.length + 1;
    final start = napWindows.isEmpty
        ? const TimeOfDay(hour: 16, minute: 0)
        : napWindows.last.endTime;
    final end = _addTimeOfDayHours(start, 1);
    napWindows.add(
      ParentChildProfileNapWindowUi(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: '${LangKey.parentToday.napWindow} $count',
        subtitle: LangKey.parentToday.afternoonRestPeriod,
        startTime: start,
        endTime: end,
      ),
    );
    _refreshProfileDirtyState();
  }

  void removeNapWindow(String id) {
    napWindows.removeWhere((nap) => nap.id == id);
    _refreshProfileDirtyState();
  }

  set safetyOption(String value) {
    selectedSafetyOption.value = value;
    _refreshProfileDirtyState();
  }

  set safetyNotes(String value) {
    safetyDetails.value = value.trim();
    _refreshProfileDirtyState();
  }

  set favoriteFoodNotes(String value) {
    favoriteFoods.value = value.trim();
    _refreshProfileDirtyState();
  }

  set favoriteActivityNotes(String value) {
    favoriteActivities.value = value.trim();
    _refreshProfileDirtyState();
  }

  set currentChallengeNotes(String value) {
    currentChallenges.value = value.trim();
    _refreshProfileDirtyState();
  }

  set profileNotes(String value) {
    notes.value = value.trim();
    _refreshProfileDirtyState();
  }

  Future<void> saveProfile() async {
    if (childId.isEmpty) {
      await showAppErrorDialog(
        title: 'Save Failed',
        message: LangKey.parentToday.unableToLoadChildProfile,
      );
      return;
    }
    if (childName.value.trim().isEmpty) {
      await showAppErrorDialog(
        title: 'Save Failed',
        message: LangKey.parentToday.childNameRequired,
      );
      return;
    }

    isSaving.value = true;
    try {
      final result = await _parentChildrenService.updateChildProfileMultipart(
        childId: childId,
        fields: _multipartProfilePayload(),
        profilePicture: selectedProfileImage.value,
      );
      final didSave = result.fold(
        (failure) {
          showAppErrorDialog(
            title: 'Save Failed',
            message: failure.message,
          );
          return false;
        },
        (_) => true,
      );
      if (!didSave) return;

      await loadProfile();
      isEditingProfileDetails.value = false;
      showGlobalToast(message: LangKey.parentToday.childProfileSaved);
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> deleteProfile() async {
    if (childId.isEmpty || isDeleting.value) return;
    isDeleting.value = true;
    try {
      final result = await _repository.deleteChildProfile(childId);
      result.fold(
        (failure) => showGlobalToast(message: failure.message, status: 'error'),
        (_) {
          showGlobalToast(message: 'Child deleted successfully');
          Get.back<bool>(result: true);
        },
      );
    } finally {
      isDeleting.value = false;
    }
  }

  void buildNewDay() => Get.toNamed<void>(
        AppRoutes.childSetupGuide,
        arguments: _childRouteArguments(),
      );

  void editDay() => Get.toNamed<void>(
        AppRoutes.buildDayFromLibrary,
        arguments: {
          ..._childRouteArguments(),
          'today_edit_only': true,
        },
      );

  void regenerateTimeline() => saveProfile();

  void _hydrate(ParentChildProfileData value) {
    childName.value = value.name;
    selectedGender.value = value.gender;
    selectedWeight.value = value.weight;
    selectedBirthDate.value = value.birthDate;
    selectedSchoolDays.assignAll(value.schoolDays);
    schoolStartTime.value = _parseTime(value.schoolStartTime);
    schoolEndTime.value = _parseTime(value.schoolEndTime);
    recurringActivities.assignAll(
      value.recurringActivities.map(
        (activity) => ParentChildProfileRecurringActivityUi(
          id: activity.id,
          name: activity.name,
          days: activity.days,
          startTime: _parseTime(activity.startTime),
          endTime: _parseTime(activity.endTime),
        ),
      ),
    );
    wakeTime.value = _parseTime(value.wakeTime);
    napWindows.assignAll(
      value.napWindows.map(
        (nap) => ParentChildProfileNapWindowUi(
          id: nap.id,
          title: nap.title,
          subtitle: nap.subtitle,
          startTime: _parseTime(nap.startTime),
          endTime: _parseTime(nap.endTime),
        ),
      ),
    );
    bedtime.value = _parseTime(value.bedtime);
    selectedSafetyOption.value = value.safetyOption;
    safetyDetails.value = value.safetyDetails;
    favoriteFoods.value = value.favoriteFoods;
    favoriteActivities.value = value.favoriteActivities;
    currentChallenges.value = value.currentChallenges;
    notes.value = value.notes;
    selectedProfileImage.value = null;
    _savedProfileFingerprint = _profileFingerprint();
    hasUnsavedProfileChanges.value = false;
  }

  ParentChildProfileData _profileFromChildMap(Map<String, dynamic> child) {
    final schoolSchedule = child['schoolSchedule'];
    final schoolMap = schoolSchedule is Map
        ? schoolSchedule.cast<String, dynamic>()
        : <String, dynamic>{};
    final recurring = child['recurringActivities'];
    final naps = child['naps'];
    final healthConditions = _readStringList(child['healthConditions']);
    final parsedBirthDate = _parseDate(child['birthDate']);
    _hasBirthDate = parsedBirthDate != null;
    avatarUrl.value =
        (child['avatar'] ?? child['profilePictureUrl'])?.toString();
    return ParentChildProfileData(
      id: child['id']?.toString() ?? childId,
      name: child['name']?.toString() ?? '',
      avatarAsset: AppAssets.parentTodayChildProfileAvatar,
      gender: _genderFromApi(child['gender']),
      birthDate: parsedBirthDate ?? DateTime.now(),
      weight: child['weight']?.toString() ?? '',
      schoolDays: _readStringList(schoolMap['days']).map(_dayFromApi).toList(),
      schoolStartTime: schoolMap['startTime']?.toString() ?? '08:30',
      schoolEndTime: schoolMap['endTime']?.toString() ?? '14:30',
      recurringActivities: _recurringActivitiesFromApi(recurring),
      wakeTime: child['wakeUpTime']?.toString() ?? '07:00',
      napWindows: _napWindowsFromApi(naps),
      bedtime: child['bedTime']?.toString() ?? '19:00',
      safetyOption: _safetyOptionFromApi(child['hasAllergy'], healthConditions),
      safetyDetails: _readTextValue(child['additionalNotes']).isNotEmpty
          ? _readTextValue(child['additionalNotes'])
          : healthConditions.join(', '),
      favoriteFoods: _readTextValue(
        child['favfood'] ?? child['favFood'] ?? child['favoriteFoods'],
      ),
      favoriteActivities: _readTextValue(
        child['favActivites'] ??
            child['favActivities'] ??
            child['favoriteActivities'],
      ),
      currentChallenges: _readTextValue(child['currentChallenges']),
      notes: _readTextValue(child['extraNote']),
      assignedNannies: const <ParentChildProfileNanny>[],
    );
  }

  DateTime? _parseDate(Object? value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString())?.toLocal();
  }

  List<String> _readStringList(Object? value) {
    if (value is! List) return const <String>[];
    return value
        .map((item) => item?.toString().trim() ?? '')
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  String _readTextValue(Object? value) {
    if (value == null) return '';
    if (value is List) {
      return value
          .map((item) => item?.toString().trim() ?? '')
          .where((item) => item.isNotEmpty)
          .join(', ');
    }
    return value.toString().trim();
  }

  List<ParentChildProfileRecurringActivity> _recurringActivitiesFromApi(
    Object? value,
  ) {
    if (value is! List) return const <ParentChildProfileRecurringActivity>[];
    return value.whereType<Map<Object?, Object?>>().map((item) {
      final map = item.cast<String, dynamic>();
      return ParentChildProfileRecurringActivity(
        id: map['id']?.toString() ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        name: map['name']?.toString() ?? '',
        days: _readStringList(map['days']).map(_dayFromApi).toList(),
        startTime: map['startTime']?.toString() ?? '08:30',
        endTime: map['endTime']?.toString() ?? '09:30',
      );
    }).toList(growable: false);
  }

  ParentChildProfileRecurringActivityUi _recurringActivityUiFromApi(
    Map<String, dynamic> map,
  ) {
    return ParentChildProfileRecurringActivityUi(
      id: map['id']?.toString() ??
          DateTime.now().microsecondsSinceEpoch.toString(),
      name: map['name']?.toString() ?? '',
      days: _readStringList(map['days']).map(_dayFromApi).toList(),
      startTime: _parseTime(map['startTime']?.toString() ?? '08:30'),
      endTime: _parseTime(map['endTime']?.toString() ?? '09:30'),
    );
  }

  List<ParentChildProfileNapWindow> _napWindowsFromApi(Object? value) {
    if (value is! List) return const <ParentChildProfileNapWindow>[];
    return value.whereType<Map<Object?, Object?>>().map((item) {
      final map = item.cast<String, dynamic>();
      return ParentChildProfileNapWindow(
        id: map['id']?.toString() ??
            DateTime.now().microsecondsSinceEpoch.toString(),
        title: map['title']?.toString() ?? LangKey.parentToday.napWindow,
        subtitle: map['subtitle']?.toString() ??
            LangKey.parentToday.afternoonRestPeriod,
        startTime: map['startTime']?.toString() ?? '16:00',
        endTime: map['endTime']?.toString() ?? '17:00',
      );
    }).toList(growable: false);
  }

  Map<String, Object?> _multipartProfilePayload() {
    return {
      'gender': _genderToApi(selectedGender.value),
      'extraNote': notes.value.trim(),
      'hasAllergy': (selectedSafetyOption.value == 'Food allergies').toString(),
      'currentChallenges': currentChallenges.value.trim(),
      'schoolSchedule': {
        'days': selectedSchoolDays.map(_dayToApi).toList(growable: false),
        'startTime': _formatTime(schoolStartTime.value),
        'endTime': _formatTime(schoolEndTime.value),
      },
      'name': childName.value.trim(),
      'wakeUpTime': _formatTime(wakeTime.value),
      'birthDate': _hasBirthDate ? _formatDate(selectedBirthDate.value) : null,
      'bedTime': _formatTime(bedtime.value),
      'healthConditions': _healthConditionsPayload().join(','),
      'naps': napWindows.map((nap) {
        return {
          'startTime': _formatTime(nap.startTime),
          'endTime': _formatTime(nap.endTime),
        };
      }).toList(growable: false),
      'weight': selectedWeight.value ?? '',
      'favfood': favoriteFoods.value.trim(),
      'additionalNotes': safetyDetails.value.trim(),
      'favActivites': favoriteActivities.value.trim(),
    };
  }

  void _refreshProfileDirtyState() {
    if (_savedProfileFingerprint.isEmpty) return;
    hasUnsavedProfileChanges.value =
        _profileFingerprint() != _savedProfileFingerprint;
  }

  String _profileFingerprint() {
    final schoolDays = selectedSchoolDays.map(_dayToApi).toList()..sort();
    final naps = napWindows.map((nap) {
      return {
        'startTime': _formatTime(nap.startTime),
        'endTime': _formatTime(nap.endTime),
      };
    }).toList(growable: false);

    return jsonEncode({
      'name': childName.value.trim(),
      'gender': _genderToApi(selectedGender.value),
      'weight': selectedWeight.value,
      'birthDate': _hasBirthDate ? _formatDate(selectedBirthDate.value) : null,
      'avatar': avatarUrl.value,
      'selectedProfileImagePath': selectedProfileImage.value?.path,
      'wakeUpTime': _formatTime(wakeTime.value),
      'bedTime': _formatTime(bedtime.value),
      'healthConditions': _healthConditionsPayload(),
      'hasAllergy': selectedSafetyOption.value == 'Food allergies',
      'additionalNotes': notes.value.trim().isEmpty ? null : notes.value.trim(),
      'schoolSchedule': {
        'days': schoolDays,
        'startTime': _formatTime(schoolStartTime.value),
        'endTime': _formatTime(schoolEndTime.value),
      },
      'naps': naps,
      'safetyDetails': safetyDetails.value.trim(),
      'favoriteFoods': favoriteFoods.value.trim(),
      'favoriteActivities': favoriteActivities.value.trim(),
      'currentChallenges': currentChallenges.value.trim(),
    });
  }

  List<String> _healthConditionsPayload() {
    if (selectedSafetyOption.value == 'None') return const ['NONE'];
    if (selectedSafetyOption.value == 'Food allergies') {
      return const ['FOOD_ALLERGIES'];
    }
    return const ['MOBILITY_CONSIDERATIONS'];
  }

  String _safetyOptionFromApi(Object? hasAllergyRaw, List<String> values) {
    final hasAllergy =
        hasAllergyRaw == true || hasAllergyRaw?.toString().toLowerCase() == 'true';
    final normalized = values.map((value) => value.trim().toUpperCase());
    if (normalized.contains('FOOD_ALLERGIES') || hasAllergy) {
      return 'Food allergies';
    }
    if (normalized.contains('MOBILITY_CONSIDERATIONS')) {
      return 'Mobility considerations';
    }
    return 'None';
  }

  String? _genderToApi(String? value) {
    final gender = value?.trim();
    if (gender == null || gender.isEmpty) return null;
    return gender.toUpperCase();
  }

  String _genderFromApi(Object? value) {
    final gender = value?.toString().trim().toUpperCase();
    return switch (gender) {
      'GIRL' => 'Girl',
      'BOY' => 'Boy',
      'OTHER' => 'Other',
      _ => '',
    };
  }

  String? _formatDate(DateTime? date) {
    if (date == null) return null;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }

  String _dayToApi(String day) {
    return switch (day.trim().toUpperCase()) {
      'MON' || 'MONDAY' => 'MON',
      'TUE' || 'TUESDAY' => 'TUE',
      'WED' || 'WEDNESDAY' => 'WED',
      'THU' || 'THURSDAY' => 'THU',
      'FRI' || 'FRIDAY' => 'FRI',
      'SAT' || 'SATURDAY' => 'SAT',
      'SUN' || 'SUNDAY' => 'SUN',
      _ => day.trim().toUpperCase(),
    };
  }

  String _dayFromApi(String day) {
    return switch (day.trim().toUpperCase()) {
      'MON' => 'Mon',
      'TUE' => 'Tue',
      'WED' => 'Wed',
      'THU' => 'Thu',
      'FRI' => 'Fri',
      'SAT' => 'Sat',
      'SUN' => 'Sun',
      _ => day,
    };
  }

  TimeOfDay _parseTime(String value) {
    final parts = value.split(':');
    if (parts.length != 2) return const TimeOfDay(hour: 0, minute: 0);
    return TimeOfDay(
      hour: int.tryParse(parts.first) ?? 0,
      minute: int.tryParse(parts.last) ?? 0,
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  TimeOfDay _addTimeOfDayHours(TimeOfDay time, int hours) {
    final totalMinutes = ((time.hour + hours) * 60 + time.minute) % (24 * 60);
    return TimeOfDay(
      hour: totalMinutes ~/ 60,
      minute: totalMinutes % 60,
    );
  }

  Map<String, Object?> _childRouteArguments() {
    final value = profile.value;
    return {
      'child_id': childId,
      'child_name': childName.value.trim(),
      'child': {
        'id': childId,
        'name': childName.value.trim(),
        'avatar': avatarUrl.value,
        'gender': _genderToApi(selectedGender.value),
        'birthDate':
            _hasBirthDate ? _formatDate(selectedBirthDate.value) : null,
        'weight': selectedWeight.value,
        'wakeUpTime': _formatTime(wakeTime.value),
        'bedTime': _formatTime(bedtime.value),
        'healthConditions': _healthConditionsPayload(),
        'hasAllergy': selectedSafetyOption.value == 'Food allergies',
        'additionalNotes':
            notes.value.trim().isEmpty ? null : notes.value.trim(),
        'schoolSchedule': {
          'days': selectedSchoolDays.map(_dayToApi).toList(growable: false),
          'startTime': _formatTime(schoolStartTime.value),
          'endTime': _formatTime(schoolEndTime.value),
        },
        'recurringActivities': recurringActivities.map((activity) {
          return {
            'name': activity.name,
            'days': activity.days.map(_dayToApi).toList(growable: false),
            'startTime': _formatTime(activity.startTime),
            'endTime': _formatTime(activity.endTime),
          };
        }).toList(growable: false),
        'naps': napWindows.map((nap) {
          return {
            'startTime': _formatTime(nap.startTime),
            'endTime': _formatTime(nap.endTime),
          };
        }).toList(growable: false),
      },
      if (value != null) 'profile_loaded': true,
    };
  }
}

class ParentChildProfileRecurringActivityUi extends Equatable {
  const ParentChildProfileRecurringActivityUi({
    required this.id,
    required this.name,
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String name;
  final List<String> days;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  @override
  List<Object?> get props => [id, name, days, startTime, endTime];
}

class ParentChildProfileNapWindowUi extends Equatable {
  const ParentChildProfileNapWindowUi({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String title;
  final String subtitle;
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  ParentChildProfileNapWindowUi copyWith({
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return ParentChildProfileNapWindowUi(
      id: id,
      title: title,
      subtitle: subtitle,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, startTime, endTime];
}
