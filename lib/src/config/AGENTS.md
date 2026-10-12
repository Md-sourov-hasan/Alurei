# Agent guide — config

## Scope

This directory owns application-wide runtime configuration. The root
[`AGENTS.md`](../../../AGENTS.md) and [`SETUP.md`](../../../SETUP.md) apply here.

## Current contract

- `AppConfig.init()` creates the one shared `Dio` client.
- `AppConfig.dio` is consumed by services; do not instantiate `Dio` in widgets
  or feature presentation code.
- `API_BASE_URL` comes from dotenv, with the existing development fallback.
- `api_endpoints.dart` is the canonical catalog of relative backend paths.

## Rules

- Keep initialization explicit, deterministic, and safe to call during app
  startup.
- Never hardcode production secrets, tokens, credentials, or private endpoints.
- Document new environment keys in `SETUP.md` and provide a safe fallback only
  when the application can genuinely operate with it.
- Configure cross-cutting HTTP behavior here or in a focused shared networking
  service, not separately in each feature.
- Add every backend path to `ApiEndpoints` and reference the constant from
  services. Keep paths relative to `API_BASE_URL`, group them by domain, and use
  methods with `Uri.encodeComponent` for dynamic path segments.
- Do not place query values directly in endpoint strings; pass them through
  Dio's `queryParameters` so they are encoded correctly.
- Do not log authorization headers, tokens, request bodies containing sensitive
  data, or personal childcare information.
- Preserve useful timeouts and map runtime request errors through the service and
  `runTask()` layers rather than exposing `DioException` to UI code.
- Changes here are application-wide; inspect all consumers before renaming or
  changing initialization order.

## Verification

Run `flutter analyze` and relevant service tests. If an environment contract
changes, verify both configured and missing-key startup behavior without adding
real secrets to the repository.
