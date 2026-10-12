import 'package:flutter/foundation.dart';

@immutable
class CareModuleContentSection {
  const CareModuleContentSection({
    required this.heading,
    required this.bullets,
  });

  factory CareModuleContentSection.fromJson(Map<String, dynamic> json) {
    return CareModuleContentSection(
      heading: json['heading']?.toString() ?? '',
      bullets: json['bullets'] is List
          ? (json['bullets'] as List).map((e) => e.toString()).toList()
          : const [],
    );
  }

  final String heading;
  final List<String> bullets;
}

@immutable
class CareModuleQuestionOption {
  const CareModuleQuestionOption({
    required this.id,
    required this.label,
    required this.isCorrect,
  });

  factory CareModuleQuestionOption.fromJson(Map<String, dynamic> json) {
    return CareModuleQuestionOption(
      id: json['id']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      isCorrect: json['isCorrect'] == true,
    );
  }

  final String id;
  final String label;
  final bool isCorrect;
}

@immutable
class CareModuleQuestion {
  const CareModuleQuestion({
    required this.id,
    required this.question,
    required this.type,
    required this.explanation,
    required this.options,
  });

  factory CareModuleQuestion.fromJson(Map<String, dynamic> json) {
    return CareModuleQuestion(
      id: json['id']?.toString() ?? '',
      question: json['question']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      explanation: json['explanation']?.toString() ?? '',
      options: json['options'] is List
          ? (json['options'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((e) => CareModuleQuestionOption.fromJson(e.cast<String, dynamic>()))
              .toList()
          : const [],
    );
  }

  final String id;
  final String question;
  final String type;
  final String explanation;
  final List<CareModuleQuestionOption> options;
}

@immutable
class CareModuleDetail {
  const CareModuleDetail({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.coverImageUrl,
    required this.category,
    required this.estimatedMinutes,
    required this.coinReward,
    required this.suggestedMinAgeYears,
    required this.suggestedMaxAgeYears,
    required this.contentTitle,
    required this.contentSections,
    required this.keyTakeaway,
    required this.questions,
    this.videoUrl,
    this.isSaved = false,
  });

  factory CareModuleDetail.fromJson(Map<String, dynamic> json) {
    return CareModuleDetail(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      subtitle: json['subtitle']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      coverImageUrl: json['coverImageUrl']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      estimatedMinutes: json['estimatedMinutes'] is int
          ? json['estimatedMinutes'] as int
          : (int.tryParse(json['estimatedMinutes']?.toString() ?? '') ?? 0),
      coinReward: json['coinReward'] is int
          ? json['coinReward'] as int
          : (int.tryParse(json['coinReward']?.toString() ?? '') ?? 0),
      suggestedMinAgeYears: json['suggestedMinAgeYears'] is int
          ? json['suggestedMinAgeYears'] as int
          : (int.tryParse(json['suggestedMinAgeYears']?.toString() ?? '') ?? 0),
      suggestedMaxAgeYears: json['suggestedMaxAgeYears'] is int
          ? json['suggestedMaxAgeYears'] as int
          : (int.tryParse(json['suggestedMaxAgeYears']?.toString() ?? '') ?? 0),
      contentTitle:
          json['contentTitle']?.toString() ?? json['title']?.toString() ?? '',
      contentSections: json['contentSections'] is List
          ? (json['contentSections'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((e) => CareModuleContentSection.fromJson(e.cast<String, dynamic>()))
              .toList()
          : const [],
      keyTakeaway: json['keyTakeaway']?.toString() ?? '',
      questions: json['questions'] is List
          ? (json['questions'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((e) => CareModuleQuestion.fromJson(e.cast<String, dynamic>()))
              .toList()
          : const [],
      videoUrl: json['videoUrl']?.toString(),
      isSaved: json['isSaved'] == true,
    );
  }

  final String id;
  final String title;
  final String subtitle;
  final String description;
  final String coverImageUrl;
  final String category;
  final int estimatedMinutes;
  final int coinReward;
  final int suggestedMinAgeYears;
  final int suggestedMaxAgeYears;
  final String contentTitle;
  final List<CareModuleContentSection> contentSections;
  final String keyTakeaway;
  final List<CareModuleQuestion> questions;
  final String? videoUrl;
  final bool isSaved;
}
