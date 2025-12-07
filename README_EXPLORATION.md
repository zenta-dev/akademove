# AkadeMove Merchant Availability Exploration - Documentation Index

This directory contains comprehensive analysis of the AkadeMove codebase's merchant status/availability management infrastructure.

## Documents Overview

### 1. **EXPLORATION_SUMMARY.txt** (11 KB)
**Best for**: Quick overview and decision-making
- Visual summary of findings
- Architecture insights organized by layer
- Critical patterns and rules
- Implementation phases with time estimates
- Risk mitigation strategies
- Infrastructure availability checklist

**Start here if you want**: A concise summary (5-minute read)

---

### 2. **MERCHANT_AVAILABILITY_ANALYSIS.md** (22 KB)
**Best for**: Deep dive and detailed understanding
- Complete structure of merchant tables and schemas
- Current implementation of merchant activation/deactivation
- WebSocket infrastructure analysis
- Web and mobile UI patterns
- Detailed gaps and missing features
- Current code organization with file paths
- Implementation recommendations by phase

**Start here if you want**: Full technical understanding (30-minute read)

---

### 3. **MERCHANT_AVAILABILITY_QUICK_REFERENCE.md** (7.3 KB)
**Best for**: Implementation and quick lookup
- Current state snapshot (what exists vs. what's missing)
- Key file locations organized by concern
- Critical patterns to follow (code examples)
- Implementation checklist with time estimates
- Testing strategy
- Risk mitigation details
- References to similar features in codebase

**Start here if you want**: Implementation guidance (10-minute read)

---

## Quick Navigation

### If you're asking...

**"What's the big picture?"**
→ Read EXPLORATION_SUMMARY.txt (sections: KEY FINDINGS, ARCHITECTURE INSIGHTS)

**"What needs to be built?"**
→ Read MERCHANT_AVAILABILITY_ANALYSIS.md (section 6: IMPLEMENTATION GAPS)

**"How do I implement this?"**
→ Read MERCHANT_AVAILABILITY_QUICK_REFERENCE.md (sections: IMPLEMENTATION CHECKLIST, CRITICAL PATTERNS)

**"Which files do I need to touch?"**
→ Read MERCHANT_AVAILABILITY_QUICK_REFERENCE.md (section: KEY FILE LOCATIONS)

**"How long will this take?"**
→ Read MERCHANT_AVAILABILITY_ANALYSIS.md (section 10: RECOMMENDED IMPLEMENTATION ORDER) or EXPLORATION_SUMMARY.txt (section: IMPLEMENTATION ROADMAP)

**"What are the risks?"**
→ Read MERCHANT_AVAILABILITY_ANALYSIS.md (section 11: TECHNICAL DEBT & CONSIDERATIONS) or EXPLORATION_SUMMARY.txt (section: RISKS & MITIGATIONS)

---

## Key Findings Summary

### What Currently Exists ✅
- Merchant table with `isActive` field (admin-only)
- Merchant order handlers (accept, reject, mark preparing/ready)
- WebSocket infrastructure via Cloudflare Durable Objects
- Driver availability service as reference pattern
- Web provider with TanStack Query
- Mobile BLoC pattern

### What's Missing ❌
- **Database**: `isOnline`, `isTakingOrders`, `operatingStatus` fields
- **API**: No toggle endpoints for merchant availability
- **WebSocket**: No `/ws/merchant/:id` route
- **Business Logic**: No `MerchantAvailabilityService`
- **UI**: No status toggle components (web/mobile)
- **Validation**: No merchant availability check before order assignment

---

## Implementation Overview

| Phase | Focus | Time | Complexity |
|-------|-------|------|-----------|
| 1 | Database & Schema | 2-4h | Low |
| 2 | Business Logic | 4-6h | Medium |
| 3 | WebSocket | 6-8h | High |
| 4 | Web UI | 4-6h | Medium |
| 5 | Mobile UI | 4-6h | Medium |
| **Total** | **Full Implementation** | **20-30h** | **~1 week** |

---

## Critical Reference Files in Codebase

### Must Read
1. `apps/server/src/features/driver/services/driver-availability-service.ts` (287 lines)
   - Template for MerchantAvailabilityService
   - Shows patterns for: setOnlineStatus(), isAvailableForOrders(), canBeAssigned()

2. `apps/server/src/features/order/order-ws.ts` (1123 lines)
   - WebSocket handler with transaction wrapping
   - Broadcast pattern example
   - Error handling with rollback

3. `apps/server/src/core/tables/merchant.ts` (108 lines)
   - Current merchant table structure
   - Existing indexes to follow

### Should Reference
- `apps/web/src/providers/merchant.tsx` (50 lines) - Web state management
- `apps/web/src/routes/dash/merchant/orders.tsx` - Web order handling
- `apps/mobile/lib/features/merchant/presentation/cubits/merchant_cubit.dart` - Mobile state

---

## How to Use These Documents

### For Stakeholders/PMs
1. Read EXPLORATION_SUMMARY.txt (2 min)
2. Review "What's Missing" section
3. Review "Implementation Roadmap"
4. Discuss time estimate (20-30 hours) and phase breakdown

### For Architects
1. Read MERCHANT_AVAILABILITY_ANALYSIS.md (20 min)
2. Review "Architecture Insights" in EXPLORATION_SUMMARY.txt
3. Check "Critical Patterns & Rules" in EXPLORATION_SUMMARY.txt
4. Identify integration points and dependencies

### For Developers (Frontend)
1. Read MERCHANT_AVAILABILITY_QUICK_REFERENCE.md (5 min)
2. Review Web UI section in MERCHANT_AVAILABILITY_ANALYSIS.md
3. Check "Key File Locations" for web files
4. Reference driver profile screen for toggle pattern

### For Developers (Backend)
1. Read MERCHANT_AVAILABILITY_QUICK_REFERENCE.md (5 min)
2. Review "Critical Patterns to Follow" section
3. Review Phase 1-3 in implementation checklist
4. Study DriverAvailabilityService and OrderRoom

### For QA/Testing
1. Read "Testing Strategy" in MERCHANT_AVAILABILITY_QUICK_REFERENCE.md
2. Review "Risks & Mitigations" in EXPLORATION_SUMMARY.txt
3. Plan test cases for each phase

---

## Key Architectural Decisions

### Database
- **Keep `isActive`** for account activation (admin-only)
- **Add `isOnline`** for real-time availability toggle
- **Add `isTakingOrders`** for independent order-taking control
- **Add `operatingStatus`** enum for OPEN/CLOSED/BREAK/MAINTENANCE

### Real-Time
- Use **existing WebSocket infrastructure** (Durable Objects)
- Follow **OrderRoom broadcast pattern**
- Add **new `/ws/merchant/:id` route** for merchant status
- Implement **auto-reject when merchant goes offline**

### API
- Follow **oRPC + Zod pattern** for type safety
- Use **requireRoles() middleware** for RBAC
- Wrap mutations in **db.transaction()**
- Invalidate **merchant cache** on status change

### UI
- Reference **driver profile** for toggle implementation
- Use **TanStack Query + React Context** on web
- Use **BLoC + Cubits** on mobile
- Add **real-time status indicator** on dashboard

---

## Risk Management

Top 5 Risks and Mitigations:

1. **Breaking existing merchant activation**
   - Keep `isActive` for account, add `isOnline` for availability

2. **Orders assigned to offline merchants**
   - Add validation check before assignment
   - Auto-reject with refund

3. **Migration breaking backward compatibility**
   - Make new fields nullable
   - Backfill in subsequent migration

4. **WebSocket broadcast overload**
   - Use message debouncing
   - Aggregate status changes

5. **Timezone issues**
   - Store timezone with merchant
   - Validate on both client & server

See EXPLORATION_SUMMARY.txt for details.

---

## Next Steps

1. ✅ Read EXPLORATION_SUMMARY.txt
2. ✅ Review MERCHANT_AVAILABILITY_ANALYSIS.md section 1-5
3. ✅ Discuss findings with team
4. ✅ Prioritize phases and assign developers
5. ✅ Start Phase 1 (database schema)
6. ✅ Reference DriverAvailabilityService during implementation
7. ✅ Follow patterns in OrderRoom WebSocket
8. ✅ Test each phase before moving to next

---

## Document Metadata

- **Generated**: 2025-12-07
- **Codebase**: AkadeMove (Turbo monorepo)
- **Files Analyzed**: 50+
- **Total Lines Documented**: 900+
- **Architecture**: Hono + oRPC + PostgreSQL + WebSocket + React + Flutter
- **Status**: Complete and ready for implementation

---

## Questions?

Refer to the specific section in the detailed documents:
- **Schema/Database**: MERCHANT_AVAILABILITY_ANALYSIS.md § 1
- **Current Implementation**: MERCHANT_AVAILABILITY_ANALYSIS.md § 2
- **WebSocket**: MERCHANT_AVAILABILITY_ANALYSIS.md § 3
- **UI Patterns**: MERCHANT_AVAILABILITY_ANALYSIS.md § 4
- **Gaps**: MERCHANT_AVAILABILITY_ANALYSIS.md § 6
- **Code Organization**: MERCHANT_AVAILABILITY_ANALYSIS.md § 7
- **Implementation**: MERCHANT_AVAILABILITY_QUICK_REFERENCE.md § Implementation Checklist
