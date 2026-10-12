import '../../domain/entities/parent_today_data.dart';

abstract final class ParentTodayModel {
  static ParentTodayData fromMap(Map<String, Object?> map) {
    final children = (map['children']! as List<Object?>)
        .cast<Map<String, Object?>>()
        .map(
          (child) => ParentTodayChild(
            id: (child['id'] as String?) ?? '',
            name: (child['name'] as String?) ?? '',
            hasAllergy: (child['has_allergy'] as bool?) ??
                (child['hasAllergy'] as bool?) ??
                (child['healthConditions'] is List &&
                    (child['healthConditions'] as List)
                        .contains('FOOD_ALLERGIES')),
            avatarAsset: (child['avatar_asset'] as String?) ??
                (child['avatar'] as String?),
            routine: _routineFromMap(child['routine']),
          ),
        )
        .toList(growable: false);
    final routine = _routineFromMap(map['routine']);

    return ParentTodayData(
      parentName: map['parent_name']! as String,
      avatarAsset: map['avatar_asset']! as String,
      notificationCount: map['notification_count']! as int,
      messageCount: map['message_count']! as int,
      children: children,
      routine: routine,
    );
  }

  static List<ParentRoutineItem> timelineFromMap(Map<String, Object?> map) {
    final rawTimeline = map['timeline'];
    if (rawTimeline is! List) return const <ParentRoutineItem>[];
    return rawTimeline
        .whereType<Map<Object?, Object?>>()
        .map((item) => _timelineItemFromApi(item.cast<String, Object?>()))
        .toList(growable: false);
  }

