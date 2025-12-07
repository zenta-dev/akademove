# Driver Quiz Implementation - Complete File Reference

## Quick Navigation

### Database Tables
- **Driver Quiz Question**: `/apps/server/src/core/tables/driver-quiz-question.ts`
- **Driver Quiz Answer**: `/apps/server/src/core/tables/driver-quiz-answer.ts`
- **Driver (with quiz fields)**: `/apps/server/src/core/tables/driver.ts` (lines 34-39, 61, 65)

### Server API Layer

#### Quiz Answer Endpoints
- **Handler**: `/apps/server/src/features/driver-quiz-answer/driver-quiz-answer-handler.ts`
- **Repository**: `/apps/server/src/features/driver-quiz-answer/driver-quiz-answer-repository.ts`
- **Spec**: `/apps/server/src/features/driver-quiz-answer/driver-quiz-answer-spec.ts`

#### Quiz Question Endpoints (Admin)
- **Handler**: `/apps/server/src/features/driver-quiz-question/driver-quiz-question-handler.ts`
- **Repository**: `/apps/server/src/features/driver-quiz-question/driver-quiz-question-repository.ts`
- **Spec**: `/apps/server/src/features/driver-quiz-question/driver-quiz-question-spec.ts`

#### Driver Approval Logic
- **Handler**: `/apps/server/src/features/driver/main/driver-main-handler.ts` (lines 100-180)
- **Repository**: `/apps/server/src/features/driver/main/driver-main-repository.ts` (lines 600-845)
  - `approve()` method: line 596-640
  - `updateQuizStatus()` method: line 788-845
  - Approval validation: line 607-613

### Schema & Types

#### Quiz Schemas
- **Quiz Question**: `/packages/schema/src/driver-quiz-question.ts`
- **Quiz Answer**: `/packages/schema/src/driver-quiz-answer.ts`
- **Driver**: `/packages/schema/src/driver.ts` (lines 17-26)
- **Constants**: `/packages/schema/src/constants.ts` (lines 147-174)

### Mobile Implementation (Flutter)

#### Cubit (State Management)
- **File**: `/apps/mobile/lib/features/driver/presentation/cubits/driver_quiz_cubit.dart`
- **Key Methods**:
  - `startQuiz()`: line 11
  - `submitAnswer()`: line 37
  - `completeQuiz()`: line 103
  - `getLatestAttempt()`: line 129
  - `checkPersistedState()`: line 212

#### UI Screen
- **File**: `/apps/mobile/lib/features/driver/presentation/screens/driver_quiz_screen.dart`
- **UI Screens**:
  - Start screen: `_buildStartScreen()`
  - Quiz screen: `_buildQuizScreen()`
  - Result screen: `_buildResultScreen()`

#### Repository
- **File**: `/apps/mobile/lib/features/driver/data/repositories/driver_quiz_repository.dart`

#### State Definition
- **File**: `/apps/mobile/lib/features/driver/presentation/states/driver_quiz_state.dart`

#### Persistence Model
- **File**: `/apps/mobile/lib/features/driver/data/models/quiz_persistence_model.dart`

### Web Implementation (React)

#### Quiz Page
- **File**: `/apps/web/src/routes/(auth)/quiz/driver.tsx`
- **Key Components**:
  - Quiz guard/redirect: line 39-61
  - Start screen: line ~100
  - Question screen: line ~150
  - Result screen: line ~200

#### Driver Signup
- **File**: `/apps/web/src/routes/(auth)/sign-up/driver.tsx`
- **Redirect to quiz**: line 79

#### Admin Dashboard

##### Driver List Page
- **File**: `/apps/web/src/routes/dash/admin/drivers.tsx`

##### Driver Table Components
- **Table**: `/apps/web/src/components/tables/driver/table.tsx`
- **Columns**: `/apps/web/src/components/tables/driver/columns.tsx`
  - Status display with color coding: line 22-50
  - Column definitions: line 52-228
- **Row Actions**: `/apps/web/src/components/tables/driver/action.tsx`
  - Conditional actions based on status: line 27-43

