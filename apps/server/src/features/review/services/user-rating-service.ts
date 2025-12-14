import { avg, eq } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

/**
 * Service for calculating and updating user ratings based on reviews.
 * Users are rated by drivers and merchants after order completion.
 */
export class UserRatingService {
	/**
	 * Calculate average rating for a user from all reviews they've received
	 */
	static async calculateUserRating(
		db: DatabaseService | DatabaseTransaction,
		userId: string,
	): Promise<number> {
		const result = await db
			.select({
				avg: avg(tables.review.score),
			})
			.from(tables.review)
			.where(eq(tables.review.toUserId, userId));

		const avgScore = result[0]?.avg ?? 0;
		return toNumberSafe(avgScore);
	}

	/**
	 * Update the user's rating in the database based on their received reviews.
	 * This should be called after a new review is submitted for a user.
	 */
	static async updateUserRating(
		db: DatabaseService | DatabaseTransaction,
		userId: string,
	): Promise<number> {
		try {
			const newRating = await UserRatingService.calculateUserRating(db, userId);

			await db
				.update(tables.user)
				.set({
					rating: newRating,
					updatedAt: new Date(),
				})
				.where(eq(tables.user.id, userId));

			logger.info(
				{ userId, newRating },
				"[UserRatingService] User rating updated",
			);

			return newRating;
		} catch (error) {
			logger.error(
				{ error, userId },
				"[UserRatingService] Failed to update user rating",
			);
			throw error;
		}
	}
}
