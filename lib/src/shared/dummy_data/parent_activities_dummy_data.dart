import 'package:alurei/src/imports/imports.dart';
import '../../features/roles/parent/activities/domain/entities/activity_item.dart';

/// Central fixture data for the Parent Activities tab.
class ParentActivitiesDummyData {
  ParentActivitiesDummyData._();

  static const List<ActivityItem> suggestedActivities = [
    ActivityItem(
      id: 'sug_1',
      title: 'Magical Bubble Trail',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      ageTag: '1 Year Old',
      imageUrl: AppAssets.activityBearArtwork,
      category: 'Indoor',
      childTarget: 'Eve',
    ),
    ActivityItem(
      id: 'sug_2',
      title: 'Magical Nature Trail',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      ageTag: '1 Year Old',
      imageUrl: AppAssets.activityPlayground,
      category: 'Outdoor',
      childTarget: 'Rose',
    ),
  ];

  static const List<ActivityItem> allActivities = [
    ActivityItem(
      id: 'all_1',
      title: 'Magical Bubble Trail',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      ageTag: '1 Year Old',
      imageUrl: AppAssets.activityPlayground,
      category: 'Outdoor',
      childTarget: 'Eve',
    ),
    ActivityItem(
      id: 'all_2',
      title: 'Magical Bubble Trail',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      ageTag: '1 Year Old',
      imageUrl: AppAssets.activityBearArtwork,
      category: 'Indoor',
      childTarget: 'Eve',
    ),
    ActivityItem(
      id: 'all_3',
      title: 'Magical Bubble Trail',
      description:
          'Follow a bubble trail created at different heights, Encourages tracking, reaching, and anticipation.',
      ageTag: '1 Year Old',
      imageUrl: AppAssets.activityPlayground,
      category: 'Outdoor',
      childTarget: 'Eve',
      hasBadge: true,
    ),
  ];
}
