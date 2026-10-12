import 'package:flutter/foundation.dart';

@immutable
class CareModuleItem {
  const CareModuleItem({
    required this.id,
    required this.title,
    required this.durationText,
    required this.coinsText,
    required this.imageUrl,
    this.category = 'Behavior',
    this.childTarget = 'Eve',
    this.childId = '',
    this.nannyUserId = '',
    this.isBookmarked = false,
    this.isAddedToWeek = false,
    this.status = 'all',
    this.progressPercentage = 0.65,
    this.progressText = '65% Complete',
  });

  final String id;
  final String title;
  final String durationText;
  final String coinsText;
  final String imageUrl;
  final String category;
  final String childTarget;
  final String childId;
  final String nannyUserId;
  final bool isBookmarked;
  final bool isAddedToWeek;
  final String status;
  final double progressPercentage;
  final String progressText;

  CareModuleItem copyWith({
    String? id,
    String? title,
    String? durationText,
    String? coinsText,
    String? imageUrl,
    String? category,
    String? childTarget,
    String? childId,
    String? nannyUserId,
    bool? isBookmarked,
    bool? isAddedToWeek,
    String? status,
    double? progressPercentage,
    String? progressText,
  }) {
    return CareModuleItem(
      id: id ?? this.id,
      title: title ?? this.title,
      durationText: durationText ?? this.durationText,
      coinsText: coinsText ?? this.coinsText,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      childTarget: childTarget ?? this.childTarget,
      childId: childId ?? this.childId,
      nannyUserId: nannyUserId ?? this.nannyUserId,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isAddedToWeek: isAddedToWeek ?? this.isAddedToWeek,
      status: status ?? this.status,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      progressText: progressText ?? this.progressText,
    );
  }

  factory CareModuleItem.fromJson(Map<String, dynamic> json) {
    final estMin = json['estimatedMinutes'] as num? ?? 50;
    final coins = json['coinReward'] as num? ?? 0;
    final childObj = json['child'] as Map<String, dynamic>?;
    final nannyObj = json['nanny'] as Map<String, dynamic>?;
    final moduleObj = json['module'] as Map<String, dynamic>?;

    final targetJson = moduleObj ?? json;

    String parsedImageUrl = targetJson['coverImageUrl'] as String? ??
        targetJson['imageUrl'] as String? ??
        json['coverImageUrl'] as String? ??
        json['imageUrl'] as String? ??
        '';

    if (parsedImageUrl.contains('photo-1595454038955-4d80d06358b2')) {
      parsedImageUrl =
          'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?q=80&w=1200&auto=format&fit=crop';
    }

    return CareModuleItem(
      id: targetJson['id'] as String? ?? json['id'] as String? ?? '',
      title: targetJson['title'] as String? ?? json['title'] as String? ?? '',
      durationText: '${estMin}m',
      coinsText: coins > 0 ? '$coins Coins' : '',
      imageUrl: parsedImageUrl,
      category: targetJson['category'] as String? ?? json['category'] as String? ?? 'OTHER',
      childTarget: childObj?['name'] as String? ?? '',
      childId: json['childId'] as String? ?? childObj?['id'] as String? ?? '',
      nannyUserId: json['nannyUserId'] as String? ?? nannyObj?['id'] as String? ?? '',
      isBookmarked: json['isBookmarked'] as bool? ?? json['isSaved'] as bool? ?? false,
      status: json['status'] as String? ?? 'all',
    );
  }
}
