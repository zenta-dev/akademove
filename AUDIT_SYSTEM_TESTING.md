# Audit System Testing Guide

## ✅ System Status: READY FOR TESTING

### Prerequisites Completed
- [x] Database migrations applied (0009_yummy_rictor.sql)
- [x] All code passes biome lint/format checks
- [x] Route types generated (audit-logs route available)
- [x] API endpoint registered at `/api/audit-logs`

---

## 🧪 Test Plan

### Test 1: User Ban Audit Logging

**Objective**: Verify that user ban operations are logged with reason and metadata

**Steps**:
```bash
# 1. Start the server
bun run dev:server

# 2. Get authentication token (as ADMIN user)
curl -X POST http://localhost:3000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@example.com","password":"password"}'

# 3. Ban a user
curl -X PUT http://localhost:3000/api/users/{userId} \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "banReason": "Violated community guidelines - harassment",
    "banExpiresIn": 86400000
  }'

# 4. Check audit logs
curl -X GET "http://localhost:3000/api/audit-logs?tableName=user&recordId={userId}" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- Status: 200 OK
- Response contains audit log entry with:
  - `operation: "UPDATE"`
  - `tableName: "user"`
  - `metadata.reason: "Violated community guidelines - harassment"`
  - `before.bannedUntil: null`
  - `after.bannedUntil: [future timestamp]`
  - `updatedById: [admin user ID]`
  - `ipAddress: [request IP]`

---

### Test 2: User Unban Audit Logging

**Steps**:
```bash
# Unban the user
curl -X PUT http://localhost:3000/api/users/{userId} \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "bannedUntil": null
  }'

# Check audit logs
curl -X GET "http://localhost:3000/api/audit-logs?tableName=user&recordId={userId}&operation=UPDATE" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- New audit entry with:
  - `metadata.reason: "User unbanned by admin"`
  - `before.bannedUntil: [previous timestamp]`
  - `after.bannedUntil: null`

---

### Test 3: User Role Change Audit Logging

**Steps**:
```bash
# Change user role from USER to DRIVER
curl -X PUT http://localhost:3000/api/users/{userId} \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "role": "DRIVER"
  }'

# Check audit logs
curl -X GET "http://localhost:3000/api/audit-logs?tableName=user&recordId={userId}" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- Audit entry shows:
  - `before.role: "USER"`
  - `after.role: "DRIVER"`
  - `metadata.reason: "Role changed from USER to DRIVER"`

---

### Test 4: Wallet Manual Adjustment Audit Logging

**Steps**:
```bash
# Manually adjust wallet balance
curl -X PUT http://localhost:3000/api/wallets/{walletId} \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "balance": 50000
  }'

# Check audit logs
curl -X GET "http://localhost:3000/api/audit-logs?tableName=wallet&recordId={walletId}" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- Audit entry shows:
  - `operation: "UPDATE"`
  - `tableName: "wallet"`
  - `metadata.reason: "Manual balance adjustment by admin"`
  - `before.balance: [old value]`
  - `after.balance: "50000"`

---

### Test 5: Wallet Transfer Audit Logging

**Steps**:
```bash
# Transfer funds between wallets
curl -X POST http://localhost:3000/api/wallets/transfer \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "fromWalletId": "{walletId1}",
    "toWalletId": "{walletId2}",
    "amount": 10000,
    "reason": "Test transfer"
  }'

# Check audit logs for both wallets
curl -X GET "http://localhost:3000/api/audit-logs?tableName=wallet" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- Two audit entries created:
  1. Sender wallet: balance decreased by 10000
  2. Recipient wallet: balance increased by 10000

---

### Test 6: Audit Log Filtering

**Steps**:
```bash
# Filter by date range
curl -X GET "http://localhost:3000/api/audit-logs?startDate=2025-12-01&endDate=2025-12-31" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Filter by user
curl -X GET "http://localhost:3000/api/audit-logs?updatedById={adminUserId}" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Filter by operation type
curl -X GET "http://localhost:3000/api/audit-logs?operation=UPDATE" \
  -H "Authorization: Bearer YOUR_TOKEN"

# Paginate results
curl -X GET "http://localhost:3000/api/audit-logs?page=1&limit=10" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- All queries return filtered results matching criteria
- Pagination works correctly (50 items per page default)

---

### Test 7: Web Dashboard UI

**Steps**:
1. Start web app: `bun run dev:web`
2. Login as ADMIN user at `http://localhost:5173`
3. Navigate to `/dash/admin/audit-logs`
4. Verify table displays all audit logs
5. Click "View Details" on any row
6. Check modal shows:
   - Metadata (IP, User Agent, Session ID, Reason)
   - Before/After JSON comparison
7. Test search by record ID
8. Test table sorting by clicking column headers
9. Test responsive design on mobile viewport

