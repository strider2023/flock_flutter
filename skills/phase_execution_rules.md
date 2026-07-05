# Phase Execution Rules

This file must be reviewed and updated at the start of every development phase.

## Working Rules

- Work phase by phase.
- Do not generate or refactor the whole app unless the active phase explicitly requires it.
- At the start of each phase, update the markdown files in `/skills` to reflect the current application state.
- Keep product requirements aligned with the current Flock direction:
  - Consumer-first Flutter app.
  - Supabase backend planned.
  - Campaigns validate demand through pledge-to-production.
  - Marketplace remains the ongoing seller channel after a campaign succeeds.
- Keep mocks close to the eventual Supabase contract when backend work is not ready yet.
- Avoid replacing current modules with unrelated architecture unless a phase explicitly calls for it.

## Current Phase Status

- Latest completed implementation phase: Login and registration Phase 1.
- Current backend status: mocked locally; Supabase is planned but not installed.
- Current auth behavior:
  - Consumer-only email/password account flow.
  - Signup creates an unconfirmed mock user.
  - Email confirmation is simulated in-app.
  - Login only succeeds after confirmation.
  - Mock sessions are persisted with `SharedPreferences`.

