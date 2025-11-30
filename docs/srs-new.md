# Software Requirements Specification (SRS)

**Project:** AkadeMove - Campus Mobility & Delivery Platform  
**Version:** 2.0  
**Tech Stack:** TypeScript, oRPC, Drizzle ORM, PostgreSQL/PostGIS, Flutter  

---

## 1. Executive Summary

AkadeMove is a campus-specific mobility and delivery platform connecting students as users, drivers, and merchants. The system enables ride-hailing, package delivery, and food ordering with unique features like class schedule integration, gender-based driver preferences, and campus community focus.

**Core Value Propositions:**
- Student-to-student service ecosystem within campus boundaries
- Flexible driver availability tied to academic schedules
- Enhanced safety through gender preferences and reputation systems
- Commission-based revenue model for platform sustainability

---

## 2. System Architecture

### 2.1 Technology Stack
- **Backend:** TypeScript, oRPC, Drizzle ORM, Hono, PostgreSQL + PostGIS
- **Web:** Tanstack Start, React, ShadcnUI, Google Maps
- **Mobile:** Flutter, BLoC (Cubit), Google Maps Flutter
- **Infrastructure:** Cloudflare Workers/KV/DO, AWS S3, Firebase (Auth/Messaging)
- **Payments:** Midtrans (QRIS/e-wallet)

### 2.2 Architecture Pattern
- **Backend:** Minimal Clean Architecture (Handler → Repository → Service)
- **Mobile:** Feature-based Clean Architecture (Presentation → Data → Domain)
- **Web:** Functional programming with file-based routing

---

## 3. User Roles & Capabilities

### 3.1 User/Passenger
- Register/authenticate via email/phone (Firebase Auth)
- Request rides, deliveries, food orders with map interface
- Set pickup/dropoff locations, select driver gender preference
- Pay via e-wallet (QRIS/bank transfer)
- Rate drivers, report issues, view order history

### 3.2 Driver (Student)
- Register with KTM, SIM, STNK verification
- Manage class schedule (manual/calendar import)
- Auto-offline during scheduled classes
- Accept/reject orders within radius
- Track earnings (daily/weekly/monthly), view ratings
- Withdraw to bank account

### 3.3 Merchant/Tenant
- Register outlet with location and documents
- Manage menu items (name, price, stock, images)
- Accept/process food orders
- Track sales and commission reports

### 3.4 Operator (Campus Admin)
- Configure pricing (base fare, per-km rate)
- Create/manage coupons and promotions
- Monitor driver/merchant performance
- Send broadcast notifications
- Review platform analytics

### 3.5 Administrator (System Owner)
- Full system access (all operator functions)
- Manage user roles and permissions (RBAC)
- Configure platform commission rates
- Access audit logs and fraud detection
- System-wide analytics and reporting

---

## 4. Core Features

### 4.1 Authentication & Authorization
- **FR-AUTH-001:** Firebase-based registration with email/phone + OTP
- **FR-AUTH-002:** Role-based access control (user, driver, merchant, operator, admin)
- **FR-AUTH-003:** Document verification for drivers (KTM, SIM, STNK) with approval workflow
- **FR-AUTH-004:** Profile management with avatar upload to S3

### 4.2 Driver Schedule Management
- **FR-SCHED-001:** Manual schedule entry (day, start time, end time)
- **FR-SCHED-002:** Recurring weekly schedules
- **FR-SCHED-003:** One-time schedule exceptions
- **FR-SCHED-004:** Auto-offline during active class periods
- **FR-SCHED-005:** Manual online/offline toggle override

### 4.3 Order Management

#### Ride-Hailing
- **FR-RIDE-001:** Map-based pickup/dropoff selection
- **FR-RIDE-002:** Distance calculation via Google Maps API
- **FR-RIDE-003:** Dynamic pricing: `basePrice + (distanceKm × pricePerKm) + tip`
- **FR-RIDE-004:** Gender preference filter (optional)
- **FR-RIDE-005:** Auto-matching to nearest available driver within radius
- **FR-RIDE-006:** Order states: `requested → matching → accepted → arriving → in_trip → completed/cancelled`
- **FR-RIDE-007:** Real-time location tracking via WebSocket

