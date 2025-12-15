/**
 * WebSocket Broadcast Handler
 *
 * Handles WEBSOCKET_BROADCAST queue messages.
 * Broadcasts messages to connected clients via Durable Objects.
 *
 * Supports two message formats:
 * 1. Event-based (e field): { e: "COMPLETED", f: "s", t: "c", ... }
 * 2. Action-based (a field): { a: "MATCHING", f: "s", t: "c", ... }
 *
 * Both formats use t: "c" (to client) since broadcasts always go TO clients.
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

	logger.info(
		{ roomName, event, action, target, hasData: !!data },
		"[WebSocketBroadcastHandler] Processing broadcast job",
	);

	try {
		// Get the Durable Object stub for the room
		const roomStub = OrderRepository.getRoomStubByName(roomName);

		// Create the broadcast message based on type (event or action)
		// Both action-based (a field) and event-based (e field) messages are broadcast TO CLIENTS
		// The "t" field indicates the intended recipient, which is "c" (client) for broadcasts
		// Note: "t: s" is only used when CLIENT sends a message TO SERVER for processing
		//
		// Per OrderEnvelopeSchema, both `e` (event) and `a` (action) are optional.
		// Driver app checks: envelope.e == OFFER || envelope.a == MATCHING
		// So action-based messages with only `a: "MATCHING"` should work correctly.
		const message = action
			? {
					a: action,
					f: "s", // from server
					t: "c", // to client (broadcasts go to connected WebSocket clients)
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

		logger.info(
			{ roomName, messageType, status: response.status },
			"[WebSocketBroadcastHandler] Broadcast completed successfully",
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
