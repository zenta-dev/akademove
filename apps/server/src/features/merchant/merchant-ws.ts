import { env } from "cloudflare:workers";
import { type MerchantEnvelope, MerchantEnvelopeSchema } from "@repo/schema/ws";
import { nullsToUndefined } from "@repo/shared";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getServices } from "@/core/factory";
import type { ServiceContext } from "@/core/interface";
import { toNumberSafe } from "@/utils";
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
 * - NEW_DATA: Response to CHECK_NEW_DATA with updated order list
 * - NO_DATA: Response when no changes since lastKnownVersion
 *
 * This enables merchants to see new incoming orders instantly without polling.
 */
export class MerchantRoom extends BaseDurableObject {
	#svc: ServiceContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
	}

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

		// Handle client-to-server actions
		if (data.t === "s" && data.a !== undefined) {
			try {
				if (data.a === "CHECK_NEW_DATA") {
					await this.#handleCheckNewData(ws, data);
				}
			} catch (error) {
				logger.error(
					{ error, action: data.a },
					"[MerchantRoom] WebSocket message handler failed",
				);
			}
		}

		logger.debug(
			{ event: data.e, action: data.a },
			"[MerchantRoom] Received message",
		);
	}

	/**
	 * Handle CHECK_NEW_DATA action - client asks if there's new data since lastKnownVersion
	 * This replaces HTTP polling with WebSocket-based data sync
	 *
	 * Client sends: { a: "CHECK_NEW_DATA", p: { syncRequest: { merchantId, lastKnownVersion } } }
	 * Server responds:
	 *   - NEW_DATA with list of active orders if data changed
	 *   - NO_DATA if no changes since lastKnownVersion
	 */
	async #handleCheckNewData(ws: WebSocket, data: MerchantEnvelope) {
		const syncRequest = data.p.syncRequest;
		if (!syncRequest) {
			logger.warn(
				data,
				"[MerchantRoom] Invalid CHECK_NEW_DATA payload - missing syncRequest",
			);
			return;
		}

		const { merchantId, lastKnownVersion } = syncRequest;

		try {
			// Fetch merchant's active orders (pending/accepted/preparing/ready statuses)
			// Using correct status values from ORDER_STATUSES constants
			const activeOrders = await this.#svc.db.query.order.findMany({
				where: (f, op) =>
					op.and(
						op.eq(f.merchantId, merchantId),
						op.inArray(f.status, [
							"REQUESTED",
							"MATCHING",
							"ACCEPTED",
							"PREPARING",
							"READY_FOR_PICKUP",
							"ARRIVING",
							"IN_TRIP",
						]),
					),
				orderBy: (f, op) => op.desc(f.createdAt),
				with: {
					items: {
						with: {
							menu: true,
						},
					},
				},
			});

			// Calculate version based on the most recent update across all active orders
			// If no orders, use epoch as version
			let currentVersion = "1970-01-01T00:00:00.000Z";
			if (activeOrders.length > 0) {
				const latestUpdate = activeOrders.reduce((latest, order) => {
					const orderTime = order.updatedAt.getTime();
					return orderTime > latest ? orderTime : latest;
				}, 0);
				currentVersion = new Date(latestUpdate).toISOString();
			}

			// Compare versions - if lastKnownVersion is missing or different, send new data
			const hasNewData =
				!lastKnownVersion || lastKnownVersion !== currentVersion;

			if (hasNewData) {
				// Compose orders for response - convert numeric fields and transform items
				const composedOrders = activeOrders.map((order) => {
					// Transform order items to expected format: { quantity, item: MerchantMenu }
					const composedItems = order.items
						?.filter(
							(
								item,
							): item is typeof item & {
								menu: NonNullable<typeof item.menu>;
							} => item.menu !== null,
						)
						.map((item) => ({
							quantity: item.quantity,
							item: {
								id: item.menu.id,
								merchantId: item.menu.merchantId,
								name: item.menu.name,
								category: item.menu.category ?? undefined,
								price: toNumberSafe(item.menu.price),
								stock: item.menu.stock,
								image: item.menu.image ?? undefined,
								createdAt: item.menu.createdAt,
								updatedAt: item.menu.updatedAt,
							},
						}));

					// Destructure to exclude raw items, then add transformed items
					const { items: _rawItems, ...orderWithoutItems } = order;

					return {
						...nullsToUndefined(orderWithoutItems),
						basePrice: toNumberSafe(order.basePrice),
						totalPrice: toNumberSafe(order.totalPrice),
						tip: order.tip ? toNumberSafe(order.tip) : undefined,
						platformCommission: order.platformCommission
							? toNumberSafe(order.platformCommission)
							: undefined,
						driverEarning: order.driverEarning
							? toNumberSafe(order.driverEarning)
							: undefined,
						merchantCommission: order.merchantCommission
							? toNumberSafe(order.merchantCommission)
							: undefined,
						discountAmount: order.discountAmount
							? toNumberSafe(order.discountAmount)
							: undefined,
						items: composedItems,
						itemCount: composedItems?.length,
					};
				});

				const newDataResponse: MerchantEnvelope = {
					e: "NEW_DATA",
					f: "s",
					t: "c",
					p: {
						merchantId,
						orders: composedOrders,
						syncRequest: {
							merchantId,
							lastKnownVersion: currentVersion,
						},
					},
				};

				logger.debug(
					{
						merchantId,
						previousVersion: lastKnownVersion,
						currentVersion,
						orderCount: activeOrders.length,
					},
					"[MerchantRoom] Sending NEW_DATA response",
				);
				ws.send(JSON.stringify(newDataResponse));
			} else {
				// No changes since last known version
				const noDataResponse: MerchantEnvelope = {
					e: "NO_DATA",
					f: "s",
					t: "c",
					p: {
						syncRequest: {
							merchantId,
							lastKnownVersion: currentVersion,
						},
					},
				};

				logger.debug(
					{ merchantId, version: currentVersion },
					"[MerchantRoom] Sending NO_DATA response - no changes",
				);
				ws.send(JSON.stringify(noDataResponse));
			}
		} catch (error) {
			logger.error(
				{ error, merchantId },
				"[MerchantRoom] Failed to handle CHECK_NEW_DATA",
			);
			// Send NO_DATA on error to avoid blocking client
			const errorResponse: MerchantEnvelope = {
				e: "NO_DATA",
				f: "s",
				t: "c",
				p: {},
			};
			ws.send(JSON.stringify(errorResponse));
		}
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
