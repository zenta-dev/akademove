import type { Coupon } from "@repo/schema/coupon";
import { RepositoryError } from "@/core/error";
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
}
