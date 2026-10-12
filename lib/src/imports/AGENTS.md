# Agent guide — imports

## Scope

This directory defines project barrel exports. The root
[`AGENTS.md`](../../../AGENTS.md) applies here; edit these files cautiously
because a change can affect most of the application.

## Barrel roles

- `imports.dart` is the primary public barrel used by application code.
- `core_imports.dart` exports Flutter SDK APIs and project-level modules.
- `packages_imports.dart` exports approved third-party package APIs.

## Rules

- Add an export only when it is intentionally useful across many files. Prefer a
  direct import for narrow or implementation-only dependencies.
- Preserve the existing split between SDK/project exports and package exports.
- Do not export feature internals merely to bypass feature boundaries. Only
  expose deliberate feature entry points required by central composition, such
  as routing.
- Avoid circular export chains and duplicate exports.
- Check symbol collisions before adding packages. Use a narrow `hide`/`show`
  clause only when the intended public surface is clear.
- Never add a dependency here unless it already exists in `pubspec.yaml` and is
  part of the approved stack.
- Keep exports grouped and readable; remove stale exports when files are moved.

## Verification

After changing a barrel, run `dart format` on changed Dart files and
`flutter analyze`. Analyzer ambiguity or hidden-name warnings must be resolved,
not suppressed.

