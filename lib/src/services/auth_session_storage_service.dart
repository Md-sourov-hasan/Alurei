import '../utils/utils.dart';
import 'secure_storage_service.dart';
import 'storage_service.dart';

/// Persists authentication secrets separately from non-sensitive user metadata.
///
/// Access and refresh tokens are written only to platform secure storage. The
/// role and profile fields required to restore routing/session state are stored
/// in SharedPreferences.
class AuthSessionStorageService {
  AuthSessionStorageService._();

  static final AuthSessionStorageService instance =
      AuthSessionStorageService._();

  static const _accessTokenKey = 'auth.access_token';
  static const _refreshTokenKey = 'auth.refresh_token';
  static const _userIdKey = 'auth.user.id';
  static const _fullNameKey = 'auth.user.full_name';
  static const _emailKey = 'auth.user.email';
  static const _phoneKey = 'auth.user.phone_number';
  static const _profilePictureKey = 'auth.user.profile_picture_url';
  static const _languageKey = 'auth.user.preferred_language';
  static const _roleKey = 'auth.user.role';
  static const _emailVerifiedKey = 'auth.user.email_verified';
  static const _phoneVerifiedKey = 'auth.user.phone_verified';
  static const _activeKey = 'auth.user.active';
  static const _verificationStatusKey = 'auth.user.verification_status';
  static const _relationshipKey = 'auth.user.relationship';
  static const _addressKey = 'auth.user.address';

  final _secureStorage = SecureStorageService.instance;
  final _localStorage = StorageService.instance;

  FutureEither<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required Map<String, Object?> user,
  }) {
    return runTask(() async {
      await _unwrap(_secureStorage.write(_accessTokenKey, accessToken));
      await _unwrap(_secureStorage.write(_refreshTokenKey, refreshToken));

      await _setString(_userIdKey, user['id'] as String?);
      await _setString(_fullNameKey, user['fullName'] as String?);
      await _setString(_emailKey, user['email'] as String?);
      await _setString(_phoneKey, user['phoneNumber'] as String?);
      await _setString(
        _profilePictureKey,
        user['profilePictureUrl'] as String?,
      );
      await _setString(
        _languageKey,
        user['preferredLanguage'] as String? ?? 'en',
      );
      await _setString(_roleKey, user['role'] as String?);
      await _setString(
        _verificationStatusKey,
        user['verificationStatus'] as String?,
      );
      await _unwrap(
        _localStorage.setBool(
          _emailVerifiedKey,
          user['isEmailVerified'] as bool? ?? false,
        ),
      );
      await _unwrap(
        _localStorage.setBool(
          _phoneVerifiedKey,
          user['isPhoneVerified'] as bool? ?? false,
        ),
      );
      await _unwrap(
        _localStorage.setBool(
          _activeKey,
          user['isActive'] as bool? ?? true,
        ),
      );
      await _setString(
        _relationshipKey,
        (user['relationShip'] ?? user['relationship']) as String?,
      );
      await _setString(_addressKey, user['address'] as String?);
    });
  }

  FutureEither<void> updateStoredUser(Map<String, Object?> user) {
    return runTask(() async {
      await _setString(_userIdKey, user['id'] as String?);
      await _setString(_fullNameKey, user['fullName'] as String?);
      await _setString(_emailKey, user['email'] as String?);
      await _setString(_phoneKey, user['phoneNumber'] as String?);
      await _setString(
        _profilePictureKey,
        user['profilePictureUrl'] as String?,
      );
      await _setString(
        _languageKey,
        user['preferredLanguage'] as String? ?? 'en',
      );
      await _setString(_roleKey, user['role'] as String?);
      await _setString(
        _verificationStatusKey,
        user['verificationStatus'] as String?,
      );
      await _setString(
        _relationshipKey,
        (user['relationShip'] ?? user['relationship']) as String?,
      );
      await _setString(_addressKey, user['address'] as String?);
      await _unwrap(
        _localStorage.setBool(
          _emailVerifiedKey,
          user['isEmailVerified'] as bool? ?? false,
        ),
      );
      await _unwrap(
        _localStorage.setBool(
          _phoneVerifiedKey,
          user['isPhoneVerified'] as bool? ?? false,
        ),
      );
      await _unwrap(
        _localStorage.setBool(
          _activeKey,
          user['isActive'] as bool? ?? true,
        ),
      );
      AppLogger.info('Stored authenticated user metadata updated locally');
    });
  }

  FutureEither<void> updateStoredPreferredLanguage(String languageCode) {
    return runTask(() async {
      await _setString(_languageKey, languageCode);
      AppLogger.info('Stored preferred language updated locally');
    });
  }

  String? get userId => _localStorage.getString(_userIdKey);

  /// Restores locally persisted user metadata only when an access token exists.
  FutureEither<Map<String, Object?>?> restoreUser() {
    return runTask(() async {
      final accessToken = await _unwrap(
        _secureStorage.read(_accessTokenKey),
      );
      final id = _localStorage.getString(_userIdKey);
      final role = _localStorage.getString(_roleKey);
      if (accessToken == null || id == null || role == null) return null;

      return <String, Object?>{
        'id': id,
        'fullName': _localStorage.getString(_fullNameKey),
        'email': _localStorage.getString(_emailKey) ?? '',
        'phoneNumber': _localStorage.getString(_phoneKey),
        'profilePictureUrl': _localStorage.getString(_profilePictureKey),
        'preferredLanguage': _localStorage.getString(_languageKey) ?? 'en',
        'role': role,
        'isEmailVerified': _localStorage.getBool(_emailVerifiedKey) ?? false,
        'isPhoneVerified': _localStorage.getBool(_phoneVerifiedKey) ?? false,
        'isActive': _localStorage.getBool(_activeKey) ?? true,
        'verificationStatus': _localStorage.getString(_verificationStatusKey),
        'relationShip': _localStorage.getString(_relationshipKey),
        'address': _localStorage.getString(_addressKey),
      };
    });
  }

  FutureEither<String?> readAccessToken() =>
      _secureStorage.read(_accessTokenKey);

  FutureEither<void> clearSession() {
    return runTask(() async {
      await _unwrap(_secureStorage.delete(_accessTokenKey));
      await _unwrap(_secureStorage.delete(_refreshTokenKey));
      for (final key in _localKeys) {
        await _unwrap(_localStorage.remove(key));
      }
    });
  }

  static const _localKeys = [
    _userIdKey,
    _fullNameKey,
    _emailKey,
    _phoneKey,
    _profilePictureKey,
    _languageKey,
    _roleKey,
    _emailVerifiedKey,
    _phoneVerifiedKey,
    _activeKey,
    _verificationStatusKey,
    _relationshipKey,
    _addressKey,
  ];

  Future<void> _setString(String key, String? value) async {
    if (value == null || value.isEmpty) {
      await _unwrap(_localStorage.remove(key));
      return;
    }
    await _unwrap(_localStorage.setString(key, value));
  }

  Future<T> _unwrap<T>(FutureEither<T> operation) async {
    final result = await operation;
    return result.fold((failure) => throw failure, (value) => value);
  }
}
