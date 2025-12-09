import { m } from "@repo/i18n";
import type { PlaceOrder } from "@repo/schema/order";
import { eq } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { log } from "@/utils";

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

	/**
	 * Validate stock availability for FOOD order items
	 *
	 * Queries order items and their associated menu items to ensure
	 * sufficient stock exists for each ordered quantity.
	 *
	 * @param orderId - The order ID to validate
	 * @param tx - Database transaction
	 * @throws RepositoryError if any item has insufficient stock
	 */
	static async validateStockAvailability(
		orderId: string,
		tx: DatabaseTransaction,
	): Promise<void> {
		// Query order items with their menu details
		const orderItems = await tx.query.orderItem.findMany({
			where: eq(tables.orderItem.orderId, orderId),
		});

		if (orderItems.length === 0) {
			log.debug({ orderId }, "[OrderValidation] No order items to validate");
			return;
		}

		// Fetch menu items to check stock
		const menuIds = orderItems.map((item) => item.menuId);
		const menuItems = await tx.query.merchantMenu.findMany({
			where: (f, op) => op.inArray(f.id, menuIds),
		});

		// Create a map for quick lookup
		const menuStockMap = new Map(
			menuItems.map((menu) => [
				menu.id,
				{ stock: menu.stock, name: menu.name },
			]),
		);

		// Check stock for each order item
		const insufficientItems: Array<{
			menuName: string;
			requested: number;
			available: number;
		}> = [];

		for (const orderItem of orderItems) {
			const menuInfo = menuStockMap.get(orderItem.menuId);
			if (!menuInfo) {
				log.warn(
					{ orderId, menuId: orderItem.menuId },
					"[OrderValidation] Menu item not found for order item",
				);
				continue;
			}

			if (orderItem.quantity > menuInfo.stock) {
				insufficientItems.push({
					menuName: menuInfo.name,
					requested: orderItem.quantity,
					available: menuInfo.stock,
				});
			}
		}

		if (insufficientItems.length > 0) {
			const itemNames = insufficientItems.map((i) => i.menuName).join(", ");
			log.warn(
				{ orderId, insufficientItems },
				"[OrderValidation] Insufficient stock for order items",
			);
			throw new RepositoryError(
				`Insufficient stock for: ${itemNames}. Please update your order.`,
				{ code: "BAD_REQUEST" },
			);
		}

		log.debug({ orderId }, "[OrderValidation] Stock validation passed");
	}
}