##### Dialog Components
- **Approve Driver**: `/apps/web/src/components/dialogs/approve-driver.tsx`
- **Reject Driver**: `/apps/web/src/components/dialogs/reject-driver.tsx`
- **Activate Driver**: `/apps/web/src/components/dialogs/activate-driver.tsx`
- **Suspend Driver**: `/apps/web/src/components/dialogs/suspend-driver.tsx`

### Notifications

#### Push Notification System
- **Handler**: `/apps/server/src/features/notification/notification-handler.ts`
- **Repository**: `/apps/server/src/features/notification/notification-repository.ts`
- **Service**: `/apps/server/src/features/notification/services/push-notification-service.ts`
- **Table**: `/apps/server/src/core/tables/notification.ts`

#### Approval Notifications (in driver-main-handler.ts)
- **Approval notification**: line 104-125
- **Rejection notification**: line 141-157

### Auto-Generated API Clients

#### Dart API Client (Mobile)
```
gen/dart/api_client/lib/src/api/
├── driver_quiz_answer_api.dart
└── driver_quiz_question_api.dart

gen/dart/api_client/lib/src/model/
├── driver_quiz_answer.dart
├── driver_quiz_answer_status.dart
├── driver_quiz_question.dart
├── driver_quiz_question_type.dart
├── driver_quiz_question_category.dart
├── driver_quiz_result.dart
├── start_driver_quiz.dart
├── submit_driver_quiz_answer.dart
└── complete_driver_quiz.dart
```

---

## Key Code Locations by Feature

### Approval Gate Enforcement
```
/apps/server/src/features/driver/main/driver-main-repository.ts:607-613
// Check enforces: quizStatus === "PASSED" before approval
```

### Quiz Status Update
```
/apps/server/src/features/driver/main/driver-main-repository.ts:788-845
// Updates driver's quiz status after completion
```

### Complete Quiz Handler
```
/apps/server/src/features/driver-quiz-answer/driver-quiz-answer-handler.ts:58-92
// Calls updateQuizStatus on completion
```

### Mobile Quiz Cubit
```
/apps/mobile/lib/features/driver/presentation/cubits/driver_quiz_cubit.dart:103-127
// completeQuiz() method updates driver status
```

### Web Quiz Page Guards
```
/apps/web/src/routes/(auth)/quiz/driver.tsx:39-61
// Redirects if already PASSED
```

### Admin Dashboard Row Actions
```
/apps/web/src/components/tables/driver/action.tsx:27-43
// Shows approve/reject for PENDING status
```

---

## Database Query Examples

### Get Pending Drivers (for approval)
```sql
SELECT * FROM drivers 
WHERE status = 'PENDING' 
  AND quiz_status = 'PASSED'
ORDER BY created_at ASC
```
**Index used**: `driver_status_quiz_idx`

### Get Driver's Latest Quiz Attempt
```sql
SELECT * FROM driver_quiz_answers 
WHERE driver_id = $1 
ORDER BY created_at DESC 
LIMIT 1
```
**Index used**: `driver_quiz_answer_driver_status_idx`

### Get Active Quiz Questions
```sql
SELECT * FROM driver_quiz_questions 
WHERE is_active = true 
ORDER BY display_order ASC
```
**Index used**: `driver_quiz_question_category_active_idx`

---

## API Endpoint Summary

### Driver Quiz Answer Routes
```
POST   /driver-quiz-answer/start              # Start quiz (DRIVER)
POST   /driver-quiz-answer/answer             # Submit answer (DRIVER)
POST   /driver-quiz-answer/complete           # Complete quiz (DRIVER)
GET    /driver-quiz-answer/                   # List attempts (DRIVER/ADMIN)
GET    /driver-quiz-answer/{attemptId}        # Get attempt
GET    /driver-quiz-answer/{attemptId}/result # Get result
GET    /driver-quiz-answer/me/latest          # Get my latest (DRIVER)
```

