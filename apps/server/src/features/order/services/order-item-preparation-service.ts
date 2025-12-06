import type { WithTx } from "@/core/interface";
import { tables } from "@/core/services/db";
import { toNumberSafe } from "@/utils";

interface MenuItem {
	id: string;
	price: string;
	// Add other menu fields if needed
}

interface OrderItem {
	item: {
		id?: string;
	};
	quantity: number;
}

/**
 * Service responsible for preparing order items
 *
 * @responsibility Transform menu items and quantities into order items for insertion
 */
export class OrderItemPreparationService {
	/**
	 * Calculate total price of menu items
	 *
	 * @param menus - Menu items with prices
	 * @param items - Order items with quantities
	 * @returns Total price of all menu items
	 */
	static calculateMenuItemsTotal(
		menus: MenuItem[],
		items: OrderItem[] | undefined,
	): number {
		if (!menus.length || !items?.length) {
			return 0;
		}

		return menus.reduce((total, menu) => {
			const orderItem = items.find((i) => i.item.id === menu.id);
			const quantity = orderItem?.quantity ?? 0;
			const price = toNumberSafe(menu.price);
			return total + price * quantity;
		}, 0);
	}

	/**
	 * Prepare order items data for database insertion
	 */
	static prepareOrderItems(
		orderId: string,
		menus: MenuItem[],
		items: OrderItem[] | undefined,
	): Array<{
		orderId: string;
		menuId: string;
		quantity: number;
		unitPrice: string;
	}> {
		return menus.map((menu) => ({
			orderId,
			menuId: menu.id,
			quantity: items?.find((i) => i.item.id === menu.id)?.quantity ?? 0,
			unitPrice: menu.price,
		}));
	}

	/**
	 * Insert order items into database
	 */
	static async insertOrderItems(
		orderId: string,
		menus: MenuItem[],
		items: OrderItem[] | undefined,
		opts: WithTx,
	): Promise<void> {
		if (!menus.length) {
			return;
		}

		const orderItems = OrderItemPreparationService.prepareOrderItems(
			orderId,
			menus,
			items,
		);
		await opts.tx.insert(tables.orderItem).values(orderItems);
	}
}
