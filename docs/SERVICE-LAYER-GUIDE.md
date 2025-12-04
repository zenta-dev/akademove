# Service Layer Quick Reference Guide

## 🎯 Purpose

This guide helps developers understand and work with the service layer introduced in the SOLID refactoring.

---

## 📦 What is a Service?

A **service** is a class that encapsulates **business logic** separate from data access operations.

### Repository vs Service

| Concern | Repository | Service |
|---------|-----------|---------|
| **Database queries** | ✅ Yes | ❌ No |
| **Business logic** | ❌ No | ✅ Yes |
| **Validation** | ❌ No | ✅ Yes |
| **Calculations** | ❌ No | ✅ Yes |
| **State transitions** | ❌ No | ✅ Yes |
| **Cache management** | ✅ Yes | ❌ No |

### Example

```typescript
// ❌ WRONG: Business logic in repository
class OrderRepository {
  async placeOrder(input: PlaceOrder) {
    // Validation logic here
    if (!input.pickup) throw new Error(...);
    
    // Pricing calculation here
    const price = distance * 5000;
    
    // Database operation
    return await this.db.insert(tables.order).values({...});
  }
}

// ✅ CORRECT: Business logic in service
class OrderRepository {
  constructor(
    private validationService: OrderValidationService,
    private pricingService: OrderPricingService,
  ) {}
  
  async placeOrder(input: PlaceOrder) {
    // Delegate to services
    this.validationService.validate(input);
    const pricing = await this.pricingService.calculate({...});
    
    // Only database operation
    return await this.db.insert(tables.order).values({...});
  }
}
```

---

## 🗂️ Service Organization

### Directory Structure
```
apps/server/src/features/
├── order/
│   ├── services/
│   │   ├── index.ts                          # Export all services
│   │   ├── order-pricing-service.ts          # Pricing calculations
│   │   ├── order-matching-service.ts         # Driver matching
│   │   ├── order-validation-service.ts       # Input validation
│   │   └── ...
│   ├── order-repository.ts                   # Data access only
│   └── order-handler.ts                      # HTTP handlers
└── ...
```

### Naming Conventions
- **File**: `{domain}-{responsibility}-service.ts`
- **Class**: `{Domain}{Responsibility}Service`
- **Examples**: 
  - `order-pricing-service.ts` → `OrderPricingService`
  - `user-ban-service.ts` → `UserBanService`
  - `driver-availability-service.ts` → `DriverAvailabilityService`

---

## 📋 Service Patterns

### Pattern 1: Validation Service
**Purpose**: Validate input and business rules

```typescript
/**
 * Service for order validation
 */
export class OrderValidationService {
  /**
   * Validate order placement input
   */
  static validate(input: PlaceOrder): void {
    if (!input.pickup) {
      throw new RepositoryError(m.error_pickup_required(), {
        code: "BAD_REQUEST",
      });
    }
    
    if (!input.destination) {
      throw new RepositoryError(m.error_destination_required(), {
        code: "BAD_REQUEST",
      });
    }
  }
}
```

**Usage**:
```typescript
// In repository
OrderValidationService.validate(input);
```

### Pattern 2: Calculation Service
**Purpose**: Perform complex calculations

```typescript
/**
 * Service for pricing calculations
 */
export class OrderPricingService {
  /**
   * Calculate order price based on distance and service type
   */
  static calculate(params: {
    distance: number;
    serviceType: OrderType;
    config: PricingConfiguration;
  }): PricingResult {
    const basePrice = params.distance * params.config.pricePerKm;
    const serviceFee = params.config.serviceFee;
    const totalPrice = basePrice + serviceFee;
    
    return {
      basePrice,
      totalPrice,
      breakdown: { distance: basePrice, serviceFee },
    };
  }
}
```

**Usage**:
```typescript
// In repository
const pricing = OrderPricingService.calculate({
  distance: 5.5,
  serviceType: 'RIDE',
  config: pricingConfig,
});
```

### Pattern 3: State Machine Service
**Purpose**: Handle state transitions

```typescript
/**
 * Service for order state management
 */
export class OrderStateService {
  /**
   * Check if state transition is valid
   */
  static canTransition(from: OrderStatus, to: OrderStatus): boolean {
    const validTransitions: Record<OrderStatus, OrderStatus[]> = {
      REQUESTED: ['MATCHING', 'CANCELLED_BY_USER'],
      MATCHING: ['ACCEPTED', 'CANCELLED_BY_SYSTEM'],
      ACCEPTED: ['ARRIVING', 'CANCELLED_BY_DRIVER'],
      // ...
    };
    
    return validTransitions[from]?.includes(to) ?? false;
  }
}
```

**Usage**:
```typescript
// In repository
if (!OrderStateService.canTransition(order.status, newStatus)) {
  throw new Error("Invalid status transition");
}
```

### Pattern 4: List Query Builder
**Purpose**: Build pagination, filtering, and sorting queries

