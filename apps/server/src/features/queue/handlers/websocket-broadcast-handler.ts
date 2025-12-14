/**
 * WebSocket Broadcast Handler
 *
 * Handles WEBSOCKET_BROADCAST queue messages.
 * Broadcasts messages to connected clients via Durable Objects.
 *
 * Supports two message formats:
 * 1. Event-based (e field): { e: "COMPLETED", f: "s", t: "c", ... }
 * 2. Action-based (a field): { a: "MATCHING", f: "s", t: "s", ... }
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
	const { roomName, event, action, target, data, excludeUserIds } = payload;

	const messageType = action ?? event;

	logger.debug(
		{ roomName, event, action, target },
		"[WebSocketBroadcastHandler] Broadcasting message",
	);

	try {
		// Get the Durable Object stub for the room
		const roomStub = OrderRepository.getRoomStubByName(roomName);

		// Create the broadcast message based on type (event or action)
		// Action-based messages (a field) are used for MATCHING and similar server-to-server actions
		// Event-based messages (e field) are used for client notifications
		const message = action
			? {
					a: action,
					f: "s", // from server
					t: "s", // to server (action-based messages are processed by DO)
					tg: target,
					p: data,
				}
			: {
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
			{ roomName, messageType },
			"[WebSocketBroadcastHandler] Broadcast completed",
		);
	} catch (error) {
		logger.error(
			{ error, roomName, messageType },
			"[WebSocketBroadcastHandler] Failed to broadcast",
		);
		// Don't throw - WebSocket broadcast is best-effort
		// The client should poll or reconnect if they miss messages
	}
}
