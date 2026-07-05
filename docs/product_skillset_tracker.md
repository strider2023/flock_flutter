# Flock Product Skillset Tracker

This tracker maps Flock's product capabilities to development progress. Treat each skill as an owned product area with a clear user outcome, current implementation state, pending scope, and delivery evidence.

## Status Legend

- `Available`: usable in the current app, even if backed by mock data.
- `Partial`: visible UI or local behavior exists, but the product outcome is incomplete.
- `Pending`: not meaningfully implemented yet.
- `Platform`: backend, commerce, data, or operations capability needed to make the feature real.

## Product North Star

Flock is an influencer-driven, pledge-to-production commerce platform for Indian Gen Z users. Creators and small brands launch limited-run drops, consumers pledge a low token amount, production starts only after a threshold is reached, failed campaigns are refunded, and successful buyers receive products they can share socially.

Flock has two linked seller surfaces:

- `Campaigns`: the demand-validation and pledge-to-production module. Sellers use campaigns to test and fund limited drops before production.
- `Marketplace`: the ongoing commerce module. Sellers can continue selling products after a campaign succeeds, turning validated drops into regular marketplace listings.

Primary loop:

1. Creator launches campaign.
2. Consumer discovers campaign.
3. Consumer pledges Rs 10-15.
4. Campaign reaches threshold.
5. Production is confirmed.
6. Successful campaign products become eligible for marketplace sale.
7. Product is delivered.
8. Consumer shares the flex.

## Skill Areas

| Skill | User Outcome | Current Status | Current Evidence | Pending Scope | Delivery Evidence |
|---|---|---:|---|---|---|
| Authentication and Session | Users can join, log in, stay signed in, and log out. | Partial | Login/signup screens, local token persistence, logout path. | Real auth API, validation, forgot password, Google/Apple auth, secure token handling. | Real account works across app restart and invalid credentials fail cleanly. |
| Consumer Marketplace Discovery | Users browse products, brands, categories, and promotional campaign entry points. | Partial | Marketplace tab, carousels, product cards, brand rows, category list, campaign promo card. | Supabase-backed product catalog, real category filtering, brand pages, cart/product detail flows. | Marketplace renders real catalog data and category navigation changes results. |
| Campaign Discovery Feed | Users discover active pledge campaigns and compare momentum. | Partial | Fund It tab, campaign carousel, feed cards, pledge progress bars, filter sheet. | Real campaign API, campaign statuses, category filters, closing-soon/new-launch logic, stable sorting. | Feed displays live campaigns with accurate thresholds, progress, and campaign states. |
| Campaign Detail | Users understand what they are pledging for before committing. | Partial | Campaign detail page with media carousel, vendor section, pledge progress, goal amount, associated products. | Funding tiers, token pledge amount, production timeline, refund rules, creator updates, comments, FAQ, trust signals. | Detail page explains pledge terms, timeline, refund state, and product deliverables clearly. |
| Pledge Flow | Users pledge a low token amount with confidence. | Partial | `Fund It!` CTA and payment bottom sheet exist. | Rs 10-15 fixed pledge model, gateway integration, payment validation, pledge confirmation, failure handling. | A user can complete a real pledge and see it in pledge history. |
| Threshold and Production Trigger | Campaigns automatically move from pledge collection to production once target is met. | Pending | Pledge count and goal fields exist in models. | Threshold rules, campaign state machine, production confirmed notification, failed campaign refund trigger. | Campaign status changes automatically when pledge target is reached or deadline expires. |
| Refunds and Failed Campaigns | Users get automatic refunds when campaigns fail. | Pending | No refund state exists. | Refund rules, payment reversal integration, refund notifications, pledge history state. | Failed campaign shows refunded state and payment reconciliation record. |
| Order and Delivery Lifecycle | Users track successful campaign orders through fulfillment. | Pending | Profile has a placeholder `Manage Orders` entry. | Order creation, Supabase order linkage, fulfillment statuses, delivery address selection, tracking details. | Pledge converts into an order after production confirmation and shows delivery status. |
| Social Flex and Sharing | Users share delivered products and campaign wins socially. | Pending | Share icons exist as TODO placeholders. | `#FlockFlex` share templates, native share integration, post-delivery prompts, referral/deep links. | User can share campaign/product content with branded copy and links. |
| Creator Campaign Creation | Influencers and small brands can launch pledge campaigns. | Pending | No creator-side module exists. | Creator onboarding, product upload, media upload, threshold setting, production timeline, campaign preview, submit/review flow. | Creator can publish a campaign that appears in the consumer feed. |
| Seller Marketplace Continuity | Sellers can keep selling successful campaign products through the marketplace. | Pending | Marketplace and campaign modules exist separately, but no campaign-to-marketplace handoff exists. | Convert funded campaign products into marketplace listings, inventory/price management, seller product dashboard, post-campaign availability controls. | A funded campaign product can be listed and purchased from the marketplace after campaign success. |
| Creator and Brand Trust | Users can evaluate whether a creator/drop is credible. | Partial | Vendor name/avatar/details and Follow button appear on campaign detail. | Verified creator profiles, follower counts, prior campaign success, policy badges, follow persistence. | Creator profile shows reputation and follow state backed by data. |
| Search and Recommendations | Users find products and campaigns quickly. | Partial | Search page, recent searches, trending chips, autocomplete, result list. | Full catalog/campaign search, ranking, filters, sort application, recent search persistence. | Search returns relevant real products/campaigns and filters modify results. |
| Favorites and Pledges | Users revisit saved products and track pledged items. | Partial | Favorites and My Pledges tabs exist with mock grid data. | Save/unsave actions, pledge history, campaign/order status, persistence. | Favorites and pledge history reflect actual user actions. |
| Addresses | Users manage delivery addresses for fulfilled orders. | Partial | Address list, add address, delete address, Indian state selector. | Edit address, default address, persistence, validation, checkout integration. | User can add/edit/delete/default an address and use it for delivery. |
| Profile Management | Users maintain account and identity information. | Partial | Profile view, edit profile, DOB/gender, avatar picker. | Persisted profile updates, image upload, validation, account deletion/privacy controls. | Profile changes persist from backend and update across screens. |
| Notifications | Users receive meaningful campaign, pledge, refund, and delivery updates. | Partial | Notification list with timestamps exists. | Event-driven notifications, deep links, read/unread state, production/refund/delivery notifications. | Campaign status changes create actionable notifications. |
| Cart and Checkout | Users buy marketplace or confirmed campaign products. | Pending | Cart icon exists but no behavior. | Cart, checkout, taxes/shipping, address selection, Supabase order/payment session, order confirmation. | User can purchase a product through Supabase-backed checkout. |
| Supabase Backend Integration | Auth, products, campaigns, pledges, orders, refunds, and notifications are backed by Supabase. | Pending | No Supabase client or backend integration is visible. `graphql_flutter` dependency exists but should be replaced if unused. | Supabase client setup, schema/RLS alignment, auth integration, storage, realtime pledge updates, edge functions for payments/refunds. | App reads and writes real Supabase data for core Phase 1 flows. |
| Brand System | App consistently reflects Flock's intended Gen Z Indian visual identity. | Partial | Flock name and tagline exist; UI is polished enough for demo. | Align colors to Electric Blue to Coral Pink, logo/icon system, Poppins/Inter typography, creator/drop visual language. | Screens match approved brand guide across light/dark modes. |
| Analytics and Metrics | Team can measure funnel health and product adoption. | Pending | No analytics layer visible. | Event taxonomy, campaign funnel tracking, pledge conversion, refund rate, creator success metrics. | Dashboards or logs show discovery-to-pledge-to-order funnel. |
| Quality, Testing, and Release Readiness | Product can ship safely and regressions are caught. | Partial | Flutter project structure and lint config exist. | Unit/widget tests, integration tests, mock API contracts, CI, crash/error reporting. | Core flows have automated tests and release checks pass. |

