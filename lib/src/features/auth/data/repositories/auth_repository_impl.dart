import 'package:alurei/src/imports/core_imports.dart';
import 'package:alurei/src/imports/packages_imports.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService.instance;
  final AuthSessionStorageService _sessionStorage =
      AuthSessionStorageService.instance;

  @override
  Stream<AppUser?> get onAuthStateChanged {
    return _authService.authStateChanges.map(
      (userData) =>
          userData == null ? null : UserModel.fromJson(userData).toEntity(),
    );
  }

  @override
  FutureEither<AppUser> login({
    String? email,
    String? phoneNumber,
    required String password,
  }) async {
    if ((email == null) == (phoneNumber == null)) {
      return left(
        const ServerFailure('Provide either email or phone number.'),
      );
    }

    final response = await _authService.signIn(
      email: email,
      phoneNumber: phoneNumber,
      password: password,
    );

    return response.fold(
      (failure) async => left(failure),
      (payload) async {
        try {
          final model = SignInResponseModel.fromJson(payload);
          final stored = await _sessionStorage.saveSession(
            accessToken: model.accessToken,
            refreshToken: model.refreshToken,
            user: model.user.toStorageMap(),
          );
          return stored.fold(left, (_) {
            _authService.emitAuthenticatedUser(model.user.toStorageMap());
            return right(model.user.toEntity());
          });
        } catch (error) {
          return left(ServerFailure('Invalid signin response.', error: error));
        }
      },
    );
  }

  @override
  FutureEither<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await _authService.signUp(
      name: name,
      email: email,
      password: password,
    );

    return result.flatMap((userData) {
      if (userData == null) {
        return left(const ServerFailure('Sign up failed: User not found.'));
      }
      final rawUser = userData['user'];
      if (rawUser is! Map<Object?, Object?>) {
        return left(const ServerFailure('Sign up returned an invalid user.'));
      }
      return right(
        UserModel.fromJson(rawUser.cast<String, Object?>()).toEntity(),
      );
    });
  }

  @override
  FutureEither<void> forgotPassword({required String email}) {
    return _authService.forgotPassword(email: email);
  }

  @override
  FutureEither<void> logout() async {
    final remoteResult = await _authService.logout();
    final localResult = await _sessionStorage.clearSession();
    _authService.emitSignedOut();

    return localResult.fold(
      left,
      (_) => remoteResult,
    );
  }

  @override
  FutureEither<void> clearLocalSession() async {
    final localResult = await _sessionStorage.clearSession();
    _authService.emitSignedOut();
    return localResult;
  }

  @override
  FutureEither<AppUser?> checkAuthState() async {
    final result = await _sessionStorage.restoreUser();
    return result.map(
      (userData) =>
          userData == null ? null : UserModel.fromJson(userData).toEntity(),
    );
  }

  @override
  FutureEither<AppUser?> getCurrentUser() async {
    final result = await _authService.getCurrentUser();
    return result.fold(
      (failure) async => left(failure),
      (userData) async {
        if (userData == null) return right(null);
        final rawUser = userData['data'] ?? userData['user'] ?? userData;
        UserModel? model;
        if (rawUser is Map<String, dynamic>) {
          model = UserModel.fromJson(rawUser);
        } else if (rawUser is Map<Object?, Object?>) {
          model = UserModel.fromJson(rawUser.cast<String, Object?>());
        }
        if (model == null) return right(null);
        await _sessionStorage.updateStoredUser(model.toStorageMap());
        return right(model.toEntity());
      },
    );
  }
}
