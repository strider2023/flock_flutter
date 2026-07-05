# Flock Flutter Architecture

This document captures the current architecture of the app as implemented so far.

## Overview

Flock is currently a Flutter consumer app organized by feature modules under `lib/modules`. The app uses `provider` and `ChangeNotifier` viewmodels for state management. Repositories provide data to viewmodels. Most repositories are currently mock or in-memory implementations, with Supabase planned as the future backend.

## App Entry Flow

1. `main.dart` starts `FlockApp`.
2. `FlockApp` provides the top-level `AuthRepository` and `AuthViewModel`.
3. `AuthWrapper` decides whether to show:
   - `AuthPage` for unauthenticated, email-confirmation, and reset-password states.
   - `MainAppView` for authenticated sessions.
4. `MainAppView` injects feature repositories and viewmodels for the authenticated area.
5. `HomePage` shows the bottom navigation shell:
   - `Market`
   - `Fund It`
   - `Notifications`
   - `Profile`

## State Management Pattern

The app follows a simple MVVM-style pattern:

- `View`: Flutter widgets render screens and collect user input.
- `ViewModel`: `ChangeNotifier` classes hold loading/error/data state and expose actions.
- `Repository`: module-specific classes provide data and simulate API behavior.
- `Model`: immutable Dart objects represent feature data.

Current examples:

- Auth:
  - Views: `AuthPage`, `LoginView`, `SignUpView`, `AuthWrapper`
  - Viewmodels: `AuthViewModel`, `LoginViewModel`, `SignUpViewModel`
  - Repository: `AuthRepository`
  - Models: `AuthUser`, `AuthSession`, `AuthResponse`, `MockAuthException`
- Marketplace:
  - View: `MarketplaceHomeView`
  - ViewModel: `MarketplaceViewModel`
  - Repository: `MarketplaceRepository`
- Campaigns:
  - Views: `CampaignHomeView`, `CampaignDetailView`
  - Viewmodels: `FeedViewModel`, `CampaignDetailViewModel`
  - Repository: `CampaignRepository`

## Auth Architecture

Auth is now intentionally shaped like Supabase while remaining local-only.

Implemented behavior:

- `signUp` creates a mock user with `emailConfirmedAt = null`.
- Signup returns `AuthResponse(user, session: null)`.
- Login uses `signInWithPassword`.
- Login returns a persisted `AuthSession` only after email confirmation.
- `confirmEmail` simulates clicking a confirmation link.
- `resendConfirmation` simulates resending email confirmation.
- `resetPasswordForEmail` simulates password reset request.
- `getCurrentSession` restores a non-expired local mock session.
- `signOut` clears the persisted mock session.

Auth state is represented by:

- `unknown`
- `authenticated`
- `unauthenticated`
- `emailConfirmationRequired`
- `passwordResetRequested`

## Backend Direction

Supabase is the planned backend, but it is not installed or configured yet.

Expected future backend responsibilities:

- Auth and session management.
- Consumer profile storage.
- Product catalog.
- Campaign data.
- Pledges and pledge counters.
- Campaign status transitions.
- Refund state.
- Marketplace listings after successful campaigns.
- Notifications.
- Orders and delivery lifecycle.

## Module Boundaries

Campaigns and marketplace are related but distinct:

- Campaigns validate demand before production.
- Marketplace supports ongoing sales after campaign success.
- Future implementation should link successful campaign products to marketplace listings rather than treating both modules as unrelated catalogs.

## Testing

Current test coverage exists for auth only:

- Mock signup creates unconfirmed users.
- Duplicate signup errors.
- Login before confirmation errors.
- Mock confirmation enables login.
- Session restore works.
- Logout clears session.
- Form validation blocks invalid auth submissions.

