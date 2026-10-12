import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

import '../config/api_endpoints.dart';
import '../config/app_config.dart';
import '../utils/utils.dart';

class ParentChildrenService {
  ParentChildrenService._();
  static final ParentChildrenService instance = ParentChildrenService._();

  Dio get _dio => AppConfig.dio;

  FutureEither<List<Map<String, dynamic>>> getChildren() {
    return runTask(() async {
      final response = await _dio.get<dynamic>(ApiEndpoints.parentChildren);
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is List) {
          return data
              .whereType<Map<dynamic, dynamic>>()
              .map((child) => child.cast<String, dynamic>())
              .toList(growable: false);
        }
      }
      if (body is List) {
        return body
            .whereType<Map<dynamic, dynamic>>()
            .map((child) => child.cast<String, dynamic>())
            .toList(growable: false);
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> getChildById(String childId) {
    return runTask(() async {
      final path = ApiEndpoints.parentChild(childId);
      _logRequest('GET', path);
      final response = await _dio.get<dynamic>(path);
      _logResponse(response, bodyLabel: 'child-profile');
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> getChildDailyTimeline(String childId) {
    return runTask(() async {
      final path = ApiEndpoints.parentChildDailyTimeline(childId);
      _logRequest('GET', path);
      final response = await _dio.get<dynamic>(path);
      _logResponse(response, bodyLabel: 'child-daily-timeline');
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> deleteChild(String childId) {
    return runTask(() async {
      final path = ApiEndpoints.parentChild(childId);
      _logRequest('DELETE', path);
      final response = await _dio.delete<dynamic>(path);
      _logResponse(response, bodyLabel: 'child-delete');
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> createChild({
    required String name,
    String? wakeUpTime,
    String? bedTime,
  }) {
    return runTask(() async {
      final data = <String, Object?>{
        'name': name.trim(),
        if (wakeUpTime != null) 'wakeUpTime': wakeUpTime,
        if (bedTime != null) 'bedTime': bedTime,
      };
      _logRequest('POST', ApiEndpoints.parentChildren, bodyLabel: 'child');
      final response = await _dio.post<dynamic>(
        ApiEndpoints.parentChildren,
        data: data,
      );
      _logResponse(response, bodyLabel: 'child-profile');
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> updateChildName({
    required String childId,
    required String name,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChild(childId);
      _logRequest('PATCH', path, bodyLabel: 'child-name');
      final response = await _dio.patch<dynamic>(
        path,
        data: {'name': name.trim()},
      );
      _logResponse(response, bodyLabel: 'child-profile');

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> updateChildProfile({
    required String childId,
    required Map<String, Object?> data,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChild(childId);
      _logRequest('PATCH', path, bodyLabel: 'child-profile');
      final response = await _dio.patch<dynamic>(path, data: data);
      _logResponse(response, bodyLabel: 'child-profile');

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> updateChildProfileMultipart({
    required String childId,
    required Map<String, Object?> fields,
    File? profilePicture,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChild(childId);
      final formDataMap = <String, dynamic>{};
      fields.forEach((key, value) {
        if (value == null) return;
        if (value is Map || value is List) {
          formDataMap[key] = jsonEncode(value);
        } else if (value is bool || value is num) {
          formDataMap[key] = value.toString();
        } else {
          formDataMap[key] = value.toString();
        }
      });
      if (profilePicture != null) {
        formDataMap['profilePicture'] = await MultipartFile.fromFile(
          profilePicture.path,
          filename: profilePicture.uri.pathSegments.last,
        );
      }

      _logRequest('PATCH', path, bodyLabel: 'child-profile-multipart');
      final response = await _dio.patch<dynamic>(
        path,
        data: FormData.fromMap(formDataMap),
        options: Options(contentType: Headers.multipartFormDataContentType),
      );
      _logResponse(response, bodyLabel: 'child-profile');

      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  FutureEither<List<Map<String, dynamic>>> getRecurringActivities({
    required String childId,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChildRecurringActivities(childId);
      _logRequest('GET', path);
      final response = await _dio.get<dynamic>(path);
      _logResponse(response, bodyLabel: 'recurring-activities');
      final body = response.data;
      if (body is Map) {
        final data = body.cast<String, dynamic>()['data'];
        if (data is List) {
          return data
              .whereType<Map<dynamic, dynamic>>()
              .map((item) => item.cast<String, dynamic>())
              .toList(growable: false);
        }
      }
      if (body is List) {
        return body
            .whereType<Map<dynamic, dynamic>>()
            .map((item) => item.cast<String, dynamic>())
            .toList(growable: false);
      }
      return <Map<String, dynamic>>[];
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, dynamic>> addRecurringActivity({
    required String childId,
    required String name,
    required List<String> days,
    required String startTime,
    required String endTime,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChildRecurringActivities(childId);
      final body = {
        'name': name.trim(),
        'days': days,
        'startTime': startTime,
        'endTime': endTime,
      };
      _logRequest('POST', path, bodyLabel: 'recurring-activity');
      final response = await _dio.post<dynamic>(path, data: body);
      _logResponse(response, bodyLabel: 'recurring-activity');
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

  FutureEither<Map<String, dynamic>> updateRecurringActivity({
    required String childId,
    required String activityId,
    required String name,
    required List<String> days,
    required String startTime,
    required String endTime,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChildRecurringActivity(
        childId,
        activityId,
      );
      final body = {
        'name': name.trim(),
        'days': days,
        'startTime': startTime,
        'endTime': endTime,
      };
      _logRequest('PATCH', path, bodyLabel: 'recurring-activity');
      final response = await _dio.patch<dynamic>(path, data: body);
      _logResponse(response, bodyLabel: 'recurring-activity');
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

  FutureEither<Map<String, dynamic>> deleteRecurringActivity({
    required String childId,
    required String activityId,
  }) {
    return runTask(() async {
      final path = ApiEndpoints.parentChildRecurringActivity(
        childId,
        activityId,
      );
      _logRequest('DELETE', path);
      final response = await _dio.delete<dynamic>(path);
      _logResponse(response, bodyLabel: 'recurring-activity-delete');
      final body = response.data;
      if (body is Map) {
        final map = body.cast<String, dynamic>();
        final data = map['data'];
        if (data is Map) return data.cast<String, dynamic>();
        return map;
      }
      return <String, dynamic>{};
    }, requiresNetwork: true);
  }

  void _logRequest(String method, String path, {String? bodyLabel}) {
    AppLogger.debug(
      '[ParentChildrenService] REQUEST $method ${_dio.options.baseUrl}$path\n'
      'Headers: ${_safeHeaders(_dio.options.headers)}\n'
      'Body: ${bodyLabel == null ? '(empty)' : '[redacted-$bodyLabel]'}',
    );
  }

  void _logResponse(Response<dynamic> response, {required String bodyLabel}) {
    AppLogger.debug(
      '[ParentChildrenService] RESPONSE ${response.statusCode} '
      '${response.requestOptions.uri}\n'
      'Headers: ${_safeHeaders(response.requestOptions.headers)}\n'
      'Body: [redacted-$bodyLabel]',
    );
  }

  Map<String, Object?> _safeHeaders(Map<String, Object?> headers) {
    return headers.map((key, value) {
      if (key.toLowerCase() == 'authorization') {
        return MapEntry(key, 'Bearer [redacted]');
      }
      return MapEntry(key, value);
    });
  }
}
