import 'package:dio/dio.dart';
import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../features/roles/parent/care/domain/entities/care_assignment.dart';
import '../features/roles/parent/care/domain/entities/care_module_detail.dart';
import '../features/roles/parent/care/domain/entities/care_module_item.dart';
import '../utils/utils.dart';

class CareService {
  CareService._();
  static final CareService instance = CareService._();

  Dio get _dio => AppConfig.dio;

  /// Fetches parent's children via GET /parent/children.
  FutureEither<List<Map<String, dynamic>>> getChildren() async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.parentChildren,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is List) {
          return (map['data'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList();
        }
      } else if (body is List) {
        return body
            .whereType<Map<dynamic, dynamic>>()
            .map((item) => item.cast<String, dynamic>())
            .toList();
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  /// Fetches care home data via GET /care/home.
  FutureEither<Map<String, dynamic>> getCareHome({
    String? tab = 'ALL',
    String? topicId = 'ALL',
    String? childId,
    String? nannyUserId,
    int page = 1,
    int limit = 20,
  }) async {
    return runTask(() async {
      final queryParams = <String, dynamic>{
        if (tab != null && tab.isNotEmpty) 'tab': tab,
        if (topicId != null && topicId.isNotEmpty) 'topicId': topicId,
        if (childId != null && childId.isNotEmpty) 'childId': childId,
        if (nannyUserId != null && nannyUserId.isNotEmpty)
          'nannyUserId': nannyUserId,
        'page': page,
        'limit': limit,
      };

      final response = await _dio.get<dynamic>(
        ApiEndpoints.careHome,
        queryParameters: queryParams,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          return (map['data'] as Map).cast<String, dynamic>();
        }
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Fetches suggested care modules for a child via GET /care/children/:childId/suggested-modules.
  FutureEither<List<CareModuleItem>> getSuggestedCareModules(
    String childId, {
    String? tab = 'ALL',
    String? nannyUserId,
    int page = 1,
    int limit = 20,
  }) async {
    return runTask(() async {
      final queryParams = <String, dynamic>{
        'adminStatus': 'ALL',
        if (tab != null && tab.isNotEmpty) 'tab': tab,
        if (nannyUserId != null && nannyUserId.isNotEmpty)
          'nannyUserId': nannyUserId,
        'page': page,
        'limit': limit,
      };

      final url = ApiEndpoints.careChildSuggestedModules(childId);
      AppLogger.info(
        '🌐 [CareService] GET SUGGESTED MODULES => URL: $url\n'
        '📦 QueryParams: $queryParams',
      );

      final response = await _dio.get<dynamic>(
        url,
        queryParameters: queryParams,
      );

      final body = response.data;
      AppLogger.info('✅ [CareService] SUGGESTED MODULES RESPONSE => $body');

      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final dataMap = map['data'];
        if (dataMap is Map && dataMap['modules'] is List) {
          final list = (dataMap['modules'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) =>
                  CareModuleItem.fromJson(item.cast<String, dynamic>()))
              .toList();
          AppLogger.info(
              '📦 [CareService] Parsed ${list.length} suggested modules for childId: $childId');
          return list;
        }
      }
      return <CareModuleItem>[];
    }, requiresNetwork: true);
  }

  /// Fetches a single care module detail via GET /care/modules/:moduleId.
  FutureEither<CareModuleDetail> getCareModuleDetail(String moduleId) async {
    return runTask(() async {
      AppLogger.info(
        '🌐 [CareService] GET MODULE DETAIL => ${ApiEndpoints.careModuleDetail(moduleId)}',
      );
      final response = await _dio.get<dynamic>(
        ApiEndpoints.careModuleDetail(moduleId),
      );

      final body = response.data;
      AppLogger.info('✅ [CareService] MODULE DETAIL RESPONSE => $body');

      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          final dataMap = (map['data'] as Map).cast<String, dynamic>();
          return CareModuleDetail.fromJson(dataMap);
        }
      }
      throw Exception('Failed to parse care module detail response');
    }, requiresNetwork: true);
  }

  /// Fetches care modules via GET /care/modules.
  FutureEither<List<CareModuleItem>> getCareModules({String? childId}) async {
    return runTask(() async {
      final response = await _dio.get<dynamic>(
        ApiEndpoints.careModules,
        queryParameters: (childId != null && childId.isNotEmpty)
            ? {'childId': childId}
            : null,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is List) {
          final list = (map['data'] as List)
              .whereType<Map<dynamic, dynamic>>()
              .map((item) =>
                  CareModuleItem.fromJson(item.cast<String, dynamic>()))
              .toList();
          return list;
        }
      } else if (body is List) {
        return body
            .whereType<Map<dynamic, dynamic>>()
            .map(
                (item) => CareModuleItem.fromJson(item.cast<String, dynamic>()))
            .toList();
      }
      return <CareModuleItem>[];
    }, requiresNetwork: true);
  }

  /// Assigns a care module to a child and nanny via POST /care/assignments.
  FutureEither<CareAssignment> assignCareModule({
    required String moduleId,
    required String childId,
    required String nannyUserId,
  }) async {
    return runTask(() async {
      final payload = <String, dynamic>{
        'moduleId': moduleId,
        'childId': childId,
        'nannyUserId': nannyUserId,
      };

      final response = await _dio.post<dynamic>(
        ApiEndpoints.careAssignments,
        data: payload,
      );

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        if (map['data'] is Map) {
          final dataMap = (map['data'] as Map).cast<String, dynamic>();
          return CareAssignment.fromJson(dataMap);
        }
      }
      throw Exception('Failed to parse care assignment response');
    }, requiresNetwork: true);
  }

  /// Saves (bookmarks) a care module via POST /care/modules/:moduleId/save.
  FutureEither<Map<String, dynamic>> saveCareModule(
    String moduleId, {
    String? childId,
  }) async {
    return runTask(() async {
      final payload = <String, dynamic>{
        if (childId != null && childId.isNotEmpty) 'childId': childId,
      };

      AppLogger.info(
        '🌐 [CareService] POST SAVE CARE MODULE => ${ApiEndpoints.careModuleSave(moduleId)}\n'
        '📦 Payload: $payload',
      );

      final response = await _dio.post<dynamic>(
        ApiEndpoints.careModuleSave(moduleId),
        data: payload.isNotEmpty ? payload : null,
      );

      final body = response.data;
      AppLogger.info('✅ [CareService] SAVE CARE MODULE RESPONSE => $body');

      if (body is Map) {
        return body.cast<String, dynamic>();
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  /// Unsaves (removes bookmark) a care module via DELETE /care/modules/:moduleId/save.
  FutureEither<Map<String, dynamic>> unsaveCareModule(
    String moduleId, {
    String? childId,
  }) async {
    return runTask(() async {
      final payload = <String, dynamic>{
        if (childId != null && childId.isNotEmpty) 'childId': childId,
      };

      AppLogger.info(
        '🌐 [CareService] DELETE UNSAVE CARE MODULE => ${ApiEndpoints.careModuleSave(moduleId)}\n'
        '📦 Payload: $payload',
      );

      final response = await _dio.delete<dynamic>(
        ApiEndpoints.careModuleSave(moduleId),
        data: payload.isNotEmpty ? payload : null,
      );

      final body = response.data;
      AppLogger.info('✅ [CareService] UNSAVE CARE MODULE RESPONSE => $body');

      if (body is Map) {
        return body.cast<String, dynamic>();
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }
}
