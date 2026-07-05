# Flock Data Model

This document describes the current app data model and the intended Supabase-aligned direction.

## Auth Models

Implemented in the Flutter mock layer.

### AuthUser

Represents a Supabase-like user.

| Field | Type | Notes |
|---|---|---|
| `id` | `String` | Mock user id. |
| `email` | `String` | Normalized lowercase email. |
| `phone` | `String?` | Consumer phone number stored as metadata-adjacent data. |
| `emailConfirmedAt` | `DateTime?` | Null until mock email confirmation is completed. |
| `userMetadata` | `Map<String, dynamic>` | Stores `full_name`, `phone`, and `account_type`. |

### AuthSession

Represents a Supabase-like session.

| Field | Type | Notes |
|---|---|---|
| `accessToken` | `String` | Mock access token passed into authenticated repositories. |
| `refreshToken` | `String` | Mock refresh token for future Supabase parity. |
| `expiresAt` | `DateTime` | Used to reject expired local sessions. |
| `user` | `AuthUser` | User attached to the session. |

### AuthResponse

Represents the response shape returned by Supabase auth calls.

| Field | Type | Notes |
|---|---|---|
| `user` | `AuthUser` | Always present after signup/login success. |
| `session` | `AuthSession?` | Null for signup until email confirmation is completed. |

### MockAuthException

Represents Supabase-like auth failures.

| Field | Type | Notes |
|---|---|---|
| `message` | `String` | User-displayable message. |
| `code` | `String` | Stable error code. |
| `statusCode` | `int?` | HTTP-style code for future backend parity. |

Current auth error codes:

- `invalid_credentials`
- `email_not_confirmed`
- `user_already_registered`
- `user_not_found`
- `email_already_confirmed`

## Product Model

Implemented as `ProductModel`.

| Field | Type | Notes |
|---|---|---|
| `imageUrl` | `String` | Product image URL. |
| `vendorName` | `String` | Seller/vendor display name. |
| `itemName` | `String` | Product title. |
| `category` | `String` | Product category. |
| `purchasePrice` | `double` | Current display price. |
| `actualPrice` | `double?` | Optional crossed-out original price. |
| `discountPercentage` | `double?` | Optional discount value. |
| `rating` | `double` | Mock rating. |
| `ratingCount` | `int` | Mock review count. |

## Campaign Models

### FeedItem

Represents a campaign card in the `Fund It` feed.

Core fields:

- `id`
- `imageUrls`
- `title`
- `description`
- `pledgeCount`
- `pledgeGoal`
- `likeCount`
- `commentCount`
- `vendorName`
- `vendorAvatarUrl`
- `campaignEndDate`
- `postedDate`

Pending fields needed for Phase 1 pledge-to-production:

- `status`: collecting, funded, failed, refunded, in production, delivered.
- `pledgeAmount`: expected Rs 10-15 token amount.
- `productionTimeline`
- `marketplaceEligible`
- `marketplaceProductId`

### CampaignDetailModel

Represents campaign detail data.

Current fields include:

- Campaign identity and media.
- Vendor name/avatar/details.
- Pledge count and pledge goal.
- Like and comment counts.
- Campaign end date.
- Total fund amount.
- Description.
- Associated products.

Pending fields:

- Campaign status.
- Refund policy.
- Production trigger timestamp.
- Delivery estimate.
- Creator updates.
- FAQ/trust signals.

## Marketplace Models

Marketplace feed sections include:

- `CarouselSection`
- `CategoryProductSection`
- `BrandSection`

Marketplace and campaign data must eventually be linked:

- A successful campaign product should become eligible for marketplace listing.
- Marketplace products should be traceable back to the campaign that validated them when applicable.

## Profile and Account Models

Current user profile model includes:

- `name`
- `phone`
- `email`
- `avatarUrl`
- `dateOfBirth`
- `gender`

Future Supabase profile table should align with auth metadata and store editable consumer profile details separately from auth credentials.

## Address Model

Current address model supports:

- `id`
- `recipientName`
- `addressDetails`
- `pincode`
- `state`
- `type`
- `instructions`

Pending fields:

- `isDefault`
- `city`
- `phone`
- backend ownership via `user_id`

## Favorites and Pledges

Current favorite/pledge grid data is mocked.

Future models should split:

- `favorites`: saved product/campaign references.
- `pledges`: user pledge records with amount, status, campaign id, payment id, and refund state.

## Notifications

Current notification model supports:

- icon
- title
- description
- timestamp

Pending fields:

- `id`
- `user_id`
- `type`
- `read_at`
- `deep_link`
- `campaign_id`
- `pledge_id`
- `order_id`