## Delivery Milestones

### Milestone 1: Consumer Pledge MVP

Goal: Make the current consumer app usable for real pledge campaigns.

- Real auth and profile persistence.
- Real campaign feed and campaign detail API.
- Rs 10-15 pledge checkout flow.
- Pledge confirmation and My Pledges history.
- Campaign status states: collecting, funded, failed, refunded.
- Successful campaign products marked as eligible for marketplace sale.
- Basic notifications for pledge, funded, failed, and refund events.

### Milestone 2: Supabase Commerce Foundation

Goal: Connect Flock to Supabase for products, campaigns, pledges, checkout, and orders.

- Supabase client and environment configuration.
- Supabase schema integration for catalog, campaigns, pledges, and orders.
- Campaign-to-marketplace product linkage.
- Product detail and cart.
- Checkout creation.
- Order history and fulfillment state.
- Address selection during checkout.

### Milestone 3: Creator Campaign Launch

Goal: Let influencers and small brands create campaigns.

- Creator onboarding.
- Campaign creation form.
- Product/media upload.
- Pledge threshold and production timeline setup.
- Campaign preview and submission.
- Creator campaign dashboard.

### Milestone 4: Production, Delivery, and Flex

Goal: Complete the promise after threshold is reached.

- Production confirmed state.
- Delivery tracking.
- Social sharing with `#FlockFlex`.
- Campaign updates and comments.
- Refund automation for failed campaigns.
- Creator and campaign trust signals.

## Immediate Ownership Backlog

| Priority | Work Item | Product Skill |
|---:|---|---|
| P0 | Define campaign state machine and data model. | Threshold and Production Trigger |
| P0 | Replace generic payment sheet with fixed pledge flow. | Pledge Flow |
| P0 | Add My Pledges real state and pledge confirmation screen. | Favorites and Pledges |
| P0 | Create Supabase/API integration skeleton. | Supabase Backend Integration |
| P1 | Add campaign status labels and deadline/threshold behavior to feed and detail. | Campaign Discovery Feed |
| P1 | Implement address edit/default and connect to checkout readiness. | Addresses |
| P1 | Wire share actions to branded campaign sharing. | Social Flex and Sharing |
| P1 | Update brand theme toward blue-to-coral identity if approved. | Brand System |
| P2 | Add creator campaign creation module. | Creator Campaign Creation |
| P2 | Add notifications with read/unread and deep links. | Notifications |
| P2 | Add analytics event layer. | Analytics and Metrics |
| P2 | Add tests for auth, campaign, pledge, and address flows. | Quality, Testing, and Release Readiness |

## Progress Review Cadence

Use this checklist during each development review:

- Which skill moved from `Pending` to `Partial` or `Partial` to `Available`?
- Which product outcome can now be demonstrated on device?
- Which mock data source was replaced with real platform data?
- Which user action is now persisted?
- Which edge case is handled: payment failure, campaign failure, refund, expired campaign, missing address, invalid auth?
- Which metric can now be measured?
