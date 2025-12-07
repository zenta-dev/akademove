# AkadeMove Merchant Status/Availability Management - Current Implementation Summary

## Executive Summary
The AkadeMove codebase has **limited merchant availability management** infrastructure. Merchants currently have an `isActive` boolean field for account activation/deactivation (admin-level), but **lack real-time online/offline status management** similar to drivers. The system needs to be extended to support:
- Merchant availability toggling (open/closed)
- Real-time status broadcasts to customers
- Order acceptance/rejection based on availability
- Dynamic menu availability during operating hours

---

## 1. Current Merchant-Related Structures

### 1.1 Database Tables
**File**: `apps/server/src/core/tables/merchant.ts`

#### Merchant Table (`merchants`)
```
Fields:
- id (UUID) - Primary key
- userId (text, FK to auth.user) - Unique reference
- name (text) - Merchant name
- email (text, unique) - Email address
- phone (JSONB) - Phone contact
- address (text) - Physical location
- location (geometry) - PostGIS point (lat, lng)
- bank (JSONB) - Bank details
- category (enum) - Primary category (ATK, Printing, Food)
- categories (text[]) - List of item categories
- isActive (boolean, default: true) - Account active/inactive
- rating (numeric) - Merchant rating (0.0-5.0)
- document (text) - Document URL
- image (text) - Profile image URL
- createdAt, updatedAt (timestamps)

Indexes:
- merchant_is_active_idx on isActive
- merchant_location_idx (GIST PostGIS spatial index)
- merchant_name_text_idx (text pattern for search)
- merchant_rating_idx
- merchant_created_at_idx
```

#### Merchant Menu Table (`merchant_menus`)
```
Fields:
- id (UUID) - Primary key
- merchantId (UUID, FK to merchant.id)
- name (varchar) - Menu item name
- category (varchar) - Item category
- price (numeric) - Base price
- stock (integer) - Available stock
- image (text) - Item image URL
- createdAt, updatedAt (timestamps)

Indexes:
- merchant_menu_merchant_id_idx
- merchant_menu_category_idx
- merchant_menu_stock_idx
- merchant_menu_merchant_category_idx
- merchant_menu_price_idx
- merchant_menu_created_at_idx
```

#### Order Table (Relevant Merchant Fields)
```
Fields relevant to merchants:
- merchantId (UUID, FK) - Reference to merchant
- type (enum) - RIDE, DELIVERY, FOOD
- status (enum) - Order status with CANCELLED_BY_MERCHANT
- acceptedAt, preparedAt, readyAt (timestamps) - Merchant action timestamps
```

**CRITICAL GAP**: No dedicated fields for:
- `isOnline`/`isAvailable` (like drivers have)
- `isTakingOrders` (unlike drivers)
- `businessHours` (start/end times)
- `operatingStatus` (open/closed/break)

### 1.2 Zod Schemas
**File**: `packages/schema/src/merchant.ts`

#### MerchantSchema
```typescript
{
  id: UUID,
  userId: string,
  name: string,
  email: email,
  phone: PhoneSchema (optional),
  address: string,
  location: CoordinateSchema (optional),
  isActive: boolean,        // ONLY availability field
  rating: number,
  document: URL (optional),
  image: URL (optional),
  category: MerchantCategorySchema,
  categories: string[],
  bank: BankSchema,
  createdAt: Date,
  updatedAt: Date
}

InsertMerchantSchema: omits id, userId, rating, isActive, document, image, categories
UpdateMerchantSchema: partial InsertMerchantSchema
```

**CRITICAL GAP**: No fields for:
- Operating hours
- Business status (open/closed)
- Availability preferences

### 1.3 Constants (Not Specialized for Merchants)
**File**: `packages/schema/src/constants.ts`

```typescript
MERCHANT_CATEGORIES: ["ATK", "Printing", "Food"]
// Note: No MERCHANT_STATUSES like DRIVER_STATUSES exists
// Merchants only have isActive boolean, not status enum
```

---

## 2. Merchant Status/Availability Management

### 2.1 Current Implementation (Limited)

#### Merchant Account Activation/Deactivation
**Location**: `apps/server/src/features/merchant/main/merchant-main-handler.ts`

```typescript
// Handler: activate (System/Admin only)
.activate (requireRoles "SYSTEM")
  -> merchant.main.activate(merchantId)
  
// Handler: deactivate (System/Admin only)
.deactivate (requireRoles "SYSTEM")
  -> merchant.main.deactivate(merchantId, reason)
```

