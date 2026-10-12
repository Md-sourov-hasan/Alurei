# Agent guide — extensions

## Scope

This directory contains small, reusable Dart and Flutter extension methods. The
root [`AGENTS.md`](../../../AGENTS.md) applies here; this file adds rules specific
to `lib/src/extensions/`.

## Responsibilities

- Add broadly reusable extensions for core, collection, widget, and context
  types.
- Keep feature-specific behavior inside its owning feature, not here.
- Export public extension files from `extensions.dart`.

## Implementation rules

- Use descriptive extension and member names that do not collide with Dart,
  Flutter, GetX, or package APIs already exported by the project.
- Keep extensions deterministic and lightweight. Do not perform networking,
  persistence, navigation, or other hidden side effects.
- Keep `BuildContext` helpers focused on presentation concerns such as theme,
  media size, and shared dialogs. Never retain a `BuildContext`.
- Prefer existing design accessors (`context.colors`, `context.textTheme`,
  `context.appColors`, and `context.designTokens`) over duplicate helpers.
- Preserve null safety and generic types; avoid `dynamic` unless an upstream API
  requires it.
- Add documentation when behavior, null handling, or units are not obvious.

## Adding or updating an extension

1. Search existing files for equivalent behavior or naming conflicts.
2. Place the method in the extension file for the extended type, or create a
   focused `snake_case.dart` file.
3. Export a new public file from `extensions.dart`.
4. Add or update tests for non-trivial transformations and edge cases.
5. Run `dart format` and `flutter analyze`.