#### Package Delivery
- **FR-DELIV-001:** Pickup/dropoff forms with notes and package size
- **FR-DELIV-002:** Photo/OTP proof of delivery
- **FR-DELIV-003:** Same pricing model as rides

#### Food Delivery
- **FR-FOOD-001:** Browse merchant menus with search/filter
- **FR-FOOD-002:** Shopping cart with item quantities
- **FR-FOOD-003:** Order workflow: `merchant accepts → prepares → driver picks up → delivers`
- **FR-FOOD-004:** Merchant can mark items out of stock

### 4.4 Payment & Wallet
- **FR-PAY-001:** In-app wallet with IDR balance
- **FR-PAY-002:** Top-up via QRIS/bank transfer (Midtrans)
- **FR-PAY-003:** Auto-deduct from wallet for orders
- **FR-PAY-004:** Commission auto-deduction: `driverEarning = totalPrice - platformCommission`
- **FR-PAY-005:** Withdrawal to driver/merchant bank accounts
- **FR-PAY-006:** Transaction history with balance tracking

### 4.5 Promotions & Coupons
- **FR-PROMO-001:** Operator creates coupons with rules:
  - Discount (fixed amount or percentage)
  - Usage limits (total and per-user)
  - Date range validity
  - Minimum order value
  - User segment targeting
- **FR-PROMO-002:** Auto-apply eligible coupons at checkout
- **FR-PROMO-003:** Event-based promotions (e.g., campus dies natalis)

### 4.6 Rating & Review
- **FR-RATE-001:** Mandatory 5-star rating after order completion
- **FR-RATE-002:** Category-based reviews (cleanliness, punctuality, safety, courtesy)
- **FR-RATE-003:** Bi-directional: passenger ↔ driver
- **FR-RATE-004:** Aggregate rating affects driver priority in matching
- **FR-RATE-005:** Review comments (optional)

### 4.7 Safety & Reporting
- **FR-SAFE-001:** In-app chat with phone number masking
- **FR-SAFE-002:** Report user for misconduct (harassment, fraud, etc.)
- **FR-SAFE-003:** Emergency button linking to campus security (optional)
- **FR-SAFE-004:** Report workflow: `pending → under_review → resolved`
- **FR-SAFE-005:** Admin can warn, suspend, or ban users

### 4.8 Leaderboard & Gamification
- **FR-LEAD-001:** Driver leaderboard by rating and order volume
- **FR-LEAD-002:** Badge system for top performers
- **FR-LEAD-003:** Priority matching for highly-rated drivers

### 4.9 Notifications
- **FR-NOTIF-001:** Push notifications via Firebase Cloud Messaging
- **FR-NOTIF-002:** Event triggers: order updates, promotions, admin broadcasts
- **FR-NOTIF-003:** In-app notification center
- **FR-NOTIF-004:** User preferences for notification types

### 4.10 Analytics & Reporting
- **FR-ANALYTICS-001:** Driver earnings dashboard (daily/weekly/monthly)
- **FR-ANALYTICS-002:** Merchant sales reports with commission breakdown
- **FR-ANALYTICS-003:** Operator dashboard: active orders, revenue, user growth
- **FR-ANALYTICS-004:** Admin audit logs for configuration changes
- **FR-ANALYTICS-005:** Export reports to CSV/Excel

---

## 5. Data Model (Key Entities)