```typescript
/**
 * Service for user list query building
 */
export class UserListQueryService {
  static generateOrderBy(sortBy?: string, order: "asc" | "desc" = "asc") {
    return (f: typeof tables.user._.columns, op: OrderByOperation) => {
      const field = sortBy ? f[sortBy] : f.id;
      return op[order](field);
    };
  }
  
  static calculateOffset(page: number, limit: number): number {
    return (page - 1) * limit;
  }
  
  static calculateTotalPages(totalCount: number, limit: number): number {
    return Math.ceil(totalCount / limit);
  }
}
```

**Usage**:
```typescript
// In repository
const orderBy = UserListQueryService.generateOrderBy(sortBy, order);
const offset = UserListQueryService.calculateOffset(page, limit);

const results = await this.db.query.user.findMany({
  orderBy,
  offset,
  limit,
});
```

### Pattern 5: Document Management
**Purpose**: Handle file uploads and validation

```typescript
/**
 * Service for driver document management
 */
export class DriverDocumentService {
  static readonly BUCKET = "driver";
  
  /**
   * Generate storage key for driver document
   */
  static generateKey(
    driverId: string,
    type: "ktm" | "sim",
    file: File | undefined,
  ): string | null {
    if (!file) return null;
    const ext = file.name.split(".").pop();
    return `${driverId}-${type}.${ext}`;
  }
  
  /**
   * Check if old document should be deleted
   */
  static shouldDelete(existingKey: string | undefined): boolean {
    return existingKey !== undefined;
  }
}
```

**Usage**:
```typescript
// In repository
const ktmKey = DriverDocumentService.generateKey(driverId, 'ktm', input.ktm);

if (ktmKey) {
  await storage.upload({
    bucket: DriverDocumentService.BUCKET,
    key: ktmKey,
    file: input.ktm,
  });
}
```

---

## 🔨 How to Use Services

### 1. Import the service
```typescript
import { OrderPricingService, OrderValidationService } from "./services";
```

### 2. Call service methods
Services use **static methods** for stateless operations:

```typescript
// Validation
OrderValidationService.validate(input);

// Calculation
const pricing = OrderPricingService.calculate(params);

// State check
const canTransition = OrderStateService.canTransition(from, to);
```

### 3. Pass dependencies if needed
Some services may need database access or other dependencies:

```typescript
// Service that needs DB access
const result = await UserSearchService.search(this.db, query);
```

---

## ✅ When to Create a New Service

### ✅ Create a service when:
1. **Logic is reused** in multiple places (DRY principle)
2. **Method is complex** (>50 lines or complex logic)
3. **Logic can be tested independently** without DB
4. **Clear business responsibility** exists (pricing, validation, etc.)

### Examples:
```typescript
// ✅ GOOD: Reusable pricing logic
class OrderPricingService {
  static calculate(params) { /* ... */ }
}

// ✅ GOOD: Complex validation logic
class CouponValidationService {
  static validateEligibility(coupon, user) { /* ... */ }
}

// ✅ GOOD: State machine logic
class OrderStateService {
  static canTransition(from, to) { /* ... */ }
}
```

### ❌ Don't create a service for:
1. **Simple CRUD operations** (keep in repository)
2. **One-line utilities** (use shared utils)
3. **DB-specific operations** (keep in repository)

### Examples:
```typescript
// ❌ BAD: Too simple for a service
class UserIdService {
  static generate() {
    return v7(); // Just use v7() directly
  }
}

// ❌ BAD: DB operation should be in repository
class UserQueryService {
  static async findById(db, id) {
    return db.query.user.findFirst({ where: eq(tables.user.id, id) });
  }
}
```

---

## 📝 Service Template

```typescript
/**
 * Service for {responsibility}
 * 
 * @responsibility {Clear description of what this service handles}
 * 
 * SOLID Principles Applied:
 * - Single Responsibility: {How it follows SRP}
 * - Open/Closed: {How it's extensible}
 * - Dependency Inversion: {Dependencies it accepts}
 */
export class MyDomainService {
  /**
   * {Method description}
   * 
   * @param params - {Description of parameters}
   * @returns {Description of return value}
   * 
   * @example
   * ```typescript
   * const result = MyDomainService.methodName({ ... });
   * ```
   */
  static methodName(params: Params): Result {
    try {
      // Business logic here
      
      return result;
    } catch (error) {
      log.error({ error, params }, "[MyDomainService] Method failed");
      throw error;
    }
  }
}
```

---

## 🧪 Testing Services

### Unit Test Example
```typescript
// order-pricing-service.test.ts
import { OrderPricingService } from "./order-pricing-service";

describe("OrderPricingService", () => {
  describe("calculate", () => {
    it("should calculate correct price for 5km RIDE", () => {
      const result = OrderPricingService.calculate({
        distance: 5,
        serviceType: "RIDE",
        config: {
          pricePerKm: 2000,
          serviceFee: 2000,
        },
      });
      
      expect(result.basePrice).toBe(10000); // 5 * 2000
      expect(result.totalPrice).toBe(12000); // 10000 + 2000
    });
    
    it("should apply surge pricing", () => {
      const result = OrderPricingService.calculate({
        distance: 5,
        serviceType: "RIDE",
        config: {
          pricePerKm: 2000,
          serviceFee: 2000,
          surgeMultiplier: 1.5,
        },
      });
      
      expect(result.totalPrice).toBe(18000); // (10000 + 2000) * 1.5
    });
  });
});
```