**Repository Methods**:
- `MerchantMainRepository.activate(id)` - Sets isActive = true
- `MerchantMainRepository.deactivate(id, reason)` - Sets isActive = false

**Constraints**:
- Only admins/operators can toggle (no merchant self-service)
- No real-time broadcasting to users
- No reason/notification sent to users
- Binary activation (not "open for hours")

#### Order Handling by Merchant Status
**Locations**: 
- `apps/server/src/features/merchant/order/merchant-order-handler.ts`
- `apps/server/src/features/merchant/order/merchant-order-repository.ts`

**Available Methods**:
```
- acceptOrder(orderId, merchantId) -> status = ACCEPTED
- rejectOrder(orderId, merchantId, reason) -> status = CANCELLED_BY_MERCHANT
- markPreparing(orderId, merchantId) -> status = PREPARING
- markReady(orderId, merchantId) -> status = READY_FOR_PICKUP
```

**Flow**:
1. Order arrives in REQUESTED status
2. Merchant can ACCEPT → ACCEPTED
3. Merchant can REJECT → CANCELLED_BY_MERCHANT (if not yet accepted)
4. Once accepted, merchant controls: PREPARING → READY_FOR_PICKUP
5. Driver picks up → IN_TRIP → COMPLETED

**CRITICAL GAP**: 
- No automatic rejection if merchant is closed/offline
- No "pause accepting new orders" feature
- No temporary break/maintenance mode
- Status changes only visible via WebSocket (not HTTP polling)

### 2.2 Driver Availability Service (Reference Pattern)
**File**: `apps/server/src/features/driver/services/driver-availability-service.ts`

This service shows the pattern merchants SHOULD follow:

```typescript
class DriverAvailabilityService {
  
  // Set online/offline status
  async setOnlineStatus(driverId, isOnline, deps, opts?)
    
  // Set order-taking status (independent of online)
  async setOrderTakingStatus(driverId, isTakingOrder, deps, opts?)
  
  // Check if available for orders
  isAvailableForOrders(driver): boolean
    // Returns: isOnline && !isTakingOrder && hasLocation
  
  // Validate can be assigned
  canBeAssignedToOrder(driver, deps): boolean
    // + checks cancellation cooldown
}
```

**Driver Table Fields**:
```
- isOnline (boolean) - Online/offline toggle
- isTakingOrder (boolean) - Currently on active order
- currentLocation (geometry) - Last known location
- lastCancellationDate (timestamp) - For cooldown
- status (enum) - PENDING, APPROVED, ACTIVE, INACTIVE, SUSPENDED
```

**Merchants currently lack this structure.**

---

## 3. Real-Time WebSocket Infrastructure

### 3.1 WebSocket Architecture
**Files**:
- `apps/server/src/features/ws.ts` - WebSocket router setup
- `apps/server/src/features/order/order-ws.ts` - Order Durable Object (1100+ lines)
- `apps/server/src/features/payment/payment-ws.ts` - Payment Durable Object

**Existing Routes**:
```
GET /ws/order/:id        - Order updates (ACCEPTED, PREPARING, READY, COMPLETED, etc.)
GET /ws/driver-pool      - Driver pool for matching
GET /ws/payment/:id      - Payment updates
```

**NO EXISTING ROUTE FOR MERCHANT STATUS BROADCASTS**

### 3.2 Order Room WebSocket Message Types
**File**: `apps/server/src/features/order/order-ws.ts`

**Merchant-related actions** (lines 80-95):
```typescript
if (data.a === "MERCHANT_ACCEPT")
  -> handleMerchantAccept(ws, data, tx)
  
if (data.a === "MERCHANT_REJECT")
  -> handleMerchantReject(ws, data, tx)
  
if (data.a === "MERCHANT_MARK_PREPARING")
  -> handleMerchantMarkPreparing(ws, data, tx)
  
if (data.a === "MERCHANT_MARK_READY")
  -> handleMerchantMarkReady(ws, data, tx)
```

**Message Format** (`OrderEnvelope` from `@repo/schema/ws`):
```typescript
{
  e: string,                      // Event type (MERCHANT_ACCEPTED, etc.)
  f: string,                      // Sender type (s = server, c = client)
  t: string,                      // Message type
  tg?: string,                    // Target audience (DRIVER, USER, MERCHANT)
  p: object,                      // Payload
  a?: string                      // Action (MATCHING, ACCEPTED, etc.)
}
```

**Broadcast Pattern** (line 711):
```typescript
this.broadcast(response, { excludes: [ws] });
// Sends to all connected clients except sender
```

**BROADCAST INFRASTRUCTURE EXISTS** - Can be repurposed for merchant status

