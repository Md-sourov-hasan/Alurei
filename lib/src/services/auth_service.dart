import 'dart:async';
import 'dart:io';
import '../config/api_endpoints.dart';
import '../utils/utils.dart';
import '../config/app_config.dart';
import 'package:dio/dio.dart';

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  Dio get _dio => AppConfig.dio;

  // Custom Backend doesn't have a built-in auth state stream, so we manage our own
  final StreamController<Map<String, Object?>?> _authStateController =
      StreamController<Map<String, Object?>?>.broadcast();

  /// Stream of auth state changes. Emits the current user map or null.
  Stream<Map<String, Object?>?> get authStateChanges =>
      _authStateController.stream;

  /// Sends exactly one identifier field: email or phone number.
  FutureEither<Map<String, Object?>> signIn({
    String? email,
    String? phoneNumber,
    required String password,
  }) async {
    assert((email == null) != (phoneNumber == null));
    return runTask(() async {
      final response = await _dio.post<Map<String, Object?>>(
        ApiEndpoints.signIn,
        data: {
          if (email != null) 'email': email,
          if (phoneNumber != null) 'phoneNumber': phoneNumber,
          'password': password,
        },
      );
      return response.data!;
    }, requiresNetwork: true);
  }

  void emitAuthenticatedUser(Map<String, Object?> user) {
    _authStateController.add(user);
  }

  void emitSignedOut() => _authStateController.add(null);

  FutureEither<Map<String, dynamic>?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    return runTask(() async {
      final response = await _dio.post<Map<String, dynamic>>(
        ApiEndpoints.signUp,
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
      final data = response.data!;
      final user = data['user'];
      if (user is Map<Object?, Object?>) {
        _authStateController.add(user.cast<String, Object?>());
      }
      return data;
    }, requiresNetwork: true);
  }

  FutureEither<void> forgotPassword({required String email}) async {
    return runTask(() async {
      await _dio.post<void>(
        ApiEndpoints.forgotPassword,
        data: {'email': email},
      );
    }, requiresNetwork: true);
  }

  FutureEither<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return runTask(() async {
      AppLogger.info('Changing password for authenticated user');
      final response = await _dio.patch<Map<String, Object?>>(
        ApiEndpoints.changePassword,
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );

      final payload = response.data;
      final data = payload?['data'];
      if (data is Map<Object?, Object?>) {
        final message = data['message'] as String?;
        if (message != null && message.trim().isNotEmpty) return message;
      }

      final message = payload?['message'] as String?;
      return (message == null || message.trim().isEmpty)
          ? 'Password changed successfully'
          : message;
    }, requiresNetwork: true);
  }

  FutureEither<String> deleteAccount({
    required String reason,
    required String details,
  }) {
    return runTask(() async {
      AppLogger.info('Deleting authenticated user account');
      final response = await _dio.post<Map<String, Object?>>(
        ApiEndpoints.deleteAccount,
        data: {
          'reason': reason,
          'details': details,
        },
      );

      final payload = response.data;
      final data = payload?['data'];
      if (data is Map<Object?, Object?>) {
        final message = data['message'] as String?;
        if (message != null && message.trim().isNotEmpty) return message;
      }

      final message = payload?['message'] as String?;
      return (message == null || message.trim().isEmpty)
          ? 'Account deleted successfully'
          : message;
    }, requiresNetwork: true);
  }

  FutureEither<void> logout() async {
    return runTask(() async {
      await _dio.post<void>(ApiEndpoints.logout);
      _authStateController.add(null);
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, Object?>?> getCurrentUser() async {
    return runTask(() async {
      final response = await _dio.get<Map<String, Object?>>(
        ApiEndpoints.currentUser,
      );
      return response.data;
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, Object?>?> getLanguages() {
    return runTask(() async {
      AppLogger.info('Fetching available languages');
      final response = await _dio.get<Map<String, Object?>>(
        ApiEndpoints.languages,
      );
      return response.data;
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, Object?>?> getPreferredLanguage() {
    return runTask(() async {
      AppLogger.info('Fetching preferred language');
      final response = await _dio.get<Map<String, Object?>>(
        ApiEndpoints.preferredLanguage,
      );
      return response.data;
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, Object?>?> updatePreferredLanguage(
    String languageCode,
  ) {
    return runTask(() async {
      AppLogger.info('Updating preferred language');
      final response = await _dio.patch<Map<String, Object?>>(
        ApiEndpoints.preferredLanguage,
        data: {'language': languageCode},
      );
      return response.data;
    }, requiresNetwork: true);
  }

  FutureEither<Map<String, Object?>?> updateCurrentUser({
    required Map<String, dynamic> fields,
    File? profilePicture,
  }) async {
    return runTask(() async {
      final formDataMap = <String, dynamic>{
        ...fields,
      };
      if (profilePicture != null) {
        formDataMap['profilePicture'] = await MultipartFile.fromFile(
          profilePicture.path,
          filename: profilePicture.uri.pathSegments.last,
        );
      }

      final formData = FormData.fromMap(formDataMap);
      _logEditProfileRequest(formDataMap, profilePicture != null);

      try {
        final response = await _dio.patch<Map<String, Object?>>(
          ApiEndpoints.userProfile,
          data: formData,
          options: Options(
            contentType: Headers.multipartFormDataContentType,
          ),
        );
        _logEditProfileResponse(response);
        return response.data;
      } on DioException catch (error) {
        _logEditProfileError(error);
        rethrow;
      }
    }, requiresNetwork: true);
  }

  void _logEditProfileRequest(
    Map<String, dynamic> formDataMap,
    bool hasProfilePicture,
  ) {
    AppLogger.info(
      '[EditProfile] REQUEST\n'
      'Method: PATCH\n'
      'Route: ${AppConfig.baseUrl}${ApiEndpoints.userProfile}\n'
      'Headers: {Accept: application/json, Content-Type: multipart/form-data, '
      'Authorization: Bearer [redacted]}\n'
      'Body fields: ${formDataMap.keys.join(', ')}\n'
      'Profile picture attached: $hasProfilePicture',
    );
  }

  void _logEditProfileResponse(Response<Map<String, Object?>?> response) {
    AppLogger.info(
      '[EditProfile] RESPONSE\n'
      'Status: ${response.statusCode}\n'
      'Body: ${_summarizeResponseBody(response.data)}',
    );
  }

  void _logEditProfileError(DioException error) {
    AppLogger.error(
      '[EditProfile] ERROR\n'
      'Status: ${error.response?.statusCode}\n'
      'Body: ${_summarizeResponseBody(error.response?.data)}',
      error,
      error.stackTrace,
    );
  }

  String _summarizeResponseBody(Object? body) {
    if (body is Map<Object?, Object?>) {
      final data = body['data'];
      return {
        'success': body['success'],
        'statusCode': body['statusCode'],
        'message': body['message'],
        'path': body['path'],
        if (data is Map<Object?, Object?>) 'dataKeys': data.keys.toList(),
      }.toString();
    }
    return body?.runtimeType.toString() ?? 'null';
  }

  void dispose() {
    _authStateController.close();
  }
}
