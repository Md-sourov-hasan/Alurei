# Agent guide — theme

## Scope

This directory is the global Material 3 design system. The root
[`AGENTS.md`](../../../AGENTS.md) and [`DESIGN.md`](../../../DESIGN.md) apply
here. Read `DESIGN.md` before changing tokens or `ThemeData`.

## Responsibilities

- `theme.dart` builds the application themes and registers theme extensions.
- `app_colors.dart` is the only source of raw palette values.
- `color_schemes.dart` owns light/dark semantic color roles.
- `global_text_styles.dart` owns Inter helpers; `text_theme.dart` applies Inter to
  the complete Material type scale.
- `app_spacing.dart`, `app_borders.dart`, `app_shadows.dart`,
  `app_durations.dart`, and `app_curves.dart` define reusable design tokens.
- `theme_constants.dart` is the public token barrel.

## Rules

- Keep Material 3 enabled and preserve light/dark theme parity.
- Add every new raw color to `AppColors`. Map theme-dependent meanings through
  `ColorScheme` or `AppColorsExtension`; do not create another palette class.
- Widgets use semantic theme colors by default. Direct `AppColors` access is for
  theme construction and fixed external/brand/overlay values only.
- Keep the main surface/text roles synchronized across `AppColors`,
  `AppPalettes`, and the light/dark `ColorScheme` builders. Every new light role
  requires a readable dark counterpart and a documented semantic accessor.
- Add reusable spacing, radius, elevation, duration, and curve values to their
  token classes rather than spreading magic values through widgets.
- Theme extensions must implement compatible `copyWith` and `lerp` behavior and
  be registered in every applicable theme.
- Keep text roles consistent with Material typography and Inter. All Google Fonts
  calls stay inside `global_text_styles.dart`; features use `context.textTheme`.
- Avoid breaking or renaming public tokens without searching all consumers.
- Export new public theme files through `theme_constants.dart`.

## Verification

Run `flutter analyze` and relevant widget/golden tests. Visually verify affected
components in light and dark modes and confirm readable contrast and RTL-safe
layout where applicable.