```typescript
// Core Tables (Drizzle ORM)
users: {
  id, name, email, emailVerified, image, role, banned, 
  banReason, gender, phone, banExpires, createdAt, updatedAt
}

drivers: {
  id, userId, studentId, licensePlate, status, rating,
  isTakingOrder, isOnline, currentLocation (PostGIS point),
  bank, lastLocationUpdate, studentCard, driverLicense,
  vehicleCertificate, createdAt, updatedAt
}

driver_schedules: {
  id, driverId, name, dayOfWeek, startTime, endTime,
  isRecurring, specificDate, isActive, createdAt, updatedAt
}

merchants: {
  id, userId, name, email, phone, address, 
  location (PostGIS point), bank, categories,
  isActive, rating, document, image, createdAt, updatedAt
}

merchant_menus: {
  id, merchantId, name, category, price, stock,
  image, createdAt, updatedAt
}

orders: {
  id, userId, driverId, merchantId, type (ride/delivery/food),
  status, pickupLocation (PostGIS point), dropoffLocation (PostGIS point),
  distanceKm, basePrice, tip, totalPrice, note,
  requestedAt, acceptedAt, arrivedAt, cancelReason,
  gender, createdAt, updatedAt
}

order_items: {
  id, orderId, menuId, quantity, unitPrice
}

wallets: {
  id, userId, balance, currency, isActive, createdAt, updatedAt
}

transactions: {
  id, walletId, type, amount, balanceBefore, balanceAfter,
  status, description, referenceId, metadata, createdAt, updatedAt
}

payments: {
  id, transactionId, provider, method, amount, status,
  externalId, paymentUrl, metadata, expiresAt,
  payload, response, createdAt, updatedAt
}

coupons: {
  id, name, code, rules (JSON), discountAmount, discountPercentage,
  usageLimit, usedCount, periodStart, periodEnd, isActive,
  createdById, createdAt, updatedAt
}

reviews: {
  id, orderId, fromUserId, toUserId, category, score,
  comment, createdAt, updatedAt
}

reports: {
  id, orderId, reporterId, targetUserId, category,
  description, evidenceUrl, status, handledById,
  resolution, reportedAt, resolvedAt
}

configurations: {
  key, name, value (JSON), description, updatedById, createdAt, updatedAt
}
```

**PostGIS Usage:**
- `drivers.currentLocation`, `merchants.location`, `orders.pickupLocation`, `orders.dropoffLocation` use geometry(point, 4326)
- Spatial queries for radius-based driver matching
- Distance calculations for pricing

---

## 6. API Structure (oRPC)

### 6.1 Naming Convention
- **Spec Files:** Define routes, input/output schemas, tags
- **Handler Files:** Implement business logic with middleware
- **Repository Files:** Database operations with caching (Cloudflare KV)

### 6.2 Example Routes
```typescript
GET    /reports             → List reports (paginated)
GET    /reports/{id}        → Get report by ID
POST   /reports             → Create report
PUT    /reports/{id}        → Update report
DELETE /reports/{id}        → Delete report

// Similar patterns for:
/auth, /users, /drivers, /drivers/schedules, /merchants, /merchants/menus,
/orders, /payments, /transactions, /wallets, /coupons, /reviews,
/configurations, /notifications
```

### 6.3 Middleware
- `hasPermission()`: RBAC check before handler execution
- `clientAuth`: Validate Firebase token + role
- `headerValidator`: Rate limiting, CORS

---

## 7. Non-Functional Requirements

### 7.1 Performance
- **NFR-PERF-001:** Driver search response < 2s on 4G
- **NFR-PERF-002:** Order matching < 5s
- **NFR-PERF-003:** Real-time location updates every 5s via WebSocket
- **NFR-PERF-004:** Cache frequently accessed data (drivers, merchants) in Cloudflare KV (TTL: 24h)

### 7.2 Scalability
- **NFR-SCALE-001:** Cloudflare Workers auto-scaling
- **NFR-SCALE-002:** Durable Objects for WebSocket state management
- **NFR-SCALE-003:** PostGIS spatial indexing for geoqueries

### 7.3 Security
- **NFR-SEC-001:** TLS 1.3 for all API traffic
- **NFR-SEC-002:** Password hashing with bcrypt (cost factor: 12)
- **NFR-SEC-003:** JWT tokens with 1-hour expiration
- **NFR-SEC-004:** RBAC enforcement via `RBACService`
- **NFR-SEC-005:** Rate limiting: 100 req/min per IP
- **NFR-SEC-006:** OWASP Top-10 compliance (SQL injection, XSS prevention)
- **NFR-SEC-007:** Audit logs for configuration changes

### 7.4 Reliability
- **NFR-REL-001:** 99.5% uptime SLA
- **NFR-REL-002:** Database backups every 6 hours
- **NFR-REL-003:** Graceful degradation if map API fails

### 7.5 Accessibility
- **NFR-ACCESS-001:** WCAG 2.1 AA compliance for web
- **NFR-ACCESS-002:** Dark mode support
- **NFR-ACCESS-003:** Multi-language (ID, EN) via ARB files

---

## 8. Business Rules

### 8.1 Pricing
```
totalPrice = basePrice + (distanceKm × pricePerKm) + tip - couponDiscount
driverEarning = totalPrice - platformCommission
```
- Minimum order value enforced by configuration
- Tips are not subject to commission (configurable)