  static ParentChildProfileData profileFromMap(Map<String, Object?> map) {
    final rawBirthDate = map['birth_date'] as String?;
    return ParentChildProfileData(
      id: (map['id'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      avatarAsset: (map['avatar_asset'] as String?) ?? '',
      gender: (map['gender'] as String?) ?? 'Girl',
      birthDate: rawBirthDate != null
          ? DateTime.tryParse(rawBirthDate) ?? DateTime(2022, 1, 1)
          : DateTime(2022, 1, 1),
      weight: (map['weight'] as String?) ?? '',
      schoolDays: _stringList(map['school_days']),
      schoolStartTime: (map['school_start_time'] as String?) ?? '09:00',
      schoolEndTime: (map['school_end_time'] as String?) ?? '13:00',
      recurringActivities:
          ((map['recurring_activities'] as List<Object?>?) ?? [])
              .cast<Map<String, Object?>>()
              .map(
                (activity) => ParentChildProfileRecurringActivity(
                  id: (activity['id'] as String?) ?? '',
                  name: (activity['name'] as String?) ?? '',
                  days: _stringList(activity['days']),
                  startTime: (activity['start_time'] as String?) ?? '09:00',
                  endTime: (activity['end_time'] as String?) ?? '10:00',
                ),
              )
              .toList(growable: false),
      wakeTime: (map['wake_time'] as String?) ?? '07:00',
      napWindows: ((map['nap_windows'] as List<Object?>?) ?? [])
          .cast<Map<String, Object?>>()
          .map(
            (nap) => ParentChildProfileNapWindow(
              id: (nap['id'] as String?) ?? '',
              title: (nap['title'] as String?) ?? 'Nap Window',
              subtitle: (nap['subtitle'] as String?) ?? 'Rest period',
              startTime: (nap['start_time'] as String?) ?? '13:00',
              endTime: (nap['end_time'] as String?) ?? '14:00',
            ),
          )
          .toList(growable: false),
      bedtime: (map['bedtime'] as String?) ?? '19:00',
      safetyOption: (map['safety_option'] as String?) ?? 'None',
      safetyDetails: (map['safety_details'] as String?) ?? '',
      favoriteFoods: (map['favorite_foods'] as String?) ?? '',
      favoriteActivities: (map['favorite_activities'] as String?) ?? '',
      currentChallenges: (map['current_challenges'] as String?) ?? '',
      notes: (map['notes'] as String?) ?? '',
      assignedNannies: ((map['assigned_nannies'] as List<Object?>?) ?? [])
          .cast<Map<String, Object?>>()
          .map(
            (nanny) => ParentChildProfileNanny(
              id: (nanny['id'] as String?) ?? '',
              name: (nanny['name'] as String?) ?? '',
              status: (nanny['status'] as String?) ?? 'Active',
              since: (nanny['since'] as String?) ?? '',
              avatarAsset: (nanny['avatar_asset'] as String?) ?? '',
              email: nanny['email'] as String?,
              phone: nanny['phone'] as String?,
            ),
          )
          .toList(growable: false),
    );
  }

  static ParentNannyProfileData nannyProfileFromMap(
    Map<String, Object?> map,
  ) {
    return ParentNannyProfileData(
      id: (map['id'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      status: (map['status'] as String?) ?? 'Active',
      since: (map['since'] as String?) ?? '',
      avatarAsset: (map['avatar_asset'] as String?) ?? '',
      email: (map['email'] as String?) ?? '',
      phone: (map['phone'] as String?) ?? '',
      caringFor: _stringList(map['caring_for']),
      careScore: (map['care_score'] as String?) ?? '90',
      overviewMetrics: _metricsFromMap(map['overview_metrics']),
      recentTasks: _tasksFromMap(map['recent_tasks']),
      weekSummary: _metricsFromMap(map['week_summary']),
      weekTasks: _tasksFromMap(map['week_tasks']),
      monthSummary: _metricsFromMap(map['month_summary']),
      monthTasks: _tasksFromMap(map['month_tasks']),
      highlights: _stringList(map['highlights']),
    );
  }

  static ParentNannyActivityDetailsData nannyActivityDetailsFromMap(
    Map<String, Object?> map,
  ) {
    return ParentNannyActivityDetailsData(
      id: (map['id'] as String?) ?? '',
      title: (map['title'] as String?) ?? '',
      category: (map['category'] as String?) ?? '',
      subtitle: (map['subtitle'] as String?) ?? '',
      timeRange: (map['time_range'] as String?) ?? '',
      completedAt: (map['completed_at'] as String?) ?? '',
      proofImages: _stringList(map['proof_images']),
      proofTimes: _stringList(map['proof_times']),
      focusTags: _stringList(map['focus_tags']),
      feedbackDate: (map['feedback_date'] as String?) ?? '',
      enjoyment: (map['enjoyment'] as String?) ?? '',
      mood: (map['mood'] as String?) ?? '',
      completion: (map['completion'] as String?) ?? '',
      nannyNote: (map['nanny_note'] as String?) ?? '',
    );
  }

  static ParentNannyPortfolioData nannyPortfolioFromMap(
    Map<String, Object?> map,
  ) {
    return ParentNannyPortfolioData(
      id: (map['id'] as String?) ?? '',
      name: (map['name'] as String?) ?? '',
      avatarAsset: (map['avatar_asset'] as String?) ?? '',
      since: (map['since'] as String?) ?? '',
      experience: (map['experience'] as String?) ?? '',
      languages: (map['languages'] as String?) ?? '',
      perks: _portfolioStatsFromMap(map['perks']),
      skills: _stringList(map['skills']),
      moreSkillsLabel: (map['more_skills_label'] as String?) ?? '',
      experiences: _portfolioExperiencesFromMap(map['experiences']),
      ageGroups: _stringList(map['age_groups']),
      insights: _portfolioInsightsFromMap(map['insights']),
    );
  }

  static List<ParentNannyPortfolioStat> _portfolioStatsFromMap(Object? value) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (stat) => ParentNannyPortfolioStat(
            label: (stat['label'] as String?) ?? '',
            value: (stat['value'] as String?) ?? '',
            accent: _parseRoutineKind({'kind': stat['accent']}),
          ),
        )
        .toList(growable: false);
  }

  static List<ParentNannyPortfolioExperience> _portfolioExperiencesFromMap(
    Object? value,
  ) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (experience) => ParentNannyPortfolioExperience(
            family: (experience['family'] as String?) ?? '',
            period: (experience['period'] as String?) ?? '',
            children: (experience['children'] as String?) ?? '',
            duration: (experience['duration'] as String?) ?? '',
          ),
        )
        .toList(growable: false);
  }

