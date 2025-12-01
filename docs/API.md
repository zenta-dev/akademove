# AkadeMove API Documentation

## Overview

AkadeMove is a campus mobility & delivery platform API built on Cloudflare Workers with Hono and oRPC. The API provides real-time order matching, driver tracking, payment processing, and gamification features.

**Base URL**: `https://api.akademove.com`
**Protocol**: HTTPS only
**Format**: JSON
**API Version**: 1.0.0

## Authentication

All authenticated endpoints require a Bearer token in the Authorization header or a session cookie.

```http
Authorization: Bearer <token>
```

### Authentication Endpoints

#### POST `/api/auth/sign-in`
Login with email and password.

**Request Body**:
```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

**Response**:
```json
{
  "status": 200,
  "body": {
    "message": "Sign in successful",
    "data": {
      "user": {
        "id": "uuid",
        "name": "John Doe",
        "email": "user@example.com",
        "role": "USER|DRIVER|MERCHANT|OPERATOR|ADMIN",
        "banned": false
      },
      "token": "jwt-token"
    }
  }
}
```

**Rate Limit**: 5 requests per 15 minutes per IP

#### POST `/api/auth/sign-up-user`
Register a new user account.

**Request Body**:
```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "phone": {
    "countryCode": "ID",
    "number": 81234567890
  },
  "password": "password123",
  "confirmPassword": "password123",
  "gender": "MALE|FEMALE" // optional
}
```

**Rate Limit**: 5 requests per 15 minutes per IP

#### POST `/api/auth/sign-up-driver`
Register a new driver account (requires KTM, SIM, and vehicle documents).

**Rate Limit**: 5 requests per 15 minutes per IP

#### POST `/api/auth/sign-up-merchant`
Register a new merchant/tenant account.

**Rate Limit**: 5 requests per 15 minutes per IP

#### POST `/api/auth/forgot-password`
Request password reset email.

#### POST `/api/auth/reset-password`
Reset password using token from email.

#### POST `/api/auth/sign-out`
Sign out current session (requires authentication).

#### GET `/api/auth/session`
Get current session information (requires authentication).

## Rate Limiting

All API endpoints are rate-limited to prevent abuse. Rate limits are applied per IP address and/or user ID.

**Global Limits**:
- 1000 requests per hour per IP

**Endpoint-Specific Limits**:
- Authentication endpoints: 5 requests per 15 minutes per IP
- Order placement: 20 requests per hour per user
- Write operations: 30 requests per minute per user
- Read operations: 100 requests per minute per user
- Expensive operations (reports/exports): 10 requests per hour per user

**Rate Limit Headers**:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 998
X-RateLimit-Reset: 1234567890000
Retry-After: 3600
```

## User Management

### GET `/api/user/me`
Get current user profile (requires authentication).

**Response**:
```json
{
  "status": 200,
  "body": {
    "data": {
      "id": "uuid",
      "name": "John Doe",
      "email": "user@example.com",
      "phone": {
        "countryCode": "ID",
        "number": 81234567890
      },
      "role": "USER",
      "emailVerified": true,
      "banned": false,
      "photo": "https://storage.url/photo.jpg",
      "gender": "MALE"
    }
  }
}
```

### PUT `/api/user/me`
Update current user profile.

### GET `/api/user/admin/list`
List all users (ADMIN/OPERATOR only).

**Query Parameters**:
- `limit`: Number of results per page (default: 10)
- `page`: Page number for offset pagination
- `cursor`: Cursor for cursor-based pagination
- `query`: Search query (name, email)
- `sortBy`: Sort field (default: createdAt)
- `order`: Sort order (asc/desc)
- `mode`: Pagination mode (offset/cursor)

## Order Management

### POST `/api/order/place`
Place a new order (RIDE, DELIVERY, or FOOD).

**Request Body**:
```json
{
  "type": "RIDE|DELIVERY|FOOD",
  "pickup": {
    "lat": -7.7956,
    "lng": 110.3695,
    "address": "UGM Campus"
  },
  "dropoff": {
    "lat": -7.8000,
    "lng": 110.3700,
    "address": "Destination"
  },
  "genderPreference": "SAME|ANY", // optional
  "notes": "Additional instructions" // optional
}
```

