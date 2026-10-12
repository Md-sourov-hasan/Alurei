import 'package:alurei/src/features/home/domain/entities/app_language.dart';

class AppLanguageModel {
  const AppLanguageModel({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.label,
  });

  factory AppLanguageModel.fromJson(Map<String, Object?> json) {
    return AppLanguageModel(
      code: json['code'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nativeName: json['nativeName'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  final String code;
  final String name;
  final String nativeName;
  final String label;

  AppLanguage toEntity() {
    return AppLanguage(
      code: code,
      name: name,
      nativeName: nativeName,
      label: label,
    );
  }
}
