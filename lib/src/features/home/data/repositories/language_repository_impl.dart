import 'package:alurei/src/features/home/data/models/app_language_model.dart';
import 'package:alurei/src/features/home/domain/entities/app_language.dart';
import 'package:alurei/src/features/home/domain/repositories/language_repository.dart';
import 'package:alurei/src/imports/core_imports.dart';
import 'package:fpdart/fpdart.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  LanguageRepositoryImpl({
    AuthService? authService,
    AuthSessionStorageService? sessionStorage,
  })  : _authService = authService ?? AuthService.instance,
        _sessionStorage = sessionStorage ?? AuthSessionStorageService.instance;

  final AuthService _authService;
  final AuthSessionStorageService _sessionStorage;

  @override
  FutureEither<List<AppLanguage>> getLanguages() async {
    final result = await _authService.getLanguages();
    return result.fold(
      left,
      (payload) {
        try {
          final data = payload?['data'];
          if (data is! List<Object?>) {
            return left(const ServerFailure('Language response was invalid.'));
          }

          final languages = data
              .whereType<Map<Object?, Object?>>()
              .map((item) => item.cast<String, Object?>())
              .map(AppLanguageModel.fromJson)
              .map((model) => model.toEntity())
              .where((language) => language.code.isNotEmpty)
              .toList();

          return right(languages);
        } catch (error) {
          return left(
              ServerFailure('Invalid language response.', error: error));
        }
      },
    );
  }

  @override
  FutureEither<String> getPreferredLanguage() async {
    final result = await _authService.getPreferredLanguage();
    return result.fold(
      left,
      (payload) {
        final data = payload?['data'];
        if (data is Map<Object?, Object?>) {
          final language = data['language'] as String?;
          if (language != null && language.trim().isNotEmpty) {
            return right(language);
          }
        }
        return right('en');
      },
    );
  }

  @override
  FutureEither<String> updatePreferredLanguage(String languageCode) async {
    final result = await _authService.updatePreferredLanguage(languageCode);
    return result.fold(
      (failure) async => left(failure),
      (payload) async {
        final data = payload?['data'];
        final updatedLanguage = data is Map<Object?, Object?>
            ? data['language'] as String? ?? languageCode
            : languageCode;

        final stored = await _sessionStorage.updateStoredPreferredLanguage(
          updatedLanguage,
        );
        return stored.fold(left, (_) => right(updatedLanguage));
      },
    );
  }
}
