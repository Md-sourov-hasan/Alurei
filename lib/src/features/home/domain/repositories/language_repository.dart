import 'package:alurei/src/features/home/domain/entities/app_language.dart';
import 'package:alurei/src/utils/utils.dart';

abstract class LanguageRepository {
  FutureEither<List<AppLanguage>> getLanguages();

  FutureEither<String> getPreferredLanguage();

  FutureEither<String> updatePreferredLanguage(String languageCode);
}
