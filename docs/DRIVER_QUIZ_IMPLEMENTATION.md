# Driver Quiz Implementation Overview - AkadeMove

## Executive Summary

The AkadeMove platform has a comprehensive driver quiz system integrated throughout the entire onboarding and approval workflow. The quiz is a mandatory requirement for driver approval, with tracking at both the database and application levels across web, mobile, and server components.

---

## 1. QUIZ FEATURE STRUCTURE

### 1.1 Database Schema

#### Driver Quiz Question Table (`driver_quiz_questions`)
- **Primary Key**: `id` (UUID)
- **Fields**:
  - `question` (text): The question text
  - `type` (enum): MULTIPLE_CHOICE, TRUE_FALSE
  - `category` (enum): SAFETY, NAVIGATION, CUSTOMER_SERVICE, PLATFORM_RULES, EMERGENCY_PROCEDURES, VEHICLE_MAINTENANCE, GENERAL
  - `options` (JSONB array): Array of `{id, text, isCorrect}` objects
  - `explanation` (text, nullable): Educational explanation
  - `points` (integer): Points for correct answer (default: 10, max: 1000)
  - `isActive` (boolean): Can deactivate questions without deleting
  - `displayOrder` (integer): For ordering in quiz UI
  - `createdAt`, `updatedAt` (timestamps)

**Indexes**:
- `type`, `category`, `isActive`, `displayOrder`
- Composite: `category + isActive` (optimized for active quiz retrieval)

#### Driver Quiz Answer Table (`driver_quiz_answers`)
- **Primary Key**: `id` (UUID)
- **Foreign Key**: `driverId` (references `drivers.id`)
- **Status**: IN_PROGRESS, COMPLETED, PASSED, FAILED
- **Fields**:
  - `totalQuestions` (integer): Total questions in attempt
  - `correctAnswers` (integer): Number of correct answers
  - `totalPoints` (integer): Sum of all question points
  - `earnedPoints` (integer): Points earned by driver
  - `passingScore` (integer): Threshold percentage (default: 70)
  - `scorePercentage` (integer): Calculated percentage score
  - `answers` (JSONB array): Array of individual question answers
  - `startedAt` (timestamp): When quiz started
  - `completedAt` (timestamp, nullable): When quiz completed
  - `createdAt`, `updatedAt` (timestamps)

