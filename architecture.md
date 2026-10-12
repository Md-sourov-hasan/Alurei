# Alurei architecture

Alurei uses feature-first Clean Architecture with GetX composition. Parent and
Nanny experiences are isolated by role, while authentication and startup flows
are common.

## Source layout

```text
lib/src/
├── features/
│   ├── AGENTS.md
│   ├── auth/                       # Common: Parent + Nanny
│   ├── onboarding/                 # Common: Parent + Nanny
│   ├── splash/                     # Common: Parent + Nanny
│   └── roles/
│       ├── AGENTS.md
│       ├── parent/
│       │   ├── <feature>/
│       │   └── shared/             # Reused only across Parent features
│       └── nanny/
│           ├── <feature>/
│           └── shared/             # Reused only across Nanny features
├── shared/                         # Reused across features or both roles
│   ├── dummy_data/                 # Central development fixture values
│   └── localization/               # Generated typed translation keys
├── config/                         # Runtime config and endpoint catalog
├── routing/                        # GetX routes and bindings
├── services/                       # App-wide external integrations
├── theme/                          # Central Material 3 design system
├── extensions/
└── utils/
```

Common features do not need a `common/` wrapper: their position directly under
`features/` identifies them as role-neutral. A role-specific feature always sits
under `features/roles/<role>/`.

## Feature anatomy

```text
<feature>/
├── data/
│   ├── models/                     # DTO/JSON/storage mapping
│   ├── repositories/               # Domain contract implementations
│   └── sources/                    # Optional remote/local sources
├── domain/
│   ├── entities/                   # Framework-independent business objects
│   ├── repositories/               # Abstract contracts
│   └── use_cases/                  # Optional reusable operations
└── presentation/
    ├── bindings/                   # GetX registration and lifecycle
    ├── controllers/                # GetxController state/actions
    ├── screens/                    # Route-level UI composition
    └── widgets/                    # Internal feature UI
```

Folders are responsibility boundaries, not a checklist. Omit a source or use-case
folder when the feature does not need it, but never merge models, repository
implementations, controllers, and screens into one file.

## Dependency direction

```text
presentation  ──>  domain  <──  data  ──>  app services
      │                │
      └──── UI state   └──── contracts/entities
```

- Domain code must not import Flutter, GetX, Dio, widgets, or data models.
- Data implements domain repository contracts and maps transport/storage models
  to domain entities.
- Presentation depends on domain contracts/use cases through injected
  controllers. It does not call Dio, storage, or repositories from widgets.
- App-wide services wrap external capabilities and expose `FutureEither<T>`.
- Cross-feature imports target an intentional contract or shared module, never
  another feature's internal data/presentation path.

## Dummy-to-API data sources

Figma-derived screens may be made functional before a backend is ready, but UI
code never owns sample values.

```text
central fixtures
      │
      v
DummyFeatureDataSource ─┐
                       ├─> FeatureRepositoryImpl -> Controller -> Screen
ApiFeatureDataSource ───┘
```

- All fixture values live under `lib/src/shared/dummy_data/`, grouped by feature.
- A feature-local dummy data source reads those fixtures and maps them to its
  data models.
- Dummy and API sources satisfy the same feature contract. Bindings select the
  implementation; controllers/screens are unchanged when the API replaces dummy
  data.
- Loading, empty, error, and pagination simulation belongs in the dummy source.
- Production bindings must never select dummy sources.

## UI composition

Screens are thin route-level compositions. `StatelessWidget` is the default;
`HookWidget` owns disposable local UI state. Use `StatefulWidget` only for a
required Flutter lifecycle or mixin that hooks cannot represent cleanly.

Screen-specific and feature-reusable components live in
`presentation/widgets/`. Since Dart-private classes cannot cross files, extracted
widgets use specific public names but remain internal by not being exported.
Widgets repeated across one role move to `roles/<role>/shared/widgets/`; widgets
repeated across roles/features move to `src/shared/widgets/`.

## State, navigation, and role flow

- Controllers extend `GetxController`, expose typed observable state, and own UI
  actions and validation decisions.
- Bindings construct controllers and repositories. Widgets never register their
  own dependencies.
- `AppRouter.getPages` and `AppRoutes` remain the only route registry.
- After common authentication/session restoration, typed session state chooses
  the Parent or Nanny root flow.
- Each role may have nested pages, but all remain named GetX routes with explicit
  bindings; do not add nested routing packages.
- Role access is enforced outside visual widgets. Hidden UI alone is not an
  authorization boundary.

## Design and localization

- All raw colors are centralized in `lib/src/theme/app_colors.dart`, then mapped
  by `color_schemes.dart` to semantic theme roles for light and dark modes.
- Inter typography is centralized in `global_text_styles.dart` and applied to the
  complete app `TextTheme`; features consume theme roles rather than font APIs.
- Layout, typography, borders, shadows, and motion use the tokens in `DESIGN.md`.
- Every visible string has matching translations in English (`en`), Arabic
  (`ar`), Filipino (`fil`), and Sinhala (`si`). Arabic screens must support RTL.
- Translation paths are generated from JSON and referenced through typed
  `LangKey` constants rather than raw string literals.

## Testing expectations

- Unit-test model mapping, repositories, use cases, and controllers.
- Widget-test important loading, content, empty, error, validation, and action
  states without real network calls.
- Test Parent and Nanny route entry, nested flows, role isolation, and logout.
- Run `flutter analyze` and `flutter test` after feature changes.
