# Agent guide — utils

## Scope

This directory contains low-level, application-wide utilities and error/task
primitives. The root [`AGENTS.md`](../../../AGENTS.md) applies here.

## Responsibilities

- `failure.dart`, `typedefs.dart`, and `task_runner.dart` define the
  `Failure`/`FutureEither` error contract.
- `error_handler.dart` normalizes external error messages.
- `logger.dart` provides application logging.
- Other files contain focused formatting, platform, debounce, and input helpers.
- `utils.dart` is the public barrel.

## Rules

- Utilities must be feature-agnostic and should not import feature presentation
  or state code.
- Prefer pure functions and small, typed APIs. Hidden navigation, storage,
  networking, or UI side effects do not belong in a generic utility.
- Fallible asynchronous infrastructure should use `FutureEither<T>` and preserve
  meaningful `Failure` categories.
- `runTask()` is the common exception boundary: log diagnostics, return a
  failure, and never expose raw external exceptions to presentation code.
- Never swallow exceptions with an empty `catch`; handle, map, log, or rethrow.
- Never log credentials, tokens, personal data, or secure values.
- Call `AppLogger.init()` during startup and use `AppLogger` instead of
  `print()`, `debugPrint()`, `dart:developer`, or direct `Logger()` instances.
- Select the log level deliberately: `debug`/`verbose` for diagnostics, `info`
  for flow, `success` for completed operations, `warning` for recoverable risk,
  `error` for failures, and `wtf` only for impossible/fatal states.
- Debouncers, timers, subscriptions, and controllers must expose and implement
  cleanup when they own resources.
- Add a file to `utils.dart` only when it is intended as a shared public API.
- Avoid `dynamic`; if an external error must be retained, contain it at the
  failure boundary and keep callers strongly typed.

## Verification

Add unit tests for success, boundary values, malformed input, error mapping, and
resource cleanup as applicable. Run `dart format`, `flutter analyze`, and the
relevant tests.
