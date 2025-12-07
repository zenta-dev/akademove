# Driver Quiz Integration - Comprehensive Testing Guide

**Created**: December 7, 2025  
**Status**: Ready for Testing  
**Expected Duration**: 60-90 minutes

---

## 📋 Test Phases Overview

| Phase | Title | Duration | Priority | Status |
|-------|-------|----------|----------|--------|
| 1 | Happy Path | 15 min | CRITICAL | TODO |
| 2 | Offline & Persistence | 10 min | HIGH | TODO |
| 3 | Push Notifications | 10 min | HIGH | TODO |
| 4 | Error Handling | 15 min | MEDIUM | TODO |
| 5 | Regression Testing | 20 min | MEDIUM | TODO |

---

## 🚀 Phase 1: Happy Path Testing (CRITICAL) - 15 minutes

### Setup
```bash
# Terminal 1: Start server
cd /home/violia/Work/akademove
bun run dev
# Wait for "Server running on http://localhost:3000"

# Terminal 2: Start mobile app
cd apps/mobile
flutter run
# Select device/emulator

# Terminal 3 (Optional): Watch database
bun run db:studio
```

### Test Steps
1. **Signup as Driver**
   - [ ] Open app and go to driver signup
   - [ ] Step 1: Enter personal info (name, email, student ID, phone)
   - [ ] Step 2: Upload documents (photo, student card, driver license)
   - [ ] Step 3: Enter vehicle info (license plate, vehicle registration)
   - [ ] Step 4: Enter banking info (bank name, account number)
   - [ ] Click "Complete Registration"
   - [ ] **Expected**: Auto-redirect to DriverQuizScreen

2. **Load Quiz**
   - [ ] Verify loading state appears
   - [ ] Quiz loads within 3 seconds
   - [ ] First question displays with options
   - [ ] **Expected**: See progress bar (e.g., "Question 1 of 10")

3. **Answer Questions**
   - [ ] Read each question carefully
   - [ ] Select correct answer (≥70% to pass)
   - [ ] Click "Submit Answer"
   - [ ] See feedback message
   - [ ] Click "Next Question"
   - [ ] Repeat until all questions answered
   - [ ] **Expected**: No crashes, smooth navigation

4. **Complete Quiz**
   - [ ] After last question, click "Complete Quiz"
   - [ ] See loading state
   - [ ] Quiz completion screen appears
   - [ ] Verify score display: "Score: X/100" or "X%"
   - [ ] **Expected**: Score ≥70% shows "PASSED"

5. **Approval Waiting Screen**
   - [ ] After completion, see "Awaiting Operator Approval" screen
   - [ ] Text says driver must wait for operator review
   - [ ] Cannot retry quiz immediately
   - [ ] **Expected**: Clear message and instructions

6. **Operator Approval**
   - [ ] Login as operator/admin in web dashboard
   - [ ] Find pending driver in "Driver Management" section
   - [ ] Click "Approve" button
   - [ ] Confirmation dialog appears
   - [ ] Confirm approval
   - [ ] **Expected**: Operator sees success message

7. **Push Notification**
   - [ ] Check device notifications
   - [ ] **Expected**: Notification appears with:
     - Title: "Driver Application Approved"
     - Body: "Congratulations! Your driver application and quiz have been approved..."
   - [ ] Tap notification
   - [ ] **Expected**: Redirected to driver home/dashboard

8. **Dashboard Access**
   - [ ] Verify driver can access dashboard
   - [ ] Verify leaderboard visible
   - [ ] Verify "ready to accept orders" state
   - [ ] **Expected**: No access denied messages

### Success Criteria
- ✅ All 8 steps complete without errors
- ✅ Auto-redirect to quiz after signup
- ✅ Quiz loads and displays properly
- ✅ Score calculated correctly
- ✅ "Awaiting Approval" screen shows
- ✅ Push notification received
- ✅ Dashboard accessible after approval

---

## 💾 Phase 2: Offline & Persistence Testing (HIGH) - 10 minutes

### Setup
- Complete Phase 1 (Happy Path) first, or have a driver at "Awaiting Approval" state