### 3.3 Broadcast Feature (Unused Pattern)
**Files**:
- `apps/server/src/features/broadcast/broadcast-handler.ts` (246 lines)
- `apps/server/src/core/tables/broadcast.ts`

**Purpose**: 
- System-wide announcements/notifications
- Email + In-App broadcasts
- Used for admin communications

**NOT for real-time individual user status (merchants/drivers)**

---

## 4. Web UI Patterns for State Management

### 4.1 Web Provider Pattern
**File**: `apps/web/src/providers/merchant.tsx` (50 lines)

```typescript
// React Context for merchant state
interface MyMerchantContextValue {
  value: Merchant | undefined,
  isLoading: boolean,
  isError: boolean,
  error: Error | null
}

// Uses TanStack Query
const { data } = useQuery(
  orpcQuery.merchant.getMine.queryOptions()
)

// No real-time updates, only polling
```

**Current Limitations**:
- No WebSocket integration
- No real-time status updates
- Only fetches merchant profile on page load
- No availability toggle UI component

### 4.2 Merchant Dashboard Routes
**Files in** `apps/web/src/routes/dash/merchant/`:
```
- index.tsx      (Overview/Dashboard)
- orders.tsx     (Order list with notifications)
- menu.tsx       (Menu management)
- profile.tsx    (Profile settings)
- sales.tsx      (Sales analytics)
- wallet.tsx     (Wallet/earnings)
```

**orders.tsx**: Shows notifications with banner + toast, but:
- No availability toggle
- No "pause accepting orders" feature
- No operating hours configuration

**profile.tsx**: Edits merchant details (name, address, etc.) but:
- No availability settings
- No operating hours
- No status management

**Mobile Home Screen** shows power icon (lines 94-97):
```dart
IconButton(
  onPressed: () {},  // NOT IMPLEMENTED
  icon: Icon(LucideIcons.power, size: 20.sp),
)
```

---

## 5. Existing Infrastructure That Can Be Leveraged

### 5.1 Transaction/Database
- ✅ Drizzle ORM with PostgreSQL
- ✅ PostGIS for geospatial queries
- ✅ Database transactions for consistency
- ✅ Proper indexing patterns established

### 5.2 Real-Time
- ✅ WebSocket with Cloudflare Durable Objects
- ✅ Broadcast pattern established
- ✅ OrderEnvelope schema for messages
- ✅ Auto-reconnection handling

### 5.3 Error Handling & Logging
- ✅ Structured logging (log.info, log.error, etc.)
- ✅ Custom error types (RepositoryError, AuthError)
- ✅ Context-aware logging

### 5.4 API & Type Safety
- ✅ oRPC with Zod validation
- ✅ Auto-generated OpenAPI spec
- ✅ Type-safe client generation (Dart)

### 5.5 State Management
- ✅ Web: TanStack Query + React Context
- ✅ Mobile: BLoC pattern with Cubits
- ✅ Established patterns for data fetching

---

## 6. Implementation Gaps & Requirements

### 6.1 Database/Schema Gaps

**Missing Merchant Fields**:
- [ ] `isOnline` (boolean) - Current status
- [ ] `isTakingOrders` (boolean) - Accept new orders?
- [ ] `operatingStatus` (enum) - OPEN, CLOSED, BREAK, MAINTENANCE
- [ ] `businessHoursStart` (time) - When merchant opens
- [ ] `businessHoursEnd` (time) - When merchant closes
- [ ] `timezone` (string) - For scheduling
- [ ] `lastStatusChange` (timestamp) - When status last changed
- [ ] `statusReason` (text) - Why closed/on break

**Missing Order Fields**:
- [ ] Validation that order can be assigned if merchant is online

### 6.2 API Handler Gaps

**Missing Endpoints**:
- [ ] POST `/merchants/:id/status/online` - Toggle online
- [ ] POST `/merchants/:id/status/pause-orders` - Pause accepting orders
- [ ] PATCH `/merchants/:id/operating-hours` - Set business hours
- [ ] GET `/merchants/:id/availability` - Get current status
- [ ] GET `/merchants/nearby?lat=X&lng=Y` - Find open merchants

**Missing Middleware**:
- [ ] Check if merchant is online before accepting order
- [ ] Auto-reject if merchant is offline/closed
- [ ] Validate merchant self-service (not just SYSTEM role)

### 6.3 WebSocket Gaps

**Missing Routes**:
- [ ] `GET /ws/merchant/:id` - Merchant status updates
- [ ] `GET /ws/merchant-broadcast` - Broadcast to all users about merchant status

