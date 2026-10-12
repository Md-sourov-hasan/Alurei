# Agent guide — Web

## Scope

This directory contains the Flutter web host shell and PWA metadata. The root
[`AGENTS.md`](../AGENTS.md) and [`SETUP.md`](../SETUP.md) apply here. Application
features remain in Dart under `lib/`.

## Rules

- Keep `index.html` minimal and retain Flutter's base-href placeholder and
  bootstrap script.
- Keep `manifest.json`, title, theme color, descriptions, and icons aligned with
  Alurei branding.
- Do not place API keys, tokens, private endpoints, or other secrets in HTML,
  JavaScript, or the web manifest; browser-delivered values are public.
- Do not duplicate Flutter UI or navigation in handwritten JavaScript.
- Add browser permissions, service workers, or third-party scripts only when a
  feature explicitly requires them, and document the setup in `SETUP.md`.
- Keep web-only behavior behind platform-safe Dart abstractions so mobile builds
  remain valid.
- After host or web plugin changes, run `flutter analyze`, relevant tests, and a
  web build.

