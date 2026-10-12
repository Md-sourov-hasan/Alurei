# Agent guide — role features

## Scope

This directory contains flows that are exclusive to one application role. The
root guide and [`../AGENTS.md`](../AGENTS.md) apply here.

## Role layout

```text
roles/
├── parent/
│   ├── <feature>/
│   └── shared/                 # Parent-only reusable code
└── nanny/
    ├── <feature>/
    └── shared/                 # Nanny-only reusable code
```

Create role folders and their nested features as product flows are implemented;
do not add placeholder Dart layers with no responsibility.

## Boundaries

- Parent code must not import Nanny internals, and Nanny code must not import
  Parent internals.
- Login, onboarding, splash, session, role selection, and other truly common
  flows remain top-level features outside `roles/`.
- A widget used by multiple screens within one role belongs in that role's
  `shared/widgets/`. A widget used by both roles belongs in
  `src/shared/widgets/`.
- A nested screen flow stays within its owning role feature. Give child routes
  explicit `AppRoutes` names and bindings; do not create an independent router.
- Role selection and authorization must come from typed session/domain state,
  not from route-name checks or UI booleans.
- Enforce role access in controllers/domain/navigation guards as applicable; do
  not rely on hiding a button as authorization.
- Role repositories may implement common domain contracts, but they must not
  depend on the other role's presentation or data layer.

## Naming and verification

- Use role-qualified names when ambiguity is possible, such as
  `ParentHomeController` and `NannyHomeController`.
- Test each role's initial route, nested navigation, logout/session cleanup,
  loading/empty/error states, and denied cross-role access.
- Verify all role screens in four locales, Arabic RTL, light/dark themes, and
  representative compact/large screen sizes.

