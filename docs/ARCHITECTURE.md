# AkadeMove Server Architecture

## 🏗️ Layer Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         HTTP/WebSocket Layer                     │
│                           (Handlers)                             │
├─────────────────────────────────────────────────────────────────┤
│  order-handler.ts    user-handler.ts    driver-handler.ts       │
│  merchant-handler.ts payment-handler.ts  wallet-handler.ts      │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Repository Layer                            │
│                    (Data Access Only)                            │
├─────────────────────────────────────────────────────────────────┤
│  • Database queries (SELECT, INSERT, UPDATE, DELETE)             │
│  • Cache management (KV operations)                              │
│  • Transaction coordination                                      │
│  • Entity composition                                            │
├─────────────────────────────────────────────────────────────────┤
│  OrderRepository     UserRepository      DriverRepository        │
│  MerchantRepository  PaymentRepository   WalletRepository        │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         │ Delegates to
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                       Service Layer                              │
│                    (Business Logic)                              │
├─────────────────────────────────────────────────────────────────┤
│  • Input validation                                              │
│  • Business rule enforcement                                     │
│  • Complex calculations                                          │
│  • State machine logic                                           │
│  • Algorithm implementation                                      │
├─────────────────────────────────────────────────────────────────┤
│  OrderPricingService    UserBanService    DriverMatchingService │
│  OrderValidationService PaymentChargeService WalletBalanceService│
│  (62 services total across all domains)                         │
└────────────────────────┬────────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────────┐
│                    Infrastructure Layer                          │
├─────────────────────────────────────────────────────────────────┤
│  Database (PostgreSQL + PostGIS) │ Cache (KV)  │ Storage (S3)   │
│  Maps API (Google Maps)           │ FCM         │ Midtrans       │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🔄 Request Flow Example: Place Order

```
1. HTTP Request
   POST /api/order/place
   │
   ▼
2. Handler (order-handler.ts)
   ├─ Extract input from request body
   ├─ Check permissions (hasPermission middleware)
   └─ Call repository
   │
   ▼
3. Repository (order-repository.ts)
   ├─ Start transaction
   │
   ├─ Delegate to OrderValidationService
   │  └─ Validate pickup/destination/user eligibility
   │
   ├─ Delegate to OrderPricingService
   │  └─ Calculate distance → base price → total price
   │
   ├─ Delegate to OrderCouponService (if coupon)
   │  └─ Validate coupon → apply discount
   │
   ├─ Delegate to OrderItemPreparationService (if food)
   │  └─ Prepare order items with menu validation
   │
   ├─ Insert order into database (tx)
   │
   ├─ Delegate to PaymentChargeService
   │  └─ Charge wallet or create payment
   │
   ├─ Delegate to OrderMatchingService
   │  └─ Find available drivers → broadcast to drivers
   │
   ├─ Commit transaction
   │
   └─ Return composed order entity
   │
   ▼
4. Handler returns HTTP response
   { status: 200, body: { message: "...", data: order } }
```

---

## 📦 Service Composition Patterns

### Pattern 1: Sequential Delegation

Repository calls services in sequence for step-by-step processing.

```typescript
async placeOrder(input: PlaceOrder) {
  // Step 1: Validate
  OrderValidationService.validate(input);
  
  // Step 2: Calculate price
  const pricing = await OrderPricingService.calculate({...});
  
  // Step 3: Apply coupon
  if (input.coupon) {
    const discount = await OrderCouponService.apply({...});
  }
  
  // Step 4: Database operation
  const order = await this.db.insert(tables.order).values({...});
  
  return order;
}
```

### Pattern 2: Service Composition

Services call other services for complex workflows.

```typescript
// OrderMatchingService uses DriverPriorityService
class OrderMatchingService {
  static async findDrivers(params) {
    const drivers = await db.query.driver.findMany({...});
    
    // Use DriverPriorityService to rank drivers
    const ranked = DriverPriorityService.rankDrivers(drivers);
    
    return ranked;
  }
}
```

### Pattern 3: Parallel Execution

Repository executes independent service calls in parallel.

```typescript
async getDashboardStats() {
  const [basicStats, revenue, orders] = await Promise.all([
    DashboardStatsService.getBasicStats(this.db),
    DashboardStatsService.getRevenueByDay(this.db, startDate, endDate),
    DashboardStatsService.getOrdersByDay(this.db, startDate, endDate),
  ]);
  
  return DashboardStatsService.compose({
    basicStats,
    revenue,
    orders,
  });
}
```

---

## 🗂️ Directory Structure

