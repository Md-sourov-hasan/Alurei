import 'package:flutter/material.dart';

import 'app_colors.dart';

/// App-specific semantic colors not represented by Material [ColorScheme].
/// Access the brightness-selected palette through `context.appColors`.
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primaryBackground,
    required this.secondaryBackground,
    required this.elevatedBackground,
    required this.strongText,
    required this.primaryText,
    required this.secondaryText,
    required this.mutedText,
    required this.disabledText,
    required this.bottomNavBackground,
    required this.bottomNavBorder,
    required this.bottomNavSelectedBackground,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.kitchenInventoryUnselectedBg,
    this.successContainer,
    this.onSuccessContainer,
    this.warningContainer,
    this.onWarningContainer,
    this.infoContainer,
    this.onInfoContainer,
  });

  final Color primaryBackground;
  final Color secondaryBackground;
  final Color elevatedBackground;
  final Color strongText;
  final Color primaryText;
  final Color secondaryText;
  final Color mutedText;
  final Color disabledText;
  final Color bottomNavBackground;
  final Color bottomNavBorder;
  final Color bottomNavSelectedBackground;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;
  final Color kitchenInventoryUnselectedBg;
  final Color? successContainer;
  final Color? onSuccessContainer;
  final Color? warningContainer;
  final Color? onWarningContainer;
  final Color? infoContainer;
  final Color? onInfoContainer;

  @override
  ThemeExtension<AppColorsExtension> copyWith({
    Color? primaryBackground,
    Color? secondaryBackground,
    Color? elevatedBackground,
    Color? strongText,
    Color? primaryText,
    Color? secondaryText,
    Color? mutedText,
    Color? disabledText,
    Color? bottomNavBackground,
    Color? bottomNavBorder,
    Color? bottomNavSelectedBackground,
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? info,
    Color? onInfo,
    Color? kitchenInventoryUnselectedBg,
    Color? successContainer,
    Color? onSuccessContainer,
    Color? warningContainer,
    Color? onWarningContainer,
    Color? infoContainer,
    Color? onInfoContainer,
  }) {
    return AppColorsExtension(
      primaryBackground: primaryBackground ?? this.primaryBackground,
      secondaryBackground: secondaryBackground ?? this.secondaryBackground,
      elevatedBackground: elevatedBackground ?? this.elevatedBackground,
      strongText: strongText ?? this.strongText,
      primaryText: primaryText ?? this.primaryText,
      secondaryText: secondaryText ?? this.secondaryText,
      mutedText: mutedText ?? this.mutedText,
      disabledText: disabledText ?? this.disabledText,
      bottomNavBackground: bottomNavBackground ?? this.bottomNavBackground,
      bottomNavBorder: bottomNavBorder ?? this.bottomNavBorder,
      bottomNavSelectedBackground:
          bottomNavSelectedBackground ?? this.bottomNavSelectedBackground,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
      kitchenInventoryUnselectedBg:
          kitchenInventoryUnselectedBg ?? this.kitchenInventoryUnselectedBg,
      successContainer: successContainer ?? this.successContainer,
      onSuccessContainer: onSuccessContainer ?? this.onSuccessContainer,
      warningContainer: warningContainer ?? this.warningContainer,
      onWarningContainer: onWarningContainer ?? this.onWarningContainer,
      infoContainer: infoContainer ?? this.infoContainer,
      onInfoContainer: onInfoContainer ?? this.onInfoContainer,
    );
  }

  @override
  ThemeExtension<AppColorsExtension> lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primaryBackground:
          Color.lerp(primaryBackground, other.primaryBackground, t)!,
      secondaryBackground:
          Color.lerp(secondaryBackground, other.secondaryBackground, t)!,
      elevatedBackground:
          Color.lerp(elevatedBackground, other.elevatedBackground, t)!,
      strongText: Color.lerp(strongText, other.strongText, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      mutedText: Color.lerp(mutedText, other.mutedText, t)!,
      disabledText: Color.lerp(disabledText, other.disabledText, t)!,
      bottomNavBackground:
          Color.lerp(bottomNavBackground, other.bottomNavBackground, t)!,
      bottomNavBorder: Color.lerp(bottomNavBorder, other.bottomNavBorder, t)!,
      bottomNavSelectedBackground: Color.lerp(
        bottomNavSelectedBackground,
        other.bottomNavSelectedBackground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
      kitchenInventoryUnselectedBg: Color.lerp(
        kitchenInventoryUnselectedBg,
        other.kitchenInventoryUnselectedBg,
        t,
      )!,
      successContainer: Color.lerp(successContainer, other.successContainer, t),
      onSuccessContainer:
          Color.lerp(onSuccessContainer, other.onSuccessContainer, t),
      warningContainer: Color.lerp(warningContainer, other.warningContainer, t),
      onWarningContainer:
          Color.lerp(onWarningContainer, other.onWarningContainer, t),
      infoContainer: Color.lerp(infoContainer, other.infoContainer, t),
      onInfoContainer: Color.lerp(onInfoContainer, other.onInfoContainer, t),
    );
  }
}

