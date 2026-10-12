# Agent guide — dummy data

## Scope

This directory is the single source for development fixture values used to make
Figma-derived screens interactive before backend APIs are available. The root,
feature, and shared agent guides continue to apply.

## Rules

- Store fixture values in focused `<feature>_dummy_data.dart` files and export
  intended fixtures from `dummy_data.dart`.
- Keep records typed where practical. For API-shaped maps, use
  `Map<String, Object?>`, never `dynamic`.
- Never put dummy values directly in screens, widgets, controllers, repository
  implementations, or production services.
- A feature's `Dummy<Feature>DataSource` may read these fixtures and map them to
  feature models. The controller depends on a repository contract, never on the
  fixture file.
- The eventual `Api<Feature>DataSource` must implement the same feature data
  source/repository contract so bindings can switch implementations without UI
  changes.
- Dummy data must be obviously fictional and must not contain real names,
  credentials, tokens, phone numbers, addresses, or childcare/family records.
- Model loading, content, empty, validation, error, and pagination states when a
  Figma flow shows them. Simulated failures/delays belong in the dummy data
  source, not in fixture constants or widgets.
- Do not ship a production binding configured to use dummy data.
