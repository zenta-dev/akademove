# AkadeMove - Comprehensive Business Documentation

**Version:** 2.0  
**Last Updated:** December 2025  
**Document Type:** Business & Technical System Documentation

---

## Table of Contents

1. [Executive Summary](#1-executive-summary)
2. [System Overview](#2-system-overview)
3. [User Roles & Permissions](#3-user-roles--permissions)
4. [Core Business Flows](#4-core-business-flows)
5. [Order Management System](#5-order-management-system)
6. [Driver Matching Algorithm](#6-driver-matching-algorithm)
7. [Payment & Financial System](#7-payment--financial-system)
8. [Pricing & Commission Structure](#8-pricing--commission-structure)
9. [Gamification & Rewards](#9-gamification--rewards)
10. [Safety & Compliance](#10-safety--compliance)
11. [Platform Configuration](#11-platform-configuration)
12. [Technical Architecture](#12-technical-architecture)
13. [Data Model](#13-data-model)
14. [Integration Points](#14-integration-points)
15. [Glossary](#15-glossary)

---

## 1. Executive Summary

### 1.1 What is AkadeMove?

AkadeMove is a **campus-specific mobility and delivery platform** connecting students as users, drivers, and merchants within university ecosystems. Unlike traditional ride-hailing apps, AkadeMove is designed specifically for the campus environment with unique features tailored to student life.

### 1.2 Core Value Propositions

| Stakeholder | Value Proposition |
|-------------|-------------------|
| **Students (Users)** | Affordable, safe transportation and delivery within campus; gender-preference matching for safety |
| **Students (Drivers)** | Flexible income source that respects academic schedules; auto-offline during classes |
| **Merchants** | Direct access to campus customers; integrated food delivery system |
| **Campus Administration** | Controlled mobility ecosystem; safety oversight; revenue sharing |
| **Platform** | Commission-based sustainable business model |

### 1.3 Service Types

| Service | Description | Use Cases |
|---------|-------------|-----------|
| **RIDE** | Motorcycle transportation | Campus commute, inter-building travel |
| **DELIVERY** | Package/document delivery | Document submission, package pickup |
| **FOOD** | Campus food ordering | Canteen orders, merchant deliveries |

### 1.4 Key Differentiators

1. **Academic Schedule Integration** - Drivers can set class schedules; system auto-disables them during classes
2. **Gender-Based Matching** - Users can request same-gender drivers for safety
3. **Campus-Only Ecosystem** - All participants are verified campus members
4. **Gamification** - Badges, leaderboards, and priority matching for top performers
5. **Real-Time Everything** - Live tracking, instant notifications, WebSocket-based updates

---

## 2. System Overview

### 2.1 Platform Components

```
┌─────────────────────────────────────────────────────────────────┐
│                        AkadeMove Platform                        │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐          │
│  │  Mobile App  │  │   Web App    │  │   Backend    │          │
│  │  (Flutter)   │  │   (React)    │  │  (Hono/oRPC) │          │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘          │
│         │                 │                 │                   │
│         └────────────┬────┴────────────────┘                   │
│                      │                                          │
│              ┌───────▼───────┐                                  │
│              │  Cloudflare   │                                  │
│              │   Workers     │                                  │
│              └───────┬───────┘                                  │
│                      │                                          │
│    ┌─────────┬───────┼───────┬─────────┬─────────┐            │
│    │         │       │       │         │         │             │
│    ▼         ▼       ▼       ▼         ▼         ▼             │
│ ┌─────┐ ┌─────┐ ┌─────┐ ┌─────────┐ ┌─────┐ ┌─────────┐       │
│ │ DB  │ │ KV  │ │ DO  │ │ Queues  │ │ S3  │ │Midtrans │       │
│ │Postgres│Cache│ │WebSocket│ Jobs  │ │Files│ │Payment  │       │
│ └─────┘ └─────┘ └─────┘ └─────────┘ └─────┘ └─────────┘       │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 2.2 Technology Stack

| Layer | Technology | Purpose |
|-------|------------|---------|
| **Backend** | TypeScript, Hono, oRPC, Drizzle ORM | API server, business logic |
| **Database** | PostgreSQL + PostGIS | Data storage, geospatial queries |
| **Cache** | Cloudflare KV | Session, frequently accessed data |
| **Real-time** | Cloudflare Durable Objects | WebSocket connections |
| **Queue** | Cloudflare Queues | Async job processing |
| **Mobile** | Flutter, BLoC pattern | iOS/Android app |
| **Web** | React 19, TanStack Router | Admin/merchant dashboards |
| **Payments** | Midtrans | QRIS, bank transfers, payouts |
| **Maps** | Google Maps API | Location, routing, geocoding |
| **Push** | Firebase Cloud Messaging | Push notifications |
| **Storage** | AWS S3 | Images, documents |

---

## 3. User Roles & Permissions

### 3.1 Role Hierarchy

```
ADMIN (Platform Owner)
   │
   ├── OPERATOR (Campus Admin)
   │      │
   │      ├── MERCHANT (Campus Shops)
   │      │
   │      └── DRIVER (Student Mitra)
   │
   └── USER (Passenger/Customer)
```

### 3.2 Role Definitions

#### USER (Passenger/Customer)
**Who:** Students, staff, or campus visitors

**Capabilities:**
- Register and verify email/phone
- Request rides, deliveries, and food orders
- Set pickup/dropoff locations on map
- Choose gender preference for drivers
- Top-up wallet via QRIS/bank transfer
- Pay for orders from wallet balance
- Rate and review drivers/merchants
- Report issues and misconduct
- View order history
- Redeem promotional coupons

#### DRIVER (Student Mitra)
**Who:** Verified students with valid documents

**Requirements:**
- KTM (Student ID Card)
- SIM (Driver's License)
- STNK (Vehicle Registration)
- Pass onboarding quiz

**Capabilities:**
- Toggle online/offline status
- Set class schedules (auto-offline during classes)
- Receive and accept/reject order offers
- Navigate to pickup/dropoff locations
- Mark order status (arrived, in-trip, completed)
- Upload proof of delivery (for high-value items)
- View earnings and withdraw to bank
- View personal ratings and leaderboard position

**Restrictions:**
- Cannot go online until documents approved
- Auto-suspended after excessive cancellations
- Must complete required training quiz

#### MERCHANT (Campus Shops/Vendors)
**Who:** Campus food vendors, print shops, stores

**Capabilities:**
- Manage store profile and location
- Create and manage menu items
- Set operating hours per day
- Toggle open/close/busy status
- Accept/reject food orders
- Mark orders as preparing/ready
- View sales analytics
- Withdraw earnings to bank

#### OPERATOR (Campus Administrator)
**Who:** Campus management staff

**Capabilities:**
- Everything a USER can do, plus:
- Manage campus users, drivers, merchants
- Approve/reject driver applications
- Approve/reject merchant applications
- Configure campus pricing
- Create and manage coupons
- Send broadcast notifications
- View campus analytics
- Handle user reports
- Manage emergency contacts

#### ADMIN (Platform Owner)
**Who:** System administrators

**Capabilities:**
- Everything an OPERATOR can do, plus:
- Cross-campus management
- System configuration
- Audit log access
- Fraud detection dashboard
- User role management
- Platform-wide analytics
- Commission rate configuration

### 3.3 Permission Matrix

| Action | USER | DRIVER | MERCHANT | OPERATOR | ADMIN |
|--------|:----:|:------:|:--------:|:--------:|:-----:|
| Place orders | Yes | No | No | Yes | Yes |
| Accept orders | No | Yes | No | No | No |
| Manage menu | No | No | Yes | No | No |
| Approve drivers | No | No | No | Yes | Yes |
| View all orders | No | No | No | Yes | Yes |
| Configure pricing | No | No | No | Yes | Yes |
| View audit logs | No | No | No | No | Yes |
| Fraud investigation | No | No | No | No | Yes |

---

## 4. Core Business Flows

### 4.1 User Registration Flow

```
┌─────────────┐
│   START     │
└──────┬──────┘
       │
       ▼
┌─────────────────────┐
│ Select Account Type │
│ (User/Driver/       │
│  Merchant)          │
└──────┬──────────────┘
       │
       ├─────────────────────────────────────┐
       │                                     │
       ▼                                     ▼
┌─────────────────┐              ┌─────────────────────┐
│  USER/MERCHANT  │              │      DRIVER         │
│  Registration   │              │   Registration      │
└──────┬──────────┘              └──────┬──────────────┘
       │                                │
       ▼                                ▼
┌─────────────────┐              ┌─────────────────────┐
│ Email/Password  │              │ Upload Documents    │
│ + Basic Info    │              │ (KTM, SIM, STNK)    │
└──────┬──────────┘              └──────┬──────────────┘
       │                                │
       ▼                                ▼
┌─────────────────┐              ┌─────────────────────┐
│ Email           │              │ Wait for            │
│ Verification    │              │ Document Approval   │
└──────┬──────────┘              └──────┬──────────────┘
       │                                │
       ▼                                ▼
┌─────────────────┐              ┌─────────────────────┐
│    ACTIVE       │              │ Complete Driver     │
│    ACCOUNT      │              │ Onboarding Quiz     │
└─────────────────┘              └──────┬──────────────┘
                                        │
                                        ▼
                                 ┌─────────────────────┐
                                 │ Quiz Passed?        │
                                 └──────┬──────────────┘
                                        │
                              ┌─────────┴─────────┐
                              │                   │
                              ▼                   ▼
                       ┌──────────┐        ┌──────────┐
                       │   YES    │        │    NO    │
                       │ APPROVED │        │  RETRY   │
                       └──────────┘        └──────────┘
```

### 4.2 Ride Booking Flow

```
USER                          SYSTEM                         DRIVER
 │                               │                              │
 │  1. Select Pickup/Dropoff     │                              │
 │─────────────────────────────▶│                              │
 │                               │                              │
 │  2. Request Estimate          │                              │
 │─────────────────────────────▶│                              │
 │                               │                              │
 │  3. Return Price & ETA        │                              │
 │◀─────────────────────────────│                              │
 │                               │                              │
 │  4. Confirm Order             │                              │
 │─────────────────────────────▶│                              │
 │                               │                              │
 │                               │  5. Deduct Wallet            │
 │                               │──────────┐                   │
 │                               │          │                   │
 │                               │◀─────────┘                   │
 │                               │                              │
 │                               │  6. Find Nearby Drivers      │
 │                               │──────────────────────────────▶│
 │                               │                              │
 │                               │  7. Send Order Offer         │
 │                               │──────────────────────────────▶│
 │                               │                              │
 │                               │  8. Driver Accepts           │
 │                               │◀──────────────────────────────│
 │                               │                              │
 │  9. Driver Assigned           │                              │
 │◀─────────────────────────────│                              │
 │                               │                              │
 │  10. Live Location Updates    │                              │
 │◀─────────────────────────────────────────────────────────────│
 │                               │                              │
 │                               │  11. Driver Arrived          │
 │◀─────────────────────────────────────────────────────────────│
 │                               │                              │
 │                               │  12. Trip Started            │
 │◀─────────────────────────────────────────────────────────────│
 │                               │                              │
 │                               │  13. Trip Completed          │
 │◀─────────────────────────────────────────────────────────────│
 │                               │                              │
 │  14. Rate Driver              │  15. Credit Driver Wallet    │
 │─────────────────────────────▶│──────────────────────────────▶│
 │                               │                              │
```

### 4.3 Food Order Flow

```
USER                    SYSTEM                  MERCHANT                DRIVER
 │                         │                        │                      │
 │ 1. Browse Menu          │                        │                      │
 │────────────────────────▶│                        │                      │
 │                         │                        │                      │
 │ 2. Add to Cart          │                        │                      │
 │────────────────────────▶│                        │                      │
 │                         │                        │                      │
 │ 3. Place Order          │                        │                      │
 │────────────────────────▶│                        │                      │
 │                         │                        │                      │
 │                         │ 4. Deduct Payment      │                      │
 │                         │──────────┐             │                      │
 │                         │◀─────────┘             │                      │
 │                         │                        │                      │
 │                         │ 5. Notify Merchant     │                      │
 │                         │───────────────────────▶│                      │
 │                         │                        │                      │
 │                         │ 6. Accept Order        │                      │
 │                         │◀───────────────────────│                      │
 │                         │                        │                      │
 │                         │ 7. Mark Preparing      │                      │
 │                         │◀───────────────────────│                      │
 │                         │                        │                      │
 │                         │ 8. Mark Ready          │                      │
 │                         │◀───────────────────────│                      │
 │                         │                        │                      │
 │                         │ 9. Find Driver         │                      │
 │                         │──────────────────────────────────────────────▶│
 │                         │                        │                      │
 │                         │ 10. Driver Accepts     │                      │
 │                         │◀──────────────────────────────────────────────│
 │                         │                        │                      │
 │                         │ 11. Pickup from Shop   │                      │
 │                         │◀──────────────────────────────────────────────│
 │                         │                        │                      │
 │ 12. Delivery            │                        │                      │
 │◀────────────────────────────────────────────────────────────────────────│
 │                         │                        │                      │
 │                         │ 13. Complete Order     │                      │
 │                         │───────────▶ │ ◀────────│                      │
 │                         │ (Credit both wallets)  │                      │
```

---

## 5. Order Management System

### 5.1 Order Types

| Type | Description | Participants | Commission Split |
|------|-------------|--------------|------------------|
| **RIDE** | Motorcycle transport | User → Driver | Platform takes % from driver |
| **DELIVERY** | Package/document delivery | User → Driver | Platform takes % from driver |
| **FOOD** | Food/beverage delivery | User → Merchant → Driver | Platform takes % from both |

### 5.2 Order State Machine

```
                                    ┌──────────────────┐
                                    │    SCHEDULED     │ (Future orders)
                                    └────────┬─────────┘
                                             │
                                             ▼
┌──────────────┐                    ┌──────────────────┐
│              │                    │                  │
│  REQUESTED   │───────────────────▶│    MATCHING      │
│              │                    │                  │
└──────────────┘                    └────────┬─────────┘
                                             │
                        ┌────────────────────┼────────────────────┐
                        │                    │                    │
                        ▼                    ▼                    │
               ┌────────────────┐   ┌────────────────┐           │
               │ CANCELLED_BY_  │   │    ACCEPTED    │           │
               │ USER/SYSTEM    │   │                │           │
               └────────────────┘   └────────┬───────┘           │
                                             │                    │
                              ┌──────────────┴──────────────┐    │
                              │ (FOOD orders only)          │    │
                              ▼                             │    │
                     ┌────────────────┐                     │    │
                     │   PREPARING    │                     │    │
                     └────────┬───────┘                     │    │
                              │                             │    │
                              ▼                             │    │
                     ┌────────────────┐                     │    │
                     │READY_FOR_PICKUP│                     │    │
                     └────────┬───────┘                     │    │
                              │                             │    │
                              └──────────────┬──────────────┘    │
                                             │                    │
                                             ▼                    │
                                    ┌────────────────┐           │
                                    │    ARRIVING    │           │
                                    └────────┬───────┘           │
                                             │                    │
                        ┌────────────────────┼────────────────┐  │
                        │                    │                │  │
                        ▼                    ▼                │  │
               ┌────────────────┐   ┌────────────────┐       │  │
               │    NO_SHOW     │   │    IN_TRIP     │       │  │
               └────────────────┘   └────────┬───────┘       │  │
                                             │                │  │
                        ┌────────────────────┼────────────────┘  │
                        │                    │                    │
                        ▼                    ▼                    │
               ┌────────────────┐   ┌────────────────┐           │
               │ CANCELLED_BY_  │   │   COMPLETED    │           │
               │ DRIVER/USER    │   │                │           │
               └────────────────┘   └────────────────┘           │
                                                                  │
               ┌──────────────────────────────────────────────────┘
               │ (Timeout - no driver found)
               ▼
      ┌────────────────┐
      │ CANCELLED_BY_  │
      │ SYSTEM         │
      └────────────────┘
```

### 5.3 Order Status Descriptions

| Status | Description | Triggered By |
|--------|-------------|--------------|
| `SCHEDULED` | Order scheduled for future | User places scheduled order |
| `REQUESTED` | Order created, payment pending | User places order |
| `MATCHING` | System searching for drivers | Payment confirmed |
| `ACCEPTED` | Driver accepted order | Driver taps Accept |
| `PREPARING` | Merchant preparing food | Merchant marks preparing |
| `READY_FOR_PICKUP` | Food ready for driver | Merchant marks ready |
| `ARRIVING` | Driver near pickup location | Driver marks arrived |
| `IN_TRIP` | Order in transit | Driver starts trip |
| `COMPLETED` | Order successfully delivered | Driver completes |
| `CANCELLED_BY_USER` | User cancelled | User cancels |
| `CANCELLED_BY_DRIVER` | Driver cancelled | Driver cancels |
| `CANCELLED_BY_MERCHANT` | Merchant rejected | Merchant rejects |
| `CANCELLED_BY_SYSTEM` | System timeout | No driver found |
| `NO_SHOW` | Customer not present | Driver marks no-show |

### 5.4 Order Data Structure

```typescript
Order {
  // Identifiers
  id: UUID
  userId: string           // Customer
  driverId: UUID          // Assigned driver
  merchantId: UUID        // For FOOD orders
  
  // Type & Status
  type: "RIDE" | "DELIVERY" | "FOOD"
  status: OrderStatus
  
  // Locations (PostGIS Points)
  pickupLocation: { x: longitude, y: latitude }
  dropoffLocation: { x: longitude, y: latitude }
  pickupAddress: string
  dropoffAddress: string
  
  // Pricing
  distanceKm: decimal
  basePrice: decimal
  tip: decimal
  totalPrice: decimal
  platformCommission: decimal
  driverEarning: decimal
  merchantCommission: decimal  // FOOD only
  merchantEarning: decimal     // FOOD only
  
  // Discount
  couponId: UUID
  couponCode: string
  discountAmount: decimal
  
  // Preferences
  gender: "MALE" | "FEMALE"
  genderPreference: "SAME" | "ANY"
  
  // Delivery specifics
  note: { pickup: string, dropoff: string }
  deliveryItemType: "DOCUMENT" | "PACKAGE" | "FOOD" | "OTHER"
  proofOfDeliveryUrl: string
  deliveryOtp: string (6 digits)
  
  // Timestamps
  scheduledAt: timestamp
  createdAt: timestamp
  updatedAt: timestamp
}
```

---

## 6. Driver Matching Algorithm

### 6.1 Matching Overview

The driver matching system is the core of AkadeMove's order fulfillment. It uses a sophisticated queue-based algorithm with PostGIS spatial queries for efficient driver discovery.

### 6.2 Matching Criteria

When searching for drivers, the system applies these filters in order:

| Priority | Criterion | Description |
|----------|-----------|-------------|
| 1 | **Online Status** | `isOnline = true` |
| 2 | **Not Busy** | `isTakingOrder = false` |
| 3 | **Active Account** | `status = 'ACTIVE'` |
| 4 | **Quiz Passed** | `quizStatus = 'PASSED'` |
| 5 | **Email Verified** | `user.emailVerified = true` |
| 6 | **Within Radius** | PostGIS distance <= current radius |
| 7 | **Gender Match** | If preference is "SAME", match user gender |
| 8 | **Not Excluded** | Not cancelled this order before |
| 9 | **Cancellation Limit** | < max daily cancellations |

### 6.3 Driver Prioritization

Qualifying drivers are sorted by:

1. **Rating** (highest first)
2. **Distance** (closest second)
3. **Badge Priority Boost** (0-100 points from badges)
4. **Leaderboard Bonus** (inverse rank for top 100)

### 6.4 Radius Expansion Strategy

```
Initial Radius (e.g., 2km)
         │
         ▼
    Search Drivers
         │
    ┌────┴────┐
    │         │
    ▼         ▼
  Found    Not Found
    │         │
    ▼         ▼
 Notify    Wait (timeout)
 Drivers       │
               ▼
         Expand Radius
         (current × 1.2)
               │
               ▼
         Below Max Radius?
               │
        ┌──────┴──────┐
        │             │
        ▼             ▼
       YES           NO
        │             │
        ▼             ▼
    Search       Cancel Order
    Again        (SYSTEM)
```

**Configuration Parameters:**

| Parameter | Description | Default |
|-----------|-------------|---------|
| `initialRadiusKm` | Starting search radius | 2 km |
| `maxRadiusKm` | Maximum search radius | 10 km |
| `expansionRate` | Radius increase per attempt | 20% |
| `timeoutMs` | Wait time between searches | 30 sec |
| `broadcastLimit` | Max drivers to notify | 10 |
| `matchingTimeoutMinutes` | Total matching time | 5 min |

### 6.5 Notification Strategy

When drivers are found, they're notified via:

1. **WebSocket Broadcast** - Instant delivery for online drivers
2. **Push Notification (FCM)** - For background/offline drivers

### 6.6 Driver Schedule Integration

Before including a driver in results, the system checks:

```
Is Current Time Within Driver's Class Schedule?
                    │
          ┌─────────┴─────────┐
          │                   │
          ▼                   ▼
         YES                 NO
          │                   │
          ▼                   ▼
    Exclude Driver     Include Driver
    (Auto-Offline)     (If Other Criteria Met)
```

---

## 7. Payment & Financial System

### 7.1 Money Flow Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                    AkadeMove Money Flow                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   USER                    PLATFORM                  DRIVER/     │
│   WALLET                  ACCOUNT                   MERCHANT    │
│     │                        │                       WALLET     │
│     │   ① TOP-UP            │                         │        │
│     │◀──────────────────────│                         │        │
│     │   (QRIS/Bank)         │                         │        │
│     │                        │                         │        │
│     │   ② ORDER PAYMENT     │                         │        │
│     │───────────────────────▶│                         │        │
│     │   (Wallet Deduct)     │                         │        │
│     │                        │                         │        │
│     │                        │   ③ COMMISSION         │        │
│     │                        │───────────┐            │        │
│     │                        │           │            │        │
│     │                        │◀──────────┘            │        │
│     │                        │   (Platform Fee)       │        │
│     │                        │                         │        │
│     │                        │   ④ EARNINGS           │        │
│     │                        │───────────────────────▶│        │
│     │                        │   (After Commission)   │        │
│     │                        │                         │        │
│     │                        │                         │        │
│     │   ⑤ REFUND            │                         │        │
│     │◀──────────────────────│   (If Cancelled)       │        │
│     │                        │                         │        │
│     │                        │                         │        │
│     │                        │   ⑥ WITHDRAWAL         │        │
│     │                        │◀───────────────────────│        │
│     │                        │   (To Bank Account)    │        │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 7.2 Transaction Types

| Type | Direction | Description |
|------|-----------|-------------|
| `TOPUP` | In | User adds balance via payment gateway |
| `PAYMENT` | Out | Order payment deducted from wallet |
| `EARNING` | In | Driver/merchant receives order earnings |
| `COMMISSION` | Out | Platform commission (audit record) |
| `REFUND` | In | Money returned for cancelled orders |
| `WITHDRAWAL` | Out | Transfer to external bank account |
| `ADJUSTMENT` | Both | Wallet-to-wallet transfers |

### 7.3 Top-Up Flow

```
USER                     SYSTEM                    MIDTRANS
 │                          │                          │
 │  1. Request Top-Up       │                          │
 │  (Amount + Method)       │                          │
 │─────────────────────────▶│                          │
 │                          │                          │
 │                          │  2. Create Charge        │
 │                          │─────────────────────────▶│
 │                          │                          │
 │                          │  3. Return Payment Code  │
 │                          │  (QRIS / VA Number)      │
 │                          │◀─────────────────────────│
 │                          │                          │
 │  4. Display QR/VA        │                          │
 │◀─────────────────────────│                          │
 │                          │                          │
 │  5. User Pays            │                          │
 │──────────────────────────────────────────────────▶│
 │  (External)              │                          │
 │                          │                          │
 │                          │  6. Webhook: Payment OK  │
 │                          │◀─────────────────────────│
 │                          │                          │
 │                          │  7. Credit Wallet        │
 │                          │───────┐                  │
 │                          │       │                  │
 │                          │◀──────┘                  │
 │                          │                          │
 │  8. Success Notification │                          │
 │◀─────────────────────────│                          │
 │                          │                          │
```

**Supported Payment Methods:**
- **QRIS** - Scan QR code (all banks)
- **Bank Transfer** - BCA, BNI, BRI, Mandiri, Permata

### 7.4 Order Payment Flow

Two payment scenarios:

#### A. Wallet Payment (Instant)
```
1. User confirms order
2. System checks wallet balance >= order total
3. Atomic SQL: UPDATE wallet SET balance = balance - amount WHERE balance >= amount
4. If successful → Create order, start matching
5. If failed → Show "Insufficient Balance" error
```

#### B. QRIS/Bank Payment (Async)
```
1. User selects external payment method
2. System creates pending transaction
3. User completes payment externally
4. Midtrans webhook confirms payment
5. System starts order matching
```

### 7.5 Commission Calculation

#### RIDE/DELIVERY Orders
```
totalPrice = basePrice + (distanceKm × pricePerKm) + tip - discount
platformCommission = totalPrice × platformFeeRate
driverEarning = totalPrice - platformCommission
```

#### FOOD Orders (Split Commission)
```
menuItemsTotal = SUM(item.price × item.quantity)
deliveryFee = totalPrice - menuItemsTotal

// Driver side
platformCommission = deliveryFee × platformFeeRate
driverEarning = deliveryFee - platformCommission

// Merchant side  
merchantCommission = menuItemsTotal × merchantCommissionRate
merchantEarning = menuItemsTotal - merchantCommission
```

#### Badge Commission Reduction
Drivers with badges can earn commission discounts:
```
effectiveCommissionRate = baseRate × (1 - badgeReduction)
```

### 7.6 Withdrawal Flow

```
DRIVER/MERCHANT              SYSTEM                    MIDTRANS IRIS
     │                          │                          │
     │  1. Request Withdrawal   │                          │
     │  (Amount + Bank Details) │                          │
     │─────────────────────────▶│                          │
     │                          │                          │
     │                          │  2. Validate             │
     │                          │  - Min amount            │
     │                          │  - Bank account          │
     │                          │───────┐                  │
     │                          │◀──────┘                  │
     │                          │                          │
     │                          │  3. Deduct Wallet        │
     │                          │───────┐                  │
     │                          │◀──────┘                  │
     │                          │                          │
     │                          │  4. Create Payout        │
     │                          │─────────────────────────▶│
     │                          │                          │
     │                          │  5. Payout Status        │
     │                          │◀─────────────────────────│
     │                          │                          │
     │  6. Success/Pending      │                          │
     │◀─────────────────────────│                          │
     │                          │                          │
     │                          │  7. Webhook (if queued)  │
     │                          │◀─────────────────────────│
     │                          │                          │
     │  8. Final Notification   │                          │
     │◀─────────────────────────│                          │
```

### 7.7 Refund Scenarios

| Scenario | Refund Amount | Penalty |
|----------|---------------|---------|
| User cancels before driver accepts | 100% | None |
| User cancels after driver accepts | 90% | 10% to platform |
| Driver cancels | 100% | Driver warning/suspension |
| System timeout (no driver) | 100% | None |
| No-show (user not present) | 50% | 50% penalty (partial to driver) |

---

## 8. Pricing & Commission Structure

### 8.1 Pricing Formula

```
Order Price = Base Fare + Distance Fee + Service Fee + Tip - Discount

Where:
- Base Fare = Fixed starting price per service type
- Distance Fee = Distance (km) × Per-km Rate
- Service Fee = Platform operational fee
- Tip = Optional user gratuity (100% to driver)
- Discount = Coupon/promotion reduction
```

### 8.2 Service-Specific Pricing

| Parameter | RIDE | DELIVERY | FOOD |
|-----------|------|----------|------|
| Base Fare | Rp 5,000 | Rp 7,000 | Rp 5,000 |
| Per-km Rate | Rp 2,500/km | Rp 3,000/km | Rp 2,500/km |
| Minimum Fare | Rp 8,000 | Rp 10,000 | Rp 8,000 |
| Platform Fee | 15% | 15% | 20% |
| Merchant Fee | - | - | 10% |

*Note: All values configurable via admin panel*

### 8.3 Commission Distribution

#### RIDE/DELIVERY
```
┌─────────────────────────────────────────┐
│           ORDER TOTAL: Rp 25,000        │
├─────────────────────────────────────────┤
│                                         │
│   Platform Commission (15%): Rp 3,750   │
│   Driver Earning: Rp 21,250             │
│                                         │
└─────────────────────────────────────────┘
```

#### FOOD (Example: Rp 50,000 total = Rp 35,000 food + Rp 15,000 delivery)
```
┌─────────────────────────────────────────┐
│           ORDER TOTAL: Rp 50,000        │
├─────────────────────────────────────────┤
│                                         │
│   MERCHANT SIDE (Food: Rp 35,000)       │
│   ├─ Merchant Commission (10%): Rp 3,500│
│   └─ Merchant Earning: Rp 31,500        │
│                                         │
│   DRIVER SIDE (Delivery: Rp 15,000)     │
│   ├─ Platform Commission (20%): Rp 3,000│
│   └─ Driver Earning: Rp 12,000          │
│                                         │
│   TOTAL PLATFORM REVENUE: Rp 6,500      │
│                                         │
└─────────────────────────────────────────┘
```

### 8.4 Coupon Types

| Type | Description | Example |
|------|-------------|---------|
| **GENERAL** | Platform-wide discounts | "10% off all rides" |
| **EVENT** | Time-limited promotions | "Dies Natalis special" |
| **MERCHANT** | Store-specific discounts | "Free delivery from Store X" |

**Coupon Rules:**
- Discount amount (fixed) OR percentage
- Minimum order value
- Maximum discount cap
- Usage limit (total + per user)
- Valid date range
- Service type restrictions (RIDE/DELIVERY/FOOD)

---

## 9. Gamification & Rewards

### 9.1 Badge System

Drivers and users can earn badges based on performance:

| Badge Level | Icon | Requirements (Example) |
|-------------|------|------------------------|
| **BRONZE** | Bronze | 10 completed trips |
| **SILVER** | Silver | 50 completed trips, 4.0+ rating |
| **GOLD** | Gold | 200 completed trips, 4.5+ rating |
| **PLATINUM** | Platinum | 500 completed trips, 4.7+ rating |
| **DIAMOND** | Diamond | 1000 completed trips, 4.9+ rating |

### 9.2 Badge Benefits

| Benefit | Description | Example |
|---------|-------------|---------|
| **Priority Boost** | Higher matching priority | +50 priority points |
| **Commission Reduction** | Lower platform fee | 5% reduction |

### 9.3 Leaderboard Categories

| Category | Metric | Period |
|----------|--------|--------|
| **VOLUME** | Completed trips count | Weekly/Monthly |
| **EARNINGS** | Total earnings | Weekly/Monthly |
| **RATING** | Average rating | Monthly |
| **STREAK** | Consecutive active days | Current |
| **ON-TIME** | On-time pickup rate | Monthly |
| **COMPLETION-RATE** | Orders completed vs cancelled | Monthly |

### 9.4 Badge Evaluation

Badges are evaluated automatically after each order completion:

```
Order Completed
      │
      ▼
Queue: BADGE_EVALUATION
      │
      ▼
Check Driver's Metrics
(trips, rating, earnings, etc.)
      │
      ▼
Compare Against Badge Criteria
      │
      ▼
Award New Badges (if qualified)
      │
      ▼
Send Congratulations Notification
```

---

## 10. Safety & Compliance

### 10.1 User Safety Features

| Feature | Description |
|---------|-------------|
| **Gender Preference** | Request same-gender driver |
| **Phone Masking** | Numbers hidden in chat |
| **Real-time Tracking** | Share trip status with contacts |
| **Emergency Button** | Quick access to campus security |
| **Rating System** | Bi-directional accountability |
| **Report System** | Flag misconduct for review |

### 10.2 Driver Verification

Required documents for driver approval:

| Document | Purpose | Verification |
|----------|---------|--------------|
| **KTM** (Student ID) | Verify student status | Admin review |
| **SIM** (Driver's License) | Legal driving permit | Admin review |
| **STNK** (Vehicle Registration) | Vehicle ownership | Admin review |
| **Quiz Pass** | Knowledge verification | Automated scoring |

### 10.3 Report & Investigation Flow

```
┌──────────────┐
│ User Reports │
│ Misconduct   │
└──────┬───────┘
       │
       ▼
┌──────────────┐
│   PENDING    │
│   Status     │
└──────┬───────┘
       │
       ▼ (Auto-escalate if unhandled)
┌──────────────┐
│ INVESTIGATING│
│ (Operator    │
│  Reviews)    │
└──────┬───────┘
       │
       ├─────────────────┐
       │                 │
       ▼                 ▼
┌──────────────┐  ┌──────────────┐
│  RESOLVED    │  │  DISMISSED   │
│  (Action     │  │  (False      │
│   Taken)     │  │   Report)    │
└──────────────┘  └──────────────┘
```

**Possible Actions:**
- Warning issued
- Temporary suspension
- Permanent ban
- Account restriction

### 10.4 Fraud Detection

The system monitors for suspicious activities:

| Fraud Type | Detection Method |
|------------|-----------------|
| **GPS Spoofing** | Velocity checks (impossible speed) |
| **Teleportation** | Location jumps > threshold |
| **Duplicate Accounts** | Bank account, IP, name similarity |
| **Fake Orders** | Pattern analysis |
| **Mock GPS** | Device sensor verification |

Fraud events are flagged with severity levels:
- **LOW** - Minor anomaly, monitor
- **MEDIUM** - Suspicious, investigate
- **HIGH** - Likely fraud, restrict access
- **CRITICAL** - Confirmed fraud, immediate action

### 10.5 Emergency Handling

```
Emergency Button Pressed
         │
         ▼
┌─────────────────────┐
│ Log Emergency Event │
│ - Location          │
│ - Order ID          │
│ - Participants      │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Notify Operators    │
│ (Push + Dashboard)  │
└──────────┬──────────┘
           │
           ▼
┌─────────────────────┐
│ Redirect to Campus  │
│ Security WhatsApp   │
└─────────────────────┘
```

---

## 11. Platform Configuration

### 11.1 Business Configuration Keys

The platform is highly configurable via the admin panel:

#### Wallet Settings
| Key | Description | Default |
|-----|-------------|---------|
| `minTopUpAmount` | Minimum top-up | Rp 10,000 |
| `minWithdrawalAmount` | Minimum withdrawal | Rp 50,000 |
| `minTransferAmount` | Minimum transfer | Rp 10,000 |
| `quickTopUpAmounts` | Quick select amounts | [20k, 50k, 100k] |

#### Driver Matching
| Key | Description | Default |
|-----|-------------|---------|
| `driverMatchingInitialRadiusKm` | Starting radius | 2 km |
| `driverMatchingMaxRadiusKm` | Maximum radius | 10 km |
| `driverMatchingRadiusExpansionRate` | Expansion rate | 0.2 (20%) |
| `driverMatchingTimeoutMinutes` | Total timeout | 5 min |
| `driverMatchingIntervalSeconds` | Search interval | 30 sec |
| `driverMatchingBroadcastLimit` | Max notifications | 10 |
| `driverMaxCancellationsPerDay` | Cancel limit | 3 |

#### Order Lifecycle
| Key | Description | Default |
|-----|-------------|---------|
| `paymentPendingTimeoutMinutes` | Payment expiry | 15 min |
| `orderCompletionTimeoutMinutes` | Auto-complete | 60 min |
| `noShowTimeoutMinutes` | No-show trigger | 10 min |
| `scheduledOrderMinAdvanceMinutes` | Min advance booking | 30 min |
| `scheduledOrderMaxAdvanceDays` | Max advance booking | 7 days |

#### Cancellation Fees
| Key | Description | Default |
|-----|-------------|---------|
| `userCancellationFeeBeforeAccept` | Before driver accepts | 0% |
| `userCancellationFeeAfterAccept` | After driver accepts | 10% |
| `noShowFee` | No-show penalty | 50% |
| `noShowDriverCompensationRate` | Driver compensation | 50% of fee |

### 11.2 Pricing Configuration

Each service type has its own pricing configuration:

```typescript
PricingConfiguration {
  baseFare: number          // Fixed starting price
  perKmRate: number         // Per kilometer rate
  minimumFare: number       // Minimum order price
  platformFeeRate: number   // Commission percentage
  taxRate: number           // Tax percentage (if applicable)
  
  // DELIVERY specific
  perKgRate?: number        // Per kilogram rate
  
  // FOOD specific
  merchantCommissionRate?: number  // Merchant fee
}
```

---

## 12. Technical Architecture

### 12.1 System Components

```
┌────────────────────────────────────────────────────────────────────┐
│                         CLIENT LAYER                                │
├────────────────────────────────────────────────────────────────────┤
│                                                                    │
│   ┌─────────────────┐    ┌─────────────────┐                      │
│   │   Mobile App    │    │    Web App      │                      │
│   │   (Flutter)     │    │   (React 19)    │                      │
│   │                 │    │                 │                      │
│   │ - User flows    │    │ - Admin panel   │                      │
│   │ - Driver flows  │    │ - Operator dash │                      │
│   │ - Real-time GPS │    │ - Merchant dash │                      │
│   │ - Push notifs   │    │ - Analytics     │                      │
│   └────────┬────────┘    └────────┬────────┘                      │
│            │                      │                                │
└────────────┼──────────────────────┼────────────────────────────────┘
             │                      │
             │   HTTPS + WebSocket  │
             │                      │
┌────────────┼──────────────────────┼────────────────────────────────┐
│            ▼                      ▼                                │
│         ┌──────────────────────────────────┐                      │
│         │       Cloudflare Workers          │                      │
│         │       (Edge Runtime)              │                      │
│         └──────────────────────────────────┘                      │
│                        │                                           │
│         ┌──────────────┼──────────────┐                           │
│         │              │              │                            │
│         ▼              ▼              ▼                            │
│   ┌──────────┐  ┌──────────┐  ┌──────────┐                        │
│   │   Hono   │  │  oRPC    │  │ Durable  │                        │
│   │  Router  │  │   API    │  │ Objects  │                        │
│   └────┬─────┘  └────┬─────┘  └────┬─────┘                        │
│        │             │             │                               │
│        └─────────────┼─────────────┘                              │
│                      │                                             │
│                      ▼                                             │
│         ┌──────────────────────────────────┐                      │
│         │       Business Logic Layer        │                      │
│         │                                   │                      │
│         │  Handlers → Repositories →        │                      │
│         │  Services                         │                      │
│         └──────────────────────────────────┘                      │
│                      │                                             │
│                                     SERVICE LAYER                  │
└──────────────────────┼─────────────────────────────────────────────┘
                       │
┌──────────────────────┼─────────────────────────────────────────────┐
│                      ▼                                             │
│         ┌──────────────────────────────────┐                      │
│         │       DATA LAYER                  │                      │
│         └──────────────────────────────────┘                      │
│                      │                                             │
│    ┌─────────┬───────┼───────┬─────────┬─────────┐               │
│    │         │       │       │         │         │                │
│    ▼         ▼       ▼       ▼         ▼         ▼                │
│ ┌─────┐ ┌─────┐ ┌─────────┐ ┌─────┐ ┌─────┐ ┌─────────┐          │
│ │Postgre│ │ KV  │ │ Queues  │ │ S3  │ │ FCM │ │Midtrans │          │
│ │+ Post │ │Cache│ │ (Jobs)  │ │Files│ │Push │ │Payment  │          │
│ │GIS    │ │     │ │         │ │     │ │     │ │         │          │
│ └─────┘ └─────┘ └─────────┘ └─────┘ └─────┘ └─────────┘          │
│                                                                    │
│                         DATA LAYER                                 │
└────────────────────────────────────────────────────────────────────┘
```

### 12.2 API Architecture

The API follows oRPC specification with automatic OpenAPI generation:

```
/api
├── /auth           # Authentication
├── /users          # User management
├── /drivers        # Driver management
├── /merchants      # Merchant management
├── /orders         # Order operations
├── /wallet         # Wallet operations
├── /transactions   # Transaction history
├── /payments       # Payment webhooks
├── /coupons        # Coupon management
├── /reviews        # Ratings & reviews
├── /notifications  # Push notifications
├── /configurations # System config
├── /reports        # User reports
├── /analytics      # Data exports
└── /ws             # WebSocket endpoints
```

### 12.3 Real-Time Communication

WebSocket endpoints for live updates:

| Endpoint | Purpose |
|----------|---------|
| `/ws/order/:orderId` | Order status updates |
| `/ws/driver-pool` | Driver order offers |
| `/ws/driver-location` | Driver GPS streaming |
| `/ws/merchant/:id/orders` | Merchant order notifications |
| `/ws/payment/general` | Payment confirmations |

### 12.4 Queue-Based Processing

Three queues handle async operations:

| Queue | Priority | Message Types |
|-------|----------|---------------|
| **ORDER_QUEUE** | High | DRIVER_MATCHING, ORDER_TIMEOUT, ORDER_COMPLETION, REFUND |
| **NOTIFICATION_QUEUE** | Medium | PUSH_NOTIFICATION, BATCH_NOTIFICATION |
| **PROCESSING_QUEUE** | Low | BADGE_EVALUATION, AUDIT_LOG, DRIVER_METRICS |

---

## 13. Data Model

### 13.1 Entity Relationship Overview

```
                    ┌─────────────┐
                    │    USER     │
                    │             │
                    │ id          │
                    │ name        │
                    │ email       │
                    │ role        │
                    │ gender      │
                    │ rating      │
                    └──────┬──────┘
                           │
        ┌──────────────────┼──────────────────┐
        │                  │                  │
        ▼                  ▼                  ▼
┌───────────────┐  ┌───────────────┐  ┌───────────────┐
│    DRIVER     │  │   MERCHANT    │  │    WALLET     │
│               │  │               │  │               │
│ userId (FK)   │  │ userId (FK)   │  │ userId (FK)   │
│ studentId     │  │ name          │  │ balance       │
│ licensePlate  │  │ location      │  │ currency      │
│ status        │  │ status        │  │               │
│ isOnline      │  │ isOnline      │  └───────┬───────┘
│ currentLocation│ │ category      │          │
│ rating        │  │ rating        │          │
└───────┬───────┘  └───────┬───────┘          │
        │                  │                  │
        │                  │                  ▼
        │                  │          ┌───────────────┐
        │                  │          │  TRANSACTION  │
        │                  │          │               │
        │                  │          │ walletId (FK) │
        │                  │          │ type          │
        │                  │          │ amount        │
        │                  │          │ status        │
        │                  │          └───────────────┘
        │                  │
        │    ┌─────────────┴─────────────┐
        │    │                           │
        │    ▼                           ▼
        │  ┌───────────────┐    ┌───────────────┐
        │  │    MENU       │    │OPERATING_HOURS│
        │  │               │    │               │
        │  │ merchantId    │    │ merchantId    │
        │  │ name          │    │ dayOfWeek     │
        │  │ price         │    │ openTime      │
        │  │ stock         │    │ closeTime     │
        │  └───────────────┘    └───────────────┘
        │
        │
        └──────────────┐
                       │
                       ▼
               ┌───────────────┐
               │    ORDER      │
               │               │
               │ userId (FK)   │◀───────────────┐
               │ driverId (FK) │                │
               │ merchantId    │                │
               │ type          │        ┌───────────────┐
               │ status        │        │  ORDER_ITEM   │
               │ pickup/dropoff│        │               │
               │ totalPrice    │        │ orderId (FK)  │
               │ commission    │        │ menuId (FK)   │
               └───────┬───────┘        │ quantity      │
                       │                │ unitPrice     │
        ┌──────────────┼──────────────┐ └───────────────┘
        │              │              │
        ▼              ▼              ▼
┌───────────────┐ ┌───────────────┐ ┌───────────────┐
│    REVIEW     │ │     CHAT      │ │STATUS_HISTORY │
│               │ │               │ │               │
│ orderId (FK)  │ │ orderId (FK)  │ │ orderId (FK)  │
│ fromUserId    │ │ senderId      │ │ previousStatus│
│ toUserId      │ │ message       │ │ newStatus     │
│ score         │ │ sentAt        │ │ changedBy     │
│ categories    │ │               │ │ changedAt     │
└───────────────┘ └───────────────┘ └───────────────┘
```

### 13.2 Key Tables Summary

| Table | Description | Key Fields |
|-------|-------------|------------|
| `users` | All user accounts | id, email, role, gender, rating |
| `drivers` | Driver profiles | userId, studentId, status, isOnline, currentLocation |
| `merchants` | Merchant profiles | userId, name, location, status, category |
| `orders` | All orders | userId, driverId, type, status, locations, pricing |
| `wallets` | User balances | userId, balance, currency |
| `transactions` | Money movements | walletId, type, amount, status |
| `payments` | External payments | transactionId, provider, method, externalId |
| `reviews` | Ratings & reviews | orderId, fromUserId, toUserId, score |
| `coupons` | Promotional codes | code, discountAmount, usageLimit |
| `badges` | Achievement definitions | code, level, criteria, benefits |
| `reports` | User reports | reporterId, targetUserId, category, status |

---

## 14. Integration Points

### 14.1 External Services

| Service | Purpose | Integration |
|---------|---------|-------------|
| **Midtrans** | Payment gateway | REST API (charge, webhooks, payout) |
| **Google Maps** | Maps & routing | JavaScript SDK, Directions API |
| **Firebase Auth** | Authentication | SDK (mobile), REST (server) |
| **Firebase Cloud Messaging** | Push notifications | Admin SDK |
| **AWS S3** | File storage | SDK (presigned URLs) |

### 14.2 Webhook Endpoints

| Endpoint | Source | Purpose |
|----------|--------|---------|
| `/payment/webhook/midtrans` | Midtrans | Payment confirmations |
| `/payment/webhook/midtrans-payout` | Midtrans Iris | Payout status updates |

### 14.3 Mobile Deep Links

| Deep Link | Purpose |
|-----------|---------|
| `akademove://order/:id` | Open specific order |
| `akademove://driver/order/:id` | Driver order details |
| `akademove://wallet` | Open wallet screen |
| `akademove://profile` | Open profile screen |

---

## 15. Glossary

| Term | Definition |
|------|------------|
| **AkadeMove** | The campus mobility platform |
| **Mitra** | Indonesian term for "partner" - refers to drivers |
| **KTM** | Kartu Tanda Mahasiswa (Student ID Card) |
| **SIM** | Surat Izin Mengemudi (Driver's License) |
| **STNK** | Surat Tanda Nomor Kendaraan (Vehicle Registration) |
| **QRIS** | Quick Response Code Indonesian Standard |
| **PostGIS** | PostgreSQL extension for geographic queries |
| **oRPC** | Type-safe RPC framework used for API |
| **Durable Objects** | Cloudflare's stateful edge computing |
| **BLoC** | Business Logic Component (Flutter pattern) |
| **FCM** | Firebase Cloud Messaging |
| **Midtrans** | Indonesian payment gateway provider |
| **Iris** | Midtrans payout/disbursement service |
| **WebSocket** | Bidirectional real-time communication protocol |
| **PostGIS Point** | Geographic coordinate (longitude, latitude) |

---

## Document History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | Dec 2024 | Dev Team | Initial SRS |
| 2.0 | Dec 2025 | Dev Team | Comprehensive business documentation |

---

**End of Document**