**Response**:
```json
{
  "status": 201,
  "body": {
    "message": "Order placed successfully",
    "data": {
      "id": "uuid",
      "type": "RIDE",
      "status": "REQUESTED",
      "totalPrice": 15000,
      "pickup": {...},
      "dropoff": {...}
    }
  }
}
```

**Rate Limit**: 20 requests per hour per user

### GET `/api/order/{id}`
Get order details by ID.

**Response includes**:
- Order details
- User information
- Driver information (if assigned)
- Real-time location (during trip)
- Status history

### PUT `/api/order/{id}/cancel`
Cancel an order.

**Cancellation Rules**:
- User cancellation: 10% penalty if after driver acceptance
- Driver cancellation: Counts toward daily limit (3 cancellations/day triggers suspension)

### GET `/api/order/list`
List user's orders (with filters).

**Query Parameters**:
- `status`: Filter by status
- `type`: Filter by order type
- `limit`, `page`, `cursor`: Pagination
- `sortBy`: createdAt, totalPrice, etc.

## Driver Management

### POST `/api/driver/accept-order`
Accept an incoming order (DRIVER only).

**Request Body**:
```json
{
  "orderId": "uuid"
}
```

### POST `/api/driver/update-location`
Update driver's current location (real-time during active order).

**Request Body**:
```json
{
  "orderId": "uuid",
  "location": {
    "lat": -7.7956,
    "lng": 110.3695
  }
}
```

### PUT `/api/driver/status`
Update driver availability status.

**Request Body**:
```json
{
  "isTakingOrder": true|false
}
```

### GET `/api/driver/schedule`
Get driver's class schedule.

### POST `/api/driver/schedule`
Set class schedule (to auto-disable during class hours).

**Request Body**:
```json
{
  "dayOfWeek": 1-7,
  "startTime": "08:00",
  "endTime": "10:00",
  "isActive": true
}
```

### GET `/api/driver/earnings`
Get driver earnings summary.

**Response**:
```json
{
  "status": 200,
  "body": {
    "data": {
      "today": 150000,
      "thisWeek": 850000,
      "thisMonth": 3200000,
      "totalOrders": 42,
      "averageRating": 4.8
    }
  }
}
```

## Merchant Management

### GET `/api/merchant/menu`
Get merchant menu items.

### POST `/api/merchant/menu`
Add new menu item (MERCHANT only).

**Request Body**:
```json
{
  "name": "Nasi Goreng",
  "description": "Spicy fried rice",
  "price": 15000,
  "category": "Food",
  "image": "<file upload>",
  "isAvailable": true
}
```

### PUT `/api/merchant/menu/{id}`
Update menu item.

### DELETE `/api/merchant/menu/{id}`
Delete menu item.

### GET `/api/merchant/orders`
Get merchant orders (FOOD type only).

### PUT `/api/merchant/orders/{id}/status`
Update order status (PREPARING, READY_FOR_PICKUP).

**Request Body**:
```json
{
  "status": "PREPARING|READY_FOR_PICKUP",
  "estimatedReadyTime": "2024-03-20T10:30:00Z" // optional
}
```

## Wallet & Payments

### GET `/api/wallet/balance`
Get current wallet balance.

**Response**:
```json
{
  "status": 200,
  "body": {
    "data": {
      "balance": 250000,
      "currency": "IDR"
    }
  }
}
```

### POST `/api/wallet/top-up`
Initiate wallet top-up via QRIS/bank transfer.

**Request Body**:
```json
{
  "amount": 100000,
  "method": "QRIS|BANK_TRANSFER"
}
```

**Response includes Midtrans payment link/QR code**.

### POST `/api/wallet/withdraw`
Withdraw funds to bank account (DRIVER only).

**Request Body**:
```json
{
  "amount": 500000,
  "bankProvider": "BCA|BNI|BRI|MANDIRI|PERMATA",
  "bankNumber": 1234567890
}
```

### GET `/api/wallet/transactions`
Get wallet transaction history.

## Ratings & Reviews

### POST `/api/review/create`
Submit rating and review after order completion.

