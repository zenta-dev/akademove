import type { ExecutionContext } from "@cloudflare/workers-types";
import type { OrderStatus } from "@repo/schema/order";
import type { OrderEnvelope } from "@repo/schema/ws";
import { inArray } from "drizzle-orm";
import { getServices } from "@/core/factory";
import { logger } from "@/utils/logger";
import { OrderBaseRepository } from "./repositories/order-base-repository";

/**
 * Active order statuses that need state rebroadcast
 * These are orders that are currently in progress and clients need to stay in sync
 */
const ACTIVE_STATUSES: OrderStatus[] = [
	"REQUESTED",
	"MATCHING",
	"ACCEPTED",
	"PREPARING",
	"READY_FOR_PICKUP",
	"ARRIVING",
	"IN_TRIP",
];

/**
 * Scheduled handler for rebroadcasting active order states
 * Called by Cloudflare Workers cron trigger every minute
 *
 * Purpose:
 * - Ensures clients stay in sync with server state even if WebSocket messages were missed
 * - Handles race conditions where status changes might not have been properly broadcast
 * - Acts as a heartbeat for active orders, keeping clients informed of current state
 *
 * This is particularly useful when:
 * - WebSocket connection was temporarily unstable
 * - Client reconnected after being offline
 * - Race condition caused a missed broadcast
 */
export async function handleOrderRebroadcastCron(
	_env: Env,
	_ctx: ExecutionContext,
): Promise<Response> {
	try {
		logger.info(
			{},
			"[OrderRebroadcastCron] Starting active order state rebroadcast",
		);

		const svc = getServices();
		const now = new Date();
		let rebroadcastCount = 0;
		let errorCount = 0;

		// Get all active orders with their related data
		const activeOrders = await svc.db.query.order.findMany({
			where: (f, _op) => inArray(f.status, ACTIVE_STATUSES),
			with: {
				user: { columns: { name: true, image: true } },
				driver: {
					with: {
						user: {
							columns: {
								name: true,
								phone: true,
								image: true,
							},
						},
					},
				},
				merchant: { columns: { id: true, name: true } },
			},
			limit: 500, // Process up to 500 active orders per cron run
		});

		logger.info(
			{ activeOrderCount: activeOrders.length },
			"[OrderRebroadcastCron] Found active orders to rebroadcast",
		);

		// Process each active order and broadcast current state
		for (const order of activeOrders) {
			try {
				// Get the room stub for this order
				const stub = OrderBaseRepository.getRoomStubByName(order.id);

				// Compose the order entity properly
				// The composed order includes driver info via the `driver` relation
				const composedOrder = await OrderBaseRepository.composeEntity(
					order as Parameters<typeof OrderBaseRepository.composeEntity>[0],
					svc.storage,
				);

				// Build the broadcast payload with current order state
				// Note: driverAssigned is omitted as the order already contains driver info
				// This is a state sync broadcast, not a driver assignment notification
				const payload: OrderEnvelope = {
					e: "ORDER_STATUS_CHANGED",
					f: "s",
					t: "c",
					p: {
						detail: {
							order: composedOrder,
							payment: null,
							transaction: null,
						},
					},
				};

				// Send broadcast request to the Durable Object
				await stub.fetch(
					new Request("http://internal/broadcast", {
						method: "POST",
						headers: { "Content-Type": "application/json" },
						body: JSON.stringify(payload),
					}),
				);

				rebroadcastCount++;

				logger.debug(
					{
						orderId: order.id,
						status: order.status,
						userId: order.userId,
						driverId: order.driverId,
					},
					"[OrderRebroadcastCron] Rebroadcast order state",
				);
			} catch (error) {
				errorCount++;
				logger.error(
					{ error, orderId: order.id },
					"[OrderRebroadcastCron] Failed to rebroadcast order state",
				);
			}
		}

		logger.info(
			{
				rebroadcastCount,
				errorCount,
				totalActiveOrders: activeOrders.length,
				duration: Date.now() - now.getTime(),
			},
			"[OrderRebroadcastCron] Completed active order state rebroadcast",
		);

		return new Response(
			`Order rebroadcast completed. Rebroadcast ${rebroadcastCount} orders, ${errorCount} errors.`,
			{ status: 200 },
		);
	} catch (error) {
		logger.error(
			{ error },
			"[OrderRebroadcastCron] Failed to rebroadcast orders",
		);
		return new Response("Order rebroadcast failed", { status: 500 });
	}
}
