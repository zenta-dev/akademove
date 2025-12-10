import type { Merchant, MerchantMenu } from "@repo/schema/merchant";
import { logger } from "@/utils/logger";

export interface BestSellerParams {
	limit?: number;
	category?: string;
}

export interface BestSellerResult {
	menu: MerchantMenu;
	merchant: Pick<Merchant, "id" | "name" | "image" | "rating">;
	orderCount: number;
}

export interface BestSellerRaw {
	menuId: string;
	menuName: string;
	menuImage: string | null;
	menuPrice: string;
	menuCategory: string | null;
	menuStock: number;
	menuCreatedAt: Date;
	menuUpdatedAt: Date;
	merchantId: string;
	merchantName: string;
	merchantImage: string | null;
	merchantRating: string | number;
	orderCount: number;
}

/**
 * Best Sellers Service
 *
 * Handles business logic for calculating and formatting best-selling menu items.
 * Follows SRP by separating analytics logic from repository data access.
 */
export class BestSellersService {
	/**
	 * Generate cache key for best sellers query
	 */
	static getCacheKey(params: BestSellerParams): string {
		const { limit = 10, category } = params;
		return `bestsellers:${category || "all"}:${limit}`;
	}

	/**
	 * Transform raw database results to best seller results
	 * Handles image URL generation via callbacks
	 */
	static async transformBestSellers(
		rawResults: BestSellerRaw[],
		callbacks: {
			getMenuImageUrl: (key: string) => string | undefined;
			getMerchantImageUrl: (key: string) => string | undefined;
			toNumberSafe: (value: string | number) => number;
		},
	): Promise<BestSellerResult[]> {
		logger.info(
			{ count: rawResults.length },
			"[BestSellersService] Transforming best sellers",
		);

		return rawResults.map((row) => {
			const menuImage = row.menuImage
				? callbacks.getMenuImageUrl(row.menuImage)
				: undefined;

			const merchantImage = row.merchantImage
				? callbacks.getMerchantImageUrl(row.merchantImage)
				: undefined;

			return {
				menu: {
					id: row.menuId,
					merchantId: row.merchantId,
					name: row.menuName,
					image: menuImage,
					category: row.menuCategory ?? undefined,
					price: callbacks.toNumberSafe(row.menuPrice),
					stock: row.menuStock,
					createdAt: row.menuCreatedAt,
					updatedAt: row.menuUpdatedAt,
				},
				merchant: {
					id: row.merchantId,
					name: row.merchantName,
					image: merchantImage,
					rating:
						typeof row.merchantRating === "string"
							? callbacks.toNumberSafe(row.merchantRating)
							: row.merchantRating,
				},
				orderCount: row.orderCount,
			};
		});
	}
}