**Indexes**:
- `driverId`, `status`, `startedAt`, `completedAt`, `scorePercentage`
- Composite: `driverId + status` (for filtering driver's attempts)

#### Driver Table Quiz Fields (`drivers`)
- `quizStatus` (enum): NOT_STARTED, IN_PROGRESS, PASSED, FAILED (default: NOT_STARTED)
- `quizAttemptId` (text, nullable): Last attempt ID
- `quizScore` (integer, nullable): Last score percentage
- `quizCompletedAt` (timestamp, nullable): When quiz last completed

**Indexes**:
- Individual: `quizStatus`
- Composite: `status + quizStatus` (for filtering pending approval)

---

## 2. QUIZ STATUSES & APPROVAL FLOW

### 2.1 Driver Status States
```
PENDING → APPROVED → ACTIVE
   ↓         ↓         ↓
REJECTED  INACTIVE  SUSPENDED
```

### 2.2 Quiz Status States
```
NOT_STARTED → IN_PROGRESS → PASSED
                    ↓
                   FAILED (can retry)
```

### 2.3 Approval Requirements
**Key Rule**: Driver MUST pass quiz (`quizStatus === "PASSED"`) before transitioning from PENDING to APPROVED.

**Enforcement in Repository** (`driver-main-repository.ts:607-613`):
```typescript
// Check if driver has passed the quiz
if (existing.quizStatus !== "PASSED") {
    throw new RepositoryError(
        "Driver must pass the quiz before approval. Current quiz status: " +
            existing.quizStatus,
        { code: "BAD_REQUEST" },
    );
}
```

---

## 3. API ENDPOINTS & HANDLERS

### 3.1 Quiz Answer Endpoints (Driver-facing)

#### Start Quiz
- **Route**: `POST /driver-quiz-answer/start`
- **Middleware**: `requireRoles("DRIVER")`
- **Input**: `StartDriverQuizSchema`
  - `questionIds[]?`: Specific questions to quiz on
  - `category?`: Filter by category
- **Output**: Quiz attempt with questions (IDs and options only, no answers)
- **Status**: 201 Created

#### Submit Answer
- **Route**: `POST /driver-quiz-answer/answer`
- **Middleware**: `requireRoles("DRIVER")`
- **Input**: `SubmitDriverQuizAnswerSchema`
  - `attemptId`: Current quiz attempt
  - `questionId`: Question being answered
  - `selectedOptionId`: Selected answer option
- **Output**: `{isCorrect, pointsEarned, explanation}`
- **Transaction**: YES (updates attempt)
- **Status**: 200 OK

#### Complete Quiz
- **Route**: `POST /driver-quiz-answer/complete`
- **Middleware**: `requireRoles("DRIVER")`
- **Input**: `CompleteDriverQuizSchema`
  - `attemptId`: Quiz attempt to complete
- **Processing**:
  1. Calculates final score
  2. Determines PASSED/FAILED status
  3. **Updates driver's quiz status** via `updateQuizStatus()`
  4. Sets `quizStatus`, `quizScore`, `quizAttemptId`, `quizCompletedAt`
- **Output**: `DriverQuizResultSchema`
- **Transaction**: YES (updates both attempt and driver record)
- **Status**: 200 OK

#### Get Latest Attempt
- **Route**: `GET /driver-quiz-answer/me/latest`
- **Middleware**: `requireRoles("DRIVER")`
- **Purpose**: Check current quiz status on app restart
- **Output**: Latest `DriverQuizAnswerSchema` or null
- **Status**: 200 OK

#### List Attempts (Admin/Driver)
- **Route**: `GET /driver-quiz-answer/`
- **Query**: `driverId?`, `status?`, `page`, `limit`
- **RBAC**: Drivers see only their own attempts
- **Status**: 200 OK

### 3.2 Quiz Question Endpoints (Admin/Operator-only)

#### List Questions
- **Route**: `GET /driver-quiz-question/`
- **Middleware**: `requireRoles("ADMIN", "OPERATOR")`
- **Query**: `category?`, `type?`, `isActive?`, `page`, `limit`

#### Create Question
- **Route**: `POST /driver-quiz-question/`
- **Input**: `InsertDriverQuizQuestionSchema`
- **Validation**: Min 2, max 6 options

#### Update/Delete Questions
- **Routes**: `PATCH /driver-quiz-question/{id}`, `DELETE /driver-quiz-question/{id}`

---

## 4. MOBILE APP IMPLEMENTATION (Flutter)

### 4.1 File Structure
```
apps/mobile/lib/features/driver/
├── presentation/
│   ├── cubits/driver_quiz_cubit.dart        # State management
│   ├── screens/driver_quiz_screen.dart       # UI
│   └── states/driver_quiz_state.dart         # State definitions
├── data/
│   ├── repositories/driver_quiz_repository.dart
│   └── models/quiz_persistence_model.dart
└── ...
```

### 4.2 DriverQuizCubit (State Management)

**State Class**: `DriverQuizState` with fields:
- `state` (CubitState): loading, success, failure
- `attempt` (QuizAttempt?): Current quiz attempt
- `result` (QuizResult?): Final quiz result
- `currentQuestionIndex` (int?): Current question position
- `selectedAnswerId` (String?): Selected option
- `answeredQuestions` (Set<String>): IDs of answered questions
- `error` (BaseError?): Error information
- `message` (String?): User messages

**Key Methods**:
1. `startQuiz()` - Initiate new quiz attempt
2. `submitAnswer()` - Submit single answer
3. `nextQuestion()` / `previousQuestion()` - Navigate
4. `completeQuiz()` - Finish and calculate score
5. `getLatestAttempt()` - Restore state on app restart
6. `selectAnswer(optionId)` - Store selected option
7. `checkPersistedState()` - Recover from crash

**Computed Properties**:
- `currentQuestion` - Current Q&A
- `isLastQuestion` - Boolean
- `allQuestionsAnswered` - Boolean
- `isCurrentQuestionAnswered` - Boolean
- `progress` - Percentage (0.0-1.0)

### 4.3 Mobile UI Flow

**DriverQuizScreen** displays three states:

1. **Start Screen**: 
   - Show quiz info (categories, passing score)
   - Button to start quiz

2. **Quiz Screen**:
   - Progress bar showing `(currentIndex + 1) / totalQuestions`
   - Current question text
   - Radio buttons for options (answer ID only, text visible)
   - Previous/Next buttons
   - Next button disabled until answer selected
   - Submit button on last question

3. **Result Screen**:
   - Score: `correctAnswers / totalQuestions` (e.g., "8/10")
   - Percentage: `scorePercentage`
   - Status badge: PASSED (green) or FAILED (red)
   - Points earned: `earnedPoints / totalPoints`
   - Completed at timestamp
   - "Retake Quiz" button if failed

### 4.4 Persistence Model
```dart
class QuizPersistenceModel {
  final String attemptId;
  final List<String> answeredQuestionIds;
  final Map<String, String> selectedAnswers;
  final DateTime startedAt;
}
```
Used to recover quiz state if app crashes.

---

## 5. WEB APP IMPLEMENTATION (React)

### 5.1 File Structure
```
apps/web/src/
├── routes/(auth)/quiz/driver.tsx           # Quiz page (protected)
├── routes/(auth)/sign-up/driver.tsx        # Driver signup
├── routes/dash/admin/drivers.tsx           # Admin driver list
├── routes/dash/operator/drivers.tsx        # Operator driver list
├── components/
│   ├── tables/driver/
│   │   ├── table.tsx                      # Data table component
│   │   ├── columns.tsx                    # Column definitions
│   │   └── action.tsx                     # Dropdown actions
│   └── dialogs/
│       ├── approve-driver.tsx             # Approve dialog
│       ├── reject-driver.tsx              # Reject dialog
│       ├── activate-driver.tsx            # Activate dialog
│       └── suspend-driver.tsx             # Suspend dialog
└── ...
```

### 5.2 Quiz Route (`/(auth)/quiz/driver`)

**Page Guard**:
```typescript
beforeLoad: async () => {
  const session = await getSession();
  if (!session || session.role !== "DRIVER") {
    redirect({ to: "/sign-up/driver", throw: true });
  }
  
  // Check if already passed
  const driver = await orpcClient.driver.getMine();
  if (driver.body.data.quizStatus === "PASSED") {
    redirect({ to: "/sign-in", throw: true });
  }
}
```

**UI Components**:
1. **Start Screen**:
   - Quiz header and instructions
   - Category breakdown
   - Passing score requirement (70%)
   - "Start Quiz" button

2. **Question Screen**:
   - Progress bar and question counter
   - Question text
   - Radio group with options (text visible)
   - Previous/Next/Submit buttons
   - Answer indicator (filled circle when answered)

3. **Result Screen**:
   - Large score display
   - Pass/Fail status badge
   - Breakdown: `correctAnswers / totalQuestions`
   - Earned vs. total points
   - "Next Steps" message:
     - If PASSED: "Waiting for admin approval..."
     - If FAILED: "You can retake the quiz"

### 5.3 Driver Signup Route
```typescript
// After successful signup, redirects to:
router.navigate({ to: "/quiz/driver" });
```

### 5.4 Admin Dashboard (Drivers List)

**Access**: Only ADMIN role

**Table Display**:
- Columns: Name, Student ID, License Plate, Rating, **Status**, Online, Joined Date
- Status badges with color coding:
  - PENDING (yellow/Clock icon)
  - APPROVED (green/CheckCircle)
  - REJECTED (red/XCircle)
  - ACTIVE (blue/PlayCircle)
  - INACTIVE (gray/PauseCircle)
  - SUSPENDED (orange/Ban)

**Row Actions** (Dropdown Menu):
```
PENDING status:
  └─ Approve Driver
  └─ Reject Driver

APPROVED status:
  └─ Activate Driver

ACTIVE status:
  └─ Suspend Driver

INACTIVE/SUSPENDED status:
  └─ Activate Driver
```

**Filtering**:
- Status (multi-select): PENDING, APPROVED, REJECTED, ACTIVE, INACTIVE, SUSPENDED
- Online Status (boolean)
- Rating Range (min/max)
- Search by name/email

### 5.5 Approve Driver Dialog

**Component**: `ApproveDriverDialog`

**UI**:
- Title: "Approve Driver"
- Description: "Are you sure you want to approve this driver?"
- Cancel and Approve buttons

**Validation**:
- Backend checks: `quizStatus === "PASSED"`
- If not passed, returns error: `"Driver must pass the quiz before approval"`

**On Success**:
1. Invalidate all driver queries
2. Toast: "Driver approved successfully"
3. Close dialog

**On Error**:
- Toast: Error message from server

---

## 6. APPROVAL & STATUS MECHANISMS

### 6.1 Current Approval Workflow

**Step 1**: Driver signs up with documents
- Documents stored: Student Card, Driver License, Vehicle Certificate
- Initial status: PENDING
- Initial quiz status: NOT_STARTED

**Step 2**: Driver takes quiz
- Cubit/Route guides through questions
- On completion, `updateQuizStatus()` called with:
  - `quizStatus`: "PASSED" or "FAILED"
  - `quizScore`: percentage
  - `quizAttemptId`: attempt ID
  - `quizCompletedAt`: completion time

**Step 3**: Admin reviews
- Via dashboard table (filters for PENDING)
- Can see quiz score in driver detail view
- Prerequisite check: `quizStatus === "PASSED"` before approval button enabled

**Step 4**: Admin approves
- Endpoint: `POST /driver/{id}/approve`
- Handler in: `driver-main-handler.ts:100-131`
- Updates: `status` → APPROVED
- Sends notification to driver

**Step 5**: Admin activates (optional intermediate step)
- Status flow: APPROVED → ACTIVE
- Endpoint: `POST /driver/{id}/activate`

### 6.2 Rejection Workflow

**Endpoint**: `POST /driver/{id}/reject`
**Input**: `RejectDriverSchema`
- `id`: driver ID
- `reason`: rejection reason (required)

**Handler** (`driver-main-handler.ts:132-165`):
1. Updates status: PENDING → REJECTED
2. Sends notification with reason:
   ```
   Title: "Driver Application Declined"
   Body: "Your driver application has been declined. Reason: {reason}"
   Data: { type: "DRIVER_DECLINED", deeplink: "akademove://contact-support" }
   ```

### 6.3 Suspension/Reactivation

**Suspend**:
- Only ACTIVE or APPROVED drivers
- Endpoint: `POST /driver/{id}/suspend`
- Updates: status → SUSPENDED
- Optional: `suspendUntil` timestamp

**Reactivate**:
- From APPROVED, INACTIVE, or SUSPENDED
- Endpoint: `POST /driver/{id}/activate`
- Updates: status → ACTIVE

---

## 7. DRIVER MODEL & SCHEMA

### 7.1 DriverSchema (packages/schema/src/driver.ts)

```typescript
export const DriverSchema = z.object({
  id: z.uuid(),
  userId: z.string(),
  studentId: z.coerce.number(),
  licensePlate: z.string().min(6).max(32),
  status: DriverStatusSchema,                    // PENDING, APPROVED, etc.
  quizStatus: DriverQuizStatusSchema,            // NOT_STARTED, PASSED, etc.
  quizAttemptId: z.string().nullable().optional(),
  quizScore: z.number().int().min(0).max(1000).nullable().optional(),
  quizCompletedAt: DateSchema.nullable().optional(),
  rating: z.number(),
  isTakingOrder: z.boolean(),
  isOnline: z.boolean(),
  currentLocation: CoordinateSchema.optional(),
  lastLocationUpdate: DateSchema.optional(),
  cancellationCount: z.number().int().default(0),
  lastCancellationDate: DateSchema.optional(),
  createdAt: DateSchema,
  
  studentCard: z.url(),
  driverLicense: z.url(),
  vehicleCertificate: z.url(),
  bank: BankSchema,
  user: UserSchema.partial().optional(),  // Relation
  distance: z.number().optional(),        // Scoped computed value
});
```

### 7.2 Quiz-Related Schemas

**DriverQuizStatusSchema**:
```typescript
export type DriverQuizStatus = 
  | "NOT_STARTED"
  | "IN_PROGRESS"
  | "PASSED"
  | "FAILED"
```

**ApproveDriverSchema**:
```typescript
export const ApproveDriverSchema = z.object({
  id: z.string(),
});
```

**RejectDriverSchema**:
```typescript
export const RejectDriverSchema = z.object({
  id: z.string(),
  reason: z.string().min(1, "Rejection reason is required"),
});
```

---

## 8. EMAIL NOTIFICATION SYSTEM

### 8.1 Current Email Templates

Located: `apps/server/emails/`

**Existing Templates**:
- `email-verification.tsx` - Email verification flow
- `order-confirmation.tsx` - Order confirmations
- `invitation.tsx` - Invitations
- `reset-password.tsx` - Password reset
- `contact-response.tsx` - Support responses

### 8.2 Driver Approval Notifications

**Current Implementation**: Push Notifications Only (in-app)

**Approval Notification** (`driver-main-handler.ts:104-125`):
```typescript
await context.repo.notification.sendNotificationToUserId({
  toUserId: result.userId,
  title: "Driver Application Approved",
  body: "Congratulations! Your driver application and quiz have been approved. You can now start accepting orders.",
  data: {
    type: "DRIVER_APPROVED",
    driverId: result.id,
    deeplink: "akademove://driver/home",
  },
  apns: {
    payload: { aps: { category: "DRIVER_APPROVED", sound: "default" } },
  },
  fromUserId: context.user.id,
});
```

**Rejection Notification** (`driver-main-handler.ts:141-157`):
```typescript
await context.repo.notification.sendNotificationToUserId({
  toUserId: result.userId,
  title: "Driver Application Declined",
  body: `Your driver application has been declined. Reason: ${reason || "..."}`,
  data: {
    type: "DRIVER_DECLINED",
    driverId: result.id,
    reason: reason || "",
    deeplink: "akademove://contact-support",
  },
});
```

### 8.3 Notification Infrastructure

**Notification Service** (`apps/server/src/features/notification/`):
- `notification-handler.ts` - API endpoints
- `notification-repository.ts` - DB operations
- `notification-spec.ts` - OpenAPI spec
- `services/push-notification-service.ts` - FCM/APNs integration
- `services/notification-topic-service.ts` - Topic subscriptions

**Notification Table** (`apps/server/src/core/tables/notification.ts`):
- Stores notification records
- Tracks: userId, title, body, type, deeplink, read status

---

## 9. ADMIN/OPERATOR DASHBOARD STRUCTURE

### 9.1 Dashboard Routes

```
/dash/admin/drivers        # Admin drivers list
/dash/operator/drivers     # Operator drivers list (if multi-campus)
```

### 9.2 Admin Dashboard Features

**Access Control**:
```typescript
beforeLoad: async () => {
  const ok = await hasAccess(["ADMIN"]);
  if (!ok) redirect({ to: "/", throw: true });
}
```

**Page Layout**:
```
┌─────────────────────────────────┐
│ Drivers                         │
│ Manage driver applications      │
├─────────────────────────────────┤
│ [Search] [Filters]              │
├─────────────────────────────────┤
│ Table:                          │
│ Name | ID | Plate | Rating | ✓ │
│ Status | Online | Joined | [⋮] │
├─────────────────────────────────┤
│ [< Page 1 of X >]               │
└─────────────────────────────────┘
```

### 9.3 Filter Options

**Statuses Multi-select**:
- [ ] PENDING
- [ ] APPROVED
- [ ] REJECTED
- [ ] ACTIVE
- [ ] INACTIVE
- [ ] SUSPENDED

**Online Status**:
- All (default)
- Online
- Offline

**Rating Range**:
- Min: 0.0
- Max: 5.0

**Search**: Name, email, student ID

### 9.4 Batch Operations

**Currently**: Individual actions via dropdown
- Approve Single Driver
- Reject with reason
- Suspend with optional expiry
- Activate

**Future Enhancement Opportunity**: Bulk approval for multiple pending drivers

### 9.5 Driver Detail View (Not shown in provided code, but referenced)

**Possible fields**:
- Full driver info
- Quiz score and status
- Document verification status
- Rating and reviews
- Order history
- Bank details
- Schedule (class times)

---

## 10. CONSTANTS & ENUMS

### 10.1 Quiz Question Types
```typescript
DRIVER_QUIZ_QUESTION_TYPES = [
  "MULTIPLE_CHOICE",
  "TRUE_FALSE",
]
```

### 10.2 Quiz Question Categories
```typescript
DRIVER_QUIZ_QUESTION_CATEGORIES = [
  "SAFETY",
  "NAVIGATION",
  "CUSTOMER_SERVICE",
  "PLATFORM_RULES",
  "EMERGENCY_PROCEDURES",
  "VEHICLE_MAINTENANCE",
  "GENERAL",
]
```

### 10.3 Quiz Answer Statuses
```typescript
DRIVER_QUIZ_ANSWER_STATUSES = [
  "IN_PROGRESS",
  "COMPLETED",
  "PASSED",
  "FAILED",
]
```

### 10.4 Driver Quiz Statuses
```typescript
DRIVER_QUIZ_STATUSES = [
  "NOT_STARTED",
  "IN_PROGRESS",
  "PASSED",
  "FAILED",
]
```

### 10.5 Driver Statuses
```typescript
DRIVER_STATUSES = [
  "PENDING",
  "APPROVED",
  "REJECTED",
  "ACTIVE",
  "INACTIVE",
  "SUSPENDED",
]
```

---

## 11. KEY BUSINESS LOGIC

### 11.1 Passing Score
- **Default**: 70%
- **Configurable**: Per attempt via `passingScore` field
- **Calculation**: `(earnedPoints / totalPoints) * 100`

### 11.2 Quiz Completion
1. Driver navigates through all questions
2. Each question worth configurable points
3. Answers stored in JSONB array with correctness flag
4. On submit: Score calculated
5. Status set to PASSED if `scorePercentage >= passingScore`, else FAILED
6. Driver's quiz status updated atomically

### 11.3 Approval Gate
```
Can only APPROVE if:
  1. Driver status = PENDING
  2. Driver quizStatus = PASSED
  3. Documents verified (optional - not in current code)
```

### 11.4 Retry Logic
- Failed quiz: Driver can attempt again
- No attempt limit enforced in code
- Each attempt tracked separately
- Only latest attempt shown to admin

---

## 12. IMPLEMENTATION GAPS & OBSERVATIONS

### 12.1 Missing/Incomplete Features
1. **Email Notifications**: 
   - Approval/Rejection use push notifications only
   - No email template for quiz-related notifications
   - Could add email fallback

2. **Quiz Admin UI**:
   - Create/Edit questions endpoints exist
   - No web dashboard for question management
   - Only CLI/API access for admins

3. **Quiz Statistics**:
   - No aggregated stats (avg score, pass rate, etc.)
   - No per-category performance tracking

4. **Attempt Limits**:
   - No max retry limit enforced
   - No timeout between attempts

5. **Document Verification**:
   - Documents uploaded but no verification endpoint
   - Documents not linked to approval workflow

### 12.2 Current Behavior
- Quiz is **mandatory** before approval
- **No time limit** on quiz completion
- **No question randomization** (questions served in `displayOrder`)
- **No answer randomization** (option order not shuffled)
- **Instant feedback** after each answer (correct/incorrect shown)

---

## 13. API INTEGRATION SUMMARY

### 13.1 Mobile API Client Generation
```bash
# Dart API client auto-generated from OpenAPI spec
gen/dart/api_client/lib/src/api/driver_quiz_*.dart
gen/dart/api_client/lib/src/model/driver_quiz_*.dart
```

**Generated Models**:
- `DriverQuizQuestion`, `DriverQuizAnswer`, `DriverQuizResult`
- `StartDriverQuiz`, `SubmitDriverQuizAnswer`, `CompleteDriverQuiz`
- Status enums: `DriverQuizStatus`, `DriverQuizAnswerStatus`

### 13.2 Web API Integration
```typescript
// React Query + oRPC client
import { orpcClient, orpcQuery } from "@/lib/orpc";

// Usage:
const mutation = useMutation(
  orpcQuery.driverQuizAnswer.startQuiz.mutationOptions({...})
);
```

---

## 14. TRANSACTION PATTERNS

All write operations use database transactions:

```typescript
// Quiz completion updates both attempt AND driver status
const result = await context.svc.db.transaction(async (tx) => {
  // 1. Complete quiz attempt
  const quizResult = await context.repo.driverQuizAnswer.completeQuiz(
    body.attemptId,
    { tx },
  );
  
  // 2. Update driver's quiz status
  await context.repo.driver.main.updateQuizStatus(
    driver.id,
    {
      quizStatus: quizResult.passed ? "PASSED" : "FAILED",
      quizAttemptId: body.attemptId,
      quizScore: quizResult.scorePercentage,
      quizCompletedAt: quizResult.completedAt ?? new Date(),
    },
    { tx },
  );
  
  return quizResult;
});
```

---

## 15. ERROR HANDLING & VALIDATION

### 15.1 Schema Validation
All endpoints validate via Zod schemas:
- Input validation on handler entry
- Type-safe oRPC contracts
- Consistent error codes: BAD_REQUEST, NOT_FOUND, FORBIDDEN, etc.

### 15.2 Approval Errors
```
❌ "Driver must be in PENDING status to be approved"
❌ "Driver must pass the quiz before approval. Current quiz status: IN_PROGRESS"
❌ "Driver not found"
```

### 15.3 Logging
Structured logging with context:
```typescript
log.info(
  { driverId: id, quizStatus, quizScore },
  "[DriverMainRepository] Driver quiz status updated"
);
```

---

## 16. SECURITY CONSIDERATIONS

### 16.1 Access Control
- **DRIVER role**: Can only view/attempt own quiz
- **ADMIN/OPERATOR role**: Can manage questions, approve drivers
- **IDOR Protection**: Drivers cannot modify other drivers

### 16.2 Data Protection
- Quiz answers stored in JSONB (not encrypted)
- Sensitive data (answers) not sent to client
- Deeplinks use `akademove://` custom scheme

### 16.3 Approval Authority
- Only ADMIN/OPERATOR can approve
- Audit trail via logging

---

## 17. DEPLOYMENT CONSIDERATIONS

### 17.1 Database Migrations
After schema changes:
```bash
bun run db:generate  # Create migration
bun run db:push     # Apply migration
```

### 17.2 API Generation
Quiz models auto-generated from oRPC spec:
```bash
make gen  # Generates OpenAPI spec, then Dart client
melos generate  # Runs Flutter build_runner
```

### 17.3 Feature Toggles
None currently visible for quiz feature.
Could add: `DISABLE_QUIZ_REQUIREMENT`, `QUIZ_PASSING_SCORE` config.

---

## SUMMARY TABLE

| Aspect | Implementation | Status |
|--------|---|---|
| **Quiz Feature** | Full system with questions, attempts, scoring | ✅ Complete |
| **Mobile App** | Flutter cubit + UI for taking quiz | ✅ Complete |
| **Web Dashboard** | Admin list + driver approval dialog | ✅ Complete |
| **Database** | Tables, indexes, relationships | ✅ Complete |
| **API Endpoints** | Start, submit, complete, list, get | ✅ Complete |
| **Approval Gate** | Quiz passing required before approval | ✅ Complete |
| **Push Notifications** | Approval/rejection notifications | ✅ Complete |
| **Email Notifications** | No quiz-specific email templates | ⚠️ Partial |
| **Quiz Admin UI** | No web dashboard for Q&A management | ⚠️ Missing |
| **Quiz Statistics** | No aggregated analytics | ⚠️ Missing |
| **Attempt Limits** | No max retries enforced | ⚠️ Not enforced |
| **Document Verification** | Documents uploaded, not verified | ⚠️ Incomplete |

---

## FILE REFERENCE MAP

### Server
- `/apps/server/src/core/tables/driver.ts` - Driver schema with quiz fields
- `/apps/server/src/core/tables/driver-quiz-answer.ts` - Quiz attempt storage
- `/apps/server/src/core/tables/driver-quiz-question.ts` - Questions storage
- `/apps/server/src/features/driver-quiz-answer/` - Answer handlers/repo
- `/apps/server/src/features/driver-quiz-question/` - Question handlers/repo
- `/apps/server/src/features/driver/main/driver-main-handler.ts` - Approval logic

### Mobile
- `/apps/mobile/lib/features/driver/presentation/cubits/driver_quiz_cubit.dart`
- `/apps/mobile/lib/features/driver/presentation/screens/driver_quiz_screen.dart`
- `/apps/mobile/lib/features/driver/data/repositories/driver_quiz_repository.dart`

### Web
- `/apps/web/src/routes/(auth)/quiz/driver.tsx` - Quiz page
- `/apps/web/src/routes/dash/admin/drivers.tsx` - Driver admin list
- `/apps/web/src/components/dialogs/approve-driver.tsx` - Approve action
- `/apps/web/src/components/tables/driver/` - Table components

### Schema
- `/packages/schema/src/driver-quiz-question.ts` - Question schemas
- `/packages/schema/src/driver-quiz-answer.ts` - Answer schemas
- `/packages/schema/src/driver.ts` - Driver with quiz fields
- `/packages/schema/src/constants.ts` - Quiz enums

