import 'dart:ui';

/// The single source of raw color values used by Alurei.
///
/// Theme-aware widgets should normally consume `context.colors` or
/// `context.appColors`. These constants are used to build those semantic themes
/// and for fixed brand colors that must not change between light and dark mode.
abstract final class AppColors {
  // Core
  static const Color transparentColor = Color(0x00000000);
  static const Color blackColor = Color(0xFF000000);
  static const Color whiteColor = Color(0xFFFFFFFF);

  // Alurei brand
  static const Color primaryColor = Color(0xFF0B5460);
  static const Color secondaryTeal = Color(0xFF009E9E);
  static const Color primaryButtonColor = primaryColor;
  static const Color secondaryColor = Color(0xFF2E6FF3);
  static const Color secondaryButtonColor = Color(0xFFFC3F5B);
  static const Color headerTextColor = Color(0xFF202939);

  // Light surfaces
  static const Color primaryBackgroundColor = Color(0xFFF4F4F4);
  static const Color secondaryBackgroundColor = Color(0xFFFAFAFA);
  static const Color whiteBackgroundColor = whiteColor;

  // Main navigation
  // Figma: active pill uses --colors/primary-foundation/50 = #E7EEEF
  static const Color bottomNavSelectedBackground = Color(0xFFE7EEEF);
  static const Color bottomNavBorder = Color(0xFFE7EEEF);

  // Parent routine timeline
  static const Color routinePathPast = Color(0xFFE4F8F3);
  static const Color routinePathActive = Color(0xFF0B6670);
  static const Color routineBreakfast = Color(0xFFFFE0C5);
  static const Color routineOutdoor = Color(0xFFA7F3D0);
  static const Color routineStudy = Color(0xFFF2DCFB);
  static const Color routineStory = Color(0xFFF1E3A9);
  static const Color routineOrangeBorder = Color(0x33E67E22);
  static const Color routineGreenBorder = Color(0x3349C988);
  static const Color routinePurpleBorder = Color(0x338E44AD);
  static const Color routineYellowBorder = Color(0x33F1C40F);
  static const Color routineDetailBreakfastSurface = Color(0xFFFFEFE0);
  static const Color routineDetailOutdoorSurface = Color(0xFFD7FBE6);
  static const Color routineDetailStudySurface = Color(0xFFF6E4FA);
  static const Color routineDetailFeedbackSurface = Color(0xFFECFDF3);
  static const Color routineDetailNoteSurface = Color(0xFFF0F9FA);
  static const Color routineDetailNoteBorder = Color(0xFF97CFD0);
  static const Color routineDetailCompleteSurface = Color(0xFFE7F6EC);

  // Light text
  static const Color blackTextColor = Color(0xFF111826);
  static const Color primaryTextColor = Color(0xFF1F2939);
  static const Color secondaryTextColor = Color(0xFF354152);
  static const Color bodyTextColor = secondaryTextColor;
  static const Color mutedTextColor = Color(0xFF4A5565);
  static const Color disabledTextColor = Color(0xFF697485);
  static const Color textHintColor = mutedTextColor;

  // Dark surfaces
  static const Color darkPrimaryBackgroundColor = Color(0xFF0F172A);
  static const Color darkSecondaryBackgroundColor = Color(0xFF111827);
  static const Color darkElevatedBackgroundColor = Color(0xFF1F2937);
  static const Color darkBottomNavSelectedBackground = Color(0xFF173F46);
  static const Color darkBottomNavBorder = Color(0xFF29434A);

  // Dark text
  static const Color darkStrongTextColor = Color(0xFFF9FAFB);
  static const Color darkPrimaryTextColor = Color(0xFFF3F4F6);
  static const Color darkSecondaryTextColor = Color(0xFFD1D5DB);
  static const Color darkMutedTextColor = Color(0xFF9CA3AF);
  static const Color darkDisabledTextColor = Color(0xFF6B7280);

  // Feedback
  static const Color redColor = Color(0xFFFC3F5B);
  static const Color errorColor = redColor;
  static const Color headingTextColor = Color(0xFF0250A9);

