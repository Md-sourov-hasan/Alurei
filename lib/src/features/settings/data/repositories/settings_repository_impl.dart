import 'package:alurei/src/features/settings/domain/repositories/settings_repository.dart';
import 'package:alurei/src/imports/core_imports.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({
    AuthService? authService,
  }) : _authService = authService ?? AuthService.instance;

  final AuthService _authService;

  @override
  FutureEither<String> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    return _authService.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  @override
  FutureEither<String> deleteAccount({
    required String reason,
    required String details,
  }) {
    return _authService.deleteAccount(
      reason: reason,
      details: details,
    );
  }
}
