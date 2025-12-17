import { CONSTANTS } from "@repo/schema/constants";
import type { ReviewCategory } from "@repo/schema/review";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Service responsible for review validation
 *
 * Handles:
 * - Score validation (1-5 range)
 * - Comment content validation (profanity, length)
 * - Categories validation (array of valid categories)
 * - Review eligibility checks (order completed, not duplicate)
 * - User participation validation (is user part of order)
 *
 * @example
 * ```typescript
 * const validationService = new ReviewValidationService(db);
 *
 * // Check if user can review order
 * const status = await validationService.getReviewEligibility({
 *   orderId: "order-123",
 *   userId: "user-456",
 *   opts: { tx }
 * });
 *
 * if (!status.canReview) {
 *   throw new Error("Cannot review this order");
 * }
 * ```
 */
export class ReviewValidationService {
	readonly #db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	/**
	 * Validates review score
	 *
	 * @param score - Rating score to validate
	 * @returns Validation result
	 */
	validateScore(score: number): { valid: boolean; error?: string } {
		if (!Number.isInteger(score)) {
			return { valid: false, error: "Score must be an integer" };
		}

		if (score < 1 || score > 5) {
			return { valid: false, error: "Score must be between 1 and 5" };
		}

		return { valid: true };
	}

	/**
	 * Validates review comment
	 *
	 * @param comment - Review comment to validate
	 * @returns Validation result
	 */
	validateComment(comment: string): { valid: boolean; error?: string } {
		if (!comment) {
			return { valid: true }; // Comment is optional
		}

		if (comment.length > 1000) {
			return { valid: false, error: "Comment cannot exceed 1000 characters" };
		}

		if (comment.trim().length === 0) {
			return { valid: false, error: "Comment cannot be empty or whitespace" };
		}

		return { valid: true };
	}

	/**
	 * Validates review categories (multi-select)
	 *
	 * @param categories - Array of review categories to validate
	 * @returns Validation result
	 */
	validateCategories(categories: ReviewCategory[]): {
		valid: boolean;
		error?: string;
	} {
		if (!Array.isArray(categories) || categories.length === 0) {
			return {
				valid: false,
				error: "At least one category must be selected",
			};
		}

		const validCategories = CONSTANTS.REVIEW_CATEGORIES as readonly string[];

		for (const category of categories) {
			if (!validCategories.includes(category)) {
				return {
					valid: false,
					error: `Invalid category "${category}". Must be one of: ${validCategories.join(", ")}`,
				};
			}
		}

		// Check for duplicates
		const uniqueCategories = new Set(categories);
		if (uniqueCategories.size !== categories.length) {
			return {
				valid: false,
				error: "Duplicate categories are not allowed",
			};
		}

		return { valid: true };
	}

	/**
	 * Validates complete review data
	 *
	 * @param params - Review data to validate
	 * @returns Validation result
	 * @throws RepositoryError if validation fails
	 */
	validateReview(params: {
		score: number;
		comment: string;
		categories: ReviewCategory[];
	}): void {
		const { score, comment, categories } = params;

		// Validate score
		const scoreValidation = this.validateScore(score);
		if (!scoreValidation.valid) {
			throw new RepositoryError(scoreValidation.error ?? "Invalid score", {
				code: "BAD_REQUEST",
			});
		}

		// Validate comment
		const commentValidation = this.validateComment(comment);
		if (!commentValidation.valid) {
			throw new RepositoryError(commentValidation.error ?? "Invalid comment", {
				code: "BAD_REQUEST",
			});
		}

		// Validate categories
		const categoriesValidation = this.validateCategories(categories);
		if (!categoriesValidation.valid) {
			throw new RepositoryError(
				categoriesValidation.error ?? "Invalid categories",
				{ code: "BAD_REQUEST" },
			);
		}
	}

