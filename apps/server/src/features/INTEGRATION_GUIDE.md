# Leaderboard & Badge System Integration Guide

This file contains instructions for integrating the new leaderboard and badge services into the existing codebase.

## ✅ Completed - New Services Created

The following new service files have been created and are ready to use:

1. **DriverMetricsService** - `/apps/server/src/features/driver/services/driver-metrics-service.ts`
   - Calculates comprehensive driver performance metrics
   
2. **BadgeCriteriaEvaluator** - `/apps/server/src/features/badge/services/badge-criteria-evaluator.ts`
   - Static utility for evaluating badge qualification criteria
   
3. **BadgeAwardService** - `/apps/server/src/features/badge/services/badge-award-service.ts`
   - Orchestrates badge awarding and push notifications
   
4. **LeaderboardScoreCalculator** - `/apps/server/src/features/leaderboard/services/leaderboard-score-calculator.ts`
   - Calculates scores for each leaderboard category
   
5. **LeaderboardCalculationService** - `/apps/server/src/features/leaderboard/services/leaderboard-calculation-service.ts`
   - Batch processes leaderboard rankings for all periods/categories
   
6. **DriverPriorityService** - `/apps/server/src/features/driver/services/driver-priority-service.ts`
   - Sorts drivers by priority score (badges + leaderboard ranking)

---

## 📝 Required Integrations (Modify Existing Files)

### 1. Integrate Badge Awarding into Order Completion

**File:** `/apps/server/src/features/order/order-ws.ts`

**Location:** In `#handleOrderDone()` method, after line 457 (after wallet balance update, before log.info)

**Add:**
```typescript
// Award badges to driver after order completion
if (order.driverId) {
	const badgeAwardService = new BadgeAwardService(this.#svc.db, this.#repo);
	await badgeAwardService.evaluateAndAwardBadges(order.driverId, opts).catch((error) => {
		log.error({ error, driverId: order.driverId }, "[OrderRoom] Failed to award badges");
	});
}
```

**Imports to add at top:**
```typescript
import { BadgeAwardService } from "@/features/badge/services/badge-award-service";
```

**Why:** This automatically checks and awards badges to the driver after every completed order based on their current metrics.

---

### 2. Integrate Priority Matching into Order Assignment

**File:** `/apps/server/src/features/order/order-ws.ts`

**Location:** In `#handleOrderMatching()` method (around line 109-115, where nearby drivers are sorted)

**Current code** (approximate):
```typescript
// Find nearby available drivers
const nearbyDrivers = await this.#repo.driver.findNearbyAvailableDrivers({
	location: order.pickupLocation,
	radius: matchingRadius,
	genderPreference: order.genderPreference,
});
```

**Replace with:**
```typescript
// Find nearby available drivers
const nearbyDrivers = await this.#repo.driver.findNearbyAvailableDrivers({
	location: order.pickupLocation,
	radius: matchingRadius,
	genderPreference: order.genderPreference,
});

// Sort drivers by priority (badges + leaderboard rank)
const driverPriorityService = new DriverPriorityService(this.#svc.db);
const driverIds = nearbyDrivers.map(d => d.id);
const sortedDrivers = await driverPriorityService.sortDriversByPriority(driverIds, { tx });

// Reorder nearbyDrivers based on priority
const prioritizedDrivers = sortedDrivers
	.map(pd => nearbyDrivers.find(d => d.id === pd.driverId))
	.filter((d): d is NonNullable<typeof d> => d !== undefined);
```

**Imports to add at top:**
```typescript
import { DriverPriorityService } from "@/features/driver/services/driver-priority-service";
```

**Why:** This ensures high-performing drivers with badges and leaderboard rankings get priority in order matching.

---

### 3. Add Cloudflare Cron Trigger

**File:** `/apps/server/wrangler.toml`

**Add at the end:**
```toml
# Scheduled leaderboard updates
[triggers]
crons = [
	# Update leaderboards every hour
	"0 * * * *",
	# Full recalculation daily at midnight
	"0 0 * * *"
]
```

**Why:** Cloudflare Workers cron triggers will automatically call the scheduled handler to update leaderboards.

---

### 4. Create Cron Handler for Scheduled Leaderboard Updates

**New File:** `/apps/server/src/features/leaderboard/leaderboard-cron.ts`

```typescript
import type { ExecutionContext } from "@cloudflare/workers-types";
import { getServices } from "@/core/factory";
import { LeaderboardCalculationService } from "./services/leaderboard-calculation-service";
import { log } from "@/utils";

/**
 * Scheduled handler for leaderboard updates
 * Called by Cloudflare Workers cron trigger
 */
export async function handleLeaderboardCron(
	env: Env,
	ctx: ExecutionContext,
): Promise<Response> {
	try {
		log.info({}, "[LeaderboardCron] Starting scheduled leaderboard calculation");

		const svc = getServices();
		const leaderboardService = new LeaderboardCalculationService(svc.db);

		// Calculate all leaderboards (all periods and categories)
		await leaderboardService.calculateAllLeaderboards();

		log.info({}, "[LeaderboardCron] Completed scheduled leaderboard calculation");

		return new Response("Leaderboard calculation completed", { status: 200 });
	} catch (error) {
		log.error({ error }, "[LeaderboardCron] Failed to calculate leaderboards");
		return new Response("Leaderboard calculation failed", { status: 500 });
	}
}
```

**Then integrate into main worker:**

**File:** `/apps/server/src/index.ts`

**Add export:**
```typescript
export { handleLeaderboardCron as scheduled } from "@/features/leaderboard/leaderboard-cron";
```

**Why:** This handler is automatically called by Cloudflare Workers on the cron schedule to keep leaderboards up-to-date.

---

