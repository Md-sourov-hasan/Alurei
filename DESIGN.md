# Design system — alurei

This file documents the design conventions established at generation time. Consult it before changing UI code.

---

## Theme overview

- **Preset:** `material3`
- **Material 3:** Primary app chrome uses Material 3 theming in `lib/src/theme/theme.dart`.
- **Dark mode:** Light and dark themes are supported; app can follow system brightness. Use semantic colors — do not branch on brightness in widgets for basic surfaces.
- **Customization:** Global `ThemeData` lives in `lib/src/theme/theme.dart` — avoid one-off `ThemeData` overrides in feature widgets.

- **Seed color:** `#0B5460` (used to derive `ColorScheme` via `ColorScheme.fromSeed` where applicable).

---

## Color system

- `lib/src/theme/app_colors.dart` is the only source of raw color values,
  including Alurei brand colors, neutral scales, supporting colors, fixed
  third-party brand colors, overlays, and semantic light/dark palette values.
- Use `context.colors` (`ColorScheme`) for standard Material roles: `primary`, `onPrimary`, `secondary`, `surface`, `onSurface`, `error`, etc.
- Use `context.appColors` for semantic extensions: `success`, `warning`, `info`, and their `on*` / container variants (see `lib/src/theme/color_schemes.dart`).
- Definitions: `lib/src/theme/color_schemes.dart`, applied through `lib/src/theme/theme.dart`.
- **Do not** hardcode hex colors in widgets — use theme roles or `appColors`.
- `color_schemes.dart` maps centralized `AppColors` values into theme-aware
  semantic roles. Do not create feature-level `ParentColors`, `NannyColors`, or
  other palette classes.
- When a new color meaning is required, add a semantic role to the centralized
  `AppColors` palette, map it through the color scheme/theme extension with both
  light and dark values, and consume it through `context.colors` or
  `context.appColors`.
- Prefer naming by meaning (`successContainer`, `onWarning`) instead of visual
  appearance (`lightGreen`, `darkOrange`) or role/screen name.
- Direct `AppColors` usage is reserved for fixed brand values, transparent/
  overlay values, and theme construction. Normal surfaces, text, borders, and
  status UI use semantic context colors so dark mode remains correct.

### Main surface and text palettes

| Role | Light | Dark | Widget access |
|------|-------|------|---------------|
| Primary background | `#F4F4F4` | `#0F172A` | `context.appColors.primaryBackground` / `context.colors.surface` |
| Secondary background | `#FAFAFA` | `#111827` | `context.appColors.secondaryBackground` / `context.colors.surfaceContainerLow` |
| Elevated background | `#FFFFFF` | `#1F2937` | `context.appColors.elevatedBackground` |
| Strong text | `#111826` | `#F9FAFB` | `context.appColors.strongText` / `context.colors.onSurface` |
| Primary text | `#1F2939` | `#F3F4F6` | `context.appColors.primaryText` |
| Secondary text | `#354152` | `#D1D5DB` | `context.appColors.secondaryText` / `context.colors.onSurfaceVariant` |
| Muted text | `#4A5565` | `#9CA3AF` | `context.appColors.mutedText` |
| Disabled text | `#697485` | `#6B7280` | `context.appColors.disabledText` / `Theme.of(context).disabledColor` |

Use `context.colors` for ordinary Material UI. Use the additional
`context.appColors` text roles only when the Figma hierarchy distinguishes
primary, secondary, muted, or disabled content beyond Material's standard roles.

---

## Typography

- Use `context.textTheme` (alias `context.typography`) for all text styles.
- Roles follow Material 3: `display*`, `headline*`, `title*`, `body*`, `label*`.
- Inter is the app-wide font through the verified `google_fonts` package.
  `buildTextTheme()` applies Inter to the full Material type scale, and the
  Cupertino override uses the same centralized family.
- Inter assets are bundled under `assets/fonts/`, and runtime font fetching is
  disabled. Preserve the OFL license when updating the font files.
- Use `GlobalTextStyles.interBodyTextStyle()` or
  `GlobalTextStyles.interTextStyle()` only when a standard `TextTheme` role does
  not express the Figma specification. Do not call `GoogleFonts.inter()` from
  screens/widgets.
- Inter may fall back to a platform font for glyphs it does not contain. Verify
  Arabic and Sinhala rendering rather than forcing missing glyphs.
- `GlobalTextStyles` does not apply a light-only default text color. Let text
  inherit the active theme or pass a semantic `context.appColors` value.

---

## Spacing, borders, motion

Import tokens via `package:alurei/src/theme/theme_constants.dart`.

| Token class | Purpose |
|-------------|---------|
| `AppSpacing` | Padding, gaps (`xxs` … `xxxl`, plus `pagePadding`, `itemGap`, `cardPadding`) |
| `AppBorders` | Border radii (`xs` … `xl`, `button`, `card`, `input`, `dialog`, …) |
| `AppShadows` | Elevation shadows (`none`, `subtle`, `card`, `elevated`, `modal`) |
| `AppDurations` | Animation durations (`fast`, `normal`, `medium`, `slow`, …) |
| `AppCurves` | Standard curves (`standard`, `emphasized`, `pageEnter`, …) |

**Rules**

- Do not use magic numbers for padding — use `AppSpacing`.
- Do not use inline `BorderRadius.circular(n)` — use `AppBorders`.
- Prefer Material 3 tonal elevation on `Card` / `Surface` — custom shadows only via `AppShadows`.

---

## Responsive scaling (ScreenUtil)

- `ScreenUtilInit` is already applied in the app wrapper — do not add another.
- Design size baseline: **440×956**. Every Figma screen is implemented against a
  440 px design width through the shared `ScreenUtilWrapper`.
