# Agent guide — services

## Scope

This directory contains application-wide integrations and infrastructure
services. The root [`AGENTS.md`](../../../AGENTS.md) applies here.

## Service contract

- Follow the existing singleton form: private constructor plus
  `ClassName.instance`.
- Async operations that can fail return `FutureEither<T>` and execute through
  `runTask()`.
- Set `requiresNetwork: true` for operations that require connectivity.
- HTTP operations use `AppConfig.dio` or `DioService.instance`; never create an
  unconfigured `Dio` client.
- HTTP paths come from `ApiEndpoints`; do not add endpoint string literals to
  service methods.
- Export services intended for broad use from `services.dart`.

## Boundaries and safety

- Services must not accept `BuildContext` and must not depend on feature widgets.
- Keep transport, device, storage, permission, and platform behavior out of
  widget `build()` methods.
- Convert external exceptions into the project `Failure` model. Do not leak raw
  `DioException`, platform exceptions, or stack traces to the UI.
- Use `AppLogger` for diagnostics, and never log passwords, tokens, private
  profile data, children/family data, or secure-storage values.
- Initialize storage services once during app startup. SharedPreferences is for
  ordinary preferences, Hive is for structured/cache data, and secure storage is
  for credentials or other sensitive values.
- Do not add FCM, local-notification, socket, or session-cleanup infrastructure
  until its backend contract and required packages are explicitly in scope.
- Use secure storage for credentials and sensitive values; do not move them to
  SharedPreferences or ordinary Hive boxes.
- Close stream controllers and other owned resources through an explicit
  lifecycle method.
- Use `rootContext` only for an established global UI helper and guard null; keep
  core service logic independent of UI state.
- Keep feature-only orchestration in the owning feature. Promote code here only
  when it is truly application-wide.

## Adding or updating a service

1. Reuse an existing service when it already owns the integration.
2. Keep the public API typed and small.
3. Wrap fallible work with `runTask()` and choose the appropriate failure type.
4. Add a public export to `services.dart` when cross-project access is intended.
5. Test success, connectivity failure, external exception, and cleanup paths.
6. Run `dart format`, `flutter analyze`, and relevant tests.
