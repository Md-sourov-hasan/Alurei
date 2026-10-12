import 'package:equatable/equatable.dart';

enum ParentRoutineKind {
  wake,
  breakfast,
  school,
  nap,
  outdoor,
  pasta,
  study,
  offer,
  external,
  story,
  bedtime,
  task,
}

enum ParentRoutineState { past, current, upcoming }

class ParentTodayChild extends Equatable {
  const ParentTodayChild({
    required this.id,
    required this.name,
    required this.hasAllergy,
    this.avatarAsset,
    this.routine = const [],
  });

  final String id;
  final String name;
  final bool hasAllergy;
  final String? avatarAsset;
  final List<ParentRoutineItem> routine;

  @override
  List<Object?> get props => [id, name, hasAllergy, avatarAsset, routine];
}

class ParentChildProfileNanny extends Equatable {
  const ParentChildProfileNanny({
    required this.id,
    required this.name,
    required this.status,
    required this.since,
    required this.avatarAsset,
    this.email,
    this.phone,
  });

  final String id;
  final String name;
  final String status;
  final String since;
  final String avatarAsset;
  final String? email;
  final String? phone;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        since,
        avatarAsset,
        email,
        phone,
      ];
}

enum ParentNannyProfileTab { overview, thisWeek, thisMonth }

enum ParentNannyPortfolioTab { portfolio, insights }

enum ParentNannyTaskKind { activity, meal, care, education }

enum ParentNannyTaskStatus { complete, warning, missing }

class ParentNannyProfileMetric extends Equatable {
  const ParentNannyProfileMetric({
    required this.id,
    required this.label,
    required this.value,
    required this.icon,
  });

  final String id;
  final String label;
  final String value;
  final ParentRoutineKind icon;

  @override
  List<Object?> get props => [id, label, value, icon];
}

class ParentNannyProfileTask extends Equatable {
  const ParentNannyProfileTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.kind,
    required this.proofCount,
    required this.status,
    this.proofMissing = false,
  });

  final String id;
  final String title;
  final String subtitle;
  final ParentNannyTaskKind kind;
  final int proofCount;
  final ParentNannyTaskStatus status;
  final bool proofMissing;

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        kind,
        proofCount,
        status,
        proofMissing,
      ];
}

class ParentNannyProfileData extends Equatable {
  const ParentNannyProfileData({
    required this.id,
    required this.name,
    required this.status,
    required this.since,
    required this.avatarAsset,
    required this.email,
    required this.phone,
    required this.caringFor,
    required this.careScore,
    required this.overviewMetrics,
    required this.recentTasks,
    required this.weekSummary,
    required this.weekTasks,
    required this.monthSummary,
    required this.monthTasks,
    required this.highlights,
  });

  final String id;
  final String name;
  final String status;
  final String since;
  final String avatarAsset;
  final String email;
  final String phone;
  final List<String> caringFor;
  final String careScore;
  final List<ParentNannyProfileMetric> overviewMetrics;
  final List<ParentNannyProfileTask> recentTasks;
  final List<ParentNannyProfileMetric> weekSummary;
  final List<ParentNannyProfileTask> weekTasks;
  final List<ParentNannyProfileMetric> monthSummary;
  final List<ParentNannyProfileTask> monthTasks;
  final List<String> highlights;

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        since,
        avatarAsset,
        email,
        phone,
        caringFor,
        careScore,
        overviewMetrics,
        recentTasks,
        weekSummary,
        weekTasks,
        monthSummary,
        monthTasks,
        highlights,
      ];
}

class ParentNannyActivityDetailsData extends Equatable {
  const ParentNannyActivityDetailsData({
    required this.id,
    required this.title,
    required this.category,
    required this.subtitle,
    required this.timeRange,
    required this.completedAt,
    required this.proofImages,
    required this.proofTimes,
    required this.focusTags,
    required this.feedbackDate,
    required this.enjoyment,
    required this.mood,
    required this.completion,
    required this.nannyNote,
  });

  final String id;
  final String title;
  final String category;
  final String subtitle;
  final String timeRange;
  final String completedAt;
  final List<String> proofImages;
  final List<String> proofTimes;
  final List<String> focusTags;
  final String feedbackDate;
  final String enjoyment;
  final String mood;
  final String completion;
  final String nannyNote;

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        subtitle,
        timeRange,
        completedAt,
        proofImages,
        proofTimes,
        focusTags,
        feedbackDate,
        enjoyment,
        mood,
        completion,
        nannyNote,
      ];
}

class ParentNannyPortfolioStat extends Equatable {
  const ParentNannyPortfolioStat({
    required this.label,
    required this.value,
    required this.accent,
  });

  final String label;
  final String value;
  final ParentRoutineKind accent;

  @override
  List<Object?> get props => [label, value, accent];
}

class ParentNannyPortfolioExperience extends Equatable {
  const ParentNannyPortfolioExperience({
    required this.family,
    required this.period,
    required this.children,
    required this.duration,
  });

  final String family;
  final String period;
  final String children;
  final String duration;

  @override
  List<Object?> get props => [family, period, children, duration];
}

class ParentNannyPortfolioInsight extends Equatable {
  const ParentNannyPortfolioInsight({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.rows,
    this.highlighted = false,
  });

