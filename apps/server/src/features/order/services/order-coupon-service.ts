import type { Coupon } from "@repo/schema/coupon";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { log, toStringNumberSafe } from "@/utils";

/**
 * Service responsible for order coupon handling
 *
 * @responsibility Validate and apply coupons to orders
 */
export class OrderCouponService {
	/**
	 * Validate coupon and calculate discount
	 */
	static async validateAndApplyCoupon(
		couponCode: string,
		totalCost: number,
		userId: string,
		db: DatabaseService,
		kv: KeyValueService,
	): Promise<{
		couponId?: string;
		couponCode: string;
		discountAmount: number;
		finalTotalCost: number;
	}> {
		// Create a CouponRepository instance
		const couponRepo = new (
			await import("../../coupon/coupon-repository")
		).CouponRepository(db, kv);

		const couponValidation = await couponRepo.validateCoupon(
			couponCode,
			totalCost,
			userId,
		);

		if (!couponValidation.valid) {
			throw new RepositoryError(couponValidation.reason ?? "Invalid coupon", {
				code: "BAD_REQUEST",
			});
		}

		let couponId: string | undefined;
		if (
			couponValidation.coupon &&
			typeof couponValidation.coupon === "object" &&
			"id" in couponValidation.coupon
		) {
			couponId = couponValidation.coupon.id as string;
		}

		const discountAmount = couponValidation.discountAmount;
		const finalTotalCost = Math.max(0, totalCost - discountAmount);

		log.info(
			{
				userId,
				couponCode,
				originalPrice: totalCost,
				discountAmount,
				finalPrice: finalTotalCost,
			},
			"[OrderCouponService] Coupon applied successfully",
		);

		return {
			couponId,
			couponCode,
			discountAmount,
			finalTotalCost,
		};
	}

	/**
	 * Get and apply the best eligible coupon for an order
	 * Used for auto-applying coupons when user doesn't provide one
	 */
	static async getAndApplyBestCoupon(
		totalCost: number,
		userId: string,
		serviceType: string,
		db: DatabaseService,
		kv: KeyValueService,
		merchantId?: string,
	): Promise<{
		couponId?: string;
		couponCode?: string;
		discountAmount: number;
		finalTotalCost: number;
		autoApplied: boolean;
		coupon?: Coupon;
	}> {
		try {
			// Create a CouponRepository instance
			const couponRepo = new (
				await import("../../coupon/coupon-repository")
			).CouponRepository(db, kv);

			const { bestCoupon, bestDiscountAmount } =
				await couponRepo.getEligibleCoupons({
					serviceType,
					totalAmount: totalCost,
					userId,
					merchantId,
				});

			if (!bestCoupon || bestDiscountAmount <= 0) {
				log.debug(
					{ userId, totalCost, serviceType },
					"[OrderCouponService] No eligible coupons found for auto-apply",
				);
				return {
					discountAmount: 0,
					finalTotalCost: totalCost,
					autoApplied: false,
				};
			}

			const finalTotalCost = Math.max(0, totalCost - bestDiscountAmount);

			log.info(
				{
					userId,
					couponCode: bestCoupon.code,
					originalPrice: totalCost,
					discountAmount: bestDiscountAmount,
					finalPrice: finalTotalCost,
				},
				"[OrderCouponService] Best coupon auto-applied successfully",
			);

			return {
				couponId: bestCoupon.id,
				couponCode: bestCoupon.code,
				discountAmount: bestDiscountAmount,
				finalTotalCost,
				autoApplied: true,
				coupon: bestCoupon,
			};
		} catch (error) {
			// Don't fail the order if auto-apply fails, just log and continue without coupon
			log.warn(
				{ error, userId, totalCost, serviceType },
				"[OrderCouponService] Failed to auto-apply coupon, continuing without discount",
			);
			return {
				discountAmount: 0,
				finalTotalCost: totalCost,
				autoApplied: false,
			};
		}
	}

	/**
	 * Prepare coupon data for order insertion
	 */
	static prepareCouponData(
		couponId?: string,
		couponCode?: string,
		discountAmount?: number,
	): {
		couponId?: string;
		couponCode?: string;
		discountAmount?: string;
	} {
		return {
			couponId,
			couponCode,
			discountAmount:
				discountAmount && discountAmount > 0
					? toStringNumberSafe(discountAmount)
					: undefined,
		};
	}

	/**
	 * Record coupon usage after successful order placement
	 * This ensures the coupon usage is tracked for:
	 * 1. Per-user usage limits
	 * 2. Global usage count tracking
	 *
	 * @param couponId - The coupon ID that was used
	 * @param orderId - The order ID the coupon was applied to
	 * @param userId - The user who used the coupon
	 * @param discountAmount - The discount amount applied
	 * @param db - Database service
	 * @param kv - KeyValue service
	 * @param opts - Optional transaction context
	 */
	static async recordCouponUsage(
		couponId: string,
		orderId: string,
		userId: string,
		discountAmount: number,
		db: DatabaseService,
		kv: KeyValueService,
		_opts?: PartialWithTx,
	): Promise<void> {
		try {
			// Create a CouponRepository instance
			const couponRepo = new (
				await import("../../coupon/coupon-repository")
			).CouponRepository(db, kv);

			// Record the usage in coupon_usages table
			await couponRepo.recordUsage(couponId, orderId, userId, discountAmount);

			// Increment the used count on the coupon
			await couponRepo.incrementUsageCount(couponId);

			log.info(
				{
					couponId,
					orderId,
					userId,
					discountAmount,
				},
				"[OrderCouponService] Coupon usage recorded successfully",
			);
		} catch (error) {
			// Log error but don't fail the order - usage recording is not critical
			log.error(
				{
					error,
					couponId,
					orderId,
					userId,
					discountAmount,
				},
				"[OrderCouponService] Failed to record coupon usage",
			);
			// Re-throw to ensure transaction rollback if within a transaction
			throw error;
		}
	}
}
