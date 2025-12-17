import { m } from "@repo/i18n";
import type { PlaceOrder } from "@repo/schema/order";
import { and, eq, inArray } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import type { DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Order statuses that are considered "active" - user cannot place a new order
 * while they have an order in any of these statuses
 */
const ACTIVE_ORDER_STATUSES = [
	"REQUESTED",
	"MATCHING",
	"ACCEPTED",
	"PREPARING",
	"READY_FOR_PICKUP",
	"ARRIVING",
	"IN_TRIP",
] as const;

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

		// Validate DELIVERY orders require item photo
		// User must include a photo of the item to be delivered so drivers can see what they'll be picking up
		if (params.type === "DELIVERY" && !params.deliveryItemPhotoUrl) {
			throw new RepositoryError(
				"Delivery orders require a photo of the item to be delivered. Please upload an item photo.",
				{ code: "BAD_REQUEST" },
			);
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
	 * Validate stock availability for FOOD order items at placement time
	 *
	 * Called BEFORE order creation to ensure sufficient stock exists.
	 * Uses the menu items fetched during order placement and the requested quantities.
	 *
	 * @param menus - Menu items fetched from database (with stock field)
	 * @param items - Order items with requested quantities
	 * @throws RepositoryError if any item has insufficient stock
	 */
	static validateStockAtPlacement(
		menus: Array<{ id: string; name: string; stock: number }>,
		items?: Array<{ quantity: number; item?: { id?: string } }>,
	): void {
		if (!items || items.length === 0) {
			return;
		}

		// Create a map of menuId -> requested quantity
		const requestedQuantities = new Map<string, number>();
		for (const item of items) {
			const menuId = item.item?.id;
			if (menuId) {
				requestedQuantities.set(menuId, item.quantity);
			}
		}

		// Check stock for each menu item
		const insufficientItems: Array<{
			menuName: string;
			requested: number;
			available: number;
		}> = [];

		for (const menu of menus) {
			const requestedQty = requestedQuantities.get(menu.id);
			if (requestedQty !== undefined && requestedQty > menu.stock) {
				insufficientItems.push({
					menuName: menu.name,
					requested: requestedQty,
					available: menu.stock,
				});
			}
		}

		if (insufficientItems.length > 0) {
			const itemDetails = insufficientItems
				.map(
					(i) =>
						`${i.menuName} (requested: ${i.requested}, available: ${i.available})`,
				)
				.join(", ");
			logger.warn(
				{ insufficientItems },
				"[OrderValidation] Insufficient stock at order placement",
			);
			throw new RepositoryError(
				`Insufficient stock for: ${itemDetails}. Please update your cart.`,
				{ code: "BAD_REQUEST" },
			);
		}

		logger.debug("[OrderValidation] Stock validation at placement passed");
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
			logger.debug({ orderId }, "[OrderValidation] No order items to validate");
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
				logger.warn(
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
			logger.warn(
				{ orderId, insufficientItems },
				"[OrderValidation] Insufficient stock for order items",
			);
			throw new RepositoryError(
				`Insufficient stock for: ${itemNames}. Please update your order.`,
				{ code: "BAD_REQUEST" },
			);
		}

		logger.debug({ orderId }, "[OrderValidation] Stock validation passed");
	}

	/**
	 * Validate that user does not have an active order
	 *
	 * Users can only have one active order at a time. This prevents users from
	 * creating multiple orders simultaneously which could cause issues with
	 * driver matching and wallet balance.
	 *
	 * @param userId - The user ID to check
	 * @param tx - Database transaction
	 * @throws RepositoryError if user already has an active order
	 */
	static async validateNoActiveOrder(
		userId: string,
		tx: DatabaseTransaction,
	): Promise<void> {
		const activeOrder = await tx.query.order.findFirst({
			columns: { id: true, status: true },
			where: and(
				eq(tables.order.userId, userId),
				inArray(tables.order.status, [...ACTIVE_ORDER_STATUSES]),
			),
		});

		if (activeOrder) {
			logger.warn(
				{ userId, activeOrderId: activeOrder.id, status: activeOrder.status },
				"[OrderValidation] User already has an active order",
			);
			throw new RepositoryError(
				"You already have an active order. Please complete or cancel it before placing a new order.",
				{ code: "BAD_REQUEST" },
			);
		}

		logger.debug({ userId }, "[OrderValidation] No active order found");
	}
}
