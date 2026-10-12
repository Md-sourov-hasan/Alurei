import 'package:alurei/src/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('theme foundations', () {
    test('uses the centralized Alurei brand palette', () {
      expect(AppColors.primaryColor, const Color(0xFF0B5460));
      expect(AppColors.primaryBackgroundColor, const Color(0xFFF4F4F4));
      expect(AppColors.secondaryBackgroundColor, const Color(0xFFFAFAFA));
      expect(AppColors.blackTextColor, const Color(0xFF111826));
      expect(AppColors.primaryTextColor, const Color(0xFF1F2939));
      expect(AppColors.secondaryTextColor, const Color(0xFF354152));
      expect(AppColors.mutedTextColor, const Color(0xFF4A5565));
      expect(AppColors.disabledTextColor, const Color(0xFF697485));
      expect(AppPalettes.light.success, AppColors.lightSuccess);
      expect(AppPalettes.dark.warning, AppColors.darkWarning);
    });

    test('maps centralized surfaces and text into both Material themes', () {
      final lightTheme = buildLightTheme();
      final darkTheme = buildDarkTheme();
      final lightColors = lightTheme.extension<AppColorsExtension>()!;
      final darkColors = darkTheme.extension<AppColorsExtension>()!;

      expect(
          lightTheme.scaffoldBackgroundColor, AppColors.primaryBackgroundColor);
      expect(lightTheme.colorScheme.surfaceContainerLow,
          AppColors.secondaryBackgroundColor);
      expect(lightTheme.colorScheme.onSurface, AppColors.blackTextColor);
      expect(lightColors.primaryText, AppColors.primaryTextColor);
      expect(lightColors.disabledText, AppColors.disabledTextColor);

      expect(darkTheme.scaffoldBackgroundColor,
          AppColors.darkPrimaryBackgroundColor);
      expect(darkTheme.colorScheme.surfaceContainerLow,
          AppColors.darkSecondaryBackgroundColor);
      expect(darkTheme.colorScheme.onSurface, AppColors.darkStrongTextColor);
      expect(darkColors.primaryText, AppColors.darkPrimaryTextColor);
      expect(darkColors.disabledText, AppColors.darkDisabledTextColor);
    });

    test('applies Inter to the global type scale and custom helpers', () {
      final textTheme = buildTextTheme();
      final bodyStyle = GlobalTextStyles.interBodyTextStyle();

      expect(textTheme.bodyMedium?.fontFamily, startsWith('Inter'));
      expect(textTheme.headlineLarge?.fontFamily, startsWith('Inter'));
      expect(bodyStyle.fontFamily, startsWith('Inter'));
    });
  });
}
