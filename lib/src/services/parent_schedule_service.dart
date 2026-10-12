import 'package:dio/dio.dart';

import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../utils/utils.dart';

class ParentScheduleService {
  ParentScheduleService._();
  static final ParentScheduleService instance = ParentScheduleService._();

  Dio get _dio => AppConfig.dio;

  FutureEither<Map<String, dynamic>> getSchedules({
    required String childId,
    String view = 'ALL',
    int page = 1,
    int limit = 20,
  }) {
    return runTask(() async {
      AppLogger.debug(
        '[ParentScheduleService] GET ${_dio.options.baseUrl}${ApiEndpoints.parentSchedules}\n'
        'Headers: ${_debugHeaders()}\n'
        'Query: ${_debugBody({
              'childId': childId,
              'view': view,
              'page': page,
              'limit': limit,
            })}',
      );

      late final Response<dynamic> response;
      try {
        response = await _dio.get<dynamic>(
          ApiEndpoints.parentSchedules,
          queryParameters: {
            'childId': childId,
            'view': view,
            'page': page,
            'limit': limit,
          },
        );
      } on DioException catch (error) {
        AppLogger.error(
          '[ParentScheduleService] ERROR ${error.response?.statusCode} '
          '${error.requestOptions.uri}\n'
          'Response Body: ${_debugBody(error.response?.data)}',
          error,
          error.stackTrace,
        );
        rethrow;
      }

      AppLogger.debug(
        '[ParentScheduleService] RESPONSE ${response.statusCode} '
        '${response.requestOptions.uri}\n'
        'Body: ${_debugBody(response.data)}',
      );

