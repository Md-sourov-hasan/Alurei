import 'dart:async';
import 'package:alurei/src/imports/imports.dart';
import 'package:alurei/src/features/auth/domain/entities/user.dart';
import 'package:alurei/src/features/auth/domain/repositories/auth_repository.dart';

enum SessionStatus { unknown, authenticated, unauthenticated }

class SessionController extends GetxController {
  final AuthRepository _repository;
  StreamSubscription<AppUser?>? _authSub;

  final Rx<SessionStatus> status = SessionStatus.unknown.obs;
  final Rx<AppUser?> user = Rx<AppUser?>(null);
  final isProfileLoading = false.obs;

  bool get isAuthenticated => status.value == SessionStatus.authenticated;

  SessionController({required AuthRepository repository})
      : _repository = repository;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  static const defaultParentUser = AppUser(
    id: 'default_parent',
    email: 'monica@example.com',
    fullName: 'Monica Steve',
    role: AppUserRole.parent,
  );

  Future<void> _init() async {
    final result = await _repository.checkAuthState();
    result.fold(
      (_) => _setUnauthenticated(),
      (u) {
        if (u != null) {
          user.value = u;
          status.value = SessionStatus.authenticated;
          fetchUserProfile();
        } else {
          _setUnauthenticated();
        }
      },
    );

    _authSub = _repository.onAuthStateChanged.listen((u) {
      if (u != null) {
        user.value = u;
        status.value = SessionStatus.authenticated;
        fetchUserProfile();
      } else {
        _setUnauthenticated();
      }
    });
  }

  Future<void> fetchUserProfile() async {
    if (isProfileLoading.value) return;
    isProfileLoading.value = true;
    try {
      final result = await _repository.getCurrentUser();
      result.fold(
        (failure) {
          AppLogger.warning(
            'Failed to fetch current user profile: ${failure.message}',
          );
        },
        (fetchedUser) {
          if (fetchedUser != null) {
            user.value = fetchedUser;
            status.value = SessionStatus.authenticated;
          }
        },
      );
    } finally {
      isProfileLoading.value = false;
    }
  }

  void _setUnauthenticated() {
    user.value = null;
    status.value = SessionStatus.unauthenticated;
  }

  Future<void> logout() async {
    await _repository.logout();
    user.value = null;
    status.value = SessionStatus.unauthenticated;
  }

  Future<void> expireSession() async {
    await _repository.clearLocalSession();
    user.value = null;
    status.value = SessionStatus.unauthenticated;
  }

  void acceptAuthenticatedUser(AppUser authenticatedUser) {
    user.value = authenticatedUser;
    status.value = SessionStatus.authenticated;
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }
}
