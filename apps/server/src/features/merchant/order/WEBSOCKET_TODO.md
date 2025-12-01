# WebSocket Integration TODO for Merchant Orders

## Current State
Merchant order management endpoints (accept, reject, preparing, ready) are implemented as REST APIs only.

## Why Deferred
- OrderRoom WebSocket already exists and broadcasts order status changes to users/drivers
- Users will see status updates when they reconnect or poll
- Merchant-specific WebSocket channel adds complexity without critical UX improvement for MVP
- REST API is sufficient for merchant actions (they're deliberate, not real-time critical)

## Future Implementation (Phase 2)

### Approach 1: Extend OrderRoom (Recommended)
Add merchant action handlers to existing `OrderRoom`:
- Merchants connect to same order WebSocket: `/ws/order/{orderId}`
- Add actions: `MERCHANT_ACCEPT`, `MERCHANT_REJECT`, `MERCHANT_MARK_PREPARING`, `MERCHANT_MARK_READY`
- Add events: `MERCHANT_ACCEPTED`, `MERCHANT_REJECTED`, `MERCHANT_PREPARING`, `MERCHANT_READY`
- Update `packages/schema/src/ws.ts` with new action/event enums
- Add handlers in `apps/server/src/features/order/order-ws.ts`

Benefits:
- All participants (user, driver, merchant) in same room
- Simplified state synchronization
- Reuses existing infrastructure

### Approach 2: Separate MerchantOrderRoom
Create dedicated Durable Object for merchant order dashboard:
- Route: `/ws/merchant/{merchantId}/orders`
- Merchant sees all their orders in real-time
- Broadcast new orders, cancellations, driver assignments

Benefits:
- Dashboard-wide notifications
- Merchant-specific features (order queue, bulk actions)

## Files to Modify (Approach 1)

1. `packages/schema/src/ws.ts`:
   - Add to `OrderEnvelopeEventSchema`: `MERCHANT_ACCEPTED`, `MERCHANT_REJECTED`, `MERCHANT_PREPARING`, `MERCHANT_READY`
   - Add to `OrderEnvelopeActionSchema`: `MERCHANT_ACCEPT`, `MERCHANT_REJECT`, `MERCHANT_MARK_PREPARING`, `MERCHANT_MARK_READY`
   - Add `merchantAction` field to `OrderEnvelopePayloadSchema`

2. `apps/server/src/features/order/order-ws.ts`:
   - Add handlers: `#handleMerchantAccept`, `#handleMerchantReject`, `#handleMerchantMarkPreparing`, `#handleMerchantMarkReady`
   - Call `this.#repo.merchant.order.*` methods in each handler
   - Broadcast events to connected clients

## Testing
- Merchant connects to `/ws/order/{orderId}` after accepting order
- Merchant sends action, verify broadcast to user
- User sees real-time status update without page refresh

