import 'package:dio/dio.dart';

import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../shared/dummy_data/build_day_library_dummy_data.dart';
import '../utils/utils.dart';

import '../features/roles/parent/activities/domain/entities/activity_item.dart';

class LibraryService {
  LibraryService._();
  static final LibraryService instance = LibraryService._();

  Dio get _dio => AppConfig.dio;

  FutureEither<List<ActivityItem>> getActivities({
    int page = 1,
    int limit = 20,
    String? search,
  }) {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.allActivities,
        queryParameters: {
          'page': page,
          'limit': limit,
          if (search != null && search.trim().isNotEmpty)
            'search': search.trim(),
        },
      );

      final body = response.data;
      if (body is Map &&
          body['data'] is Map &&
          body['data']['activities'] is List) {
        final activitiesJson = body['data']['activities'] as List;
        final list = activitiesJson
            .whereType<Map<dynamic, dynamic>>()
            .map((e) => ActivityItem.fromJson(e.cast<String, dynamic>()))
            .toList();
        return list;
      }
      return <ActivityItem>[];
    }, requiresNetwork: true);
  }

  FutureEither<BuildDayLibraryResult> getLibrary({
    String? search,
    String? recipeMealType,
    String? activityType,
    String? location,
    int? minAge,
    int? maxAge,
    int page = 1,
    int limit = 6,
  }) {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.library,
        queryParameters: {
          if (search != null && search.trim().isNotEmpty)
            'search': search.trim(),
          if (recipeMealType != null && recipeMealType.trim().isNotEmpty)
            'recipeMealType': recipeMealType.trim(),
          if (activityType != null && activityType.trim().isNotEmpty)
            'activityType': activityType.trim(),
          if (location != null && location.trim().isNotEmpty)
            'location': location.trim(),
          if (minAge != null) 'minAge': minAge,
          if (maxAge != null) 'maxAge': maxAge,
          'page': page,
          'limit': limit,
        },
      );

      final body = response.data;
      if (body is Map) {
        return BuildDayLibraryResult.fromMap(body.cast<String, dynamic>());
      }
      return BuildDayLibraryResult.empty;
    }, requiresNetwork: true);
  }
}