  static List<ParentNannyPortfolioInsight> _portfolioInsightsFromMap(
    Object? value,
  ) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (insight) => ParentNannyPortfolioInsight(
            title: (insight['title'] as String?) ?? '',
            subtitle: (insight['subtitle'] as String?) ?? '',
            icon: _parseNannyTaskKind(insight['icon']),
            rows: _portfolioStatsFromMap(insight['rows']),
            highlighted: (insight['highlighted'] as bool?) ?? false,
          ),
        )
        .toList(growable: false);
  }

  static List<ParentNannyProfileMetric> _metricsFromMap(Object? value) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (metric) => ParentNannyProfileMetric(
            id: (metric['id'] as String?) ?? '',
            label: (metric['label'] as String?) ?? '',
            value: (metric['value'] as String?) ?? '',
            icon: _parseRoutineKind({'kind': metric['icon']}),
          ),
        )
        .toList(growable: false);
  }

  static List<ParentNannyProfileTask> _tasksFromMap(Object? value) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (task) => ParentNannyProfileTask(
            id: (task['id'] as String?) ?? '',
            title: (task['title'] as String?) ?? '',
            subtitle: (task['subtitle'] as String?) ?? '',
            kind: _parseNannyTaskKind(task['kind']),
            proofCount: (task['proof_count'] as int?) ?? 0,
            status: _parseNannyTaskStatus(task['status']),
            proofMissing: (task['proof_missing'] as bool?) ?? false,
          ),
        )
        .toList(growable: false);
  }

  static List<String> _stringList(Object? value) {
    if (value is! List<Object?>) return const [];
    return value.cast<String>().toList(growable: false);
  }

  static List<ParentRoutineItem> _routineFromMap(Object? value) {
    if (value is! List<Object?>) return const [];
    return value
        .cast<Map<String, Object?>>()
        .map(
          (item) => ParentRoutineItem(
            id: item['id']! as String,
            kind: _parseRoutineKind(item),
            state: _parseRoutineState(item['state']),
            startTime: item['start'] as String?,
            endTime: item['end'] as String?,
            title: item['title'] as String?,
            description: item['description'] as String?,
            itemTypeLabel: item['item_type_label'] as String?,
            type: item['type'] as String?,
            category: item['category'] as String?,
            mode: item['mode'] as String?,
          ),
        )
        .toList(growable: false);
  }

  static ParentRoutineItem _timelineItemFromApi(Map<String, Object?> item) {
    final type = item['type']?.toString();
    final category = item['category']?.toString();
    final mode = item['mode']?.toString();
    final libraryRef = item['libraryRef'];
    final libraryMap = libraryRef is Map<Object?, Object?>
        ? libraryRef.cast<String, Object?>()
        : const <String, Object?>{};

    return ParentRoutineItem(
      id: item['id']?.toString() ?? '',
      kind: _routineKindFromTimeline(type: type, category: category),
      state: ParentRoutineState.upcoming,
      startTime: item['startTime']?.toString(),
      endTime: item['endTime']?.toString(),
      title: item['title']?.toString(),
      description: item['description']?.toString(),
      itemTypeLabel: _timelineItemTypeLabel(
        type: type,
        category: category,
        mode: mode,
        libraryRefType: libraryMap['type']?.toString(),
      ),
      type: type,
      category: category,
      mode: mode,
    );
  }

  static ParentRoutineKind _routineKindFromTimeline({
    required String? type,
    required String? category,
  }) {
    final normalizedType = type?.trim().toUpperCase();
    final normalizedCategory = category?.trim().toUpperCase();
    for (final rule in _timelineKindRules) {
      if (rule.matches(normalizedType, normalizedCategory)) return rule.kind;
    }
    return ParentRoutineKind.task;
  }

  static String? _timelineItemTypeLabel({
    required String? type,
    required String? category,
    required String? mode,
    required String? libraryRefType,
  }) {
    if (type == null && category == null && mode == null) return null;
    final normalizedType = type?.trim().toUpperCase();
    if (normalizedType != 'SCHEDULE') return _friendlyTimelineLabel(type);
    final source =
        mode?.trim().toUpperCase() == 'LIBRARY' ? libraryRefType : category;
    return _friendlyTimelineLabel(source ?? category);
  }

  static String _friendlyTimelineLabel(String? value) {
    final normalized = value?.trim();
    if (normalized == null || normalized.isEmpty) return '';
    return normalized.split('_').where((part) => part.isNotEmpty).map((part) {
      final lower = part.toLowerCase();
      return '${lower[0].toUpperCase()}${lower.substring(1)}';
    }).join(' ');
  }

  static ParentRoutineKind _parseRoutineKind(Map<String, Object?> item) {
    final value = item['kind'] ?? item['item_type'] ?? item['type'];
    if (value is! String) return ParentRoutineKind.task;
    return ParentRoutineKind.values.firstWhere(
      (kind) => kind.name == value,
      orElse: () => ParentRoutineKind.task,
    );
  }

  static ParentRoutineState _parseRoutineState(Object? value) {
    if (value is! String) return ParentRoutineState.upcoming;
    return ParentRoutineState.values.firstWhere(
      (state) => state.name == value,
      orElse: () => ParentRoutineState.upcoming,
    );
  }

  static ParentNannyTaskKind _parseNannyTaskKind(Object? value) {
    if (value is! String) return ParentNannyTaskKind.activity;
    return ParentNannyTaskKind.values.firstWhere(
      (kind) => kind.name == value,
      orElse: () => ParentNannyTaskKind.activity,
    );
  }

  static ParentNannyTaskStatus _parseNannyTaskStatus(Object? value) {
    if (value is! String) return ParentNannyTaskStatus.complete;
    return ParentNannyTaskStatus.values.firstWhere(
      (status) => status.name == value,
      orElse: () => ParentNannyTaskStatus.complete,
    );
  }
}

