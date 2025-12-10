/**
 * WebSocket Broadcast Handler
 *
 * Handles WEBSOCKET_BROADCAST queue messages.
 * Broadcasts messages to connected clients via Durable Objects.
 */

import type { WebSocketBroadcastJob } from "@repo/schema/queue";
import { OrderRepository } from "@/features/order/order-repository";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleWebSocketBroadcast(
	job: WebSocketBroadcastJob,
	_context: QueueHandlerContext,
): Promise<void> {
	const { payload } = job;
	const { roomName, event, target, data, excludeUserIds } = payload;

	logger.debug(
		{ roomName, event, target },
		"[WebSocketBroadcastHandler] Broadcasting message",
	);

	try {
		// Get the Durable Object stub for the room
		const roomStub = OrderRepository.getRoomStubByName(roomName);

		// Create the broadcast message
		const message = {
			e: event,
			f: "s", // from server
			t: "c", // to client
			tg: target,
			p: data,
		};

		// Send the broadcast request to the Durable Object
		// Note: The actual broadcast logic is in the OrderRoom.broadcast() method
		// We need to call a fetch to trigger it
		const response = await roomStub.fetch(
			new Request("http://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({
					message,
					excludeUserIds,
				}),
			}),
		);

		if (!response.ok) {
			const errorText = await response.text();
			throw new Error(`Broadcast failed: ${errorText}`);
		}

		logger.debug(
			{ roomName, event },
			"[WebSocketBroadcastHandler] Broadcast completed",
		);
	} catch (error) {
		logger.error(
			{ error, roomName, event },
			"[WebSocketBroadcastHandler] Failed to broadcast",
		);
		// Don't throw - WebSocket broadcast is best-effort
		// The client should poll or reconnect if they miss messages
	}
}
