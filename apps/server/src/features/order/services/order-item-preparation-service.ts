import type { WithTx } from "@/core/interface";
import { tables } from "@/core/services/db";

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
