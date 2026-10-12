import 'package:flutter/foundation.dart';

@immutable
class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.description,
    required this.ageTag,
    required this.imageUrl,
    this.category = 'Indoor',
    this.childTarget = 'Eve',
    this.hasBadge = false,
    this.isScheduled = false,
  });

  final String id;
  final String title;
  final String description;
  final String ageTag;
  final String imageUrl;
  final String category;
  final String childTarget;
  final bool hasBadge;
  final bool isScheduled;

  factory ActivityItem.fromJson(Map<String, dynamic> json) {
    final locationList = json['location'] as List?;
    final locationStr = (locationList != null && locationList.isNotEmpty)
        ? locationList.first.toString()
        : (json['category'] as String? ?? 'INDOOR');

    return ActivityItem(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ??
          json['whyThisActivity'] as String? ??
          '',
      ageTag: json['ageSuitability'] as String? ??
          json['ageTag'] as String? ??
          '3-7 years',
      imageUrl: json['imageUrl'] as String? ?? '',
      category: locationStr,
      childTarget: 'Eve',
      hasBadge: false,
      isScheduled: false,
    );
  }

  ActivityItem copyWith({
    String? id,
    String? title,
    String? description,
    String? ageTag,
    String? imageUrl,
    String? category,
    String? childTarget,
    bool? hasBadge,
    bool? isScheduled,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ageTag: ageTag ?? this.ageTag,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      childTarget: childTarget ?? this.childTarget,
      hasBadge: hasBadge ?? this.hasBadge,
      isScheduled: isScheduled ?? this.isScheduled,
    );
  }
}