### Driver Quiz Question Routes (Admin/Operator only)
```
GET    /driver-quiz-question/                 # List questions
GET    /driver-quiz-question/{id}             # Get question
POST   /driver-quiz-question/                 # Create question
PATCH  /driver-quiz-question/{id}             # Update question
DELETE /driver-quiz-question/{id}             # Delete question
```

### Driver Main Routes
```
POST   /driver/{id}/approve                   # Approve driver (ADMIN/OPERATOR)
POST   /driver/{id}/reject                    # Reject driver (ADMIN/OPERATOR)
POST   /driver/{id}/suspend                   # Suspend driver
POST   /driver/{id}/activate                  # Activate driver
```

---

## State Flow Diagrams

### Quiz Completion State Update Flow
```
completeQuiz() handler
    ↓
completeQuiz() repository method
    ↓
Calculate score & determine PASSED/FAILED
    ↓
Update driverQuizAnswer status
    ↓
Call driver.main.updateQuizStatus()
    ↓
Update driver.quizStatus
Update driver.quizScore
Update driver.quizAttemptId
Update driver.quizCompletedAt
    ↓
Emit push notification (if approved)
```

### Driver Approval Flow
```
Driver takes quiz
    ↓
Quiz status becomes PASSED/FAILED
    ↓
Admin views driver in dashboard
    ↓
Check: status = PENDING AND quizStatus = PASSED
    ↓
Admin clicks "Approve Driver"
    ↓
approve() handler validates prerequisites
    ↓
Update status: PENDING → APPROVED
    ↓
Send push notification
    ↓
Admin clicks "Activate Driver"
    ↓
Update status: APPROVED → ACTIVE
```

---

## Testing Locations

### Quiz Tests
- Mobile: `/apps/mobile/test/features/driver/` (if exists)
- Server: `/apps/server/test/` (if exists)

### Generated API Tests
- Dart: `gen/dart/api_client/test/driver_quiz_*.dart`

---

## Migration Files

### Database Migrations
```
/apps/server/drizzle/migrations/
# After schema changes, run:
# bun run db:generate  (creates new migration)
# bun run db:push      (applies migration)
```

---

## Localization Keys

Assuming i18n package at `/packages/i18n/`:
- `m.driver_sign_up()`
- `m.approve_driver()`
- `m.approve_driver_desc()`
- `m.pending()`
- `m.approved()`
- `m.active()`
- etc.

---

## Key Dependencies

### Server
- `@orpc/contract` - API spec generation
- `drizzle-orm` - Database ORM
- `zod` - Schema validation

### Mobile
- `flutter_bloc` - State management
- `api_client` - Generated Dart HTTP client
- `get_it` - Dependency injection

### Web
- `@tanstack/react-query` - Server state
- `@tanstack/react-router` - Routing
- `shadcn-ui` - UI components

---

## How to Extend the Quiz System

### Add a New Question Category
1. Update: `/packages/schema/src/constants.ts` - add to `DRIVER_QUIZ_QUESTION_CATEGORIES`
2. Update: `/apps/server/src/core/tables/driver-quiz-question.ts` - enum includes new category
3. Re-generate migrations and Dart client
4. Update admin UI filters if needed

### Add Email Notifications
1. Create: `/apps/server/emails/driver-quiz-*.tsx` template
2. Update: `/apps/server/src/features/driver-quiz-answer/driver-quiz-answer-handler.ts`
3. Add email send after completion
4. Test with email preview service

### Add Quiz Statistics Dashboard
1. Create: `/apps/server/src/features/driver-quiz-answer/quiz-stats-repository.ts`
2. Add aggregation methods: average score, pass rate by category, etc.
3. Create API endpoints for stats
4. Create: `/apps/web/src/routes/dash/admin/quiz-stats.tsx`
5. Add charts (recharts/visx)

### Add Question Randomization
1. Update: `completeQuiz()` method in repository to shuffle questions
2. Update: API response to randomize option order
3. Update mobile UI to handle randomized options

### Add Attempt Limits
1. Add to schema: `maxAttempts`, `cooldownMinutes`
2. Check in `startQuiz()` handler
3. Enforce on frontend with UI message

