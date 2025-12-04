import { m } from "@repo/i18n";
import type { PlaceOrder } from "@repo/schema/order";
import { RepositoryError } from "@/core/error";

/**
 * Service responsible for order placement validation
 *
 * Handles:
 * - Validating required order parameters
 * - Validating menu items and merchant consistency
 * - Extracting menu item IDs
 */
export class OrderValidationService {
	/**
	 * Validate required parameters for order placement
	 *
	 * @param params - Order placement parameters
	 * @throws RepositoryError if validation fails
	 */
	static validatePlaceOrderParams(params: PlaceOrder): void {
		// Validate locations
		if (!params.pickupLocation || !params.dropoffLocation) {
			throw new RepositoryError(m.error_pickup_dropoff_required(), {
				code: "BAD_REQUEST",
			});
		}

		// Validate order type
		if (!params.type) {
			throw new RepositoryError(m.error_order_type_required(), {
				code: "BAD_REQUEST",
			});
		}

		// Validate payment info
		if (!params.payment || !params.payment.method || !params.payment.provider) {
			throw new RepositoryError(m.error_payment_info_required(), {
				code: "BAD_REQUEST",
			});
		}
	}

	/**
	 * Extract menu item IDs from order items
	 *
	 * @param items - Order items array
	 * @returns Array of menu item IDs (non-null only)
	 */
	static extractMenuItemIds(
		items?: Array<{ item?: { id?: string } }>,
	): string[] {
		if (!items) return [];

		return items.map((el) => el.item?.id).filter((id): id is string => !!id);
	}

	/**
	 * Validate menu items match the requested IDs
	 *
	 * @param menuItems - Retrieved menu items
	 * @param requestedIds - Requested menu item IDs
	 * @throws RepositoryError if validation fails
	 */
	static validateMenuItems(menuItems: unknown[], requestedIds: string[]): void {
		if (menuItems.length && menuItems.length !== requestedIds.length) {
			throw new RepositoryError(m.error_invalid_products(), {
				code: "BAD_REQUEST",
			});
		}
	}

	/**
	 * Validate all menu items belong to the same merchant
	 *
	 * @param menuItems - Menu items with merchantId
	 * @throws RepositoryError if items from multiple merchants
	 */
	static validateSingleMerchant(
		menuItems: Array<{ merchantId: string }>,
	): void {
		const uniqueMerchantIds = new Set(menuItems.map((m) => m.merchantId));

		if (uniqueMerchantIds.size > 1) {
			throw new RepositoryError("Can't order from different merchants", {
				code: "BAD_REQUEST",
			});
		}
	}

	/**
	 * Get merchant ID from menu items
	 *
	 * @param menuItems - Menu items with merchantId
	 * @returns Merchant ID or undefined if no items
	 */
	static getMerchantId(
		menuItems: Array<{ merchantId: string }>,
	): string | undefined {
		return menuItems[0]?.merchantId;
	}
}