### Integration Test Example
```typescript
// order-repository.test.ts
import { OrderRepository } from "./order-repository";
import { OrderPricingService } from "./services";

describe("OrderRepository", () => {
  // Mock the service
  const mockPricingService = {
    calculate: jest.fn(),
  };
  
  const repository = new OrderRepository(
    db,
    kv,
    mockPricingService,
  );
  
  it("should place order with calculated price", async () => {
    mockPricingService.calculate.mockReturnValue({
      basePrice: 10000,
      totalPrice: 12000,
    });
    
    const order = await repository.placeOrder({
      pickup: { lat: 0, lng: 0 },
      destination: { lat: 0.1, lng: 0.1 },
      type: "RIDE",
    });
    
    expect(mockPricingService.calculate).toHaveBeenCalled();
    expect(order.totalPrice).toBe(12000);
  });
});
```

---

## 🎯 Best Practices

### 1. Keep Services Focused
Each service should have **one clear responsibility**.

```typescript
// ✅ GOOD: Focused service
class OrderPricingService {
  static calculate(params) { /* Only pricing logic */ }
}

// ❌ BAD: Multiple responsibilities
class OrderService {
  static calculate(params) { /* Pricing */ }
  static validate(input) { /* Validation */ }
  static matchDriver(orderId) { /* Matching */ }
}
```

### 2. Use Static Methods
For stateless logic, use **static methods**:

```typescript
// ✅ GOOD: Static methods for stateless logic
class ValidationService {
  static validate(input: Input): void {
    // Stateless validation
  }
}

// ❌ AVOID: Instance methods for simple logic
class ValidationService {
  validate(input: Input): void {
    // No need for instance if no state
  }
}
```

### 3. Document Thoroughly
Add **JSDoc comments** to all public methods:

```typescript
/**
 * Calculate order price based on distance and service type
 * 
 * @param params - Pricing parameters
 * @param params.distance - Distance in kilometers
 * @param params.serviceType - Type of service (RIDE, DELIVERY, FOOD)
 * @param params.config - Pricing configuration
 * @returns Pricing breakdown with base price and total price
 * 
 * @example
 * ```typescript
 * const pricing = OrderPricingService.calculate({
 *   distance: 5.5,
 *   serviceType: 'RIDE',
 *   config: pricingConfig,
 * });
 * ```
 */
static calculate(params: PricingParams): PricingResult {
  // ...
}
```

### 4. Handle Errors Properly
Use **try-catch** and **structured logging**:

```typescript
static calculate(params: Params): Result {
  try {
    // Logic here
    return result;
  } catch (error) {
    log.error({ error, params }, "[ServiceName] Calculation failed");
    throw error;
  }
}
```

### 5. Type Safety
- **Never use `any`** - use `unknown` instead
- **Avoid null assertions** - check explicitly
- **Use proper types** for parameters and return values

```typescript
// ✅ GOOD: Proper types
static calculate(params: PricingParams): PricingResult {
  // ...
}

// ❌ BAD: Any types
static calculate(params: any): any {
  // ...
}
```

---

## 🔍 Finding Services

### All Services by Domain

```bash
# List all services
find apps/server/src/features -name "*-service.ts"

# List services in specific domain
find apps/server/src/features/order/services -name "*-service.ts"
```

### Service Index Files
Each domain has an `index.ts` that exports all services:

```typescript
// apps/server/src/features/order/services/index.ts
export { OrderPricingService } from "./order-pricing-service";
export { OrderValidationService } from "./order-validation-service";
export { OrderMatchingService } from "./order-matching-service";
// ...
```

### Import from Index
```typescript
// Import multiple services at once
import {
  OrderPricingService,
  OrderValidationService,
  OrderMatchingService,
} from "@/features/order/services";
```

---

## 📚 Further Reading

- **Main Documentation**: `docs/SOLID-REFACTORING-SUMMARY.md`
- **Agent Guide**: `.ruler/AGENTS.md`
- **SRS Document**: `docs/srs-new.md`

---

## ❓ FAQ

### Q: When should I use a service vs a repository?
**A**: Use services for **business logic** (validation, calculations, state transitions). Use repositories for **data access** (queries, inserts, updates).

### Q: Can services call other services?
**A**: Yes! Services can compose other services. Example: `OrderMatchingService` uses `DriverPriorityService`.

### Q: Should services have state?
**A**: Generally no. Services should be **stateless** and use static methods. If you need state, consider dependency injection.

### Q: Can services access the database?
**A**: Some services may need DB access for queries (like `UserSearchService`). But they should **not** perform writes - that's the repository's job.

### Q: How do I test services?
**A**: Services are easy to unit test because they don't depend on database setup. Just pass in mock parameters and assert the output.

---

**Last Updated**: December 5, 2025  
**Questions?** Refer to main documentation or ask the team.