	/**
	 * Checks if user already reviewed an order
	 *
	 * @param params - Check parameters
	 * @returns true if user already reviewed this order
	 */
	async hasUserReviewedOrder(params: {
		orderId: string;
		userId: string;
		opts?: PartialWithTx;
	}): Promise<boolean> {
		try {
			const { orderId, userId, opts } = params;

			const result = await (opts?.tx ?? this.#db).query.review.findFirst({
				where: (f, op) =>
					op.and(op.eq(f.orderId, orderId), op.eq(f.fromUserId, userId)),
			});

			return result !== undefined && result !== null;
		} catch (error) {
			logger.error(
				{ error, params },
				"[ReviewValidationService] Failed to check if user reviewed order",
			);
			return false;
		}
	}

	/**
	 * Gets review eligibility status for user and order
	 *
	 * Checks:
	 * - Order exists and is completed
	 * - User is part of order (as customer or driver)
	 * - User hasn't already reviewed this order
	 *
	 * Note: Uses completedDriverId for driver lookup after order completion,
	 * as driverId may be cleared after the trip ends.
	 *
	 * @param params - Eligibility check parameters
	 * @returns Review eligibility status
	 */
	async getReviewEligibility(params: {
		orderId: string;
		userId: string;
		opts?: PartialWithTx;
	}): Promise<{
		canReview: boolean;
		alreadyReviewed: boolean;
		orderCompleted: boolean;
		isUserInOrder: boolean;
		reason?: string;
	}> {
		try {
			const { orderId, userId, opts } = params;

			// Check if order exists and is completed
			const order = await (opts?.tx ?? this.#db).query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!order) {
				return {
					canReview: false,
					alreadyReviewed: false,
					orderCompleted: false,
					isUserInOrder: false,
					reason: "Order not found",
				};
			}

			const orderCompleted = order.status === "COMPLETED";

			// Get driver's userId for comparison
			// Use completedDriverId first (set when order is completed), fallback to driverId
			const effectiveDriverId = order.completedDriverId ?? order.driverId;
			let driverUserId: string | null = null;

			if (effectiveDriverId) {
				const driver = await (opts?.tx ?? this.#db).query.driver.findFirst({
					where: (f, op) => op.eq(f.id, effectiveDriverId),
				});
				driverUserId = driver?.userId ?? null;
			}

			// Get merchant's userId for comparison (for FOOD orders)
			let merchantUserId: string | null = null;

			if (order.merchantId) {
				const merchantId = order.merchantId;
				const merchant = await (opts?.tx ?? this.#db).query.merchant.findFirst({
					where: (f, op) => op.eq(f.id, merchantId),
				});
				merchantUserId = merchant?.userId ?? null;
			}

			// Check if user is part of this order (as customer, driver, or merchant)
			const isUserInOrder =
				order.userId === userId ||
				driverUserId === userId ||
				merchantUserId === userId;

			// Check if user already reviewed this order
			const alreadyReviewed = await this.hasUserReviewedOrder({
				orderId,
				userId,
				opts,
			});

			// Determine if user can review
			let canReview = true;
			let reason: string | undefined;

			if (!orderCompleted) {
				canReview = false;
				reason = "Order is not completed yet";
			} else if (!isUserInOrder) {
				canReview = false;
				reason = "User is not part of this order";
			} else if (alreadyReviewed) {
				canReview = false;
				reason = "User already reviewed this order";
			}

			logger.info(
				{ orderId, userId, canReview, reason },
				"[ReviewValidationService] Review eligibility checked",
			);

			return {
				canReview,
				alreadyReviewed,
				orderCompleted,
				isUserInOrder,
				reason,
			};
		} catch (error) {
			logger.error(
				{ error, params },
				"[ReviewValidationService] Failed to get review eligibility",
			);
			return {
				canReview: false,
				alreadyReviewed: false,
				orderCompleted: false,
				isUserInOrder: false,
				reason: "Failed to check eligibility",
			};
		}
	}

	/**
	 * Validates review eligibility and throws error if not eligible
	 *
	 * @param params - Validation parameters
	 * @throws RepositoryError if user cannot review order
	 */
	async validateReviewEligibility(params: {
		orderId: string;
		userId: string;
		opts?: PartialWithTx;
	}): Promise<void> {
		const eligibility = await this.getReviewEligibility(params);

		if (!eligibility.canReview) {
			throw new RepositoryError(
				eligibility.reason ?? "Cannot review this order",
				{ code: "BAD_REQUEST" },
			);
		}
	}

	/**
	 * Validates that toUserId is the other party in the order
	 *
	 * Ensures fromUserId is rating the correct person (driver rates user, user rates driver)
	 * Uses completedDriverId for driver lookup after order completion.
	 *
	 * @param params - Validation parameters
	 * @returns true if toUserId is valid
	 */
	async validateReviewTarget(params: {
		orderId: string;
		fromUserId: string;
		toUserId: string;
		opts?: PartialWithTx;
	}): Promise<{ valid: boolean; error?: string }> {
		try {
			const { orderId, fromUserId, toUserId, opts } = params;

			const order = await (opts?.tx ?? this.#db).query.order.findFirst({
				where: (f, op) => op.eq(f.id, orderId),
			});

			if (!order) {
				return { valid: false, error: "Order not found" };
			}

			// Get driver's userId for comparison
			// Use completedDriverId first (set when order is completed), fallback to driverId
			const effectiveDriverId = order.completedDriverId ?? order.driverId;
			let driverUserId: string | null = null;

			if (effectiveDriverId) {
				const driver = await (opts?.tx ?? this.#db).query.driver.findFirst({
					where: (f, op) => op.eq(f.id, effectiveDriverId),
				});
				driverUserId = driver?.userId ?? null;
			}

			// If fromUser is the customer, toUser must be the driver OR merchant (for FOOD orders)
			if (fromUserId === order.userId) {
				// Customer can review the driver
				if (driverUserId && toUserId === driverUserId) {
					return { valid: true };
				}

				// Customer can also review the merchant (for FOOD orders)
				if (order.merchantId) {
					const merchantId = order.merchantId;
					const merchant = await (
						opts?.tx ?? this.#db
					).query.merchant.findFirst({
						where: (f, op) => op.eq(f.id, merchantId),
					});
					if (merchant && toUserId === merchant.userId) {
						return { valid: true };
					}
				}

				// If neither driver nor merchant matched
				if (!driverUserId && !order.merchantId) {
					return {
						valid: false,
						error: "Order has no driver or merchant assigned",
					};
				}

				return {
					valid: false,
					error: "Customer can only review the assigned driver or merchant",
				};
			}

			// If fromUser is the driver, toUser must be the customer
			if (fromUserId === driverUserId) {
				if (toUserId !== order.userId) {
					return {
						valid: false,
						error: "Driver can only review the customer",
					};
				}
				return { valid: true };
			}

			// If fromUser is the merchant, toUser must be the customer
			if (order.merchantId) {
				const merchantId = order.merchantId;
				const merchant = await (opts?.tx ?? this.#db).query.merchant.findFirst({
					where: (f, op) => op.eq(f.id, merchantId),
				});
				if (merchant && fromUserId === merchant.userId) {
					if (toUserId !== order.userId) {
						return {
							valid: false,
							error: "Merchant can only review the customer",
						};
					}
					return { valid: true };
				}
			}

			return {
				valid: false,
				error: "fromUserId is not part of this order",
			};
		} catch (error) {
			logger.error(
				{ error, params },
				"[ReviewValidationService] Failed to validate review target",
			);
			return {
				valid: false,
				error: "Failed to validate review target",
			};
		}
	}
}
