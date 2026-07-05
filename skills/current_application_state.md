# Current Application State

This file summarizes what exists in the Flutter application and should be updated before each phase starts.

## Implemented Modules

| Module | Current State |
|---|---|
| Auth | Supabase-shaped local mock auth with signup, login, email confirmation, reset-password request, session restore, and logout. |
| Marketplace | Consumer marketplace shell with product carousel, category/product sections, brand rows, search entry, cart placeholder, and campaign promo entry. Data is mocked. |
| Campaigns | `Fund It` feed with carousel, campaign cards, pledge progress, filters, campaign detail, associated products, and mock funding sheet. Data is mocked. |
| Search | Search screen with recent searches, trending chips, autocomplete suggestions, result list, and sort/filter UI. Data is mocked. |
| Profile | Profile display, edit profile screen, image picker, logout, and navigation to addresses/favorites/orders/support placeholders. Data is mocked. |
| Addresses | Address list, add address, delete address, Indian state selector. Data is in-memory. |
| Favorites / Pledges | Favorites and My Pledges tabs with mock grid data. |
| Notifications | Mock notification list with relative timestamps. |

## Product Model

Flock has two linked seller surfaces:

- `Campaigns`: sellers validate demand and trigger production through pledge thresholds.
- `Marketplace`: sellers continue selling successful campaign products after campaign success.

## Recently Completed

- Added Supabase-shaped mock auth models:
  - `AuthResponse`
  - `AuthUser`
  - `AuthSession`
  - `MockAuthException`
- Replaced token-only auth mock with mock user/session persistence.
- Added email-confirmation-required and password-reset-requested auth states.
- Added confirm-password validation and specific auth error codes.
- Added auth repository/viewmodel tests.

## Known Gaps

- Supabase SDK and backend schema are not integrated yet.
- Marketplace, campaigns, profile, addresses, favorites, and notifications still use mock or in-memory data.
- Payment, pledge persistence, refunds, campaign state transitions, and order lifecycle are not implemented.
- Seller campaign creation and marketplace seller dashboard are not implemented.
- Google/Apple login is not configured.

