import 'package:dio/dio.dart';

class AppErrorHandler {
  static String format(dynamic error) {
    if (error is String) return error;

    if (error is DioException) {
      if (error.response?.data != null) {
        final data = error.response!.data;
        if (data is Map) {
          if (data['message'] != null &&
              data['message'].toString().trim().isNotEmpty) {
            return data['message'].toString();
          }
          if (data['error'] != null &&
              data['error'].toString().trim().isNotEmpty) {
            return data['error'].toString();
          }
        } else if (data is String && data.trim().isNotEmpty) {
          return data;
        }
      }

      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return 'Connection timed out. Please check your internet connection and try again.';
      }

      if (error.type == DioExceptionType.connectionError) {
        return 'Unable to connect to server. Please check your internet connection.';
      }

      final statusCode = error.response?.statusCode;
      if (statusCode == 400) {
        return 'Invalid email/phone number or password. Please try again.';
      } else if (statusCode == 401) {
        return 'Invalid credentials. Please check your details and try again.';
      } else if (statusCode == 403) {
        return 'Access denied. You do not have permission to perform this action.';
      } else if (statusCode == 404) {
        return 'Requested resource not found.';
      } else if (statusCode != null && statusCode >= 500) {
        return 'Server error ($statusCode). Please try again later.';
      }
    }

    try {
      if (error?.message != null) return error.message.toString();
      if (error?.toString() != null) return error.toString();
    } catch (_) {}

    return 'An unexpected error occurred. Please try again.';
  }
}
