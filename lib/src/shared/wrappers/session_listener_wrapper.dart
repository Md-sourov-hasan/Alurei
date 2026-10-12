import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';

class SessionListenerWrapper extends HookWidget {
  final Widget child;
  const SessionListenerWrapper({super.key, required this.child});

  static String? _lastSyncedUserId;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      Worker? worker;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final session = Get.find<SessionController>();

        void handleStatus(SessionStatus status) {
          if (status != SessionStatus.unknown) {
            FlutterNativeSplash.remove();

            final current = Get.currentRoute;

            // Do not override navigation while on splash screen;
            // SplashController will handle navigation after the logo animation completes.
            if (current == AppRoutes.splash || current.isEmpty) {
              if (status == SessionStatus.authenticated) {
                _syncPreferredLanguageFromBackend(context, session);
              }
              return;
            }

            if (status == SessionStatus.authenticated) {
              _syncPreferredLanguageFromBackend(context, session);
              if (current != AppRoutes.main) {
                Future.microtask(
                  () => Get.offAllNamed<dynamic>(AppRoutes.main),
                );
              }
            } else if (status == SessionStatus.unauthenticated) {
              _lastSyncedUserId = null;
              if (current != AppRoutes.login &&
                  current != AppRoutes.roleSelection) {
                Future.microtask(
                  () => Get.offAllNamed<dynamic>(AppRoutes.login),
                );
              }
            }
          }
        }

        // Handle the initial state immediately
        handleStatus(session.status.value);

        // Listen for subsequent changes
        worker = ever(
          session.status,
          handleStatus,
          condition: () => session.status.value != SessionStatus.unknown,
        );
      });
      return () => worker?.dispose();
    }, []);

    return child;
  }

  Future<void> _syncPreferredLanguageFromBackend(
    BuildContext context,
    SessionController session,
  ) async {
    final user = session.user.value;
    if (user == null || _lastSyncedUserId == user.id) return;
    _lastSyncedUserId = user.id;

    final result = await AuthService.instance.getPreferredLanguage();
    await result.fold(
      (failure) async {
        AppLogger.warning(
          'Preferred language sync failed: ${failure.runtimeType}',
        );
      },
      (payload) async {
        final data = payload?['data'];
        final languageCode =
            data is Map<Object?, Object?> ? data['language'] as String? : null;
        if (languageCode == null || languageCode.trim().isEmpty) return;

        final locale = Locale(languageCode);
        await AuthSessionStorageService.instance
            .updateStoredPreferredLanguage(languageCode);
        await StorageService.instance.setString(
          'app_language_code',
          languageCode,
        );

        if (context.mounted && context.locale.languageCode != languageCode) {
          await context.setLocale(locale);
        }
        if (Get.locale?.languageCode != languageCode) {
          await Get.updateLocale(locale);
        }

        final currentUser = session.user.value;
        if (currentUser != null &&
            currentUser.preferredLanguage != languageCode) {
          session.acceptAuthenticatedUser(
            currentUser.copyWith(preferredLanguage: languageCode),
          );
        }
      },
    );
  }
}