  // Supporting colors
  static const Color supportingGreen = Color(0xFF189E4A);
  static const Color supportingGreenShade = Color(0xFFEDFAF2);
  static const Color supportingOrange = Color(0xFFF59E0B);
  static const Color supportingOrangeShade = Color(0xFFFFF7ED);
  static const Color supportingYellowShade = Color(0xFFFEFCE8);
  static const Color supportingRed = Color(0xFFEF4444);
  static const Color supportingRedShade = Color(0xFFFEF2F2);

  // Neutral scale
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Light semantic palette
  static const Color lightSuccess = Color(0xFF2E7D32);
  static const Color lightOnSuccess = whiteColor;
  static const Color lightSuccessContainer = Color(0xFFA5D6A7);
  static const Color lightOnSuccessContainer = Color(0xFF1B5E20);
  static const Color lightWarning = Color(0xFFED6C02);
  static const Color warning500 = Color(0xFFF79009);
  static const Color warning700 = Color(0xFFB54708);
  static const Color lightOnWarning = whiteColor;
  static const Color lightWarningContainer = Color(0xFFFFCC80);
  static const Color lightOnWarningContainer = Color(0xFFE65100);
  static const Color lightInfo = Color(0xFF0288D1);
  static const Color lightOnInfo = whiteColor;
  static const Color lightInfoContainer = Color(0xFF81D4FA);
  static const Color lightOnInfoContainer = Color(0xFF01579B);

  // Dark semantic palette
  static const Color darkSuccess = Color(0xFF81C784);
  static const Color darkOnSuccess = Color(0xFF003300);
  static const Color darkSuccessContainer = Color(0xFF1B5E20);
  static const Color darkOnSuccessContainer = Color(0xFFA5D6A7);
  static const Color darkWarning = Color(0xFFFFB74D);
  static const Color darkOnWarning = Color(0xFF5D4037);
  static const Color darkWarningContainer = Color(0xFFE65100);
  static const Color darkOnWarningContainer = Color(0xFFFFCC80);
  static const Color darkInfo = Color(0xFF4FC3F7);
  static const Color darkOnInfo = Color(0xFF01579B);
  static const Color darkInfoContainer = Color(0xFF0277BD);
  static const Color darkOnInfoContainer = Color(0xFFE1F5FE);

  // Fixed third-party brand colors
  static const Color googleColor = Color(0xFFEA4335);
  static const Color facebookColor = Color(0xFF4285F4);
  static const Color appleColor = blackColor;

  // Shadow and overlay colors
  static const Color black04 = Color(0x0A000000);
  static const Color black05 = Color(0x0D000000);
  static const Color black06 = Color(0x0F000000);
  static const Color black08 = Color(0x14000000);
  static const Color black12 = Color(0x1F000000);
  static const Color black16 = Color(0x29000000);
  static const Color black26 = Color(0x42000000);
  static const Color black40 = Color(0x66000000);

  // Alurei brand teal palette (Figma "Blue 2" scale — fixed brand values)
  static const Color brandTealSurface = Color(0xFFD0F4F3);
  static const Color brandTealLight = Color(0xFFE6F5F5);
  static const Color brandLogoLight = Color(0xFFE7EEEF);
  static const Color brandTealIce = Color(0xFFF5FAFA);
  static const Color brandGray50 = Color(0xFFF9F9F9);
  static const Color brandTealGlassBg = Color(0x1A005757);
  static const Color brandTealTrack = Color(0xFFB0E1E1);

  // Input field colors
  static const Color inputBackground = Color(0xFFF8F8F8);
  static const Color inputBorder = Color(0xFFE8E8E8);
  static const Color dividerColor = Color(0xFFE8E8E8);
  // Bedtime story screen
  static const Color bedtimeStoryFamilyPlayer = Color(0xFF007070);
  static const Color bedtimeStoryTranscriptBackground = Color(0xFFF5F3F3);
  static const Color bedtimeStoryRecorderBackground = Color(0xFFF8FAFC);
  static const Color bedtimeStoryDashedBorder = Color(0xFFB3CACE);
  static const Color bedtimeStoryInfoBackground = Color(0x1A0B5460);