  final String title;
  final String subtitle;
  final ParentNannyTaskKind icon;
  final List<ParentNannyPortfolioStat> rows;
  final bool highlighted;

  @override
  List<Object?> get props => [title, subtitle, icon, rows, highlighted];
}

class ParentNannyPortfolioData extends Equatable {
  const ParentNannyPortfolioData({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.since,
    required this.experience,
    required this.languages,
    required this.perks,
    required this.skills,
    required this.moreSkillsLabel,
    required this.experiences,
    required this.ageGroups,
    required this.insights,
  });

  final String id;
  final String name;
  final String avatarAsset;
  final String since;
  final String experience;
  final String languages;
  final List<ParentNannyPortfolioStat> perks;
  final List<String> skills;
  final String moreSkillsLabel;
  final List<ParentNannyPortfolioExperience> experiences;
  final List<String> ageGroups;
  final List<ParentNannyPortfolioInsight> insights;

  @override
  List<Object?> get props => [
        id,
        name,
        avatarAsset,
        since,
        experience,
        languages,
        perks,
        skills,
        moreSkillsLabel,
        experiences,
        ageGroups,
        insights,
      ];
}

class ParentChildProfileRecurringActivity extends Equatable {
  const ParentChildProfileRecurringActivity({
    required this.id,
    required this.name,
    required this.days,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String name;
  final List<String> days;
  final String startTime;
  final String endTime;

  @override
  List<Object?> get props => [id, name, days, startTime, endTime];
}

class ParentChildProfileNapWindow extends Equatable {
  const ParentChildProfileNapWindow({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.startTime,
    required this.endTime,
  });

  final String id;
  final String title;
  final String subtitle;
  final String startTime;
  final String endTime;

  @override
  List<Object?> get props => [id, title, subtitle, startTime, endTime];
}

class ParentChildProfileData extends Equatable {
  const ParentChildProfileData({
    required this.id,
    required this.name,
    required this.avatarAsset,
    required this.gender,
    required this.birthDate,
    required this.weight,
    required this.schoolDays,
    required this.schoolStartTime,
    required this.schoolEndTime,
    required this.recurringActivities,
    required this.wakeTime,
    required this.napWindows,
    required this.bedtime,
    required this.safetyOption,
    required this.safetyDetails,
    required this.favoriteFoods,
    required this.favoriteActivities,
    required this.currentChallenges,
    required this.notes,
    required this.assignedNannies,
  });

  final String id;
  final String name;
  final String avatarAsset;
  final String gender;
  final DateTime birthDate;
  final String weight;
  final List<String> schoolDays;
  final String schoolStartTime;
  final String schoolEndTime;
  final List<ParentChildProfileRecurringActivity> recurringActivities;
  final String wakeTime;
  final List<ParentChildProfileNapWindow> napWindows;
  final String bedtime;
  final String safetyOption;
  final String safetyDetails;
  final String favoriteFoods;
  final String favoriteActivities;
  final String currentChallenges;
  final String notes;
  final List<ParentChildProfileNanny> assignedNannies;

  @override
  List<Object?> get props => [
        id,
        name,
        avatarAsset,
        gender,
        birthDate,
        weight,
        schoolDays,
        schoolStartTime,
        schoolEndTime,
        recurringActivities,
        wakeTime,
        napWindows,
        bedtime,
        safetyOption,
        safetyDetails,
        favoriteFoods,
        favoriteActivities,
        currentChallenges,
        notes,
        assignedNannies,
      ];
}

class ParentRoutineItem extends Equatable {
  const ParentRoutineItem({
    required this.id,
    required this.kind,
    required this.state,
    this.startTime,
    this.endTime,
    this.title,
    this.description,
    this.itemTypeLabel,
    this.type,
    this.category,
    this.mode,
  });

  final String id;
  final ParentRoutineKind kind;
  final ParentRoutineState state;
  final String? startTime;
  final String? endTime;
  final String? title;
  final String? description;
  final String? itemTypeLabel;
  final String? type;
  final String? category;
  final String? mode;

  @override
  List<Object?> get props => [
        id,
        kind,
        state,
        startTime,
        endTime,
        title,
        description,
        itemTypeLabel,
        type,
        category,
        mode,
      ];
}

class ParentTodayData extends Equatable {
  const ParentTodayData({
    required this.parentName,
    required this.avatarAsset,
    required this.notificationCount,
    required this.messageCount,
    required this.children,
    required this.routine,
  });

  final String parentName;
  final String avatarAsset;
  final int notificationCount;
  final int messageCount;
  final List<ParentTodayChild> children;
  final List<ParentRoutineItem> routine;

  ParentTodayData copyWith({
    List<ParentTodayChild>? children,
    List<ParentRoutineItem>? routine,
  }) {
    return ParentTodayData(
      parentName: parentName,
      avatarAsset: avatarAsset,
      notificationCount: notificationCount,
      messageCount: messageCount,
      children: children ?? this.children,
      routine: routine ?? this.routine,
    );
  }

  @override
  List<Object?> get props => [
        parentName,
        avatarAsset,
        notificationCount,
        messageCount,
        children,
        routine,
      ];
}
