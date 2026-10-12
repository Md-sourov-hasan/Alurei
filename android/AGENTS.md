# Agent guide — Android

## Scope

This directory contains Flutter-generated Android host code. The root
[`AGENTS.md`](../AGENTS.md) and [`SETUP.md`](../SETUP.md) apply here. Do not edit
native files unless a task explicitly requires Android integration.

## Project contract

- Android namespace and application ID are `com.alurei.app`.
- `MainActivity` uses Flutter's current `FlutterActivity` embedding.
- Dart owns application behavior; native code is only for platform integration.

## Rules

- Do not hand-edit generated plugin registrants or Gradle wrapper files.
- Keep secrets, signing credentials, `key.properties`, and service-account files
  out of source control.
- Document required SDK keys and native setup in `SETUP.md`; use placeholders in
  tracked examples.
- Add permissions only when a feature needs them, and keep permission requests in
  the Dart `PermissionService` flow.
- Preserve the existing package ID during Flutter regeneration or migrations.
- Prefer package-supported configuration over custom native forks.
- After Gradle, manifest, SDK, or plugin changes, run `flutter analyze`, relevant
  tests, and an Android debug build.