/// Brightness-specific semantic palettes built exclusively from [AppColors].
abstract final class AppPalettes {
  static const light = AppColorsExtension(
    primaryBackground: AppColors.primaryBackgroundColor,
    secondaryBackground: AppColors.secondaryBackgroundColor,
    elevatedBackground: AppColors.whiteBackgroundColor,
    strongText: AppColors.blackTextColor,
    primaryText: AppColors.primaryTextColor,
    secondaryText: AppColors.secondaryTextColor,
    mutedText: AppColors.mutedTextColor,
    disabledText: AppColors.disabledTextColor,
    bottomNavBackground: AppColors.whiteBackgroundColor,
    bottomNavBorder: AppColors.bottomNavBorder,
    bottomNavSelectedBackground: AppColors.bottomNavSelectedBackground,
    success: AppColors.lightSuccess,
    onSuccess: AppColors.lightOnSuccess,
    successContainer: AppColors.lightSuccessContainer,
    onSuccessContainer: AppColors.lightOnSuccessContainer,
    warning: AppColors.warning500,
    onWarning: AppColors.lightOnWarning,
    warningContainer: AppColors.lightWarningContainer,
    onWarningContainer: AppColors.lightOnWarningContainer,
    info: AppColors.lightInfo,
    onInfo: AppColors.lightOnInfo,
    kitchenInventoryUnselectedBg: AppColors.kitchenInventoryUnselectedBg,
    infoContainer: AppColors.lightInfoContainer,
    onInfoContainer: AppColors.lightOnInfoContainer,
  );

  static const dark = AppColorsExtension(
    primaryBackground: AppColors.darkPrimaryBackgroundColor,
    secondaryBackground: AppColors.darkSecondaryBackgroundColor,
    elevatedBackground: AppColors.darkElevatedBackgroundColor,
    strongText: AppColors.darkStrongTextColor,
    primaryText: AppColors.darkPrimaryTextColor,
    secondaryText: AppColors.darkSecondaryTextColor,
    mutedText: AppColors.darkMutedTextColor,
    disabledText: AppColors.darkDisabledTextColor,
    bottomNavBackground: AppColors.darkElevatedBackgroundColor,
    bottomNavBorder: AppColors.darkBottomNavBorder,
    bottomNavSelectedBackground: AppColors.darkBottomNavSelectedBackground,
    success: AppColors.darkSuccess,
    onSuccess: AppColors.darkOnSuccess,
    successContainer: AppColors.darkSuccessContainer,
    onSuccessContainer: AppColors.darkOnSuccessContainer,
    warning: AppColors.darkWarning,
    onWarning: AppColors.darkOnWarning,
    warningContainer: AppColors.darkWarningContainer,
    onWarningContainer: AppColors.darkOnWarningContainer,
    info: AppColors.darkInfo,
    onInfo: AppColors.darkOnInfo,
    kitchenInventoryUnselectedBg: AppColors.kitchenInventoryUnselectedBg,
    infoContainer: AppColors.darkInfoContainer,
    onInfoContainer: AppColors.darkOnInfoContainer,
  );
}