  // Login screen specific tokens from Figma
  static const Color brandTealBorder = Color(0xFF97CFD0);
  static const Color brandRedAsterisk = Color(0xFFF97066);
  static const Color brandDarkAsterisk = Color(0xFF333333);
  static const Color brandGrayHint = Color(0xFF7C8799);
  static const Color brandGrayText = Color(0xFF535862);
  static const Color brandGrayDark = Color(0xFF414651);
  static const Color brandGrayBorder = Color(0xFFD5D7DA);
  static const Color brandGrayLight = Color(0xFFEEF2F6);
  static const Color documentItemSurface = Color(0xFFFBF9F8);
  static const Color documentItemBorder = Color(0x4DBECABA);

  // Kitchen & Grocery specific tokens
  static const Color groceryWarningOrange = Color(0xFFDC6803);
  static const Color missingBackgroundAlpha = Color(0x1ABA1A1A);
  static const Color lowBackgroundAlpha = Color(0x1A017D2D);
  static const Color stockBackgroundAlpha = Color(0x1A17B26A);
  static const Color groceryCardBorder = Color(0xFFEFEDED);
  static const Color groceryTrackColor = Color(0xFFE7EEEF);
  static const Color groceryNoteBg = Color(0xFFFCFCFD);
  static const Color groceryNoteBorder = Color(0xFFE3E8EF);
  static const Color groceryNoteText = Color(0xFF364152);
  static const Color groceryNoteSecondary = Color(0xFF697586);
  static const Color stockSegmentMissing = Color(0xFFFECDCA);
  static const Color stockSegmentMissingActive = Color(0xFFFDA29B);
  static const Color stockSegmentText = Color(0xFF5A6475);
  static const Color inventorySelectedBorder = Color(0xFFB3CACE);
  static const Color groceryRed = Color(0xFFF04438);
  static const Color groceryMissingRed = Color(0xFFD92D20);
  static const Color deleteRed = Color(0xFFFB2C36);
  static const Color groceryGreen = Color(0xFF17B26A);
  static const Color groceryStockGreen = Color(0xFF079455);
  static const Color kitchenInventoryUnselectedBg = Color(0xFFCAEFEF);
  static const Color voucherBadgeBg = Color(0xFF009E9E);
  static const Color recipeCardShadow = Color(0x0A006121);
  static const Color mealTypeBadgeBg = Color(0x1A006687);
  static const Color kitchenChildChipUnselectedBg = Color(0x33CAEFEF);

  // Reward points & Redeem offer tokens (Figma V2 Evaturner)
  static const Color rewardSuccessBadgeBg = Color(0x1A17B26A);
  static const Color rewardSuccessBadgeText = Color(0xFF067647);
  static const Color rewardErrorBadgeBg = Color(0x1AF04438);
  static const Color rewardErrorBadgeText = Color(0xFFD92D20);
  static const Color redeemOfferHeaderBorder = Color(0xFF0A4F53);
  static const Color redeemOfferHeaderBg = Color(0xFFF1F5F9);
  static const Color redeemOfferTitleText = Color(0xFF334155);
  static const Color redeemOfferBorder = Color(0xFFE2E8F0);
  static const Color redeemOfferTabUnselectedText = Color(0xFF1E293B);
  static const Color redeemOfferDashedBorder = Color(0xFF00897B);
  static const Color redeemOfferCodeText = Color(0xFF004D54);
  static const Color redeemOfferSubtext = Color(0xFF475569);
  static const Color redeemOfferIconMuted = Color(0xFF94A3B8);
  static const Color redeemOfferVoucherBadgeBg = Color(0xFFEAF2F2);
  static const Color rewardCardGradientStart = Color(0xFF007070);
  static const Color rewardCardGradientEnd = Color(0xFF083C44);
  static const Color wellbeingCardBorder = Color(0xFFEBEBEA);
}
