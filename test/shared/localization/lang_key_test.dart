import 'dart:io';

import 'package:alurei/src/shared/localization/localization.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('generated LangKey getters translate internally', () {
    expect(LangKey.auth, isNotNull);
    expect(LangKey.onboarding, isNotNull);

    final generatedSource = File(
      'lib/src/shared/localization/generated/lang_key.g.dart',
    ).readAsStringSync();

    expect(
      generatedSource,
      contains('String get name => "auth.name".tr();'),
    );
    expect(
      generatedSource,
      contains('String get logIn => "auth.log_in".tr();'),
    );
  });
}
