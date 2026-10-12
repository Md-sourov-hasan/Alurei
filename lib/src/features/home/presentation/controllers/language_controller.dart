import 'package:alurei/src/features/home/domain/entities/app_language.dart';
import 'package:alurei/src/features/home/domain/repositories/language_repository.dart';
import 'package:alurei/src/features/auth/presentation/providers/session_controller.dart';
import 'package:alurei/src/imports/imports.dart';

class LanguageController extends GetxController {
  LanguageController({
    required LanguageRepository repository,
  }) : _repository = repository;

  final LanguageRepository _repository;

  final selectedLanguageCode = 'en'.obs;
  final languages = <AppLanguage>[].obs;
  final isLoading = true.obs;
  final isSaving = false.obs;
  final errorMessage = ''.obs;

  List<AppLanguage> get visibleLanguages {
    if (languages.isNotEmpty) return languages;
    return const [
      AppLanguage(
        code: 'en',
        name: 'English',
        nativeName: 'English',
        label: 'English (EN)',
      ),
      AppLanguage(
        code: 'ar',
        name: 'Arabic',
        nativeName: 'عربي',
        label: 'Arabic',
      ),
      AppLanguage(
        code: 'fil',
        name: 'Filipino',
        nativeName: 'Wikang Filipino',
        label: 'Filipino',
      ),
      AppLanguage(
        code: 'si',
        name: 'Sinhala',
        nativeName: 'සිංහල',
        label: 'Sinhala',
      ),
    ];
  }

  @override
  void onInit() {
    super.onInit();
    _hydrateLocalLanguage();
    loadLanguages();
  }

  void _hydrateLocalLanguage() {
    final savedLang = StorageService.instance.getString('app_language_code');
    final currentLang = Get.context?.locale.languageCode ?? 'en';
    selectedLanguageCode.value = savedLang ?? currentLang;
  }

  Future<void> loadLanguages() async {
    isLoading.value = true;
    errorMessage.value = '';

    final languagesResult = await _repository.getLanguages();
    final preferredResult = await _repository.getPreferredLanguage();
    isLoading.value = false;

    languagesResult.fold(
      (failure) {
        errorMessage.value = failure.message;
        AppLogger.warning('Language list load failed: ${failure.runtimeType}');
      },
      languages.assignAll,
    );

    preferredResult.fold(
      (failure) {
        AppLogger.warning(
          'Preferred language load failed: ${failure.runtimeType}',
        );
      },
      (languageCode) {
        selectedLanguageCode.value = languageCode;
        _applyLocalLanguage(languageCode);
      },
    );
  }

  Future<void> selectLanguage(String code, [BuildContext? context]) async {
    selectedLanguageCode.value = code;
  }

  Future<void> saveLanguage([BuildContext? context]) async {
    if (isSaving.value) return;

    final code = selectedLanguageCode.value;
    isSaving.value = true;
    final result = await _repository.updatePreferredLanguage(code);
    isSaving.value = false;

    await result.fold(
      (failure) async {
        AppLogger.warning('Language update failed: ${failure.runtimeType}');
        showGlobalToast(message: failure.message, status: 'error');
      },
      (languageCode) async {
        selectedLanguageCode.value = languageCode;
        await _applyLocalLanguage(languageCode, context);
        _updateSessionLanguage(languageCode);
        showGlobalToast(message: LangKey.languageScreen.languageSaved);
        Get.back<void>();
      },
    );
  }

  Future<void> _applyLocalLanguage(
    String code, [
    BuildContext? context,
  ]) async {
    final locale = Locale(code);
    await StorageService.instance.setString('app_language_code', code);
    final targetContext = context ?? Get.context;
    if (targetContext != null && targetContext.mounted) {
      await targetContext.setLocale(locale);
    }
    await Get.updateLocale(locale);
  }

  void _updateSessionLanguage(String languageCode) {
    if (!Get.isRegistered<SessionController>()) return;
    final session = Get.find<SessionController>();
    final user = session.user.value;
    if (user == null) return;
    session.acceptAuthenticatedUser(
      user.copyWith(preferredLanguage: languageCode),
    );
  }
}