```
apps/server/src/
├── core/                          # Core infrastructure
│   ├── base.ts                    # Base classes
│   ├── constants.ts               # Configuration constants
│   ├── error.ts                   # Error classes
│   ├── factory.ts                 # Dependency injection
│   ├── interface.ts               # Shared interfaces
│   ├── services/                  # Core services
│   │   ├── db.ts                  # Database service
│   │   ├── kv.ts                  # Key-value cache
│   │   ├── storage.ts             # S3 storage
│   │   ├── map.ts                 # Google Maps
│   │   └── ...
│   └── tables/                    # Drizzle schemas
│       ├── order.ts
│       ├── user.ts
│       └── ...
│
├── features/                      # Feature modules
│   ├── order/
│   │   ├── services/              # 📦 Business logic
│   │   │   ├── index.ts           # Export all services
│   │   │   ├── order-pricing-service.ts
│   │   │   ├── order-matching-service.ts
│   │   │   ├── order-validation-service.ts
│   │   │   ├── order-cancellation-service.ts
│   │   │   ├── order-refund-service.ts
│   │   │   └── ...
│   │   ├── order-repository.ts    # 🗄️ Data access
│   │   ├── order-handler.ts       # 🌐 HTTP handlers
│   │   ├── order-spec.ts          # 📋 oRPC spec
│   │   └── order-ws.ts            # 🔌 WebSocket
│   │
│   ├── user/
│   │   ├── services/
│   │   │   ├── user-ban-service.ts
│   │   │   ├── user-profile-service.ts
│   │   │   ├── dashboard-stats-service.ts
│   │   │   └── ...
│   │   ├── admin/
│   │   │   └── user-admin-repository.ts
│   │   └── me/
│   │       └── user-me-repository.ts
│   │
│   ├── driver/
│   │   ├── services/
│   │   │   ├── driver-availability-service.ts
│   │   │   ├── driver-location-service.ts
│   │   │   ├── driver-priority-service.ts
│   │   │   └── ...
│   │   ├── main/
│   │   │   ├── driver-main-repository.ts
│   │   │   └── driver-main-handler.ts
│   │   └── schedule/
│   │       └── driver-schedule-repository.ts
│   │
│   └── [other features...]
│
└── index.ts                       # Entry point
```

---

## 🔄 Data Flow Patterns

### 1. Create/Insert Pattern

```
Handler
  └─> Repository.create()
      ├─> ValidationService.validate()
      ├─> db.insert(table).values({...})
      ├─> cache.set(id, entity)
      └─> return entity
```

### 2. Update Pattern

```
Handler
  └─> Repository.update()
      ├─> Repository.get() [fetch existing]
      ├─> ValidationService.validate()
      ├─> db.transaction(async (tx) => {
      │   ├─> tx.update(table).set({...})
      │   ├─> BusinessService.process(tx, ...)
      │   └─> return updated
      │   })
      ├─> cache.delete(id)
      └─> return entity
```

### 3. List/Query Pattern

```
Handler
  └─> Repository.list()
      ├─> ListQueryService.buildWhere()
      ├─> ListQueryService.generateOrderBy()
      ├─> ListQueryService.calculateOffset()
      ├─> db.query.table.findMany({...})
      ├─> ListQueryService.calculateTotalPages()
      └─> return { rows, totalPages }
```

### 4. Complex Workflow Pattern

```
Handler
  └─> Repository.complexOperation()
      └─> db.transaction(async (tx) => {
          ├─> ValidationService.validate()
          ├─> CalculationService.calculate()
          ├─> tx.insert(table1).values({...})
          ├─> tx.update(table2).set({...})
          ├─> NotificationService.send()
          └─> return result
          })
```

---

## 🎯 Dependency Flow

```
┌─────────────────────────────────────────────────┐
│              Handler Layer                       │
│  (No business logic, just orchestration)         │
└─────────────────┬───────────────────────────────┘
                  │ depends on
                  ▼
┌─────────────────────────────────────────────────┐
│           Repository Layer                       │
│  (Data access + service coordination)            │
└───────┬─────────────────────┬───────────────────┘
        │ depends on          │ depends on
        ▼                     ▼
┌─────────────────┐    ┌─────────────────────────┐
│  Service Layer  │    │  Infrastructure Layer    │
│ (Business logic)│    │  (Database, Cache, etc)  │
└─────────────────┘    └─────────────────────────┘

✅ Allowed dependencies:
   Handler → Repository
   Repository → Service
   Repository → Infrastructure
   Service → Service (composition)

❌ Forbidden dependencies:
   Service → Repository (violation of DIP)
   Service → Handler (violation of layering)
   Handler → Service (should go through Repository)
```

---

## 🔐 Permission Flow

```
HTTP Request
  │
  ▼
hasPermission Middleware
  ├─ Extract user from context
  ├─ Check RBAC rules (resource + action)
  └─ Allow/Deny
  │
  ▼
Handler
  └─> Repository
      └─> Service (no permission checks here)
```

**Key**: Services don't check permissions. That's the handler/middleware's job.

---

## 💾 Transaction Pattern

