import '../imports/core_imports.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig._();
  static late final Dio dio;

  static String get baseUrl => _getBaseUrl();

  static Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: _getBaseUrl(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!_isPublicAuthRequest(options.path)) {
            final tokenResult =
                await AuthSessionStorageService.instance.readAccessToken();
            tokenResult.fold(
              (_) {},
              (token) {
                if (token != null && token.isNotEmpty) {
                  options.headers['Authorization'] = 'Bearer $token';
                }
              },
            );
          }
          AppLogger.info(
            '🌐 [DIO] REQUEST[${options.method}] => URL: ${options.uri}\n'
            '🔑 Headers: ${_redactedHeaders(options.headers)}',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.info(
            '✅ [DIO] RESPONSE[${response.statusCode}] => '
            'URL: ${response.requestOptions.uri}',
          );
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          AppLogger.error(
            '❌ [DIO] ERROR[${e.response?.statusCode}] => URL: ${e.requestOptions.uri}\n'
            '⚠️ Error Message: ${e.message}',
          );
          return handler.next(e);
        },
      ),
    );
  }

  static bool _isPublicAuthRequest(String path) {
    return path == ApiEndpoints.signIn ||
        path == ApiEndpoints.login ||
        path == ApiEndpoints.signUp ||
        path == ApiEndpoints.forgotPassword;
  }

  static Map<String, Object?> _redactedHeaders(Map<String, Object?> headers) {
    return headers.map((key, value) {
      if (key.toLowerCase() == 'authorization') {
        return MapEntry(key, 'Bearer [redacted]');
      }
      return MapEntry(key, value);
    });
  }

  static String _getBaseUrl() {
    final envUrl = dotenv.maybeGet('API_BASE_URL') ??
        dotenv.maybeGet('BASE_URL') ??
        'https://evatar-backend.onrender.com/api/v1';
    return envUrl.endsWith('/')
        ? envUrl.substring(0, envUrl.length - 1)
        : envUrl;
  }
}
