# Agent guide — routing

## Scope

This directory is the central GetX navigation composition layer. The root
[`AGENTS.md`](../../../AGENTS.md) applies here.

## File responsibilities

- `app_routes.dart`: canonical named-route constants.
- `app_router.dart`: `GetPage` registrations in `AppRouter.getPages`.
- `app_bindings.dart`: application-level lazy dependency registration.
- `global_navigator.dart`: root navigator key and nullable root context access.

## Rules

- Use GetX navigation and `GetPage`; do not introduce GoRouter, AutoRoute, or a
  second app/router wrapper.
- Route names must be constants in `AppRoutes`. Do not scatter string route
  literals through features.
- When adding a routable page, update the route constant and `AppRouter.getPages`
  together, then attach the appropriate binding when dependencies are required.
- Register controllers and repositories through bindings with `Get.lazyPut`,
  `Get.put`, or `Get.create` according to lifecycle needs. Avoid inline
  registration inside widgets.
- Keep route construction lightweight; business logic belongs in controllers or
  services.
- Treat route renames as deep-link changes. Search all call sites before
  modifying an existing path.
- `rootContext` may be null before mounting or after teardown. Check it before
  use and never store it in a long-lived object.
- Central routing may import feature entry screens, but features must not import
  another feature's internals.

## Verification

Run `flutter analyze` and navigation/widget tests covering added routes, binding
lifecycle, unknown paths, and back navigation where applicable.