```typescript
// ALWAYS wrap multi-step mutations in transactions

// ✅ CORRECT: Transaction in handler or repository
await db.transaction(async (tx) => {
  // Step 1: Insert order
  const order = await tx.insert(tables.order).values({...});
  
  // Step 2: Charge wallet (pass tx)
  await walletRepo.charge({ orderId: order.id }, { tx });
  
  // Step 3: Create notification (pass tx)
  await notificationRepo.create({ ... }, { tx });
  
  // All or nothing - automatic rollback on error
});

// ❌ WRONG: No transaction for related operations
const order = await db.insert(tables.order).values({...});
await walletRepo.charge({ orderId: order.id }); // Separate transaction!
await notificationRepo.create({ ... }); // Another separate transaction!
```

---

## 🧪 Testing Architecture

### Unit Testing Services

```typescript
// Services are pure business logic - easy to test
describe('OrderPricingService', () => {
  it('should calculate price correctly', () => {
    const result = OrderPricingService.calculate({
      distance: 5,
      serviceType: 'RIDE',
      config: mockConfig,
    });
    
    expect(result.totalPrice).toBe(12000);
  });
});
```

### Integration Testing Repositories

```typescript
// Mock services, test DB operations
describe('OrderRepository', () => {
  const mockPricingService = { calculate: jest.fn() };
  const repo = new OrderRepository(db, kv, mockPricingService);
  
  it('should place order', async () => {
    mockPricingService.calculate.mockReturnValue({ totalPrice: 15000 });
    
    const order = await repo.placeOrder({...});
    
    expect(order.totalPrice).toBe(15000);
    expect(mockPricingService.calculate).toHaveBeenCalled();
  });
});
```

### E2E Testing Handlers

```typescript
// Test full flow from HTTP to DB
describe('POST /api/order/place', () => {
  it('should place order successfully', async () => {
    const response = await request(app)
      .post('/api/order/place')
      .send({ pickup: {...}, destination: {...} })
      .expect(200);
    
    expect(response.body.data.status).toBe('REQUESTED');
  });
});
```

---

## 📊 Performance Considerations

### 1. Caching Strategy

```
┌──────────────────────────────────────────────┐
│         Read Operation Flow                  │
├──────────────────────────────────────────────┤
│  1. Check cache (KV)                         │
│     └─ HIT: Return cached entity             │
│     └─ MISS: Continue to DB                  │
│  2. Query database                           │
│  3. Compose entity (with relations)          │
│  4. Store in cache (with TTL)                │
│  5. Return entity                            │
└──────────────────────────────────────────────┘
```

### 2. Query Optimization

- Use database indexes for filtered/sorted columns
- Use composite indexes for multi-column filters
- Use spatial indexes for PostGIS queries (driver matching)
- Batch queries with `Promise.all()` when independent

### 3. Service Optimization

- Static methods for stateless services (no instantiation overhead)
- In-memory caching for hot-path configs (pricing configs)
- Parallel execution of independent service calls

---

## 🚀 Deployment Architecture

```
┌─────────────────────────────────────────────────────────┐
│                   Cloudflare Workers                     │
│  ┌───────────────────────────────────────────────────┐  │
│  │  HTTP Server (Hono + oRPC)                        │  │
│  │    ├─ REST API endpoints                          │  │
│  │    └─ oRPC endpoints                              │  │
│  └───────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────┐  │
│  │  WebSocket Server (Durable Objects)               │  │
│  │    ├─ Order room (real-time order updates)       │  │
│  │    └─ Chat room (order-related messaging)        │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
           │                     │                │
           ▼                     ▼                ▼
    ┌───────────┐        ┌───────────┐    ┌───────────┐
    │ PostgreSQL│        │ Cloudflare│    │ R2/S3     │
    │ + PostGIS │        │ KV (Cache)│    │ (Storage) │
    └───────────┘        └───────────┘    └───────────┘
```

---

## 🔄 Migration Path (Future)

### Current: Monolith
```
Single server codebase with all features
```

### Future Option 1: Modular Monolith
```
Same deployment, but clear module boundaries
(Already achieved with service layer!)
```

### Future Option 2: Microservices
```
Separate deployments per domain:
  - Order Service
  - Payment Service
  - Driver Service
  - User Service
  
(Service layer makes this migration easier)
```

---

## 📚 References

- **SOLID Refactoring Summary**: `docs/SOLID-REFACTORING-SUMMARY.md`
- **Service Layer Guide**: `docs/SERVICE-LAYER-GUIDE.md`
- **Agent Development Guide**: `.ruler/AGENTS.md`
- **SRS Document**: `docs/srs-new.md`
- **API Documentation**: `docs/API.md`

---

**Last Updated**: December 5, 2025  
**Architecture Version**: 2.0 (Post-SOLID Refactoring)