      final responseBody = response.data;
      if (responseBody is Map) {
        final map = responseBody.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> createLibrarySchedule({
    required String childId,
    required String date,
    required String libraryItemId,
    required String libraryItemType,
    required String startTime,
    required String endTime,
    required String description,
  }) {
    return runTask(() async {
      final body = {
        'childId': childId,
        'date': date,
        'libraryItemId': libraryItemId,
        'libraryItemType': libraryItemType,
        'startTime': startTime,
        'endTime': endTime,
        'description': description,
      };
      AppLogger.debug(
        '[ParentScheduleService] POST ${_dio.options.baseUrl}${ApiEndpoints.parentScheduleLibrary}\n'
        'Headers: ${_debugHeaders()}\n'
        'Body: ${_debugBody(body)}',
      );

      late final Response<dynamic> response;
      try {
        response = await _dio.post<dynamic>(
          ApiEndpoints.parentScheduleLibrary,
          data: body,
        );
      } on DioException catch (error) {
        AppLogger.error(
          '[ParentScheduleService] ERROR ${error.response?.statusCode} '
          '${error.requestOptions.uri}\n'
          'Request Body: ${_debugBody(body)}\n'
          'Response Body: ${_debugBody(error.response?.data)}',
          error,
          error.stackTrace,
        );
        rethrow;
      }

      AppLogger.debug(
        '[ParentScheduleService] RESPONSE ${response.statusCode} '
        '${response.requestOptions.uri}\n'
        'Body: ${_debugBody(response.data)}',
      );

      final responseBody = response.data;
      if (responseBody is Map) {
        final map = responseBody.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> updateLibrarySchedule({
    required String scheduleId,
    required String date,
    required String libraryItemId,
    required String libraryItemType,
    required String startTime,
    required String endTime,
    required String description,
  }) {
    return runTask(() async {
      final path = '${ApiEndpoints.parentScheduleLibrary}/$scheduleId';
      final body = {
        'date': date,
        'libraryItemId': libraryItemId,
        'libraryItemType': libraryItemType,
        'startTime': startTime,
        'endTime': endTime,
        'description': description,
      };
      AppLogger.debug(
        '[ParentScheduleService] PATCH ${_dio.options.baseUrl}$path\n'
        'Headers: ${_debugHeaders()}\n'
        'Body: ${_debugBody(body)}',
      );

      late final Response<dynamic> response;
      try {
        response = await _dio.patch<dynamic>(path, data: body);
      } on DioException catch (error) {
        AppLogger.error(
          '[ParentScheduleService] ERROR ${error.response?.statusCode} '
          '${error.requestOptions.uri}\n'
          'Request Body: ${_debugBody(body)}\n'
          'Response Body: ${_debugBody(error.response?.data)}',
          error,
          error.stackTrace,
        );
        rethrow;
      }

      AppLogger.debug(
        '[ParentScheduleService] RESPONSE ${response.statusCode} '
        '${response.requestOptions.uri}\n'
        'Body: ${_debugBody(response.data)}',
      );

      final responseBody = response.data;
      if (responseBody is Map) {
        final map = responseBody.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> createManualSchedule({
    required String childId,
    required String date,
    required String title,
    required String category,
    required String startTime,
    required String endTime,
    required String description,
  }) {
    return runTask(() async {
      final body = {
        'childId': childId,
        'date': date,
        'title': title,
        'category': category,
        'startTime': startTime,
        'endTime': endTime,
        'description': description,
      };
      AppLogger.debug(
        '[ParentScheduleService] POST ${_dio.options.baseUrl}${ApiEndpoints.parentScheduleManual}\n'
        'Headers: ${_debugHeaders()}\n'
        'Body: ${_debugBody(body)}',
      );

      late final Response<dynamic> response;
      try {
        response = await _dio.post<dynamic>(
          ApiEndpoints.parentScheduleManual,
          data: body,
        );
      } on DioException catch (error) {
        AppLogger.error(
          '[ParentScheduleService] ERROR ${error.response?.statusCode} '
          '${error.requestOptions.uri}\n'
          'Request Body: ${_debugBody(body)}\n'
          'Response Body: ${_debugBody(error.response?.data)}',
          error,
          error.stackTrace,
        );
        rethrow;
      }

      AppLogger.debug(
        '[ParentScheduleService] RESPONSE ${response.statusCode} '
        '${response.requestOptions.uri}\n'
        'Body: ${_debugBody(response.data)}',
      );

      final responseBody = response.data;
      if (responseBody is Map) {
        final map = responseBody.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> deleteSchedule({
    required String scheduleId,
  }) {
    return runTask(() async {
      final path = '${ApiEndpoints.parentSchedules}/$scheduleId';
      AppLogger.debug(
        '[ParentScheduleService] DELETE ${_dio.options.baseUrl}$path\n'
        'Headers: ${_debugHeaders()}',
      );

      late final Response<dynamic> response;
      try {
        response = await _dio.delete<dynamic>(path);
      } on DioException catch (error) {
        AppLogger.error(
          '[ParentScheduleService] ERROR ${error.response?.statusCode} '
          '${error.requestOptions.uri}\n'
          'Response Body: ${_debugBody(error.response?.data)}',
          error,
          error.stackTrace,
        );
        rethrow;
      }

      AppLogger.debug(
        '[ParentScheduleService] RESPONSE ${response.statusCode} '
        '${response.requestOptions.uri}\n'
        'Body: ${_debugBody(response.data)}',
      );

      final responseBody = response.data;
      if (responseBody is Map) {
        final map = responseBody.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  Map<String, Object?> _debugHeaders() {
    return {
      ..._dio.options.headers,
      'Authorization': 'Bearer [redacted]',
    };
  }

  Object? _debugBody(Object? value) {
    if (value is Map) {
      return value.map((key, value) {
        final normalizedKey = key.toString().toLowerCase();
        if (normalizedKey == 'authorization') {
          return MapEntry(key, '[redacted]');
        }
        if (normalizedKey == 'childid' ||
            normalizedKey == 'userid' ||
            normalizedKey == 'parentuserid') {
          return MapEntry(key, '[redacted-family-id]');
        }
        if (normalizedKey == 'description' ||
            normalizedKey == 'additionalnotes') {
          return MapEntry(key, '[redacted-childcare-note]');
        }
        return MapEntry(key, _debugBody(value));
      });
    }
    if (value is List) {
      return value.map(_debugBody).toList(growable: false);
    }
    return value;
  }
}
