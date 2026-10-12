import 'package:alurei/src/config/api_endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiEndpoints', () {
    const endpoints = <String>{
      ApiEndpoints.login,
      ApiEndpoints.signUp,
      ApiEndpoints.forgotPassword,
      ApiEndpoints.logout,
      ApiEndpoints.currentUser,
      ApiEndpoints.parentKitchenItems,
    };

    test('contains every current endpoint once', () {
      expect(endpoints, hasLength(6));
    });

    test('uses relative paths supplied to the shared Dio base URL', () {
      for (final endpoint in endpoints) {
        expect(endpoint, startsWith('/'));
        expect(Uri.parse(endpoint).hasScheme, isFalse);
        expect(Uri.parse(endpoint).host, isEmpty);
      }
    });
  });
}