### 5. Implement Commission Reduction for High-Ranked Drivers

**File:** `/apps/server/src/features/order/order-ws.ts`

**Location:** In `#handleOrderDone()` method, around line 363-371 (commission calculation section)

**Current code:**
```typescript
// Calculate commission based on order type
let commissionRate = 0;
if (order.type === "RIDE") {
	commissionRate = commissionRates.rideCommissionRate || 0.15;
} else if (order.type === "DELIVERY") {
	commissionRate = commissionRates.deliveryCommissionRate || 0.15;
} else if (order.type === "FOOD") {
	commissionRate = commissionRates.foodCommissionRate || 0.2;
}
```

**Replace with:**
```typescript
// Calculate commission based on order type
let commissionRate = 0;
if (order.type === "RIDE") {
	commissionRate = commissionRates.rideCommissionRate || 0.15;
} else if (order.type === "DELIVERY") {
	commissionRate = commissionRates.deliveryCommissionRate || 0.15;
} else if (order.type === "FOOD") {
	commissionRate = commissionRates.foodCommissionRate || 0.2;
}

// Apply commission reduction from driver badges
if (order.driverId) {
	const driverBadges = await tx.query.userBadge.findMany({
		where: (f, op) => {
			const driver = await tx.query.driver.findFirst({
				where: (df, dop) => dop.eq(df.id, order.driverId),
			});
			return driver ? op.eq(f.userId, driver.userId) : undefined;
		},
		with: { badge: true },
	});

	// Find highest commission reduction from badges
	let maxReduction = 0;
	for (const userBadge of driverBadges) {
		const reduction = userBadge.badge.benefits?.commissionReduction ?? 0;
		if (reduction > maxReduction) {
			maxReduction = reduction;
		}
	}

	// Apply reduction (max 50% per schema)
	if (maxReduction > 0) {
		const originalRate = commissionRate;
		commissionRate = commissionRate * (1 - maxReduction);
		log.info(
			{ 
				driverId: order.driverId, 
				originalRate, 
				reduction: maxReduction, 
				finalRate: commissionRate 
			},
			"[OrderRoom] Applied badge commission reduction",
		);
	}
}
```

**Why:** Rewards high-performing drivers who have earned badges with commission reductions, increasing their earnings.

---

## ⚠️ Important Notes

1. **Transaction Safety:** All badge award and priority calculations support optional `{ tx }` parameter to work within existing transactions.

2. **Non-blocking Operations:** Badge notifications use `.catch()` to avoid failing order completions if push notifications fail.

3. **Performance:** 
   - Driver metrics calculations are optimized with parallel queries
   - Leaderboard calculations process all drivers in batches
   - Cron jobs run off the critical path

4. **Testing:** After integration, test these scenarios:
   - Complete an order → verify badge awarded if criteria met
   - Create new order → verify high-badge drivers get priority
   - Wait for cron trigger → verify leaderboards update
   - Complete order with badge → verify commission reduction applied

5. **Monitoring:** Watch logs for:
   - `[BadgeAwardService]` - Badge awarding events
   - `[DriverPriorityService]` - Priority sorting operations
   - `[LeaderboardCalculationService]` - Leaderboard calculations
   - `[LeaderboardCron]` - Scheduled job execution

---

## 📊 Expected Behavior After Integration

### Badge System
- ✅ Badges automatically awarded after every completed order
- ✅ Push notifications sent to drivers when badges earned
- ✅ Badge progress trackable via API
- ✅ Badge benefits (priority boost, commission reduction) applied automatically

### Leaderboard System
- ✅ Rankings updated hourly via cron job
- ✅ 6 categories tracked: RATING, VOLUME, EARNINGS, STREAK, ON-TIME, COMPLETION-RATE
- ✅ 6 periods: DAILY, WEEKLY, MONTHLY, QUARTERLY, YEARLY, ALL-TIME
- ✅ Top 100 drivers get priority boost in matching

### Driver Priority
- ✅ Badge priority boost: 0-100 points
- ✅ Leaderboard bonus: Top 100 weekly volume rankings (1st = 100, 100th = 1)
- ✅ Combined score determines matching priority

### Commission Reduction
- ✅ High-badge drivers pay less commission
- ✅ Max reduction: 50% (per schema validation)
- ✅ Automatically applied on order completion

---

## 🔄 Future Enhancements

1. **Web Dashboard:** Create operator UI to view/manage badges and leaderboards
2. **Badge Expiration:** Add time-limited badges that require renewal
3. **Team Leaderboards:** Add merchant team rankings
4. **Custom Periods:** Allow operators to define custom leaderboard periods
5. **Badge Combos:** Award special badges for earning multiple badges
6. **Leaderboard Prizes:** Auto-award coupons/bonuses to top performers

---

## 📚 Service Usage Examples

### Award Badges Manually (e.g., in admin panel)
```typescript
const badgeAwardService = new BadgeAwardService(db, repo);
const result = await badgeAwardService.evaluateAndAwardBadges(driverId);
console.log(`New badges: ${result.newBadges.length}`);
```

### Check Badge Progress
```typescript
const badgeAwardService = new BadgeAwardService(db, repo);
const progress = await badgeAwardService.checkBadgeProgress(driverId, badgeId);
console.log(`Progress: ${progress.toFixed(1)}%`);
```

### Calculate Leaderboard On-Demand
```typescript
const leaderboardService = new LeaderboardCalculationService(db);
await leaderboardService.calculateLeaderboardForPeriodAndCategory("WEEKLY", "VOLUME");
```

### Sort Drivers by Priority
```typescript
const priorityService = new DriverPriorityService(db);
const sorted = await priorityService.sortDriversByPriority(driverIds);
// sorted[0] = highest priority driver
```
