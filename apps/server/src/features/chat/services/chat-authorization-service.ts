import { RepositoryError } from "@/core/error";
import type { OrderDatabase } from "@/core/tables/order";
import { log } from "@/utils";

/**
 * Chat Authorization Service
 *
 * Handles authorization logic for order chat messages.
 * Follows SRP by separating authorization logic from repository.
 */
export class ChatAuthorizationService {
	/**
	 * Verify if user is authorized to send messages in an order
	 * User must be either the customer, driver, or merchant of the order
	 */
	static async verifyOrderParticipant(
		userId: string,
		order: OrderDatabase,
		callbacks: {
			getMerchantUserId: (merchantId: string) => Promise<string | undefined>;
		},
	): Promise<{
		isAuthorized: boolean;
		role: "user" | "driver" | "merchant" | undefined;
	}> {
		// Check if user is the customer
		if (order.userId === userId) {
			log.debug(
				{ userId, orderId: order.id },
				"[ChatAuthorizationService] User authorized as customer",
			);
			return { isAuthorized: true, role: "user" };
		}

		// Check if user is the driver
		if (order.driverId === userId) {
			log.debug(
				{ userId, orderId: order.id },
				"[ChatAuthorizationService] User authorized as driver",
			);
			return { isAuthorized: true, role: "driver" };
		}

		// Check if user is the merchant
		if (order.merchantId) {
			const merchantUserId = await callbacks.getMerchantUserId(
				order.merchantId,
			);
			if (merchantUserId === userId) {
				log.debug(
					{ userId, orderId: order.id, merchantId: order.merchantId },
					"[ChatAuthorizationService] User authorized as merchant",
				);
				return { isAuthorized: true, role: "merchant" };
			}
		}

		log.warn(
			{
				userId,
				orderId: order.id,
				orderUserId: order.userId,
				driverId: order.driverId,
				merchantId: order.merchantId,
			},
			"[ChatAuthorizationService] User not authorized to send messages in this order",
		);

		return { isAuthorized: false, role: undefined };
	}

	/**
	 * Throw error if user is not authorized
	 */
	static async requireOrderParticipant(
		userId: string,
		order: OrderDatabase,
		callbacks: {
			getMerchantUserId: (merchantId: string) => Promise<string | undefined>;
		},
	): Promise<void> {
		const { isAuthorized } =
			await ChatAuthorizationService.verifyOrderParticipant(
				userId,
				order,
				callbacks,
			);

		if (!isAuthorized) {
			throw new RepositoryError(
				"User is not authorized to send messages in this order",
				{ code: "FORBIDDEN" },
			);
		}
	}
}