**Missing Message Types**:
- [ ] MERCHANT_ONLINE
- [ ] MERCHANT_OFFLINE
- [ ] MERCHANT_PAUSED_ORDERS
- [ ] MERCHANT_RESUMED_ORDERS
- [ ] MERCHANT_BREAK_MODE

### 6.4 UI/UX Gaps

**Web (React)**:
- [ ] Availability toggle on dashboard
- [ ] Operating hours configuration
- [ ] Pause/Resume orders buttons
- [ ] Status indicator (green/red) in header
- [ ] Notifications about status changes

**Mobile (Flutter)**:
- [ ] Power button handler implementation
- [ ] Status toggle screen
- [ ] Operating hours editor
- [ ] Real-time status sync with WebSocket

### 6.5 Business Logic Gaps

- [ ] Auto-reject orders if merchant goes offline while matching
- [ ] Auto-pause orders during off-hours
- [ ] Merchant can manually pause (e.g., busy, break)
- [ ] Orders fail to assign if merchant becomes unavailable
- [ ] Users see only open merchants in search/list

---

## 7. Current Code Organization

```
apps/server/
├── src/
│   ├── core/
│   │   ├── tables/
│   │   │   ├── merchant.ts           ← Main table definition
│   │   │   ├── order.ts              ← Order table
│   │   │   ├── auth.ts               ← User table
│   │   │   └── driver.ts             ← Reference: has isOnline, isTakingOrder
│   │   └── constants.ts              ← BUSINESS_CONSTANTS, CACHE_TTLS
│   └── features/
│       ├── merchant/
│       │   ├── main/
│       │   │   ├── merchant-main-spec.ts         ← API spec
│       │   │   ├── merchant-main-handler.ts      ← Handlers (activate/deactivate only)
│       │   │   └── merchant-main-repository.ts   ← DB layer
│       │   ├── order/
│       │   │   ├── merchant-order-spec.ts
│       │   │   ├── merchant-order-handler.ts     ← Accept/reject/marking
│       │   │   └── merchant-order-repository.ts
│       │   ├── menu/
│       │   │   ├── merchant-menu-spec.ts
│       │   │   ├── merchant-menu-handler.ts
│       │   │   └── merchant-menu-repository.ts
│       │   ├── services/
│       │   │   ├── merchant-order-status-service.ts
│       │   │   ├── merchant-verification-service.ts
│       │   │   ├── merchant-stats-service.ts
│       │   │   ├── merchant-document-service.ts
│       │   │   ├── menu-image-service.ts
│       │   │   └── best-sellers-service.ts
│       │   └── merchant-handler.ts   ← Router
│       ├── driver/
│       │   ├── services/
│       │   │   └── driver-availability-service.ts ← REFERENCE PATTERN
│       │   └── cron/
│       │       └── auto-offline-handler.ts
│       ├── order/
│       │   ├── order-ws.ts           ← WebSocket handler (1100 lines)
│       │   └── order-repository.ts
│       ├── broadcast/
│       │   ├── broadcast-handler.ts
│       │   ├── broadcast-repository.ts
│       │   └── broadcast-spec.ts
│       └── ws.ts                     ← WebSocket router setup
└── drizzle/
    ├── migrations/
    └── tables/

packages/schema/
├── src/
│   ├── merchant.ts      ← Schema definitions
│   ├── constants.ts     ← MERCHANT_CATEGORIES (not MERCHANT_STATUSES)
│   ├── ws.ts            ← OrderEnvelope (can be extended)
│   └── index.ts

apps/web/
├── src/
│   ├── providers/
│   │   ├── merchant.tsx ← Context + useQuery (no WebSocket)
│   │   └── driver.tsx   ← Reference: has real-time features
│   └── routes/dash/
│       ├── merchant/
│       │   ├── index.tsx      (Dashboard - no availability toggle)
│       │   ├── orders.tsx     (Orders - no toggle)
│       │   └── profile.tsx    (Settings - no hours/status)
│       └── driver/
│           ├── profile.tsx    ← Reference: online toggle

apps/mobile/lib/
├── features/
│   ├── merchant/
│   │   ├── presentation/
│   │   │   ├── cubits/
│   │   │   │   ├── merchant_cubit.dart        (getMine only, no status toggle)
│   │   │   │   ├── merchant_order_cubit.dart  (Order accept/reject)
│   │   │   │   └── merchant_menu_cubit.dart
│   │   │   ├── screens/
│   │   │   │   ├── merchant_home_screen.dart  (Power button not implemented)
│   │   │   │   ├── merchant_profile_screen.dart
│   │   │   │   └── merchant_edit_profile.dart
│   │   │   └── states/
│   │   │       ├── merchant_state.dart        (mine: Merchant only)
│   │   │       ├── merchant_order_state.dart
│   │   │       └── merchant_menu_state.dart
│   │   └── data/
│   │       ├── merchant_repository.dart
│   │       └── merchant_order_repository.dart
│   └── driver/
│       └── presentation/
│           └── screens/
│               └── driver_profile_screen.dart ← Reference: has availability toggle
```