**Request Body**:
```json
{
  "orderId": "uuid",
  "rating": 5,
  "comment": "Great service!",
  "categories": {
    "cleanliness": 5,
    "courtesy": 5,
    "safety": 5
  }
}
```

**Rules**:
- Both driver and user must rate each other
- Order status changes to COMPLETED only after both ratings submitted
- Rating impacts driver ranking and matching priority

### GET `/api/review/received`
Get reviews received by current user/driver.

## Leaderboard & Badges

### GET `/api/leaderboard`
Get driver leaderboard rankings.

**Query Parameters**:
- `period`: daily, weekly, monthly, all-time
- `limit`: Number of results (default: 10)

**Response**:
```json
{
  "status": 200,
  "body": {
    "data": {
      "rows": [
        {
          "rank": 1,
          "driverId": "uuid",
          "driverName": "John Driver",
          "totalEarnings": 5000000,
          "totalOrders": 150,
          "averageRating": 4.9,
          "badges": ["Elite-Driver", "First-Order"]
        }
      ]
    }
  }
}
```

### GET `/api/badge/list`
Get all available badges.

### GET `/api/badge/user`
Get current user's earned badges.

## Configuration (OPERATOR only)

### GET `/api/configuration`
Get platform configuration.

**Response includes**:
- Commission rates (ride, delivery, food, merchant)
- Base fare and per-km pricing
- Cancellation penalties
- Driver matching radius
- Auto-accept timeout

### PUT `/api/configuration`
Update platform configuration.

**Request Body**:
```json
{
  "rideCommissionRate": 0.15,
  "deliveryCommissionRate": 0.15,
  "foodCommissionRate": 0.20,
  "merchantCommissionRate": 0.10,
  "baseFare": 5000,
  "pricePerKm": 3000
}
```

## Coupons & Promotions (OPERATOR only)

### GET `/api/coupon/list`
Get all coupons.

### POST `/api/coupon/create`
Create new coupon.

**Request Body**:
```json
{
  "code": "WELCOME50",
  "discountType": "PERCENTAGE|FIXED",
  "discountValue": 50,
  "minOrderAmount": 20000,
  "maxDiscount": 10000,
  "validFrom": "2024-03-01T00:00:00Z",
  "validTo": "2024-03-31T23:59:59Z",
  "usageLimit": 100,
  "userUsageLimit": 1
}
```

### POST `/api/coupon/apply`
Apply coupon to order.

## Emergency & Safety

### POST `/api/emergency/trigger`
Trigger emergency alert (during active trip).

**Request Body**:
```json
{
  "orderId": "uuid",
  "location": {
    "lat": -7.7956,
    "lng": 110.3695
  },
  "message": "Emergency situation" // optional
}
```

**Response**:
- Notifies campus security/operator
- Shares real-time location
- Creates incident record

### GET `/api/emergency/list`
Get emergency incidents (OPERATOR only).

## Reports & Analytics (OPERATOR/ADMIN only)

### GET `/api/report/orders`
Get order analytics report.

**Query Parameters**:
- `startDate`, `endDate`: Date range
- `type`: Order type filter
- `status`: Status filter

**Rate Limit**: 10 requests per hour (expensive operation)

### GET `/api/report/drivers`
Get driver performance report.

### GET `/api/report/revenue`
Get revenue analytics.

**Response includes**:
- Total revenue
- Platform commission earned
- Revenue by order type
- Revenue by merchant
- Growth metrics

## WebSocket Real-time Updates

### Connection: `wss://api.akademove.com/ws`

**Authentication**: Query parameter `token=<jwt>`

**Events**:

#### Order Status Updates
```json
{
  "type": "ORDER_STATUS_UPDATE",
  "data": {
    "orderId": "uuid",
    "status": "ACCEPTED",
    "driverId": "uuid",
    "driverName": "John Driver",
    "driverLocation": {
      "lat": -7.7956,
      "lng": 110.3695
    }
  }
}
```

#### Driver Location Updates
```json
{
  "type": "DRIVER_LOCATION_UPDATE",
  "data": {
    "orderId": "uuid",
    "location": {
      "lat": -7.7956,
      "lng": 110.3695
    },
    "heading": 180,
    "speed": 30
  }
}
```

