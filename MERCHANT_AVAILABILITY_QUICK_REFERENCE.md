# Quick Reference: Merchant Availability Management

## Current State Snapshot

### What Exists ✅
- `merchant` table with `isActive` (boolean) for admin-only activation
- `merchant_menus` table for item catalog
- `order` table with `merchantId` FK and `CANCELLED_BY_MERCHANT` status
- Merchant order handlers: accept, reject, markPreparing, markReady
- WebSocket infrastructure (OrderRoom Durable Object) for real-time order updates
- Driver availability pattern as reference (driver-availability-service.ts)
- Web provider (merchant.tsx) with TanStack Query
- Mobile BLoC pattern for merchant features

### What's Missing ❌
**Database Fields:**
- `isOnline` (boolean)
- `isTakingOrders` (boolean)
- `operatingStatus` (enum: OPEN, CLOSED, BREAK, MAINTENANCE)
- `businessHoursStart`, `businessHoursEnd` (time)
- `timezone` (string)
- `lastStatusChange`, `statusReason` (timestamps)

**API Endpoints:**
- POST `/merchants/:id/status/online` - Toggle online
- POST `/merchants/:id/status/pause-orders` - Pause new orders
- PATCH `/merchants/:id/operating-hours` - Set hours
- GET `/merchants/:id/availability` - Get status

**WebSocket:**
- No `/ws/merchant/:id` route for status broadcasts
- No merchant status message types (MERCHANT_ONLINE, etc.)

**Business Logic:**
- No `MerchantAvailabilityService` (should copy DriverAvailabilityService pattern)
- No validation that merchant is online before accepting order
- No auto-reject for offline merchants

**UI Components:**
- Web: No availability toggle, no operating hours page
- Mobile: Power button not implemented

---

## Key File Locations

### Schema & Database
```
packages/schema/src/merchant.ts              ← Zod schemas
packages/schema/src/constants.ts             ← Add MERCHANT_STATUSES
apps/server/src/core/tables/merchant.ts      ← Table definition
```

### Handlers & Repositories
```
apps/server/src/features/merchant/main/merchant-main-handler.ts      ← API handlers
apps/server/src/features/merchant/main/merchant-main-repository.ts    ← DB layer
apps/server/src/features/merchant/order/merchant-order-repository.ts  ← Order validation
```

### Services
```
apps/server/src/features/merchant/services/                           ← Create availability service
apps/server/src/features/driver/services/driver-availability-service.ts ← Reference
```

### WebSocket
```
apps/server/src/features/ws.ts                  ← Add /ws/merchant/:id route
apps/server/src/features/order/order-ws.ts      ← Add auto-reject logic
apps/server/src/features/merchant/merchant-ws.ts ← Create Durable Object
```

### Web UI
```
apps/web/src/providers/merchant.tsx             ← Add WebSocket hook
apps/web/src/routes/dash/merchant/index.tsx     ← Add status indicator
apps/web/src/routes/dash/merchant/availability.tsx ← Create new page
```

### Mobile UI
```
apps/mobile/lib/features/merchant/presentation/cubits/merchant_cubit.dart
apps/mobile/lib/features/merchant/presentation/screens/merchant_home_screen.dart
```

---

## Critical Patterns to Follow

### Database Changes (Drizzle)
```typescript
// Add indexes like driver table
index("merchant_is_online_idx").on(t.isOnline),
index("merchant_status_online_idx").on(t.status, t.isOnline),
```

### Service Pattern (TypeScript)
```typescript
// Based on DriverAvailabilityService pattern
class MerchantAvailabilityService {
  async setOnlineStatus(merchantId, isOnline, deps, opts?) { ... }
  isAvailableForOrders(merchant): boolean { ... }
}
```

### WebSocket Message (Enum)
```typescript
// Extend message types in order-ws.ts
if (data.a === "MERCHANT_STATUS_CHANGE")
  -> handleMerchantStatusChange(ws, data, tx)
```

