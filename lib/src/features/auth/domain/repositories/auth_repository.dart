import 'package:alurei/src/utils/utils.dart';
import 'package:alurei/src/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  /// Stream of auth state changes. Emits AppUser when authenticated, null when not.
  Stream<AppUser?> get onAuthStateChanged;

  /// Sign in with exactly one identifier: email or phone number.
  FutureEither<AppUser> login({
    String? email,
    String? phoneNumber,
    required String password,
  });

  /// Sign up with email, password, and optional name
  FutureEither<AppUser> signUp({
    required String name,
    required String email,
    required String password,
  });

  /// Send a password reset email
  FutureEither<void> forgotPassword({
    required String email,
  });

  /// Sign out the current user
  FutureEither<void> logout();

  /// Clear local session state after the backend rejects the stored token.
  FutureEither<void> clearLocalSession();

  /// Check if the user is currently authenticated natively
  FutureEither<AppUser?> checkAuthState();

  /// Fetch the current user profile from the backend API
  FutureEither<AppUser?> getCurrentUser();
}