const _timelineKindRules = [
  _TimelineKindRule(type: 'WAKE_UP', kind: ParentRoutineKind.wake),
  _TimelineKindRule(type: 'SCHOOL', kind: ParentRoutineKind.school),
  _TimelineKindRule(
    type: 'NAP',
    category: 'NAP',
    kind: ParentRoutineKind.nap,
  ),
  _TimelineKindRule(
    type: 'BEDTIME',
    category: 'BEDTIME',
    kind: ParentRoutineKind.bedtime,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'RECIPE',
    kind: ParentRoutineKind.breakfast,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'ACTIVITY',
    kind: ParentRoutineKind.outdoor,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'HOME_STUDY',
    kind: ParentRoutineKind.study,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'NAP',
    kind: ParentRoutineKind.nap,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'BEDTIME',
    kind: ParentRoutineKind.bedtime,
  ),
  _TimelineKindRule(
    type: 'SCHEDULE',
    category: 'OTHER',
    kind: ParentRoutineKind.task,
  ),
];

class _TimelineKindRule {
  const _TimelineKindRule({
    required this.type,
    required this.kind,
    this.category,
  });

  final String type;
  final String? category;
  final ParentRoutineKind kind;

  bool matches(String? candidateType, String? candidateCategory) {
    if (candidateType != type) return false;
    return category == null || candidateCategory == category;
  }
}
