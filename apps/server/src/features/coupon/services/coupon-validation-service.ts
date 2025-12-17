import type { Coupon } from "@repo/schema/coupon";
import { count, eq } from "drizzle-orm";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

export interface CouponValidationResult {
	valid: boolean;
	reason?: string;
}

export type GetUserOrderCountFn = (userId: string) => Promise<number>;

export type GetUserUsageCountFn = (
	couponId: string,
	userId: string,
) => Promise<number>;

/**
 * Service for validating coupon eligibility rules
 * Handles all business rules: active status, dates, merchant, usage limits, user restrictions, time-based rules
 *
 * Follows SOLID principles:
 * - Single Responsibility: Only coupon eligibility validation
 * - Open/Closed: Extensible validation rules via new methods
 * - Dependency Inversion: Depends on callback functions for data access
 */
export class CouponValidationService {
	/**
	 * Validate coupon active status
	 */
	static validateActiveStatus(coupon: Coupon): CouponValidationResult {
		if (!coupon.isActive) {
			return {
				valid: false,
				reason: "Coupon is not active",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate coupon merchant eligibility
	 */
	static validateMerchant(
		coupon: Coupon,
		merchantId?: string,
	): CouponValidationResult {
		if (merchantId && coupon.merchantId && coupon.merchantId !== merchantId) {
			return {
				valid: false,
				reason: "Coupon not valid for this merchant",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate coupon date range
	 */
	static validateDateRange(coupon: Coupon): CouponValidationResult {
		const now = new Date();
		const startDate = new Date(coupon.periodStart);
		const endDate = new Date(coupon.periodEnd);

		if (now < startDate) {
			return {
				valid: false,
				reason: "Coupon is not yet valid",
			};
		}

		if (now > endDate) {
			return {
				valid: false,
				reason: "Coupon has expired",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate global usage limit
	 */
	static validateGlobalUsageLimit(coupon: Coupon): CouponValidationResult {
		if (coupon.usedCount >= coupon.usageLimit) {
			return {
				valid: false,
				reason: "Coupon usage limit reached",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate per-user usage limit
	 */
	static async validateUserUsageLimit(
		coupon: Coupon,
		userUsageCount: number,
	): Promise<CouponValidationResult> {
		const perUserLimit = coupon.rules?.user?.perUserLimit ?? 1;

		if (userUsageCount >= perUserLimit) {
			return {
				valid: false,
				reason: "You have already used this coupon",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate new user only restriction
	 */
	static async validateNewUserOnly(
		coupon: Coupon,
		userOrderCount: number,
	): Promise<CouponValidationResult> {
		if (coupon.rules?.user?.newUserOnly) {
			if (userOrderCount > 0) {
				return {
					valid: false,
					reason: "This coupon is for new users only",
				};
			}
		}

		return { valid: true };
	}

	/**
	 * Validate minimum order amount
	 */
	static validateMinOrderAmount(
		coupon: Coupon,
		orderAmount: number,
	): CouponValidationResult {
		const minOrderAmount = coupon.rules?.general?.minOrderAmount;

		if (minOrderAmount !== undefined && orderAmount < minOrderAmount) {
			return {
				valid: false,
				reason: `Minimum order amount is ${minOrderAmount}`,
			};
		}

		return { valid: true };
	}

	/**
	 * Validate time-based rules (day of week, hour of day)
	 */
	static validateTimeBasedRules(coupon: Coupon): CouponValidationResult {
		if (!coupon.rules?.time) {
			return { valid: true };
		}

		const now = new Date();
		const currentDay = [
			"SUNDAY",
			"MONDAY",
			"TUESDAY",
			"WEDNESDAY",
			"THURSDAY",
			"FRIDAY",
			"SATURDAY",
		][now.getDay()];
		const currentHour = now.getHours();

		// Check day of week restriction
		if (
			coupon.rules.time.allowedDays &&
			coupon.rules.time.allowedDays.length > 0 &&
			!coupon.rules.time.allowedDays.includes(
				currentDay as
					| "SUNDAY"
					| "MONDAY"
					| "TUESDAY"
					| "WEDNESDAY"
					| "THURSDAY"
					| "FRIDAY"
					| "SATURDAY",
			)
		) {
			return {
				valid: false,
				reason: "Coupon not valid on this day",
			};
		}

		// Check hour of day restriction
		if (
			coupon.rules.time.allowedHours &&
			coupon.rules.time.allowedHours.length > 0 &&
			!coupon.rules.time.allowedHours.includes(currentHour)
		) {
			return {
				valid: false,
				reason: "Coupon not valid at this hour",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate discount type compatibility
	 * Note: This validates the coupon's discount type (FIXED/PERCENTAGE), not service type (RIDE/DELIVERY/FOOD)
	 */
	static validateDiscountType(coupon: Coupon): CouponValidationResult {
		const couponDiscountType = coupon.rules?.general?.type;

		if (
			couponDiscountType &&
			couponDiscountType !== "FIXED" &&
			couponDiscountType !== "PERCENTAGE"
		) {
			return {
				valid: false,
				reason: "Coupon discount type not supported",
			};
		}

		return { valid: true };
	}

	/**
	 * Validate service type eligibility
	 * Checks if the coupon is valid for the requested service type (RIDE/DELIVERY/FOOD)
	 * Empty or undefined serviceTypes means coupon is valid for all services
	 */
	static validateServiceType(
		coupon: Coupon,
		serviceType?: string,
	): CouponValidationResult {
		// If coupon has no service type restrictions, it's valid for all services
		if (
			!coupon.serviceTypes ||
			!Array.isArray(coupon.serviceTypes) ||
			coupon.serviceTypes.length === 0
		) {
			return { valid: true };
		}

		// If no service type provided, allow (will be validated at order time)
		if (!serviceType) {
			return { valid: true };
		}

		// Check if the service type is in the allowed list
		if (
			!coupon.serviceTypes.includes(serviceType as "RIDE" | "DELIVERY" | "FOOD")
		) {
			return {
				valid: false,
				reason: `Coupon not valid for ${serviceType} orders`,
			};
		}

		return { valid: true };
	}

	/**
	 * Validate all coupon eligibility rules (for filtering eligible coupons)
	 */
	static async validateCouponEligibility(
		coupon: Coupon,
		params: {
			orderAmount: number;
			userId: string;
			merchantId?: string;
			serviceType?: string;
			getUserUsageCount: GetUserUsageCountFn;
			getUserOrderCount: GetUserOrderCountFn;
		},
	): Promise<CouponValidationResult> {
		try {
			const {
				orderAmount,
				userId,
				merchantId,
				serviceType,
				getUserUsageCount,
				getUserOrderCount,
			} = params;

			logger.debug(
				{
					couponCode: coupon.code,
					couponId: coupon.id,
					orderAmount,
					serviceType,
					merchantId,
					couponServiceTypes: coupon.serviceTypes,
					couponMinOrderAmount: coupon.rules?.general?.minOrderAmount,
				},
				"[CouponValidationService] Starting eligibility checks",
			);

			// Check discount type
			const discountTypeCheck =
				CouponValidationService.validateDiscountType(coupon);
			if (!discountTypeCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "discountType",
						reason: discountTypeCheck.reason,
					},
					"[CouponValidationService] Check failed",
				);
				return discountTypeCheck;
			}

			// Check service type eligibility
			const serviceTypeCheck = CouponValidationService.validateServiceType(
				coupon,
				serviceType,
			);
			if (!serviceTypeCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "serviceType",
						reason: serviceTypeCheck.reason,
						couponServiceTypes: coupon.serviceTypes,
						requestedServiceType: serviceType,
					},
					"[CouponValidationService] Check failed",
				);
				return serviceTypeCheck;
			}

			// Check merchant eligibility
			const merchantCheck = CouponValidationService.validateMerchant(
				coupon,
				merchantId,
			);
			if (!merchantCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "merchant",
						reason: merchantCheck.reason,
					},
					"[CouponValidationService] Check failed",
				);
				return merchantCheck;
			}

			// Check minimum order amount
			const minOrderCheck = CouponValidationService.validateMinOrderAmount(
				coupon,
				orderAmount,
			);
			if (!minOrderCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "minOrderAmount",
						reason: minOrderCheck.reason,
						orderAmount,
						minOrderAmount: coupon.rules?.general?.minOrderAmount,
					},
					"[CouponValidationService] Check failed",
				);
				return minOrderCheck;
			}

			// Check per-user usage limit
			const userUsageCount = await getUserUsageCount(coupon.id, userId);
			const userUsageCheck =
				await CouponValidationService.validateUserUsageLimit(
					coupon,
					userUsageCount,
				);
			if (!userUsageCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "userUsageLimit",
						reason: userUsageCheck.reason,
						userUsageCount,
						perUserLimit: coupon.rules?.user?.perUserLimit,
					},
					"[CouponValidationService] Check failed",
				);
				return userUsageCheck;
			}

			// Check new user restriction
			const userOrderCount = await getUserOrderCount(userId);
			const newUserCheck = await CouponValidationService.validateNewUserOnly(
				coupon,
				userOrderCount,
			);
			if (!newUserCheck.valid) {
				logger.debug(
					{
						couponCode: coupon.code,
						check: "newUserOnly",
						reason: newUserCheck.reason,
						userOrderCount,
						newUserOnly: coupon.rules?.user?.newUserOnly,
					},
					"[CouponValidationService] Check failed",
				);
				return newUserCheck;
			}

			logger.debug(
				{ couponCode: coupon.code, couponId: coupon.id },
				"[CouponValidationService] All eligibility checks passed",
			);

			return { valid: true };
		} catch (error) {
			logger.error(
				{ error, couponId: coupon.id, params },
				"[CouponValidationService] Failed to validate eligibility",
			);
			return {
				valid: false,
				reason: "Validation failed",
			};
		}
	}

	/**
	 * Validate all coupon rules for a specific coupon code (comprehensive validation)
	 */
	static async validateCouponCode(
		coupon: Coupon,
		params: {
			orderAmount: number;
			userId: string;
			merchantId?: string;
			serviceType?: string;
			getUserUsageCount: GetUserUsageCountFn;
			getUserOrderCount: GetUserOrderCountFn;
		},
	): Promise<CouponValidationResult> {
		try {
			const {
				orderAmount,
				userId,
				merchantId,
				serviceType,
				getUserUsageCount,
				getUserOrderCount,
			} = params;

			// Check active status
			const activeCheck = CouponValidationService.validateActiveStatus(coupon);
			if (!activeCheck.valid) {
				return activeCheck;
			}

			// Check service type eligibility
			const serviceTypeCheck = CouponValidationService.validateServiceType(
				coupon,
				serviceType,
			);
			if (!serviceTypeCheck.valid) {
				return serviceTypeCheck;
			}

			// Check merchant eligibility
			const merchantCheck = CouponValidationService.validateMerchant(
				coupon,
				merchantId,
			);
			if (!merchantCheck.valid) {
				return merchantCheck;
			}

			// Check date range
			const dateCheck = CouponValidationService.validateDateRange(coupon);
			if (!dateCheck.valid) {
				return dateCheck;
			}

			// Check global usage limit
			const globalUsageCheck =
				CouponValidationService.validateGlobalUsageLimit(coupon);
			if (!globalUsageCheck.valid) {
				return globalUsageCheck;
			}

			// Check per-user usage limit
			const userUsageCount = await getUserUsageCount(coupon.id, userId);
			const userUsageCheck =
				await CouponValidationService.validateUserUsageLimit(
					coupon,
					userUsageCount,
				);
			if (!userUsageCheck.valid) {
				return userUsageCheck;
			}

			// Check new user restriction
			const userOrderCount = await getUserOrderCount(userId);
			const newUserCheck = await CouponValidationService.validateNewUserOnly(
				coupon,
				userOrderCount,
			);
			if (!newUserCheck.valid) {
				return newUserCheck;
			}

			// Check minimum order amount
			const minOrderCheck = CouponValidationService.validateMinOrderAmount(
				coupon,
				orderAmount,
			);
			if (!minOrderCheck.valid) {
				return minOrderCheck;
			}

			// Check time-based rules
			const timeCheck = CouponValidationService.validateTimeBasedRules(coupon);
			if (!timeCheck.valid) {
				return timeCheck;
			}

			return { valid: true };
		} catch (error) {
			logger.error(
				{ error, couponId: coupon.id, params },
				"[CouponValidationService] Failed to validate coupon code",
			);
			return {
				valid: false,
				reason: "Validation failed",
			};
		}
	}

	/**
	 * Create getUserOrderCount callback for database queries
	 * Note: Throws on error to prevent incorrect coupon eligibility
	 */
	static createGetUserOrderCount(
		db: DatabaseService | DatabaseTransaction,
	): GetUserOrderCountFn {
		return async (userId: string): Promise<number> => {
			try {
				const result = await db
					.select({ count: count(tables.order.id) })
					.from(tables.order)
					.where(eq(tables.order.userId, userId));

				return result[0]?.count ?? 0;
			} catch (error) {
				logger.error(
					{ error, userId },
					"[CouponValidationService] Failed to get user order count",
				);
				// Throw error instead of returning 0 to prevent incorrect eligibility
				throw error;
			}
		};
	}

	/**
	 * Create getUserUsageCount callback for database queries
	 * Note: Throws on error to prevent incorrect coupon eligibility
	 */
	static createGetUserUsageCount(
		db: DatabaseService | DatabaseTransaction,
	): GetUserUsageCountFn {
		return async (couponId: string, userId: string): Promise<number> => {
			try {
				const usages = await db.query.couponUsage.findMany({
					where: (f, op) =>
						op.and(op.eq(f.couponId, couponId), op.eq(f.userId, userId)),
				});

				return usages.length;
			} catch (error) {
				logger.error(
					{ error, couponId, userId },
					"[CouponValidationService] Failed to get user usage count",
				);
				// Throw error instead of returning 0 to prevent incorrect eligibility
				throw error;
			}
		};
	}
}
