# Driver Quiz Mobile - Complete Testing Guide

## Testing Status
All P1 features have been implemented and are ready for testing.

## Test Scenarios

### Start Screen Tests
```
✅ Feature: Quiz Information Box Display
- Tap "Start Quiz" without selecting anything
- Expected: Quiz info box visible with 5 bullet points:
  1. "You will be presented with multiple-choice questions"
  2. "Cover topics: Safety, Navigation, Customer Service, Platform Rules"
  3. "Passing score: 70%"
  4. "You must pass this quiz to be eligible for driver approval"
  5. "Take your time - there is no time limit"

✅ Feature: Start Button
- Tap "Start Quiz" button
- Expected: 
  - Loading spinner appears
  - Transitions to quiz screen
  - First question displays with options
```

### Quiz Screen - Navigation Tests
```
✅ Feature: Question Navigation Buttons
- Notice numbered buttons (1-N) below question card
- Expected:
  - Current question button is highlighted in primary color
  - Answered questions have green background
  - Unanswered questions have outline style
  
✅ Feature: Jump to Question
- Click on a question number button
- Expected:
  - Screen jumps to that question
  - Question text changes
  - Selected answer is cleared
  - Progress updates
```

### Quiz Screen - Answer Submission Tests
```
✅ Feature: Answer Feedback
- Select an answer (radio button lights up)
- Expected:
  - Button text shows "Submit Answer"
  - Selection is highlighted
  
✅ Feature: Submit Answer
- Tap "Submit Answer" button
- Expected:
  - Loading spinner appears on button
  - Server responds with correctness and points
  - Green or red feedback box appears:
    - "Correct!" + "+X points earned" (green background)
    - "Incorrect" (red background)
  - Options become disabled
  - "Next" button appears

✅ Feature: Sequential Navigation
- Answer Question 1 → "Next" appears
- Tap "Next" → Goes to Question 2
- Navigate through all questions
- Expected:
  - On last question, "Next" changes to "Complete Quiz" button
  - Button is green/highlighted when all questions answered
```

### Result Screen - PASSED Tests
```
✅ Feature: Passed Quiz Result
- Complete quiz with score >= 70%
- Expected:
  - Green circle with checkmark icon
  - "Congratulations!" title
  - "You have successfully passed the driver knowledge quiz!" message
  - Score breakdown displayed:
    - Score: XX%
    - Correct Answers: X/N
    - Points Earned: XX
    - Total Points: XXX
  - Button labeled with arrow → "Go to Sign In"

✅ Feature: Navigation After Passing
- Tap "Go to Sign In" button
- Expected:
  - Navigates to /sign-in route
  - User can complete sign-in process
```

### Result Screen - FAILED Tests
```
✅ Feature: Failed Quiz Result
- Complete quiz with score < 70%
- Expected:
  - Red circle with X icon
  - "Quiz Not Passed" title
  - "Don't worry, you can try again!" message
  - Score breakdown displayed (same as passed)
  - Alert box appears (red background):
    - Title: "Not Passed"
    - Message: "You need at least 70% to pass. Please review the material and try again."
  - Button labeled with refresh icon → "Try Again"

✅ Feature: Retry After Failing
- Tap "Try Again" button
- Expected:
  - Quiz resets to initial state
  - Start screen appears
  - Can tap "Start Quiz" to begin new attempt
  - New attempt clears old answers
  - Progress resets to 0%
```

### Error Handling Tests
```
✅ Feature: Answer Without Selection
- Try to submit answer without selecting option
- Expected:
  - Error message displayed: "Please select an answer before submitting"
  - Loading spinner does NOT appear
  - Quiz continues from same question

✅ Feature: Network Error
- Simulate network disconnection
- Try to submit answer
- Expected:
  - Error dialog/snackbar appears
  - User can retry submission
  - No silent failures

✅ Feature: App Crash Recovery
- During quiz, force close app
- Reopen app
- Expected:
  - Quiz restores to last known state
  - Can continue from last question
  - Progress is preserved
```