- In templates and new code, use the `res` convention: widths `.w`, heights `.h`, radius `.r`, font sizes `.sp` when ScreenUtil is enabled.
- ScreenUtil values are runtime — avoid `const` widgets that depend on `.w` / `.sp`.
- Do not constrain the runtime application to a literal 440 px box. The 440 px
  value is the design coordinate system; ScreenUtil adapts it to the device.

---

## Context extensions

Defined in `lib/src/extensions/context_extension.dart`:

| Member | Use |
|--------|-----|
| `context.colors` | `ColorScheme` |
| `context.textTheme` / `context.typography` | Text styles |
| `context.appColors` | Semantic success/warning/info |
| `context.designTokens` | Theme extension tokens |
| `context.isDarkMode` | Brightness check |
| `context.width` / `context.height` | Screen size |
| `context.showAppDialog` | Dialog helper |
| `context.showTypedSnackBar` | Status snackbars |

Prefer these shortcuts over repeating `Theme.of(context)` in widgets.

---

## Component conventions

- Use Iconsax (`IconsaxPlusLinear`, `IconsaxPlusBold`, or the appropriate
  variant) for standard interface icons; do not use Flutter `Icons.*`.
- Use supplied custom SVG artwork only when the design requires it. Register
  every path in `AppAssets` and render it through the shared asset pipeline.
- Use `AppTopBar` for centered detail/profile/form headers,
  `AppDashboardTopBar` for Parent/Nanny main screens, `AppMessagesTopBar` for
  message lists, and `AppConversationTopBar` for an open conversation. Pass
  localized labels and controller callbacks into these presentation widgets.

- Reusable widgets belong in `lib/src/shared/widgets/`.
- Screen-specific widgets belong in that feature's `presentation/widgets/`.
  Widgets reused only across one role belong in
  `features/roles/<role>/shared/widgets/`; promote them to `src/shared/widgets/`
  only when both roles or unrelated features reuse them.
- Screen files are route-level compositions without business logic. Prefer
  `StatelessWidget`; use `HookWidget` for disposable local presentation state.
- Default style parameters to theme values, not hardcoded colors.
- Widget file names match the widget class (`primary_button.dart` → `PrimaryButton`).
- Do not read theme inside `const` constructors.
- Extracted widgets in separate files use specific public class names because
  Dart-private classes cannot cross library files; keep internal widgets out of
  public barrels.

### Dark mode checklist

- No raw `Colors.white` / `Colors.black` for surfaces — use `colorScheme` roles.
- Verify new screens in both light and dark theme.

---

## Localization

- User-visible strings use `easy_localization` — files in `assets/translations/`.
- Supported languages are English (`en`), Arabic (`ar`), Filipino (`fil`), and
  Sinhala (`si`). Every key must exist in all four files before a feature is
  complete.
- Do not hardcode display strings in widgets.
- Do not type translation paths such as `'auth.name'.tr()` in UI code. Run
  `dart run tool/generate_lang_keys.dart` and use autocomplete-safe keys such as
  `LangKey.auth.name`. Translation is applied inside the generated getter; do not
  append `.tr()` at the call site.
- Never edit `shared/localization/generated/lang_key.g.dart` manually.
- Add keys to JSON translation files, then run the generate command in **SETUP.md**.
- Use interpolation in JSON — do not concatenate translated strings in Dart.
- Arabic is RTL: verify directional padding/alignment, icon direction, text-field
  layout, and navigation affordances. Prefer `start`/`end` APIs over `left`/`right`.
- Filipino and Sinhala strings may expand beyond English. Avoid fixed text
  heights and test wrapping at large text scale.

---

## Figma MCP implementation workflow

Figma MCP output supplies layout and visual intent. A screen is not complete
until the static design is connected to application architecture and states.

1. Inspect the target frame, components, variants, spacing, assets, and
   interactions through the Figma MCP server. Use the 440 px frame as the
   ScreenUtil design width.
   Download any raster artwork returned by Figma MCP into `assets/images/`,
   register it in `AppAssets`, and render the local file rather than its
   short-lived Figma URL.
2. Map Figma values to existing semantic colors, typography, spacing, borders,
   shadows, and reusable widgets. Add missing semantic tokens centrally rather
   than copying raw values into the screen.
3. Split route-level composition into `screens/` and extracted components into
   the appropriate `widgets/` directory.
4. Define typed models, repository/data-source contracts, a GetX controller, and
   bindings. The UI renders state and forwards user intent only.
5. Until a backend exists, implement a dummy data source backed by centralized
   fixtures in `lib/src/shared/dummy_data/`. Never embed sample records in the
   screen or controller.
6. Make every visible control functional using dummy-backed state: navigation,
   form validation, selection, loading, content, empty, error, retry, pagination,
   and dialogs shown in the design.
7. When the API becomes available, add an API data source implementing the same
   contract and switch the binding. Models, controllers, widgets, and screens
   should not require redesign.
8. Verify light/dark modes, all four locales, Arabic RTL, text scaling, scrolling,
   keyboard behavior, and representative device widths.

---

## Do / Don't

**Do**

- `context.colors` / `context.appColors` for color
- `context.textTheme` for typography
- `AppSpacing`, `AppBorders`, `AppShadows`, `AppDurations`, `AppCurves` for layout and motion
- `showAppDialog` and shared widgets for consistent UX

**Don't**

- Hardcode hex colors or arbitrary font families in widgets
- Call `GoogleFonts` directly outside `lib/src/theme/global_text_styles.dart`
- Magic padding/radius numbers
- Duplicate theme definitions per screen
- Bypass design tokens for one-off “quick” UI

For agent workflows and architecture boundaries, see **[AGENTS.md](AGENTS.md)**.
