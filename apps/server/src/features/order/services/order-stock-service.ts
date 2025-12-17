import { eq, sql } from "drizzle-orm";
import type { WithTx } from "@/core/interface";
import { tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Service responsible for managing menu stock updates during order lifecycle
 *
 * @responsibility Decrement stock and increment soldStock when orders are completed
 */
export class OrderStockService {
	/**
	 * Update stock for menu items when an order is completed
	 *
	 * This method:
	 * 1. Fetches order items for the given order
	 * 2. Decrements stock by the ordered quantity
	 * 3. Increments soldStock by the ordered quantity
	 *
	 * @param orderId - The completed order ID
	 * @param opts - Transaction options
	 */
	static async updateStockOnOrderCompletion(
		orderId: string,
		opts: WithTx,
	): Promise<void> {
		try {
			// Fetch order items for this order
			const orderItems = await opts.tx.query.orderItem.findMany({
				where: eq(tables.orderItem.orderId, orderId),
			});

			if (orderItems.length === 0) {
				logger.debug(
					{ orderId },
					"[OrderStockService] No order items to update stock for",
				);
				return;
			}

			// Update stock for each menu item
			const updatePromises = orderItems.map(async (item) => {
				const result = await opts.tx
					.update(tables.merchantMenu)
					.set({
						// Decrement stock (ensure it doesn't go below 0)
						stock: sql`GREATEST(${tables.merchantMenu.stock} - ${item.quantity}, 0)`,
						// Increment soldStock
						soldStock: sql`${tables.merchantMenu.soldStock} + ${item.quantity}`,
						updatedAt: new Date(),
					})
					.where(eq(tables.merchantMenu.id, item.menuId))
					.returning({
						id: tables.merchantMenu.id,
						stock: tables.merchantMenu.stock,
						soldStock: tables.merchantMenu.soldStock,
					});

				if (result.length > 0) {
					logger.info(
						{
							menuId: item.menuId,
							quantity: item.quantity,
							newStock: result[0].stock,
							newSoldStock: result[0].soldStock,
						},
						"[OrderStockService] Updated menu stock",
					);
				}

				return result;
			});

			await Promise.all(updatePromises);

			logger.info(
				{ orderId, itemCount: orderItems.length },
				"[OrderStockService] Successfully updated stock for all order items",
			);
		} catch (error) {
			logger.error(
				{ error, orderId },
				"[OrderStockService] Failed to update stock on order completion",
			);
			throw error;
		}
	}
}
