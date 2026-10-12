import 'package:alurei/src/utils/utils.dart';

abstract class SettingsRepository {
  FutureEither<String> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  FutureEither<String> deleteAccount({
    required String reason,
    required String details,
  });
}