### Test 1: State Persists on App Restart
1. [ ] Driver at "Awaiting Approval" screen
2. [ ] Note the time/state
3. [ ] **Force close app** (don't just minimize):
   - Android: Swipe away from recents or use Settings → Apps
   - iOS: Swipe up from bottom
4. [ ] Reopen app
5. [ ] **Expected**: 
   - App auto-navigates to "Awaiting Approval" screen
   - Same state as before (no lost data)
   - No loading spinner or errors

### Test 2: Offline Fallback
1. [ ] App at "Awaiting Approval" screen
2. [ ] **Enable airplane mode** on device
3. [ ] Close app
4. [ ] Reopen app (still in airplane mode)
5. [ ] **Expected**:
   - App loads state from local cache
   - Shows "Awaiting Approval" screen
   - No network error shown (graceful fallback)
   - Can still see quiz state

### Test 3: Offline to Online Recovery
1. [ ] Still in airplane mode at "Awaiting Approval"
2. [ ] Click "Refresh" or "Check Status" button (if available)
3. [ ] **Expected**: Error message or loading (trying to fetch)
4. [ ] **Disable airplane mode**
5. [ ] Click refresh again
6. [ ] **Expected**: Successfully fetches latest state from server

### Test 4: Quiz State During Interruption
1. [ ] In **new driver signup**, go to quiz
2. [ ] Answer 3-4 questions
3. [ ] **Force close app**
4. [ ] Reopen app
5. [ ] **Expected**:
   - Navigates back to quiz
   - Shows "Awaiting Approval" (if quiz completed before)
   - OR shows quiz screen with progress restored

### Success Criteria
- ✅ State persists after app restart
- ✅ Offline fallback to cache works
- ✅ No crashes or errors on network failures
- ✅ Recovery successful when network restored
- ✅ Quiz progress saved and restored

---

## 🔔 Phase 3: Push Notifications Testing (HIGH) - 10 minutes

### Setup
- Have two accounts ready:
  - Driver account (completed quiz, awaiting approval)
  - Operator/admin account (can approve drivers)

### Test 1: Approval Notification
1. [ ] **Device 1** (Driver):
   - Complete driver signup and quiz
   - Reach "Awaiting Approval" screen
   - Keep app in foreground or background

2. [ ] **Device 2** (Operator):
   - Login as operator/admin
   - Go to Driver Management / Pending Drivers
   - Find the driver from step 1
   - Click "Approve" button
   - Enter any notes (optional)
   - Click "Confirm"
   - **Expected**: Operator sees success message

3. [ ] **Device 1** (Driver):
   - **Expected**: Push notification appears:
     - **Title**: "Driver Application Approved"
     - **Body**: "Congratulations! Your driver application and quiz have been approved. You can now start accepting orders."
     - **Icon**: App icon
     - **Sound**: Should play notification sound
   - Tap notification
   - **Expected**: Deep link works - redirected to driver home/dashboard

### Test 2: Rejection Notification
1. [ ] **New Driver Signup**:
   - Signup as driver
   - Complete quiz (can answer wrong to fail, or pass and test rejection)

2. [ ] **Operator**:
   - Go to Driver Management
   - Find the driver
   - Click "Reject" or "Decline"
   - Enter rejection reason: "Document quality unclear"
   - Click "Confirm"
   - **Expected**: Success message

3. [ ] **Driver Device**:
   - **Expected**: Push notification appears:
     - **Title**: "Driver Application Declined"
     - **Body**: "Your driver application has been declined. Reason: Document quality unclear"
   - Tap notification
   - **Expected**: Deep link works - opens support contact screen

### Test 3: Notification Payload
While notifications displayed correctly, verify payload in logs:

```bash
# Check mobile logs
flutter logs | grep -i "DRIVER_APPROVED\|DRIVER_DECLINED"

# Expected output:
# I/flutter: DRIVER_APPROVED notification received
# I/flutter: deeplink: akademove://driver/home
```

### Success Criteria
- ✅ Approval notification shows correct title/body
- ✅ Rejection notification includes reason
- ✅ Notification sound plays
- ✅ Tap notification triggers deep link
- ✅ Deep links open correct screens
- ✅ No missing or truncated text

---

## ⚠️ Phase 4: Error Handling Testing (MEDIUM) - 15 minutes

### Test 1: Network Failure During Quiz
1. [ ] Start new quiz
2. [ ] Answer 2 questions
3. [ ] **Disconnect network**:
   - Disable WiFi and mobile data
   - Or enable airplane mode
4. [ ] Try to submit answer
5. [ ] **Expected**:
   - Error message appears (e.g., "Network error, please try again")
   - No crash or frozen screen
   - App remains responsive
6. [ ] **Reconnect network**
7. [ ] Click "Retry" or "Try Again"
8. [ ] **Expected**: Request succeeds and answer submitted

### Test 2: API Timeout
1. [ ] Start quiz
2. [ ] Answer question
3. [ ] Simulate slow network (optional, if DevTools available):
   - Dev → Chrome DevTools → Network → Slow 3G
4. [ ] Submit answer
5. [ ] **Expected**:
   - Loading state shown
   - Timeout after ~30 seconds (or app-defined timeout)
   - Error message, not crash
   - Option to retry

### Test 3: Rapid Submission (Idempotency)
1. [ ] Start quiz
2. [ ] Answer question
3. [ ] Click "Submit" **multiple times quickly**
4. [ ] **Expected**:
   - Only submitted once (not multiple duplicates)
   - No duplicate records in database
   - App handles gracefully

### Test 4: Invalid State Recovery
1. [ ] Complete quiz to "Awaiting Approval"
2. [ ] Delete app cache (if possible) or simulate corrupted cache
3. [ ] Reopen app
4. [ ] **Expected**:
   - App doesn't crash
   - Fetches fresh state from server
   - Shows correct state

### Test 5: Timeout on Notification Send
1. [ ] Operator approves driver
2. [ ] (This can't be directly tested, but verify in logs)
3. [ ] Check server logs:
   ```bash
   # Look for any error messages
   grep -i "notification" server_logs.txt
   ```
4. [ ] **Expected**:
   - Approval still succeeds (notifications don't block)
   - If notification fails, error is logged but driver approval confirmed

### Success Criteria
- ✅ No crashes on network failures
- ✅ Error messages are user-friendly
- ✅ Retry mechanism works
- ✅ No duplicate submissions
- ✅ Graceful handling of timeouts
- ✅ Invalid state recovered

---

## 🔄 Phase 5: Regression Testing (MEDIUM) - 20 minutes

Verify that existing features still work after quiz integration.

### Test 1: Regular User Signup (Non-Driver)
1. [ ] Open app
2. [ ] Go to user signup (not driver)
3. [ ] Complete signup with email/phone
4. [ ] **Expected**:
   - Signup completes successfully
   - No quiz redirect (only drivers get quiz)
   - User dashboard accessible
   - User can place orders

### Test 2: Driver Signup Previous Flow
1. [ ] Go to driver signup
2. [ ] Complete 4 steps
3. [ ] **Expected**:
   - Signup completes
   - Auto-redirect to quiz (new behavior)
   - Quiz loads properly

### Test 3: Order Placement
1. [ ] **Existing approved driver** (pre-quiz):
   - Login as driver
   - Try to place/accept an order
2. [ ] **Expected**:
   - Order placement works normally
   - No new flow interruptions
   - Driver can accept and complete orders

### Test 4: Merchant Operations
1. [ ] Login as merchant
2. [ ] Create/manage orders
3. [ ] Check order history
4. [ ] **Expected**:
   - All merchant operations unaffected
   - Orders display correctly
   - No quiz interference

### Test 5: Operator Dashboard
1. [ ] Login as operator
2. [ ] Go to Driver Management
3. [ ] Check **existing approved drivers** (pre-quiz)
4. [ ] **Expected**:
   - Drivers display normally
   - No duplicate quiz entries
   - Approve/Reject buttons still functional

### Test 6: Leaderboard
1. [ ] Check driver leaderboard
2. [ ] Verify rankings correct
3. [ ] **Expected**:
   - Quiz doesn't affect leaderboard display
   - Rankings accurate
   - No performance degradation

### Success Criteria
- ✅ User signup (non-driver) unaffected
- ✅ Order placement works for all driver types
- ✅ Merchant operations unaffected
- ✅ Operator dashboard functional
- ✅ Leaderboard displays correctly
- ✅ No performance degradation
- ✅ No broken features

---

## 📊 Test Results Summary

### Completion Checklist
- [ ] Phase 1: Happy Path - **PASS/FAIL**
- [ ] Phase 2: Offline & Persistence - **PASS/FAIL**
- [ ] Phase 3: Notifications - **PASS/FAIL**
- [ ] Phase 4: Error Handling - **PASS/FAIL**
- [ ] Phase 5: Regression - **PASS/FAIL**

### Issues Found
If you find any issues, please document:

```
## Issue Report

**Issue #1**:
- **Title**: [Brief description]
- **Phase**: [Which testing phase]
- **Steps to Reproduce**:
  1. ...
  2. ...
  3. ...
- **Expected**: [What should happen]
- **Actual**: [What actually happened]
- **Logs**: [Relevant error messages]
- **Device**: [Device type, OS version]
- **Severity**: [Critical/High/Medium/Low]

## Solution (if known):
[Description of fix or workaround]
```

---

## 🐛 Debugging Commands

### Mobile Logs
```bash
# Run app with detailed logs
flutter run -v

# Filter logs
flutter logs | grep -i "quiz\|error\|exception"

# Watch specific class
flutter logs | grep "DriverQuizCubit"
```

### Server Logs
```bash
# Check server for API errors
grep -i "quiz\|error" server_logs.txt

# Check notifications
grep -i "notification" server_logs.txt
```

### Database
```bash
# Open database studio
bun run db:studio

# Check quiz attempts
SELECT * FROM driver_quiz_answer WHERE user_id = 'USER_ID';

# Check notifications sent
SELECT * FROM notification WHERE type IN ('DRIVER_APPROVED', 'DRIVER_DECLINED');
```

---

## 📝 Test Report Template

```markdown
# Test Report - Driver Quiz Integration

**Date**: [Date]
**Tester**: [Your Name]
**Device**: [Device/Emulator]
**OS Version**: [Android X.X / iOS X.X]
**App Version**: [Version]
**Server**: Local (localhost:3000)

## Summary
- Total Tests: 25+
- Passed: [ ]
- Failed: [ ]
- Skipped: [ ]
- Overall Result: [ ] PASS / [ ] FAIL

## Phase Results

### Phase 1: Happy Path
- Result: [ ] PASS / [ ] FAIL
- Issues: [List any issues]

### Phase 2: Offline & Persistence
- Result: [ ] PASS / [ ] FAIL
- Issues: [List any issues]

### Phase 3: Notifications
- Result: [ ] PASS / [ ] FAIL
- Issues: [List any issues]

### Phase 4: Error Handling
- Result: [ ] PASS / [ ] FAIL
- Issues: [List any issues]

### Phase 5: Regression
- Result: [ ] PASS / [ ] FAIL
- Issues: [List any issues]

## Known Issues

| # | Issue | Severity | Status |
|---|-------|----------|--------|
| 1 | [Issue description] | [Critical/High/Medium/Low] | Open/Fixed |

## Sign-Off

- [ ] All critical issues fixed
- [ ] All high issues reviewed
- [ ] Code review complete
- [ ] Ready for production

**Tested By**: [Name]
**Date**: [Date]
**Approved By**: [Name]
```

---

## ✅ Final Checklist

Before marking as complete:

- [ ] All 5 test phases executed
- [ ] No critical issues found
- [ ] High-priority issues documented
- [ ] Commits reviewed and clean
- [ ] Code follows AGENTS.md patterns
- [ ] No sensitive data in logs
- [ ] Performance acceptable
- [ ] Documentation complete
- [ ] Ready for deployment

---

**Happy Testing! 🚀**

For issues or questions, refer to `DRIVER_QUIZ_FINAL_SUMMARY.md` in the project root.