**Expected Results**:
- ✅ Table loads with audit logs
- ✅ Color-coded badges (INSERT=green, UPDATE=blue, DELETE=red)
- ✅ Detail modal displays all metadata
- ✅ JSON diff viewer highlights changes
- ✅ Search filters results
- ✅ Column visibility adapts to screen size

---

### Test 8: Transaction Rollback Safety

**Objective**: Verify audit logs rollback if main operation fails

**Steps**:
```bash
# Attempt invalid user update (should fail validation)
curl -X PUT http://localhost:3000/api/users/{userId} \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "role": "INVALID_ROLE"
  }'

# Check audit logs
curl -X GET "http://localhost:3000/api/audit-logs?tableName=user&recordId={userId}" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**Expected Results**:
- User update fails with validation error
- NO audit log entry created (transaction rolled back)

---

### Test 9: Context-less Degradation

**Objective**: Verify system works when context not provided

**Manual Test**:
1. Temporarily remove `context` parameter from a repository call
2. Execute operation
3. Verify operation succeeds but no audit log created
4. Restore `context` parameter

**Expected Results**:
- Operation completes successfully
- No crash or error thrown
- Audit logging gracefully skipped

---

## 🎯 Success Criteria

### Must Pass (Critical)
- [ ] User ban/unban operations logged with reason
- [ ] User role changes logged with before/after values
- [ ] Wallet balance adjustments logged
- [ ] Wallet transfers create two audit entries
- [ ] All audit logs include IP address and timestamp
- [ ] Audit logs survive transaction rollbacks
- [ ] Web UI displays audit logs correctly
- [ ] Detail modal shows metadata and JSON diff

### Should Pass (Important)
- [ ] Search/filter functionality works
- [ ] Pagination handles large datasets
- [ ] Mobile responsive design works
- [ ] Performance acceptable (<500ms query time)

### Nice to Have (Optional)
- [ ] Export to CSV functionality
- [ ] Advanced filtering (multiple tables, date ranges)
- [ ] Real-time audit log updates

---

## 📊 Database Verification

### Check Audit Tables Exist
```sql
-- Connect to database
psql $DATABASE_URL

-- List audit tables
\dt am___*_audit_log

-- Check user audit log structure
\d am___user_audit_log

-- Check wallet audit log structure
\d am___wallet_audit_log

-- Query recent audit logs
SELECT 
  id, 
  operation, 
  "recordId", 
  "updatedAt", 
  "updatedById",
  metadata->>'reason' as reason
FROM am___user_audit_log
ORDER BY "updatedAt" DESC
LIMIT 10;
```

**Expected Output**:
- 6 audit tables: configurations, contact, coupon, report, user, wallet
- Each table has indexes on: recordId, updatedAt, updatedById, ipAddress
- JSONB columns: before, after, metadata

---

## 🐛 Troubleshooting

### Issue: Migration not applied
```bash
cd apps/server
bun run db:migrate
```

### Issue: Route types missing
```bash
cd apps/web
bun run typegen  # or equivalent
```

### Issue: Server won't start
```bash
# Check for syntax errors
bun run check

# Check environment variables
cat .env | grep DATABASE_URL
```

### Issue: 401 Unauthorized
- Verify authentication token is valid
- Check user has required permissions (`configurations:list`)

### Issue: Audit logs not appearing
1. Check `context` is passed to repository methods
2. Verify user is authenticated (context.user exists)
3. Check transaction completed successfully
4. Query database directly to confirm logs exist

---

## 📝 Test Results Template

### Date: _____________
### Tester: _____________

| Test # | Test Name | Status | Notes |
|--------|-----------|--------|-------|
| 1 | User Ban Audit | ⬜ PASS / ⬜ FAIL | |
| 2 | User Unban Audit | ⬜ PASS / ⬜ FAIL | |
| 3 | Role Change Audit | ⬜ PASS / ⬜ FAIL | |
| 4 | Wallet Adjustment | ⬜ PASS / ⬜ FAIL | |
| 5 | Wallet Transfer | ⬜ PASS / ⬜ FAIL | |
| 6 | Audit Filtering | ⬜ PASS / ⬜ FAIL | |
| 7 | Web Dashboard UI | ⬜ PASS / ⬜ FAIL | |
| 8 | Rollback Safety | ⬜ PASS / ⬜ FAIL | |
| 9 | Context Degradation | ⬜ PASS / ⬜ FAIL | |

**Overall Status**: ⬜ ALL PASS / ⬜ PARTIAL / ⬜ FAILED

**Blocker Issues**: _____________________________________________

**Recommendations**: _____________________________________________

---

## 🚀 Ready for Production Checklist

- [ ] All tests pass (9/9)
- [ ] Performance benchmarks met (<500ms)
- [ ] Mobile UI tested on real devices
- [ ] Edge cases handled (null values, empty strings, special characters)
- [ ] Documentation reviewed
- [ ] Stakeholder approval obtained
- [ ] Database backup completed
- [ ] Rollback plan documented