### Broadcast Pattern (Durable Object)
```typescript
// Similar to OrderRoom.broadcast()
this.broadcast(merchantStatusPayload, { excludes: [ws] });
```

### Web Hook Pattern (React)
```typescript
// Use existing useOrderUpdates as template
const useOrderUpdates = ({ enabled, interval }) => {
  useEffect(() => {
    const ws = new WebSocket(`/ws/order/${orderId}`);
    ws.onmessage = (e) => { ... }
  }, []);
}
```

### Mobile BLoC Pattern (Dart)
```dart
// Based on existing merchant_cubit.dart
class MerchantAvailabilityCubit extends BaseCubit<MerchantAvailabilityState> {
  Future<void> toggleOnline(bool isOnline) async { ... }
}
```

---

## Implementation Checklist

### Phase 1: Schema (2-4 hours)
- [ ] Add fields to merchant.ts table
- [ ] Add MERCHANT_STATUSES to constants.ts
- [ ] Update MerchantSchema in packages/schema/src/merchant.ts
- [ ] Create and apply migration
- [ ] Test with db:push

### Phase 2: Business Logic (4-6 hours)
- [ ] Create merchant-availability-service.ts
- [ ] Add availability check in merchant-order-repository.ts
- [ ] Add handlers to merchant-main-handler.ts
- [ ] Add repository methods to merchant-main-repository.ts
- [ ] Write unit tests

### Phase 3: WebSocket (6-8 hours)
- [ ] Create merchant-ws.ts Durable Object
- [ ] Add /ws/merchant/:id route in ws.ts
- [ ] Add message handlers in order-ws.ts
- [ ] Test with WebSocket client

### Phase 4: Web UI (4-6 hours)
- [ ] Add WebSocket hook to merchant provider
- [ ] Create availability toggle component
- [ ] Add operating hours form
- [ ] Update dashboard index.tsx
- [ ] Test in browser

### Phase 5: Mobile UI (4-6 hours)
- [ ] Create merchant_availability_cubit.dart
- [ ] Implement power button handler
- [ ] Create availability screen
- [ ] Add WebSocket listening
- [ ] Test on device

**Total Estimate: 20-30 hours (~1 week)**

---

## Testing Strategy

### Unit Tests
- MerchantAvailabilityService methods
- Order validation with merchant availability

### Integration Tests
- Merchant toggle → DB update
- Merchant toggle → WebSocket broadcast
- Order rejection when merchant offline

### E2E Tests
- Web: Toggle online → See status change
- Mobile: Toggle power button → See status update
- Both: User sees only open merchants

---

## Risk Mitigation

**Risk**: Breaking existing merchant activation flow
- Mitigation: Keep `isActive` for account status, add new `isOnline` for availability

**Risk**: Orders in-flight when merchant goes offline
- Mitigation: Auto-reject with refund using existing refund service

**Risk**: Timezone issues with business hours
- Mitigation: Store timezone with merchant, validate on client + server

**Risk**: Database migration issues
- Mitigation: Make new fields nullable initially, backfill in subsequent migration

---

## References in Codebase

### Similar Features to Learn From
1. **Driver Availability**: `driver-availability-service.ts` (287 lines)
2. **Order WebSocket**: `order-ws.ts` (1123 lines)
3. **Payment WebSocket**: `payment-ws.ts`
4. **Order Rejection**: `merchant-order-repository.ts` - rejectOrder method
5. **Web Provider**: `merchant.tsx` & `driver.tsx` (comparison)

### Schema Patterns
- Enums: `merchant.ts` has merchantCategory, `driver.ts` has driverStatus
- Geometry: `merchant.ts` has location (PostGIS point)
- Relations: Drizzle relations established (merchant ← user, menu ← merchant)

---

## Deployment Considerations

1. **Database**: Migration must be safe (backward compatible)
2. **API**: No breaking changes to existing merchant endpoints
3. **WebSocket**: Can be added without affecting existing order channel
4. **Feature Flags**: Consider gradual rollout if needed
5. **Documentation**: Update API docs after changes
