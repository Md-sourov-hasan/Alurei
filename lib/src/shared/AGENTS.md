# Agent guide — shared

## Scope

This directory contains code that is genuinely reusable across multiple
features. The root [`AGENTS.md`](../../../AGENTS.md) and
[`DESIGN.md`](../../../DESIGN.md) apply here.

## Directory roles

- `widgets/`: reusable, theme-aware UI components.
- `helpers/`: app-wide UI and formatting helpers.
- `hooks/`: reusable Flutter Hooks with explicit lifecycle cleanup.
- `wrappers/`: app or subtree composition wrappers.
- `enums/`: shared UI/domain-neutral enums.
- `app_assets.dart`: centralized asset identifiers.
- `localization/`: generated, autocomplete-safe `LangKey` constants.
- `dummy_data/`: centralized development fixtures consumed by feature dummy data
  sources.
- `shared.dart` and nested barrel files: intentional public exports.

## Rules

- Do not move code here solely to make an import convenient. It must serve more
  than one feature without depending on feature internals.
- Shared code may depend on extensions, theme, utilities, and services where
  appropriate; it must not import private implementation paths from a feature.
- Widgets stay presentation-only: no direct HTTP, persistence, or backend calls,
  and no business logic in `build()`.
- Use semantic theme colors and the design tokens documented in `DESIGN.md`.
  Support both light and dark themes.
- User-visible text must be localized. Prefer parameters or translation keys over
  embedded English strings.
- Use generated `LangKey` constants instead of raw translation key strings.
- Use Iconsax for standard interface icons instead of Flutter `Icons.*`.
  Design-specific SVGs are allowed only through a centralized `AppAssets` path.
- Never place dummy values in shared widgets. Fixture files belong only under
  `dummy_data/` and are consumed through feature data sources/repositories.
- Prefer `const` constructors unless values use runtime ScreenUtil extensions.
- Hooks must use the appropriate effect cleanup for timers, listeners,
  controllers, and subscriptions.
- Reuse `showGlobalToast()`, `showAppDialog()`, and existing shared components
  before adding a parallel feedback or component system.
- Add new public APIs to the closest barrel, then to `shared.dart` only when
  project-wide access is intended.

## Verification

For reusable UI, add focused widget tests covering key states and interactions.
Check light/dark appearance, RTL/localization behavior, small screens, loading,
empty, and error states as relevant. Run `flutter analyze` and `flutter test`.