### 8.2 Matching Algorithm
**Priority factors:**
1. Driver online status and `isTakingOrder = false`
2. Distance to pickup location (within configurable radius)
3. Gender preference match (if specified)
4. Driver rating (higher rating = higher priority)
5. Not on active class schedule

**Timeout:** If no driver accepts in 30s, expand radius by 20%

### 8.3 Order Cancellation
- **User cancels:** No penalty if before driver accepts; 10% fee if after acceptance
- **Driver cancels:** Warning on first offense; suspension after 3 cancellations/day
- **No-show:** User charged 50% if driver arrives but user not present

### 8.4 Commission Structure
- **Rides/Delivery:** 15% platform fee
- **Food Orders:** 20% platform fee (10% from driver, 10% from merchant)
- Configurable via `configurations` table

---

## 9. Acceptance Criteria Examples

### FR-RIDE-001: Map-based Order Creation
```gherkin
Given: User is on home screen with location permission granted
When: User taps pickup marker and selects destination
Then: System displays route preview with distance and estimated price
And: "Request Ride" button is enabled
```

### FR-SCHED-004: Auto-Offline During Class
```gherkin
Given: Driver has recurring Monday 08:00-10:00 class schedule
When: System clock reaches Monday 08:00
Then: Driver status changes to offline automatically
And: Driver receives notification "You're offline due to scheduled class"
When: System clock reaches Monday 10:00
Then: Driver status reverts to previous state
```

### FR-PAY-003: Wallet Deduction
```gherkin
Given: User wallet balance = 50,000 IDR
And: Order total price = 25,000 IDR
When: User confirms order
Then: Wallet balance = 25,000 IDR
And: Transaction record created with type = "order_payment"
```

---

## 10. Testing Strategy

### 10.1 Unit Tests
- Repository methods with mocked DB
- Price calculation functions
- Distance computation utilities

### 10.2 Integration Tests
- oRPC handler flows with test database
- Payment gateway sandbox testing
- Firebase Auth mock integration

### 10.3 E2E Tests (Mobile)
- Flutter integration tests for critical flows:
  - User registration → order ride → payment → rating
  - Driver onboarding → accept order → complete trip

---

## 11. Deployment & DevOps

### 11.1 Environments
- **Development:** Local PostgreSQL, Cloudflare dev mode
- **Staging:** Cloudflare Workers preview, test DB
- **Production:** Cloudflare Workers, managed PostgreSQL

### 11.2 CI/CD Pipeline
1. **Lint:** TypeScript (ESLint), Dart (dart analyze)
2. **Test:** Run unit + integration tests
3. **Build:** Compile TypeScript, build Flutter APK/IPA
4. **Deploy:** Wrangler for Workers, AWS S3 for mobile releases

### 11.3 Monitoring
- **Logs:** Cloudflare Workers analytics
- **Errors:** Sentry for backend/mobile
- **APM:** Track API latency, order completion rates

---

## 12. Risks & Mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| Low driver adoption | High | Incentive programs, campus marketing |
| GPS inaccuracy indoors | Medium | Fallback to manual location entry |
| Payment gateway downtime | High | Queue failed payments, retry mechanism |
| Fraudulent orders | Medium | RBAC, audit logs, user verification |
| Privacy violations | High | Phone masking, data encryption at rest |

---

## 13. Future Enhancements

- **V2.1:** Calendar API integration for automatic schedule import
- **V2.2:** In-app voice/video calls
- **V2.3:** AI-based demand prediction for driver recommendations
- **V2.4:** Carbon footprint tracking for eco-conscious users
- **V2.5:** Multi-campus support with federated authentication

---

## 14. Glossary

- **KTM:** Student ID Card (Kartu Tanda Mahasiswa)
- **SIM:** Driver's License (Surat Izin Mengemudi)
- **STNK:** Vehicle Registration (Surat Tanda Nomor Kendaraan)
- **QRIS:** Indonesian standard QR code payment
- **PostGIS:** PostgreSQL extension for geographic queries
- **oRPC:** Type-safe RPC framework
- **Drizzle ORM:** TypeScript ORM for SQL databases

---

**Document Control:**  
Last Updated: 2025-12-01  
Authors: Development Team  
Stakeholders: Campus Administration, Student Union, IT Department