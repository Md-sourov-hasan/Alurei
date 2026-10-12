import 'package:alurei/src/imports/imports.dart';

class AiSetupActivityGroup {
  const AiSetupActivityGroup({
    required this.title,
    required this.icon,
    required this.activities,
  });

  final String title;
  final String icon;
  final List<String> activities;
}

class AiSetupNapWindow extends Equatable {
  const AiSetupNapWindow({
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

  AiSetupNapWindow copyWith({
    String? title,
    String? subtitle,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
  }) {
    return AiSetupNapWindow(
      id: id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [id, title, subtitle, startTime, endTime];
}

class AiSetupRecurringActivity extends Equatable {
  const AiSetupRecurringActivity({
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

class AiSetupGuideController extends GetxController {
  final genders = AiSetupGuideDummyData.genders;
  final weights = AiSetupGuideDummyData.weights;
  final activityGroups = AiSetupGuideDummyData.activityGroups
      .map(
        (group) => AiSetupActivityGroup(
          title: group.title,
          icon: activityGroupIcon(group.title),
          activities: group.activities,
        ),
      )
      .toList(growable: false);

  final childName = ''.obs;
  final selectedGender = RxnString();
  final selectedWeight = RxnString();
  final selectedBirthDate = Rxn<DateTime>();
  final selectedSchoolDays = <String>{'Mon'}.obs;
  final schoolStartTime = const TimeOfDay(hour: 8, minute: 30).obs;
  final schoolEndTime = const TimeOfDay(hour: 14, minute: 30).obs;
  final activityName = RxnString();
  final activityDays = <String>{'Mon'}.obs;
  final activityStartTime = const TimeOfDay(hour: 8, minute: 30).obs;
  final activityEndTime = const TimeOfDay(hour: 9, minute: 30).obs;
  final recurringActivities = <AiSetupRecurringActivity>[].obs;
  final wakeTime = const TimeOfDay(hour: 7, minute: 0).obs;
  final napStartTime = const TimeOfDay(hour: 13, minute: 0).obs;
  final napEndTime = const TimeOfDay(hour: 15, minute: 0).obs;
  final additionalNaps = <AiSetupNapWindow>[].obs;
  final bedtime = const TimeOfDay(hour: 19, minute: 30).obs;
  final hasMultipleNaps = false.obs;
  final selectedSafetyOption = 'None'.obs;
  final safetyDetails = ''.obs;
  final favoriteFoods = ''.obs;
  final favoriteActivities = ''.obs;
  final currentChallenges = ''.obs;
  final notes = ''.obs;
  final isGenerating = false.obs;
  final isCompleted = false.obs;
  final validationMessage = RxnString();

  static const weekDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const safetyOptions = [
    'None',
    'Food allergies',
    'Mobility considerations',
  ];

  bool get showSchoolSchedule {
    final birthDate = selectedBirthDate.value;
    if (birthDate == null) return true;
    return _ageInYears(birthDate, DateTime.now()) > 2;
  }

  void updateName(String value) {
    childName.value = value.trim();
    validationMessage.value = null;
  }

  set setupNotes(String value) => notes.value = value.trim();

  void selectGender(String value) {
    selectedGender.value = value;
    validationMessage.value = null;
  }

  set weight(String value) => selectedWeight.value = value;

  void selectBirthDate(DateTime value) {
    final now = DateTime.now();
    selectedBirthDate.value = value.isAfter(now) ? now : value;
    if (!showSchoolSchedule) {
      selectedSchoolDays.clear();
    } else if (selectedSchoolDays.isEmpty) {
      selectedSchoolDays.add('Mon');
    }
    validationMessage.value = null;
  }

  void toggleSchoolDay(String day) => _toggleDay(selectedSchoolDays, day);

  void toggleActivityDay(String day) => _toggleDay(activityDays, day);

  set schoolStart(TimeOfDay value) => schoolStartTime.value = value;

  set schoolEnd(TimeOfDay value) => schoolEndTime.value = value;

  set activityStart(TimeOfDay value) => activityStartTime.value = value;

  set activityEnd(TimeOfDay value) => activityEndTime.value = value;

  set wake(TimeOfDay value) => wakeTime.value = value;

  set napStart(TimeOfDay value) => napStartTime.value = value;

  set napEnd(TimeOfDay value) => napEndTime.value = value;

  set bedtimeValue(TimeOfDay value) => bedtime.value = value;

  set activity(String value) => activityName.value = value;

  void setRecurringActivity() {
    final name = activityName.value?.trim();
    if (name == null || name.isEmpty) {
      validationMessage.value = LangKey.parentToday.activityNameRequired;
      return;
    }
    validationMessage.value = null;
    recurringActivities.add(
      AiSetupRecurringActivity(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        days: activityDays.toList(growable: false),
        startTime: activityStartTime.value,
        endTime: activityEndTime.value,
      ),
    );
    activityName.value = null;
  }

  void removeRecurringActivity(String id) {
    recurringActivities.removeWhere((activity) => activity.id == id);
  }

  void toggleMultipleNaps() {
    addNapWindow();
  }

  void addNapWindow() {
    hasMultipleNaps.value = true;
    final count = additionalNaps.length + 2;
    additionalNaps.add(
      AiSetupNapWindow(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        title: 'Nap Window $count',
        subtitle: LangKey.parentToday.afternoonRestPeriod,
        startTime: const TimeOfDay(hour: 16, minute: 0),
        endTime: const TimeOfDay(hour: 17, minute: 0),
      ),
    );
  }

  void removeNapWindow(String id) {
    additionalNaps.removeWhere((nap) => nap.id == id);
    if (additionalNaps.isEmpty) {
      hasMultipleNaps.value = false;
    }
  }

  void updateNapStartTime(String id, TimeOfDay time) {
    final index = additionalNaps.indexWhere((nap) => nap.id == id);
    if (index != -1) {
      additionalNaps[index] = additionalNaps[index].copyWith(startTime: time);
    }
  }

  void updateNapEndTime(String id, TimeOfDay time) {
    final index = additionalNaps.indexWhere((nap) => nap.id == id);
    if (index != -1) {
      additionalNaps[index] = additionalNaps[index].copyWith(endTime: time);
    }
  }

  set safetyOption(String value) => selectedSafetyOption.value = value;

  set favoriteFoodNotes(String value) => favoriteFoods.value = value.trim();

  set favoriteActivityNotes(String value) =>
      favoriteActivities.value = value.trim();

  set currentChallengeNotes(String value) =>
      currentChallenges.value = value.trim();

  Future<void> continueSetup() async {
    if (childName.value.isEmpty) {
      validationMessage.value = LangKey.parentToday.childNameRequired;
      return;
    }
    if (selectedGender.value == null) {
      validationMessage.value = LangKey.parentToday.genderRequired;
      return;
    }
    if (selectedBirthDate.value == null) {
      validationMessage.value = LangKey.parentToday.birthDateRequired;
      return;
    }

    validationMessage.value = null;
    isGenerating.value = true;
    await Future<void>.delayed(const Duration(milliseconds: 2400));
    isGenerating.value = false;
    isCompleted.value = true;
  }

  void viewTodayCareFlow() {
    Get.offNamed<void>(
      AppRoutes.parentToday,
      arguments: {
        'generated_child_name':
            childName.value.isEmpty ? 'Eve' : childName.value.trim(),
      },
    );
  }

  void _toggleDay(RxSet<String> days, String day) {
    days.contains(day) ? days.remove(day) : days.add(day);
    if (days.isEmpty) days.add(day);
  }

  int _ageInYears(DateTime birthDate, DateTime today) {
    var age = today.year - birthDate.year;
    final birthdayPassed = today.month > birthDate.month ||
        (today.month == birthDate.month && today.day >= birthDate.day);
    if (!birthdayPassed) age--;
    return age;
  }

  static String activityGroupIcon(String title) {
    return switch (title) {
      'Creative Activities' => AppAssets.icKayak,
      'Health & Care' => AppAssets.icApple,
      'Learning & Development' => AppAssets.icAccCap,
      'Physical Activities' => AppAssets.icOmega,
      'Social Activities' => AppAssets.icCircleFadingPlus,
      'Religious & Family Activities' => AppAssets.icChessBishop,
      _ => AppAssets.icKayak,
    };
  }
}
