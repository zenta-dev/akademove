import { env } from "cloudflare:workers";
import { type MerchantEnvelope, MerchantEnvelopeSchema } from "@repo/schema/ws";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { logger } from "@/utils/logger";

/**
 * MerchantRoom - Durable Object for merchant real-time notifications
 *
 * Each merchant connects to their own room at `/ws/merchant/{merchantId}/orders`
 * to receive real-time notifications for:
 * - NEW_ORDER: When a new food order is placed and payment succeeds
 * - ORDER_CANCELLED: When an order is cancelled by user/system
 * - DRIVER_ASSIGNED: When a driver accepts the order
 * - ORDER_COMPLETED: When an order is completed
 *
 * This enables merchants to see new incoming orders instantly without polling.
 */
export class MerchantRoom extends BaseDurableObject {
	broadcast(message: MerchantEnvelope, opts?: BroadcastOptions): void {
		const parse = MerchantEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			logger.warn(parse, "[MerchantRoom] Invalid merchant WS message");
			return;
		}
		super.broadcast(parse.data, opts);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);

		const { success, data } = await MerchantEnvelopeSchema.safeParseAsync(
			JSON.parse(message.toString()),
		);

		if (!success) {
			logger.warn(data, "[MerchantRoom] Invalid merchant WS message format");
			return;
		}

		// Merchant room is primarily for receiving events, not sending actions
		// But we can add merchant actions here if needed in the future
		logger.debug(
			{ event: data.e, action: data.a },
			"[MerchantRoom] Received message",
		);
	}

	/**
	 * Gets merchant room Durable Object stub for WebSocket broadcasting
	 *
	 * @param merchantId - Merchant ID (used as room name)
	 * @returns Durable Object stub
	 */
	static getRoomStubByName(merchantId: string) {
		const stubId = env.MERCHANT_ROOM.idFromName(merchantId);
		return env.MERCHANT_ROOM.get(stubId);
	}
}
