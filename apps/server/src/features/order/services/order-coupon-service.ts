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
