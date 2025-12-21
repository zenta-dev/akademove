import type { ExecutionContext } from "@cloudflare/workers-types";
import { avg, eq, isNotNull } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { tables } from "@/core/services/db";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

/**
 * Rating Recalculation Cron Handler
 * Schedule: Every 5 minutes
 *
 * Purpose:
 * - Recalculate and sync ratings for all users (customers), drivers, and merchants
 * - Ensures ratings stay in sync even if individual review updates fail
 * - Acts as a safety net for the real-time rating updates in review-handler
 *
 * This handles cases where:
 * 1. Rating update fails during review submission
 * 2. Database inconsistencies between user.rating and driver.rating
 * 3. Historical data migrations or corrections
 */
export async function handleRatingRecalculationCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	const startTime = Date.now();

	try {
		logger.info({}, "[RatingRecalculationCron] Starting rating recalculation");

		const svc = getServices();

		const [customerCount, driverCount, merchantCount] = await Promise.all([
			recalculateCustomerRatings(svc.db),
			recalculateDriverRatings(svc.db),
			recalculateMerchantRatings(svc.db),
		]);

		const duration = Date.now() - startTime;

		logger.info(
			{
				customerCount,
				driverCount,
				merchantCount,
				duration,
			},
			"[RatingRecalculationCron] Completed rating recalculation",
		);

		return new Response(
			`Rating recalculation completed. Updated: ${customerCount} customers, ${driverCount} drivers, ${merchantCount} merchants. Duration: ${duration}ms`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error, duration: Date.now() - startTime },
			"[RatingRecalculationCron] Failed to recalculate ratings",
		);
		return new Response("Rating recalculation failed", { status: 500 });
	}
}

/**
 * Recalculate ratings for all customers (users who have received reviews)
 * Updates user.rating based on average of all reviews where toUserId = user.id
 */
async function recalculateCustomerRatings(
	db: ReturnType<typeof getServices>["db"],
): Promise<number> {
	let updatedCount = 0;

	try {
		// Get all users who have received at least one review
		const usersWithReviews = await db
			.selectDistinct({ userId: tables.review.toUserId })
			.from(tables.review)
			.where(isNotNull(tables.review.toUserId));

		if (usersWithReviews.length === 0) {
			logger.info({}, "[RatingRecalculationCron] No customers with reviews");
			return 0;
		}

		logger.info(
			{ count: usersWithReviews.length },
			"[RatingRecalculationCron] Found customers with reviews",
		);

		// Process each user
		for (const { userId } of usersWithReviews) {
			try {
				// Calculate average rating from all reviews
				const result = await db
					.select({ avg: avg(tables.review.score) })
					.from(tables.review)
					.where(eq(tables.review.toUserId, userId));

				const newRating = toNumberSafe(result[0]?.avg ?? 0);

				// Update user rating
				await db
					.update(tables.user)
					.set({
						rating: newRating,
						updatedAt: new Date(),
					})
					.where(eq(tables.user.id, userId));

				updatedCount++;
			} catch (error) {
				logger.error(
					{ error, userId },
					"[RatingRecalculationCron] Failed to update customer rating",
				);
			}
		}

		return updatedCount;
	} catch (error) {
		logger.error(
			{ error },
			"[RatingRecalculationCron] Failed to recalculate customer ratings",
		);
		throw error;
	}
}

/**
 * Recalculate ratings for all drivers
 * Updates both user.rating and driver.rating to keep them in sync
 */
async function recalculateDriverRatings(
	db: ReturnType<typeof getServices>["db"],
): Promise<number> {
	let updatedCount = 0;

	try {
		// Get all drivers
		const drivers = await db.query.driver.findMany({
			columns: {
				id: true,
				userId: true,
			},
		});

		if (drivers.length === 0) {
			logger.info({}, "[RatingRecalculationCron] No drivers found");
			return 0;
		}

		logger.info(
			{ count: drivers.length },
			"[RatingRecalculationCron] Found drivers to process",
		);

		// Process each driver
		for (const driver of drivers) {
			try {
				// Calculate average rating from all reviews for this driver's user account
				const result = await db
					.select({ avg: avg(tables.review.score) })
					.from(tables.review)
					.where(eq(tables.review.toUserId, driver.userId));

				const newRating = toNumberSafe(result[0]?.avg ?? 0);

				// Update both user.rating and driver.rating atomically
				await db.transaction(async (tx) => {
					await Promise.all([
						tx
							.update(tables.user)
							.set({
								rating: newRating,
								updatedAt: new Date(),
							})
							.where(eq(tables.user.id, driver.userId)),
						tx
							.update(tables.driver)
							.set({
								rating: newRating,
								updatedAt: new Date(),
							})
							.where(eq(tables.driver.id, driver.id)),
					]);
				});

				updatedCount++;
			} catch (error) {
				logger.error(
					{ error, driverId: driver.id, userId: driver.userId },
					"[RatingRecalculationCron] Failed to update driver rating",
				);
			}
		}

		return updatedCount;
	} catch (error) {
		logger.error(
			{ error },
			"[RatingRecalculationCron] Failed to recalculate driver ratings",
		);
		throw error;
	}
}

/**
 * Recalculate ratings for all merchants
 * Updates merchant.rating based on average of all reviews where toUserId = merchant.userId
 */
async function recalculateMerchantRatings(
	db: ReturnType<typeof getServices>["db"],
): Promise<number> {
	let updatedCount = 0;

	try {
		// Get all merchants
		const merchants = await db.query.merchant.findMany({
			columns: {
				id: true,
				userId: true,
			},
		});

		if (merchants.length === 0) {
			logger.info({}, "[RatingRecalculationCron] No merchants found");
			return 0;
		}

		logger.info(
			{ count: merchants.length },
			"[RatingRecalculationCron] Found merchants to process",
		);

		// Process each merchant
		for (const merchant of merchants) {
			try {
				// Calculate average rating from all reviews for this merchant's user account
				const result = await db
					.select({ avg: avg(tables.review.score) })
					.from(tables.review)
					.where(eq(tables.review.toUserId, merchant.userId));

				const newRating = toNumberSafe(result[0]?.avg ?? 0);

				// Update both user.rating and merchant.rating atomically
				await db.transaction(async (tx) => {
					await Promise.all([
						tx
							.update(tables.user)
							.set({
								rating: newRating,
								updatedAt: new Date(),
							})
							.where(eq(tables.user.id, merchant.userId)),
						tx
							.update(tables.merchant)
							.set({
								rating: newRating,
								updatedAt: new Date(),
							})
							.where(eq(tables.merchant.id, merchant.id)),
					]);
				});

				updatedCount++;
			} catch (error) {
				logger.error(
					{ error, merchantId: merchant.id, userId: merchant.userId },
					"[RatingRecalculationCron] Failed to update merchant rating",
				);
			}
		}

		return updatedCount;
	} catch (error) {
		logger.error(
			{ error },
			"[RatingRecalculationCron] Failed to recalculate merchant ratings",
		);
		throw error;
	}
}
