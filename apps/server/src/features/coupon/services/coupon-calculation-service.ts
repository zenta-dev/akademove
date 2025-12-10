import type { Coupon } from "@repo/schema/coupon";
import { logger } from "@/utils/logger";

export interface DiscountCalculationResult {
	discountAmount: number;
	finalAmount: number;
}

/**
 * Service for calculating coupon discounts
 * Handles discount calculation logic: fixed amount, percentage, caps
 *
 * Follows SOLID principles:
 * - Single Responsibility: Only discount calculation
 * - Open/Closed: Extensible calculation strategies
 * - Dependency Inversion: No external dependencies (pure calculation)
 */
export class CouponCalculationService {
	/**
	 * Calculate discount amount based on coupon type (fixed or percentage)
	 */
	static calculateBaseDiscount(coupon: Coupon, orderAmount: number): number {
		try {
			// Fixed amount discount
			if (coupon.discountAmount !== undefined && coupon.discountAmount > 0) {
				return coupon.discountAmount;
			}

			// Percentage discount
			if (
				coupon.discountPercentage !== undefined &&
				coupon.discountPercentage > 0
			) {
				return (orderAmount * coupon.discountPercentage) / 100;
			}

			return 0;
		} catch (error) {
			logger.error(
				{ error, couponId: coupon.id, orderAmount },
				"[CouponCalculationService] Failed to calculate base discount",
			);
			return 0;
		}
	}

	/**
	 * Apply maximum discount cap to calculated discount
	 */
	static applyMaxDiscountCap(coupon: Coupon, discountAmount: number): number {
		try {
			const maxDiscountAmount = coupon.rules?.general?.maxDiscountAmount;

			if (
				maxDiscountAmount !== undefined &&
				discountAmount > maxDiscountAmount
			) {
				return maxDiscountAmount;
			}

			return discountAmount;
		} catch (error) {
			logger.error(
				{ error, couponId: coupon.id, discountAmount },
				"[CouponCalculationService] Failed to apply max discount cap",
			);
			return discountAmount;
		}
	}

	/**
	 * Calculate final discount with all rules applied
	 */
	static calculateDiscount(
		coupon: Coupon,
		orderAmount: number,
	): DiscountCalculationResult {
		try {
			// Calculate base discount
			let discountAmount = CouponCalculationService.calculateBaseDiscount(
				coupon,
				orderAmount,
			);

			// Apply max discount cap
			discountAmount = CouponCalculationService.applyMaxDiscountCap(
				coupon,
				discountAmount,
			);

			// Calculate final amount (never negative)
			const finalAmount = Math.max(0, orderAmount - discountAmount);

			logger.debug(
				{
					couponId: coupon.id,
					couponCode: coupon.code,
					orderAmount,
					discountAmount,
					finalAmount,
				},
				"[CouponCalculationService] Discount calculated",
			);

			return {
				discountAmount,
				finalAmount,
			};
		} catch (error) {
			logger.error(
				{ error, couponId: coupon.id, orderAmount },
				"[CouponCalculationService] Failed to calculate discount",
			);
			return {
				discountAmount: 0,
				finalAmount: orderAmount,
			};
		}
	}

	/**
	 * Calculate discounts for multiple coupons and rank by best discount
	 */
	static calculateBestCoupon(
		coupons: Coupon[],
		orderAmount: number,
	): {
		bestCoupon: Coupon | null;
		bestDiscountAmount: number;
		allDiscounts: Array<{ coupon: Coupon; discountAmount: number }>;
	} {
		try {
			if (coupons.length === 0) {
				return {
					bestCoupon: null,
					bestDiscountAmount: 0,
					allDiscounts: [],
				};
			}

			// Calculate discount for each coupon
			const allDiscounts = coupons.map((coupon) => {
				const { discountAmount } = CouponCalculationService.calculateDiscount(
					coupon,
					orderAmount,
				);
				return { coupon, discountAmount };
			});

			// Sort by discount amount (highest first)
			allDiscounts.sort((a, b) => b.discountAmount - a.discountAmount);

			const best = allDiscounts[0];

			return {
				bestCoupon: best?.coupon ?? null,
				bestDiscountAmount: best?.discountAmount ?? 0,
				allDiscounts,
			};
		} catch (error) {
			logger.error(
				{ error, couponsCount: coupons.length, orderAmount },
				"[CouponCalculationService] Failed to calculate best coupon",
			);
			return {
				bestCoupon: null,
				bestDiscountAmount: 0,
				allDiscounts: [],
			};
		}
	}
}