#### New Order (for drivers)
```json
{
  "type": "NEW_ORDER",
  "data": {
    "orderId": "uuid",
    "type": "RIDE",
    "pickup": {...},
    "dropoff": {...},
    "estimatedEarnings": 12000,
    "distance": 3.5
  }
}
```

## Error Responses

All error responses follow this format:

```json
{
  "success": false,
  "message": "Error description",
  "code": "ERROR_CODE"
}
```

**Error Codes**:
- `BAD_REQUEST` (400): Invalid request data
- `UNAUTHORIZED` (401): Missing or invalid authentication
- `FORBIDDEN` (403): Insufficient permissions or rate limit exceeded
- `NOT_FOUND` (404): Resource not found
- `CONFLICT` (409): Resource conflict (e.g., duplicate)
- `INTERNAL_SERVER_ERROR` (500): Server error

### Rate Limit Error
```json
{
  "success": false,
  "message": "Rate limit exceeded. Try again in 3600 seconds.",
  "code": "FORBIDDEN"
}
```

## Order State Machine

Orders follow this state flow:

```
REQUESTED → MATCHING → ACCEPTED → ARRIVING → IN_TRIP → COMPLETED
                ↓
            CANCELLED_BY_USER / CANCELLED_BY_DRIVER / CANCELLED_BY_SYSTEM
```

**Food Orders**:
```
REQUESTED → MATCHING → ACCEPTED → PREPARING → READY_FOR_PICKUP → IN_TRIP → COMPLETED
```

**State Transitions**:
- `REQUESTED`: User created order, waiting for matching
- `MATCHING`: System searching for available driver
- `ACCEPTED`: Driver accepted, navigating to pickup
- `PREPARING`: Merchant preparing food (FOOD orders only)
- `READY_FOR_PICKUP`: Food ready (FOOD orders only)
- `ARRIVING`: Driver near pickup location
- `IN_TRIP`: Order in progress (pickup complete)
- `COMPLETED`: Trip finished, awaiting rating
- `CANCELLED_*`: Cancelled by user/driver/system

## Commission & Pricing

**Platform Commission** (deducted from order total):
- RIDE: 15%
- DELIVERY: 15%
- FOOD: 20%

**Merchant Commission** (FOOD orders only): 10%

**Example Calculation** (FOOD order, ₹30,000):
- Platform commission: ₹6,000 (20%)
- Merchant commission: ₹3,000 (10%)
- Driver earns: ₹24,000
- Merchant earns: ₹27,000

## Security & Best Practices

1. **Always use HTTPS** - Never send credentials over HTTP
2. **Store tokens securely** - Use secure storage (e.g., httpOnly cookies)
3. **Respect rate limits** - Implement exponential backoff
4. **Validate input** - All requests are validated with Zod schemas
5. **Handle errors gracefully** - Check error codes and messages
6. **Use WebSocket reconnection** - Implement automatic reconnection with backoff
7. **Log user actions** - All sensitive operations are logged

## SDK Examples

### JavaScript/TypeScript
```typescript
import { orpcClient } from "@/lib/orpc";

// Place an order
const result = await orpcClient.order.placeOrder({
  body: {
    type: "RIDE",
    pickup: { lat: -7.7956, lng: 110.3695, address: "UGM" },
    dropoff: { lat: -7.8000, lng: 110.3700, address: "Destination" }
  }
});

if (result.status === 201) {
  console.log("Order placed:", result.body.data);
}
```

### Dart/Flutter
```dart
final client = ApiClient();

// Get wallet balance
final response = await client.getWalletApi().getBalance();
print('Balance: ${response.data.balance}');
```

## Support

For API support or bug reports, contact:
- Email: api-support@akademove.com
- GitHub Issues: https://github.com/akademove/issues
- Documentation: https://docs.akademove.com

## Changelog

### v1.0.0 (2024-03-20)
- Initial API release
- Authentication & user management
- Order placement & matching
- Real-time tracking
- Wallet & payments
- Ratings & reviews
- Leaderboard & badges
- Rate limiting
- Error boundaries
