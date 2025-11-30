# akademove
*A platform enabling mobility, courier, and food delivery inside a campus ecosystem — powered by real-time services, clean architecture, and multi-role workflows.*
Built for **users**, **drivers (students)**, **merchants**, **operators**, and **administrators**.

# **🔗 Table of Contents**

* [Overview](#overview)
* [Features](#features)
* [Architecture](#architecture)
* [Tech Stack](#tech-stack)
* [Monorepo Structure](#monorepo-structure)
* [Installation](#installation)
* [Environment Variables](#environment-variables)
* [API Overview](#api-overview)
* [WebSocket Channels](#websocket-channels)
* [Development Guidelines](#development-guidelines)
* [Contribution Guide](#contribution-guide)
* [Commit Convention](#commit-convention)
* [Versioning](#versioning)
* [License](#license)

# **📌 Overview**

This platform provides a comprehensive mobility and delivery solution for university communities:

* Ride hailing
* Delivery (goods/documents)
* Food delivery
* Real-time location tracking
* In-app wallet & QRIS payment
* Merchant dashboard
* Operator administration & reporting


Built with **modular clean architecture**, shared schemas, and a modern developer experience across backend, mobile, and web dashboards.

# **🚀 Features**

### **User**

* Ride/food/goods ordering
* Gender-based driver preference
* Live driver tracking
* Wallet + QRIS payment
* Chat with driver (number masking)
* Ratings & reports


### **Driver**

* Online/offline availability
* Auto-off during class schedule (KRS)
* Auto-matching & prioritization
* Earnings dashboard
* Delivery proof (photo/OTP)


### **Merchant**

* Menu & inventory management
* Order preparation flow
* Sales reporting & commission tracking


### **Operator/Admin**

* Pricing rules (tariff/km)
* Promo / coupon management
* Driver & merchant monitoring
* Broadcast announcements
* Audit logs & analytics


# **🧱 Architecture**

This monorepo contains three primary applications:

| Component         | Stack                                           | Purpose                            |
| ----------------- | ----------------------------------------------- | ---------------------------------- |
| **Backend**       | TypeScript, oRPC, Drizzle, CF Workers, Postgres | API, real-time, payments, matching |
| **Mobile App**    | Flutter                                         | User/Driver client                 |
| **Web Dashboard** | React (TanStack Start)                          | Merchant, Operator, Admin panels   |

All three follow clean architecture principles as documented in the project’s tech stack reference.


# **🛠 Tech Stack**

### **Backend**

* TypeScript
* oRPC
* Drizzle ORM
* PostgreSQL + PostGIS
* Cloudflare KV & Durable Objects
* Firebase Admin + FCM
* AWS S3
* Google Maps API
* Zod validation


**Rule:** Avoid `any`, use `unknown` instead.

### **Mobile**

* Flutter (Dart)
* Cubit (BLoC minimal)
* Dio
* Dart Mappable
* Google Maps Flutter
* GeoLocator
* WebSocket Channel
* Custom OpenAPI generator


**Rule:** Avoid `dynamic`.

### **Web Dashboard**

* TypeScript
* React + TanStack Start
* TanStack Query
* Shadcn UI
* Firebase
* Google Maps via `@vis.gl/react-google-maps`


# **📂 Monorepo Structure**

```
/
│── backend/
│   ├── src/
│   │   ├── core/
│   │   ├── features/
│   │   ├── utils/
│   │   └── index.ts
│   └── drizzle/
│
│── mobile/
│   ├── lib/
│   │   ├── app/
│   │   ├── core/
│   │   ├── features/
│   │   ├── widgets/
│   │   └── main.dart
│
│── web/
│   ├── src/
│   │   ├── components/
│   │   ├── routes/
│   │   ├── hooks/
│   │   └── lib/
│   └── server.ts
│
│── shared/
│   ├── schemas/
│   ├── types/
│   └── openapi/
│
└── README.md
```

# **📦 Installation**

## **1. Clone the Monorepo**

```bash
git clone https://github.com/<org>/<repo>.git
cd repo
```

## **2. Backend Setup**

### Install dependencies:

```bash
cd backend
pnpm install
```

### Generate database schema:

```bash
pnpm drizzle:push
```

### Start dev server:

```bash
pnpm dev
```

## **3. Mobile Setup**

```bash
cd mobile
flutter pub get
flutter run
```

## **4. Web Dashboard Setup**

```bash
cd web
pnpm install
pnpm dev
```

# **🔐 Environment Variables**

A complete `.env.example` file is recommended.

### Backend (sample)

```
DATABASE_URL=
FIREBASE_SERVICE_ACCOUNT=
GOOGLE_MAPS_KEY=
AWS_S3_KEY=
AWS_S3_SECRET=
RESEND_API_KEY=
QRIS_CALLBACK_URL=
```

### Mobile

```
API_BASE_URL=
GOOGLE_MAPS_KEY=
FCM_SERVER_KEY=
```

### Web

```
VITE_API_URL=
VITE_GOOGLE_MAPS_KEY=
VITE_FIREBASE_API_KEY=
```

# **📡 API Overview**

A complete OpenAPI specification is stored in `/shared/openapi`.

### Core Endpoints

| Domain       | Methods                          |
| ------------ | -------------------------------- |
| Auth         | register/login/logout            |
| User         | profile, history, wallet         |
| Driver       | schedule, availability, earnings |
| Order        | create, cancel, status, track    |
| Merchant     | menu, items, orders              |
| Payment      | create, verify, webhook          |
| Notification | FCM tokens                       |
| Operator     | pricing, coupons, reports        |

### Example (Order creation)

```
POST /orders
Body:
{
  pickup: { lat, lng },
  dropoff: { lat, lng },
  type: "ride" | "delivery" | "food",
  genderPreference: "same" | "any"
}
```

### Webhooks

```
POST /payments/midtrans/webhook
```

# **📡 WebSocket Channels**

### Order updates

```
/ws/order/{orderId}
```

Events:

```
ORDER_MATCHING
ORDER_ACCEPTED
DRIVER_ARRIVING
IN_TRIP
COMPLETED
CANCELLED
PAYMENT_CONFIRMED
```

### Driver location stream

```
/ws/driver/{driverId}/location
```

# **🧭 Development Guidelines**

### **Backend**

* Avoid `any`
* Always validate inputs with **Zod**
* Strict type safety
* Business logic must never reside inside handlers

### **Mobile**

* Use Cubit, not full BLoC
* Avoid `dynamic`
* WebSocket must be wrapped in `WebsocketService`

### **Web**

* Use TanStack Query for all data fetching
* UI must follow Shadcn component standards
* Avoid unnecessary client components

# **🤝 Contribution Guide**

### 1. Fork & create a branch

```
git checkout -b feature/<short-title>
```

### 2. Follow commit conventions

(see below)

### 3. Submit PR with:

* clear description
* screenshots for UI work
* test coverage (if applicable)

### 4. CI must pass

* lint
* typecheck
* build

# **📜 Commit Convention**

Use **Conventional Commits**:

| Type        | Meaning                        |
| ----------- | ------------------------------ |
| `feat:`     | New feature                    |
| `fix:`      | Bug fix                        |
| `docs:`     | Documentation                  |
| `refactor:` | Code cleanup (no logic change) |
| `perf:`     | Performance improvements       |
| `test:`     | Tests                          |
| `chore:`    | Build/CI/tooling               |

Example:

```
feat(order): add gender preference to matching engine
```

# **🏷 Versioning**

Use **Semantic Versioning (SemVer)**:

```
MAJOR.MINOR.PATCH
```

Example:

* `1.0.0` release
* `1.1.0` new features
* `1.1.1` small fixes