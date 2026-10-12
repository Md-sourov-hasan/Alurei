# Agent guide — features

## Scope

This directory owns all user-facing product capabilities. The root
[`AGENTS.md`](../../../AGENTS.md), [`architecture.md`](../../../architecture.md),
and [`DESIGN.md`](../../../DESIGN.md) apply here.

## Feature placement

- Common flows used by both Parent and Nanny stay directly under `features/`,
  for example `auth/`, `onboarding/`, and `splash/`.
- Role-specific flows live under `features/roles/parent/` or
  `features/roles/nanny/` and also follow `roles/AGENTS.md`.
- Code reused by unrelated features or both roles belongs under `src/shared/`.
- Do not import another feature's `data/` or `presentation/` internals. Share a
  domain contract or promote genuinely global code instead.

## Required feature structure

Use only the folders a feature needs, while preserving these boundaries:

```text
<feature>/
├── data/
│   ├── models/                 # DTOs and serialization
│   ├── repositories/           # Repository implementations
│   └── sources/                # Optional remote/local data sources
├── domain/
│   ├── entities/               # Business objects
│   ├── repositories/           # Abstract repository contracts
│   └── use_cases/              # Optional reusable business operations
└── presentation/
    ├── bindings/               # GetX dependency registration
    ├── controllers/            # GetxController state and actions
    ├── screens/                # Route-level UI composition only
    └── widgets/                # Feature/screen-specific UI pieces
```

Existing `providers/` folders should migrate to `controllers/` when their files
are next substantially changed; do not maintain both names inside one feature.

## Layer boundaries

- Models map external JSON/storage representations and convert to domain
  entities. They do not contain UI state.
- Repository contracts live in `domain/repositories/`; implementations live in
  `data/repositories/` and call services/data sources.
- Controllers validate intent, call repositories/use cases, own reactive state,
  and expose typed UI actions. They do not build widgets.
- Screens compose widgets and bind observable state. They must not call Dio,
  storage, services, or repositories directly and must not contain business
  rules.
- Register controllers and their dependencies in bindings or central route
  setup, never with inline `Get.put()` in a widget.

## Screen and widget rules

- Prefer `StatelessWidget` for purely declarative UI.
- Use `HookWidget` for local, disposable presentation state such as text,
  animation, focus, tab, or page controllers.
- Use `StatefulWidget` only when a Flutter lifecycle/mixin API cannot be cleanly
  expressed with hooks; document the reason.
- Move screen-internal components out of screen files and into
  `presentation/widgets/`. Screen files should remain short route-level
  compositions.
- Dart-private (`_Name`) classes cannot be imported across files. Extracted
  internal widgets therefore use specific public class names but remain feature
  internal by not being exported from public barrels. Do not use `part` files
  only to simulate privacy.
- Reuse a widget across screens in the same feature from that feature's
  `presentation/widgets/`. Promote it to `src/shared/widgets/` only when it is
  role-neutral and reused across features or roles.
- Keep validation rules and action decisions in controllers/domain code. A form
  widget may display validation messages and collect input.

## UI, colors, and localization

- Never add raw hex colors or feature-local color classes. Add raw values to
  `src/theme/app_colors.dart`, map theme-dependent meanings in
  `color_schemes.dart`, support light and dark modes, and consume semantic colors
  through theme/context extensions.
- Use `context.textTheme` for Inter typography. Use `GlobalTextStyles` only for a
  justified Figma-specific style not covered by the type scale; never call
  `GoogleFonts` directly in a feature.
- Use the spacing, border, typography, shadow, duration, and curve tokens from
  `DESIGN.md`.
- Every user-visible string must use an `easy_localization` key present in all
  four locale files: English (`en`), Arabic (`ar`), Filipino (`fil`), and Sinhala
  (`si`).
- Reference translations only through generated keys, for example
  `LangKey.auth.name` (translation is automatic). After changing locale JSON, run
  `dart run tool/generate_lang_keys.dart`.
- Verify Arabic RTL layout and allow text to expand in every supported language.

## Figma MCP and dummy-backed screens

- Treat Figma MCP output as a visual specification. Preserve the 440 px design
  width through ScreenUtil, but map measurements to project tokens/components.
- Download raster images exposed by Figma MCP into `assets/images/`, rename them
  semantically, and register them in `AppAssets`. Never ship temporary Figma MCP
  asset URLs or substitute an unrelated placeholder for supplied artwork.
- Do not paste a complete generated frame into one large screen file. Extract
  components and connect them to controller state and typed actions.
- Store every sample value under `src/shared/dummy_data/`, grouped by feature.
  Screens, widgets, and controllers must not declare dummy lists/maps.
- Define a feature data-source/repository contract first. Use a dummy data source
  while the backend is unavailable and an API data source later; bindings choose
  the implementation.
- Make Figma interactions functional with dummy data and implement loading,
  content, empty, error, retry, validation, and nested navigation states that the
  flow requires.
- When replacing dummy data with an API, remove the dummy binding/fixtures only
  after the API implementation passes the same controller/widget tests.

## Adding a feature

1. Decide whether it is common, Parent-only, or Nanny-only.
2. Create its data, domain, and presentation boundaries without empty ceremonial
   layers.
3. Define repository contracts before implementations and inject them into a
   controller.
4. Put route-level UI in `screens/` and extracted components in `widgets/`.
5. Register routes and bindings centrally.
6. Add translations for all four locales and use centralized theme tokens.
7. Regenerate `LangKey` and connect temporary content through the dummy-source
   contract when an API is not ready.
8. Test repositories/controllers and important screen states, then run
   `flutter analyze` and `flutter test`.
