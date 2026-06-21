# Swim Success

A Flutter test-task app with two features:

1. **Pace Selector** — set your fastest 100m freestyle time via MIN:SEC input, slider, and tap-to-edit. Swimmer level updates live. Submit pace to a REST API on Continue.
2. **User List + Detail** — fetch users from JSONPlaceholder, search by name, pull-to-refresh, and navigate to a detail screen with address, company, and website.

Dark theme throughout. Built for Android and iOS.

## How to run

```bash
flutter pub get
flutter run
```

Run tests:

```bash
flutter test
flutter analyze
```

## State management — BLoC / Cubit

This project uses **Cubit** (from `flutter_bloc`) for both features.

**Why Cubit over other options:**

- **Explicit states** — each feature models loading, success, and error as separate sealed classes (`PaceSubmitting`, `UserListError`, etc.) instead of nullable fields with implicit meaning. The UI can pattern-match on state without guessing which combination of flags is active.
- **Testability** — Cubits are pure Dart (no `BuildContext`, no widgets). Business logic like pace clamping, level calculation, and name filtering can be unit-tested by calling methods and asserting emitted states.
- **Separation from UI** — widgets only render state and dispatch actions. Networking lives in repositories; Cubits orchestrate the flow. No widget calls `http` directly.
- **Why not full Bloc** — our interactions are mostly direct action → emit (increment seconds, submit pace, update search query). Cubit's simpler API is enough. A full Bloc with event transformers would add ceremony without benefit here, except potentially for debounced slider/API work — but the spec only fires the POST on Continue tap, so Cubit stays the right fit.

`setState` is used in exactly one place: `InlineEditableDigit`, for the local `_isEditing` flag that controls whether the inline text field is visible. That is trivial UI state, not business data.

## Project structure

Feature-first clean architecture. Each feature owns its data, logic, and presentation layers.

```
lib/
  core/
    constants/       API URLs, durations, shared messages
    network/         HttpClient wrapper, typed network exceptions
    theme/           Colors, spacing, text styles, ThemeData
    utils/           Shared helpers (e.g. min loading duration)
    widgets/         Generic widgets reused across features (LoadingIndicator)

  features/
    pace_selector/
      data/
        models/      PaceSubmissionRequest
        repository/  PaceRepository (interface + impl)
      logic/         PaceCubit, PaceState, level thresholds, time utils
      presentation/
        screens/     PaceSelectorScreen
        theme/       Per-level accent colors, pace UI constants
        widgets/     PaceTimeDisplay, PaceSlider, ContinueButton, etc.

    user_list/
      data/
        models/      UserModel, AddressModel, CompanyModel
        repository/  UserRepository (interface + impl)
      logic/         UserListCubit, UserListState
      presentation/
        screens/     UserListScreen, UserDetailScreen
        widgets/     UserListTile, UserSearchField, UserDetailSection
```

**Rules followed:**

- Nothing in `data/` imports Flutter widgets.
- Repositories parse JSON into typed models and throw typed exceptions — they don't know about loading states.
- Screens are composition roots (BlocProvider + layout). Complex UI lives in dedicated widget files (~100–150 line limit per file).
- Shared code moves to `core/` only when a second feature actually needs it.

## Swimmer level thresholds

Based on **100m freestyle total time** (lower = faster = higher level). These are reasonable estimates for a fitness app, not official competitive swim classifications.

| Level        | Time range   | Seconds   |
|--------------|--------------|-----------|
| Elite        | ≤ 0:59       | ≤ 59      |
| Advanced     | 1:00 – 1:30  | 60 – 90   |
| Intermediate | 1:31 – 2:00  | 91 – 120  |
| Beginner     | > 2:00       | > 120     |

Defined in `lib/features/pace_selector/logic/pace_level_constants.dart`.

Slider range: **0:30 – 4:00** (ticks at 1:10, 1:30, 2:00 as reference labels). The 1:30–2:00 band uses a stretched non-linear scale for easier adjustment; visual fill zones extend intermediate to 3:30. Minutes input capped at 4 to match.

## Networking

- **Pace submit:** `POST https://jsonplaceholder.typicode.com/posts` with `{ "pace_seconds": <int> }`
- **User list:** `GET https://jsonplaceholder.typicode.com/users`

Uses the `http` package (lightweight; only simple GET/POST needed) wrapped in repository classes.

## What I'd do differently with more time

- **Unit tests for Cubits** — level filtering and pace clamp/submit flows are structured for testing but only partially covered today (model parsing and level thresholds have tests; Cubit emit sequences do not).
- **Dependency injection** — repositories are constructed manually in screen `BlocProvider`s. With more time I'd add `get_it` or constructor injection at the app root so tests can swap in fakes without touching screens.
- **Debounced search** — name filtering is instant on every keystroke. Fine for 10 users; would debounce for larger datasets.
- **go_router** — `Navigator.push` works for the current two-screen flow. A declarative router would help if onboarding, deep links, or more routes were added.
- **Offline / caching** — user list re-fetches from network every time. Would cache locally and show stale-while-revalidate for a production app.
- **Golden / integration tests** — widget tests cover key screens; golden tests would lock in the dark-theme layout against regressions.

## Commit history

Work was done incrementally on the `dev` branch — one focused commit per step (scaffolding → pace input → slider/levels → API → user list → detail → polish).