---

## 8. Key Files Reference

### Server-Side Files to Modify
1. **Schema & Constants**:
   - `packages/schema/src/merchant.ts` - Add status fields
   - `packages/schema/src/constants.ts` - Add MERCHANT_STATUSES

2. **Database**:
   - `apps/server/src/core/tables/merchant.ts` - Add columns + indexes

3. **API Handlers**:
   - `apps/server/src/features/merchant/main/merchant-main-handler.ts` - Add toggle endpoint
   - Create: `apps/server/src/features/merchant/services/merchant-availability-service.ts`

4. **WebSocket**:
   - `apps/server/src/features/ws.ts` - Add `/ws/merchant/:id` route
   - Create: `apps/server/src/features/merchant/merchant-ws.ts` - Durable Object
   - `apps/server/src/features/order/order-ws.ts` - Auto-reject if merchant offline

5. **Validation**:
   - `apps/server/src/features/merchant/order/merchant-order-repository.ts` - Check availability

### Web-Side Files to Create/Modify
1. `apps/web/src/providers/merchant.tsx` - Add WebSocket hook
2. Create: `apps/web/src/routes/dash/merchant/availability.tsx`
3. Update: `apps/web/src/routes/dash/merchant/index.tsx` - Add status indicator

### Mobile-Side Files to Create/Modify
1. Create: `apps/mobile/lib/features/merchant/presentation/cubits/merchant_availability_cubit.dart`
2. Update: `apps/mobile/lib/features/merchant/presentation/screens/merchant_home_screen.dart` - Implement power button
3. Create: `apps/mobile/lib/features/merchant/presentation/screens/merchant_availability_screen.dart`

---

## 9. Summary of Findings

| Aspect | Status | Details |
|--------|--------|---------|
| **Merchant Table** | ✅ Exists | Has `isActive` but missing `isOnline`, `isTakingOrders`, operating hours |
| **Order Table** | ✅ Exists | Has merchant tracking but no availability validation |
| **API Endpoints** | ❌ Missing | No toggle endpoint for availability |
| **WebSocket** | ✅ Exists | OrderRoom for orders, but no merchant status channel |
| **Business Logic** | ❌ Missing | No service for merchant availability like DriverAvailabilityService |
| **Web UI** | ❌ Missing | No toggle component, only profile editor |
| **Mobile UI** | ❌ Partial | Power button exists but not implemented |
| **Real-Time Sync** | ❌ Missing | No broadcast to users when merchant status changes |
| **Order Validation** | ❌ Missing | No check if merchant available before accepting order |
| **Auto-Pause** | ❌ Missing | No operating hours or auto-close feature |

---

## 10. Recommended Implementation Order

1. **Phase 1 - Database & Schema** (Low complexity)
   - Add merchant status fields to table
   - Add MERCHANT_STATUSES to constants
   - Update Zod schemas
   - Run migration

2. **Phase 2 - Business Logic** (Medium complexity)
   - Create `MerchantAvailabilityService` (based on DriverAvailabilityService)
   - Add validation in order repository
   - Create handlers for toggle endpoints

3. **Phase 3 - WebSocket** (High complexity)
   - Create merchant status Durable Object
   - Add `/ws/merchant/:id` route
   - Implement broadcast on status change
   - Auto-reject orders if merchant goes offline

4. **Phase 4 - Web UI** (Medium complexity)
   - Add toggle component to dashboard
   - Create availability settings page
   - Add WebSocket integration

5. **Phase 5 - Mobile UI** (Medium complexity)
   - Implement power button action
   - Create availability screen
   - Add WebSocket listening

---

## 11. Technical Debt & Considerations

- **Transactions**: All status changes must be transactional
- **Caching**: Invalidate merchant cache on availability change
- **Logging**: Audit trail for status changes
- **Permissions**: Only merchant owner or admins can toggle
- **Notifications**: Notify users when merchants go offline
- **Orders**: Handle in-flight orders if merchant goes offline
- **Timezone**: Operating hours need timezone awareness
- **API Backward Compatibility**: Don't break existing merchant API