### Cache & Data Tests
```
✅ Feature: Cache Clearing After Completion
- Complete quiz and reach result screen
- Close app and reopen
- Navigate back to quiz screen
- Expected:
  - Old quiz data is NOT shown
  - Fresh quiz can be started
  - Cache is properly cleared

✅ Feature: Multiple Attempts
- Complete first attempt (pass or fail)
- Start new attempt
- Expected:
  - Clean slate for new quiz
  - Old answers not visible
  - Progress bar starts at 0%
```

### Visual & UX Tests
```
✅ Feature: Responsive Layout
- Test on different screen sizes
- Rotate device (portrait ↔ landscape)
- Expected:
  - All text readable
  - Buttons properly sized
  - Navigation buttons wrap if needed
  - Scrolling works smoothly

✅ Feature: Loading States
- During any API call
- Expected:
  - Button shows loading spinner
  - Button is disabled during operation
  - User sees visual feedback

✅ Feature: Color Coding
- Passed result: Green colors
- Failed result: Red colors
- Correct answer: Green feedback
- Incorrect answer: Red feedback
- Current question: Primary color highlight
- Answered questions: Green background
```

## Quick Test Checklist

### Pre-Test
- [ ] App builds without errors: `flutter build apk` or `flutter run`
- [ ] No console errors during startup
- [ ] No runtime crashes on screens

### Start Screen
- [ ] Info box displays with all 5 bullet points
- [ ] "Start Quiz" button is clickable
- [ ] Loading state works during quiz load

### Quiz Flow
- [ ] Questions display correctly
- [ ] Category badges show correct colors
- [ ] Previous/Next buttons work
- [ ] Navigation buttons (1-N) appear and work
- [ ] Selected answer highlights correctly

### Answer Feedback
- [ ] Correct answer shows green "Correct!" with points
- [ ] Incorrect answer shows red "Incorrect"
- [ ] Points are accurate
- [ ] Options disable after answer
- [ ] "Next" button appears after submit

### Result Screen
- [ ] Passed: Shows "Congratulations!" with correct stats
- [ ] Failed: Shows "Quiz Not Passed" with alert
- [ ] Score calculations are correct
- [ ] Pass button navigates to sign-in
- [ ] Fail button allows retry

### Error Handling
- [ ] Attempting submit without answer shows error
- [ ] Network errors handled gracefully
- [ ] No silent failures

## Test Execution Order

1. **Smoke Test** (2 mins)
   - Start app → See start screen
   - Tap "Start Quiz" → See first question
   - Tap "Complete Quiz" (skip to end)

2. **Happy Path - PASS** (5 mins)
   - Start quiz
   - Answer all questions correctly
   - Verify "Congratulations" screen
   - Verify navigation to sign-in

3. **Happy Path - FAIL** (5 mins)
   - Start new quiz
   - Answer some incorrectly
   - Verify "Quiz Not Passed" screen
   - Verify "Try Again" works

4. **Edge Cases** (10 mins)
   - Try submit without answer
   - Navigate between questions
   - Check cache after completion
   - Rotate device mid-quiz

5. **Error Scenarios** (5 mins)
   - Simulate network error
   - Force close and reopen
   - Check error recovery

## Expected Results

All tests should pass with:
- ✅ No crashes
- ✅ All buttons working
- ✅ Correct visual feedback
- ✅ Proper navigation
- ✅ Accurate scoring
- ✅ Clean state management
- ✅ Graceful error handling

## Performance Expectations

- App start: < 3 seconds
- Quiz load: < 2 seconds
- Answer submit: < 1 second
- Screen transitions: < 500ms
- Navigation between questions: < 200ms

## Device Testing

- [ ] Android Phone (< 5.5", small screen)
- [ ] Android Tablet (> 7", large screen)
- [ ] iOS Phone (6-8" screen)
- [ ] iOS Tablet (iPad, 10" screen)

## Sign-Off

Once all tests pass:
1. Update test results in PR
2. Add "✅ Ready for QA" comment
3. Request review from team
4. Deploy to beta when approved

---

**Testing Responsibility**: QA Team / Developer (self-testing)
**Expected Duration**: 30-45 minutes
**Success Criteria**: All tests passing without crashes
