import { env } from "cloudflare:workers";
import type {
	FoodPricingConfiguration,
	PricingConfiguration,
} from "@repo/schema";
import type { Order } from "@repo/schema/order";
import {
	type MerchantEnvelope,
	type OrderEnvelope,
	OrderEnvelopeSchema,
} from "@repo/schema/ws";
import Decimal from "decimal.js";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { CONFIGURATION_KEYS } from "@/core/constants";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
import { BadgeAwardService } from "@/features/badge/services/badge-award-service";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

export class OrderRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
	}

	broadcast(message: OrderEnvelope, opts?: BroadcastOptions): void {
		const parse = OrderEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			logger.warn(
				{ zodError: parse.error, message },
				"[OrderRoom] Invalid order WS message - validation failed",
			);
			return;
		}
		logger.debug(
			{
				event: parse.data.e,
				action: parse.data.a,
				target: parse.data.tg,
				sessionCount: this.sessions.size,
			},
			"[OrderRoom] Broadcasting message to connected sessions",
		);
		super.broadcast(parse.data, opts);
	}

	/**
	 * Handle HTTP requests and WebSocket upgrades
	 * Supports POST /broadcast for REST API to trigger WebSocket broadcasts
	 *
	 * Accepts two formats:
	 * 1. Direct OrderEnvelope: { e: "...", f: "s", t: "c", p: {...} }
	 * 2. Wrapped format from queue handler: { message: OrderEnvelope, excludeUserIds?: string[] }
	 */
	async fetch(request: Request): Promise<Response> {
		const url = new URL(request.url);

		// Handle broadcast requests from REST API handlers
		if (request.method === "POST" && url.pathname.endsWith("/broadcast")) {
			try {
				const body = (await request.json()) as
					| OrderEnvelope
					| { message: OrderEnvelope; excludeUserIds?: string[] };

				logger.debug(
					{ body, roomId: this.ctx.id.toString() },
					"[OrderRoom] Received broadcast request",
				);

				// FIX: Handle both direct OrderEnvelope and wrapped format from WebSocketBroadcastHandler
				// The queue handler wraps the message in { message, excludeUserIds }
				const isWrappedFormat =
					body !== null &&
					typeof body === "object" &&
					"message" in body &&
					body.message !== null &&
					typeof body.message === "object";

				const envelope = isWrappedFormat
					? (body as { message: OrderEnvelope; excludeUserIds?: string[] })
							.message
					: (body as OrderEnvelope);
				const excludeUserIds = isWrappedFormat
					? (body as { message: OrderEnvelope; excludeUserIds?: string[] })
							.excludeUserIds
					: undefined;

				logger.debug(
					{
						envelope,
						isWrappedFormat,
						excludeUserIds,
						connectedSessions: this.sessions.size,
					},
					"[OrderRoom] Parsed broadcast envelope",
				);

				// Convert excludeUserIds to WebSocket array for broadcast options
				const excludes = excludeUserIds?.length
					? this.findByIds(excludeUserIds)
					: undefined;

				this.broadcast(envelope, excludes ? { excludes } : undefined);
				return new Response(JSON.stringify({ success: true }), {
					status: 200,
					headers: { "Content-Type": "application/json" },
				});
			} catch (error) {
				logger.error({ error }, "[OrderRoom] Failed to broadcast message");
				return new Response(
					JSON.stringify({ success: false, error: "Failed to broadcast" }),
					{ status: 500, headers: { "Content-Type": "application/json" } },
				);
			}
		}

		// Default: handle WebSocket upgrade
		return super.fetch(request);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);
		const session = this.findUserIdBySocket(ws);
		if (!session) throw new Error("Session not found");

		const { success, data } = await OrderEnvelopeSchema.safeParseAsync(
			JSON.parse(message.toString()),
		);
		if (!success) {
			logger.warn(data, "Invalid order WS message format");
			return;
		}

		// Handle client → server actions (a field)
		// Only 2 actions supported: DRIVER_UPDATE_LOCATION and DRIVER_COMPLETE_ORDER
		if (data.t === "s" && data.a !== undefined) {
			try {
				if (data.a === "DRIVER_UPDATE_LOCATION") {
					await this.#handleDriverUpdateLocation(ws, data);
				}
				if (data.a === "DRIVER_COMPLETE_ORDER") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleOrderDone(ws, data, tx),
					);
				}
				if (data.a === "CHECK_NEW_DATA") {
					await this.#handleCheckNewData(ws, data);
				}
			} catch (error) {
				logger.error(
					{ error, action: data.a, userId: session },
					"[OrderRoom] WebSocket message handler failed - transaction rolled back",
				);
				// Close the WebSocket connection on critical errors
				ws.close(1011, "An error occurred while processing your request");
			}
		}
	}

	async #handleDriverUpdateLocation(ws: WebSocket, data: OrderEnvelope) {
		const driverLocation = data.p.driverUpdateLocation;

		// Persist driver location if provided (with deduplication handled by handler)
		if (
			driverLocation?.driverId &&
			driverLocation.x != null &&
			driverLocation.y != null
		) {
			try {
				// Get current driver location for deduplication check
				const driver = await this.#repo.driver.main.get(
					driverLocation.driverId,
				);
				const currentLocation = driver.currentLocation;

				// Skip DB write if location hasn't changed (deduplication)
				const isSameLocation =
					currentLocation != null &&
					currentLocation.x === driverLocation.x &&
					currentLocation.y === driverLocation.y;

				if (!isSameLocation) {
					await this.#repo.driver.main.updateLocation(driverLocation.driverId, {
						x: driverLocation.x,
						y: driverLocation.y,
					});
					logger.debug(
						{
							driverId: driverLocation.driverId,
							x: driverLocation.x,
							y: driverLocation.y,
						},
						"[OrderRoom] Driver location persisted via WebSocket",
					);
				} else {
					logger.debug(
						{ driverId: driverLocation.driverId },
						"[OrderRoom] Skipping location persist - same as current",
					);
				}
			} catch (error) {
				// Log error but don't fail the broadcast - location update is best-effort
				logger.error(
					{ error, driverId: driverLocation.driverId },
					"[OrderRoom] Failed to persist driver location via WebSocket",
				);
			}
		}

		// Always broadcast to connected clients regardless of persistence result
		const payload: OrderEnvelope = {
			e: "DRIVER_LOCATION_UPDATE",
			f: "s",
			t: "c",
			p: data.p,
		};
		this.broadcast(payload, { excludes: [ws] });
	}

	/**
	 * Handle CHECK_NEW_DATA action - client requesting current order state
	 *
	 * This is called after a WebSocket client connects to get the current order state.
	 * Server responds with NEW_DATA (with current order) or NO_DATA (if order not found).
	 */
	async #handleCheckNewData(ws: WebSocket, data: OrderEnvelope) {
		const syncRequest = data.p.syncRequest;
		if (!syncRequest?.orderId) {
			logger.warn(data, "[OrderRoom] CHECK_NEW_DATA missing orderId");
			const noDataPayload: OrderEnvelope = {
				e: "NO_DATA",
				f: "s",
				t: "c",
				p: {},
			};
			ws.send(JSON.stringify(noDataPayload));
			return;
		}

		try {
			// Fetch current order with related data
			const order = await this.#repo.order.get(syncRequest.orderId);

			// Check if client already has the latest version (delta sync)
			const serverVersion = order.updatedAt.toISOString();
			if (
				syncRequest.lastKnownVersion &&
				syncRequest.lastKnownVersion === serverVersion
			) {
				logger.debug(
					{ orderId: order.id, version: serverVersion },
					"[OrderRoom] Client has latest data - sending NO_DATA",
				);
				const noDataPayload: OrderEnvelope = {
					e: "NO_DATA",
					f: "s",
					t: "c",
					p: {},
				};
				ws.send(JSON.stringify(noDataPayload));
				return;
			}

			// Get payment info using referenceId (orderId in transaction)
			let payment = null;
			let transaction = null;

			try {
				const paymentResult = await this.#svc.db.query.payment.findFirst({
					where: (f, op) =>
						op.and(
							op.like(
								f.metadata as unknown as Parameters<typeof op.like>[0],
								`%"orderId":"${order.id}"%`,
							),
						),
				});

				if (paymentResult) {
					const { PaymentRepository } = await import(
						"@/features/payment/payment-repository"
					);
					payment = PaymentRepository.composeEntity(paymentResult);

					// Get associated transaction
					if (paymentResult.transactionId) {
						const txResult = await this.#svc.db.query.transaction.findFirst({
							where: (f, op) =>
								op.eq(f.id, paymentResult.transactionId as string),
						});
						if (txResult) {
							const { TransactionRepository } = await import(
								"@/features/transaction/transaction-repository"
							);
							transaction = TransactionRepository.composeEntity(txResult);
						}
					}
				}
			} catch {
				// Ignore errors fetching payment/transaction - not critical
				logger.debug(
					{ orderId: order.id },
					"[OrderRoom] Could not fetch payment/transaction for CHECK_NEW_DATA",
				);
			}

			// Get assigned driver if any
			const assignedDriver = order.driverId
				? await this.#repo.driver.main.get(order.driverId)
				: null;

			// Send current order state
			const newDataPayload: OrderEnvelope = {
				e: "NEW_DATA",
				f: "s",
				t: "c",
				p: {
					detail: {
						order,
						payment,
						transaction,
					},
					...(assignedDriver && { driverAssigned: assignedDriver }),
				},
			};

			ws.send(JSON.stringify(newDataPayload));
			logger.debug(
				{ orderId: order.id, status: order.status },
				"[OrderRoom] Sent current order state via NEW_DATA",
			);
		} catch (error) {
			logger.error(
				{ error, orderId: syncRequest.orderId },
				"[OrderRoom] Failed to handle CHECK_NEW_DATA",
			);

			// Send NO_DATA on error (order might not exist)
			const noDataPayload: OrderEnvelope = {
				e: "NO_DATA",
				f: "s",
				t: "c",
				p: {},
			};
			ws.send(JSON.stringify(noDataPayload));
		}
	}

	async #handleOrderDone(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const done = data.p.done;
		if (!done) {
			logger.warn(data, "Invalid order done payload");
			return;
		}

		const opts = { tx };

		// Get order details to calculate commission
		const order = await this.#repo.order.get(done.orderId, opts);

		let key = "";
		if (order.type === "RIDE") {
			key = CONFIGURATION_KEYS.RIDE_SERVICE_PRICING;
		} else if (order.type === "DELIVERY") {
			key = CONFIGURATION_KEYS.DELIVERY_SERVICE_PRICING;
		} else if (order.type === "FOOD") {
			key = CONFIGURATION_KEYS.FOOD_SERVICE_PRICING;
		}

		// Get commission configuration
		const prcingConfig = await this.#repo.configuration.get(key);
		const commissionRates = prcingConfig.value as PricingConfiguration;

		// Calculate commission based on order type
		let commissionRate = 0;
		if (order.type === "RIDE") {
			commissionRate = commissionRates.platformFeeRate;
		} else if (order.type === "DELIVERY") {
			commissionRate = commissionRates.platformFeeRate;
		} else if (order.type === "FOOD") {
			commissionRate = commissionRates.platformFeeRate;
		}

		// Get driver details - needed for wallet lookup and badge commission reduction
		const driver = order.driverId
			? await tx.query.driver.findFirst({
					where: (f, op) => op.eq(f.id, order.driverId ?? ""),
				})
			: null;

		if (!driver?.userId) {
			logger.error(
				{ orderId: order.id, driverId: order.driverId },
				"[OrderRoom] Driver not found or missing userId for order completion",
			);
			return;
		}

		// Apply commission reduction from driver badges
		const driverBadges = await tx.query.userBadge.findMany({
			where: (f, op) => op.eq(f.userId, driver.userId),
			with: { badge: true },
		});

		// Find highest commission reduction from badges
		let maxReduction = 0;
		for (const userBadge of driverBadges) {
			const benefits = userBadge.badge.benefits as
				| { commissionReduction?: number }
				| null
				| undefined;
			const reduction = benefits?.commissionReduction ?? 0;
			if (reduction > maxReduction) {
				maxReduction = reduction;
			}
		}

		// Apply reduction (max 50% per schema)
		if (maxReduction > 0) {
			const originalRate = commissionRate;
			commissionRate = commissionRate * (1 - maxReduction);
			logger.info(
				{
					driverId: order.driverId,
					originalRate,
					reduction: maxReduction,
					finalRate: commissionRate,
				},
				"[OrderRoom] Applied badge commission reduction",
			);
		}

		// Calculate amounts
		const totalPrice = new Decimal(order.totalPrice);
		const platformCommission = totalPrice.times(commissionRate);
		// For FOOD orders, merchantCommissionRate MUST come from config, no fallback allowed
		const merchantCommission =
			order.type === "FOOD"
				? totalPrice.times(
						(commissionRates as FoodPricingConfiguration)
							.merchantCommissionRate,
					)
				: new Decimal(0);
		// FIX: Driver earning should be calculated minus both platform AND merchant commission
		// For FOOD orders, part of the total goes to the merchant
		const driverEarning = totalPrice
			.minus(platformCommission)
			.minus(merchantCommission);

		// Get driver wallet using driver's userId (not driverId)
		const driverwallet = await this.#repo.wallet.getByUserId(
			driver.userId,
			opts,
		);

		// FIX: Perform atomic balance update FIRST to get correct balance values
		// This prevents race condition where transaction records have incorrect balances
		const driverBalanceResult = await this.#svc.walletServices.balance.add(
			{
				walletId: driverwallet.id,
				amount: toNumberSafe(driverEarning.toString()),
			},
			{ tx: opts.tx },
		);

		// Create transaction records for driver earning and platform commission
		// Now using correct balance values from the atomic update
		const [updatedOrder] = await Promise.all([
			// Update order with commission details and store completedDriverId for reviews
			this.#repo.order.update(
				done.orderId,
				{
					status: "COMPLETED",
					completedDriverId: done.driverId,
					platformCommission: toNumberSafe(platformCommission.toString()),
					driverEarning: toNumberSafe(driverEarning.toString()),
					merchantCommission: toNumberSafe(merchantCommission.toString()),
				},
				opts,
			),

			// Credit driver wallet with earnings - using correct balance from atomic update
			this.#repo.transaction.insert(
				{
					walletId: driverwallet.id,
					type: "EARNING",
					amount: toNumberSafe(driverEarning.toString()),
					balanceBefore: driverBalanceResult.balanceBefore,
					balanceAfter: driverBalanceResult.balanceAfter,
					status: "SUCCESS",
					description: `Driver earning for order #${order.id.slice(0, 8)}`,
					referenceId: order.id,
					metadata: {
						orderId: order.id,
						orderType: order.type,
						totalPrice: toNumberSafe(totalPrice.toString()),
						commissionRate,
					},
				},
				opts,
			),

			// Record platform commission
			this.#repo.transaction.insert(
				{
					walletId: driverwallet.id, // Use driver wallet for tracking
					type: "COMMISSION",
					amount: toNumberSafe(platformCommission.toString()),
					status: "SUCCESS",
					description: `Platform commission for order #${order.id.slice(0, 8)}`,
					referenceId: order.id,
					metadata: {
						orderId: order.id,
						orderType: order.type,
						totalPrice: toNumberSafe(totalPrice.toString()),
						commissionRate,
					},
				},
				opts,
			),

			// Update driver availability
			this.#repo.driver.main.update(
				done.driverId,
				{
					isTakingOrder: false,
					currentLocation: done.driverCurrentLocation,
				},
				opts,
			),
		]);

		// Award badges to driver after order completion
		if (order.driverId) {
			const badgeAwardService = new BadgeAwardService(this.#svc.db, this.#repo);
			await badgeAwardService
				.evaluateAndAwardBadges(order.driverId, opts)
				.catch((error) => {
					logger.error(
						{ error, driverId: order.driverId },
						"[OrderRoom] Failed to award badges",
					);
				});
		}

		logger.info(
			{
				orderId: order.id,
				orderType: order.type,
				totalPrice: toNumberSafe(totalPrice.toString()),
				platformCommission: toNumberSafe(platformCommission.toString()),
				driverEarning: toNumberSafe(driverEarning.toString()),
				merchantCommission: toNumberSafe(merchantCommission.toString()),
			},
			"[OrderRoom] Commission calculated and distributed",
		);

		// Broadcast COMPLETED event with updated order details
		// User cubit expects p.detail.order to update UI
		const completedPayload: OrderEnvelope = {
			e: "ORDER_COMPLETED",
			f: "s",
			t: "c",
			p: {
				detail: {
					order: updatedOrder,
					payment: null,
					transaction: null,
				},
			},
		};
		this.broadcast(completedPayload, { excludes: [ws] });

		// Send push notification to user as fallback for when WebSocket is disconnected
		// This ensures user is notified even if their app is in background or WebSocket failed
		await this.#repo.notification.sendNotificationToUserId({
			fromUserId: order.driverId ?? "",
			toUserId: order.userId,
			title: "Trip Completed",
			body: `Your ${order.type.toLowerCase()} order has been completed. Please rate your driver.`,
			data: {
				type: "ORDER_COMPLETED",
				orderId: order.id,
				deeplink: `akademove://order/${order.id}/rate`,
			},
			android: {
				priority: "high",
				notification: { clickAction: "USER_RATE_DRIVER" },
			},
			apns: {
				payload: { aps: { category: "ORDER_COMPLETED", sound: "default" } },
			},
		});

		// Notify MerchantRoom if this is a FOOD order
		if (updatedOrder.merchantId && updatedOrder.type === "FOOD") {
			await this.#notifyMerchantRoom(
				updatedOrder.merchantId,
				"ORDER_COMPLETED",
				updatedOrder,
			);
		}

		logger.info(
			{ orderId: order.id, userId: order.userId },
			"[OrderRoom] Order completion notification sent to user",
		);
	}

	/**
	 * Notifies MerchantRoom of order events
	 * Used to sync merchant dashboard when driver accepts or order completes
	 *
	 * @param merchantId - Merchant ID to notify
	 * @param event - Event type (DRIVER_ASSIGNED, ORDER_COMPLETED, ORDER_CANCELLED)
	 * @param order - Order data
	 * @param driverName - Optional driver name for DRIVER_ASSIGNED event
	 */
	async #notifyMerchantRoom(
		merchantId: string,
		event: MerchantEnvelope["e"],
		order: Order,
		driverName?: string,
	): Promise<void> {
		try {
			const stub = env.MERCHANT_ROOM.idFromName(merchantId);
			const room = env.MERCHANT_ROOM.get(stub);

			const payload: MerchantEnvelope = {
				e: event,
				f: "s",
				t: "c",
				p: {
					order,
					orderId: order.id,
					merchantId,
					newStatus: order.status,
					...(driverName && { driverName }),
				},
			};

			await room.fetch("https://internal/broadcast", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify(payload),
			});

			logger.debug(
				{ orderId: order.id, merchantId, event },
				"[OrderRoom] MerchantRoom notified",
			);
		} catch (error) {
			// Non-critical - log and continue
			logger.warn(
				{ error, orderId: order.id, merchantId, event },
				"[OrderRoom] Failed to notify MerchantRoom - non-critical",
			);
		}
	}
}
