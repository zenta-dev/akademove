# Driver Quiz Integration Plan - Final Implementation

## Overview
Integrate the existing driver quiz system with mobile app signup flow using the established patterns in the codebase.

## Key Findings & Best Practices

### Existing Patterns to Follow
1. **Approve/Reject Pattern** (DriverMainRepository):
   - `approve()` checks quiz status automatically
   - No separate approval flow needed
   - Notification should be sent AFTER approval in handler layer

2. **Notification Pattern** (NotificationRepository):
   - Used in: order-ws.ts, payment-repository.ts, badge-award-service.ts
   - Pattern: `context.repo.notification.sendNotificationToUserId({ toUserId, title, body, data, notification })`
   - Should be in handler, not repository

3. **Database Design**:
   - Quiz answers stored with status tracking: IN_PROGRESS → PASSED/FAILED
   - Driver table has quiz_status field (NOT_STARTED, IN_PROGRESS, PASSED, FAILED)
   - Driver.status must be PENDING before can be approved
   - Quiz must be PASSED before driver can be approved

### Current Quiz Flow
```
1. startQuiz() → Creates attempt with status IN_PROGRESS
2. submitAnswer() × N → Adds answers to attempt
3. completeQuiz() → Calculates score, updates status to PASSED/FAILED, updates driver.quizStatus
4. approve() [in main handler] → Only works if quizStatus === PASSED
```

## Implementation Strategy

### Phase 1: API Adjustments (Minimal - No Changes Needed!)
✅ **Status**: Existing API is complete and correct
- The approve() method already validates quiz status
- No notification logic needed in API (follows separation of concerns)
- Handler layer will add notifications (after this integration)

### Phase 2: Regenerate Dart API Client
**File**: `/home/violia/Work/akademove/gen/dart/api_client/`
```bash
cd /home/violia/Work/akademove
bun run dev  # Start server
make gen     # Generate from OpenAPI spec
melos generate  # Build json_serializable
```

### Phase 3: Mobile Repository Implementation
**File**: `apps/mobile/lib/features/driver/data/repositories/driver_quiz_repository.dart`
- Replace all mock implementations with real API calls
- Use generated `ApiClient` from `api_client` package
- Add KeyValue service integration for state persistence
- Implement proper error handling and type mapping

### Phase 4: Mobile KeyValue Service Integration
**Pattern**: Use existing KeyValue service (from core)
```
Key: "quiz_attempt_${driverId}"
Value: {
  attemptId: string
  status: IN_PROGRESS|COMPLETED
  currentQuestionIndex: int
  selectedAnswers: Map<questionId, optionId>
  answeredQuestions: Set<string>
  lastSyncTime: DateTime
}
```

### Phase 5: Signup Flow Integration
**File**: `apps/mobile/lib/features/auth/presentation/screens/sign_up_driver_screen.dart`
- After successful signup, redirect to quiz screen
- Pass driver ID and user context
- Handle quiz result (show approval waiting screen)

### Phase 6: Driver Approval Notifications (Server)
**File**: `apps/server/src/features/driver/main/driver-main-handler.ts`
- Add notification in approve() handler after successful update
- Add notification in reject() handler with reason
- Follow existing pattern from order-ws.ts

## File Structure

### Files to Modify (Server)
1. `apps/server/src/features/driver/main/driver-main-handler.ts` - Add notifications
2. No schema changes needed
3. No database migrations needed

### Files to Create (Mobile)
1. `apps/mobile/lib/features/driver/data/models/quiz_persistence_model.dart` - KV model
2. `apps/mobile/lib/features/driver/data/local/quiz_local_datasource.dart` - Local storage

### Files to Modify (Mobile)
1. `apps/mobile/lib/features/driver/data/repositories/driver_quiz_repository.dart` - Real API
2. `apps/mobile/lib/features/driver/presentation/cubits/driver_quiz_cubit.dart` - State management
3. `apps/mobile/lib/features/auth/presentation/screens/sign_up_driver_screen.dart` - Navigation
4. `apps/mobile/lib/app/router/router.dart` - Add quiz route
5. `apps/mobile/lib/locator.dart` - Register dependencies

## Testing Strategy

### Server Testing
1. Test quiz completion flow
2. Test approval with/without quiz passed
3. Test notification sending on approval

### Mobile Testing
1. Test API client generation
2. Test real API calls (start/submit/complete)
3. Test KV service persistence
4. Test app reopen state restoration
5. Test notification handling

## Risk Mitigation

### Known Risks
1. API client generation might have issues → Use `make gen` with error logs
2. KV service availability → Fallback to API if KV fails
3. Notification delivery → Not critical for functionality
4. Network failures during quiz → Local cache prevents data loss

### Rollback Plan
1. If quiz breaks signup → revert redirect change
2. If API integration fails → keep mock implementation temporarily
3. If KV fails → implement in-memory cache
