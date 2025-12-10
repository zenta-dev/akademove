import { env } from "cloudflare:workers";
import type {
	FoodPricingConfiguration,
	PricingConfiguration,
} from "@repo/schema";
import { type OrderEnvelope, OrderEnvelopeSchema } from "@repo/schema/ws";
import Decimal from "decimal.js";
import { sql } from "drizzle-orm";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { BUSINESS_CONSTANTS, CONFIGURATION_KEYS } from "@/core/constants";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
import { BadgeAwardService } from "@/features/badge/services/badge-award-service";
import { BusinessConfigurationService } from "@/features/configuration/services";
import { DriverPriorityService } from "@/features/driver/services/driver-priority-service";
import { OrderCancellationService } from "@/features/order/services/order-cancellation-service";
import { OrderRefundService } from "@/features/order/services/order-refund-service";
import { safeSync, toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

type OrderId = string;
export class OrderRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;
	#broadcasted: Map<OrderId, WebSocket[]>;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
		this.#broadcasted = new Map();
	}

	broadcast(message: OrderEnvelope, opts?: BroadcastOptions): void {
		const parse = OrderEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			logger.warn(parse, "Invalid order WS message");
			return;
		}
		super.broadcast(parse.data, opts);
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

		if (data.t === "s" && data.a !== undefined) {
			try {
				if (data.a === "MATCHING") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleOrderMatching(ws, data, tx),
					);
				}
				if (data.a === "UPDATE_LOCATION") {
					await this.#handleDriverUpdateLocation(ws, data);
				}
				if (data.a === "ACCEPTED") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleOrderAccepted(ws, data, tx),
					);
				}
				if (data.a === "DONE") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleOrderDone(ws, data, tx),
					);
				}
				if (data.a === "SEND_MESSAGE") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleChatMessage(ws, data, tx),
					);
				}
				if (data.a === "MERCHANT_ACCEPT") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleMerchantAccept(ws, data, tx),
					);
				}
				if (data.a === "MERCHANT_REJECT") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleMerchantReject(ws, data, tx),
					);
				}
				if (data.a === "MERCHANT_MARK_PREPARING") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleMerchantMarkPreparing(ws, data, tx),
					);
				}
				if (data.a === "MERCHANT_MARK_READY") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleMerchantMarkReady(ws, data, tx),
					);
				}
				if (data.a === "REPORT_NO_SHOW") {
					await this.#svc.db.transaction(
						async (tx) => await this.#handleNoShow(ws, data, tx),
					);
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

	async #handleOrderMatching(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const opts = { tx };
		const detail = data.p.detail;
		if (!detail) {
			logger.warn(data, "Invalid order matching payload");
			return;
		}

		const findOrder = await this.#repo.order.get(detail.order.id, opts);

		// REFACTOR: Use OrderMatchingService for driver discovery with timeout expansion
		// Service encapsulates matching business logic (radius, gender preference, availability)
		// Uses 30s timeout with 20% radius expansion on each attempt
		const matchedDrivers =
			await this.#svc.orderServices.matching.findDriversWithTimeoutExpansion(
				{
					orderId: findOrder.id,
					pickupLocation: findOrder.pickupLocation,
					orderType: findOrder.type,
					genderPreference: findOrder.genderPreference,
					userGender: findOrder.gender,
					radiusKm: BUSINESS_CONSTANTS.DRIVER_MATCHING_RADIUS_KM, // Initial radius from constants
				},
				BUSINESS_CONSTANTS.DRIVER_MATCHING_MAX_EXPANSION_ATTEMPTS, // Max expansion attempts from constants
				opts,
			);

		// Extract driver data for compatibility with existing code
		let nearbyDrivers = matchedDrivers.map((m) => m.driver);

		// Sort drivers by priority (badges + leaderboard rank)
		if (nearbyDrivers.length > 0) {
			const driverPriorityService = new DriverPriorityService(this.#svc.db);
			const driverIds = nearbyDrivers
				.map((d) => d.id)
				.filter((id): id is string => id !== null && id !== undefined);
			const sortedDrivers = await driverPriorityService.sortDriversByPriority(
				driverIds,
				opts,
			);

			// Reorder nearbyDrivers based on priority
			nearbyDrivers = sortedDrivers
				.map((pd) => nearbyDrivers.find((d) => d.id === pd.driverId))
				.filter(
					(d): d is NonNullable<typeof d> => d !== null && d !== undefined,
				);

			logger.info(
				{
					orderId: findOrder.id,
					availableDrivers: nearbyDrivers.length,
					sortedByPriority: true,
				},
				"[OrderRoom] Drivers sorted by priority (badges + leaderboard)",
			);
		}

		logger.info(
			{
				orderId: findOrder.id,
				availableDrivers: nearbyDrivers.length,
			},
			"[OrderRoom] Driver matching completed via OrderMatchingService",
		);

		if (nearbyDrivers.length === 0) {
			logger.warn(
				{ orderId: findOrder.id, userId: findOrder.userId },
				"[OrderRoom] No nearby driver found — cancelling order and processing refund",
			);

			const paymentId = detail.payment?.id;
			const [updatedOrder, findPayment] = await Promise.all([
				this.#repo.order.update(
					findOrder.id,
					{
						status: "CANCELLED_BY_SYSTEM",
						cancelReason: "No driver around you",
					},
					opts,
				),
				paymentId
					? opts.tx.query.payment.findFirst({
							with: { transaction: { with: { wallet: true } } },
							where: (f, op) => op.eq(f.id, paymentId),
						})
					: Promise.resolve(null),
			]);

			const response: OrderEnvelope = {
				e: "CANCELED",
				f: "s",
				t: "c",
				p: data.p,
			};

			if (findPayment) {
				try {
					const { transaction } = findPayment;
					const wallet = transaction.wallet;
					const refundAmount = updatedOrder.totalPrice;

					// Use atomic balance add service for refund
					const { balanceBefore, balanceAfter } =
						await this.#svc.walletServices.balance.add(
							{ walletId: wallet.id, amount: refundAmount },
							{ tx: opts.tx },
						);

					const [updatedTransaction, updatedPayment] = await Promise.all([
						this.#repo.transaction.update(
							transaction.id,
							{
								status: "REFUNDED",
								balanceBefore,
								balanceAfter,
							},
							opts,
						),
						this.#repo.payment.update(
							findPayment.id,
							{ status: "REFUNDED" },
							opts,
						),
					]);

					data.p = {
						detail: {
							transaction: updatedTransaction,
							payment: updatedPayment,
							order: updatedOrder,
						},
					};

					logger.info(
						{
							orderId: updatedOrder.id,
							userId: wallet.userId,
							refundAmount,
						},
						"[OrderRoom] Refund processed successfully",
					);
				} catch (refundError) {
					logger.error(
						{
							error: refundError,
							orderId: updatedOrder.id,
							paymentId: findPayment.id,
						},
						"[OrderRoom] Failed to process refund - transaction will be rolled back",
					);
					throw refundError; // Re-throw to trigger transaction rollback
				}
			}

			ws.send(JSON.stringify(response));
			ws.close(1000, "No driver around you");
			return;
		}

		const envelope: OrderEnvelope = {
			e: "OFFER",
			f: "s",
			t: "c",
			tg: "DRIVER",
			p: data.p,
		};
		const msg = JSON.stringify(envelope);

		const tasks: Promise<unknown>[] = [];
		const driverIds: string[] = [];
		for (const driver of nearbyDrivers) {
			// Skip drivers without required fields
			if (!driver.userId || !driver.id) {
				logger.warn(
					{ driver },
					"[OrderRoom] Skipping driver with missing fields",
				);
				continue;
			}

			const driverWs = this.findById(driver.userId);
			if (driverWs) {
				driverWs.send(msg);
				driverIds.push(driver.id);
			}
			const orderUrl = `${env.CORS_ORIGIN}/dash/merchant/orders/${findOrder.id}`;
			tasks.push(
				this.#repo.notification.sendNotificationToUserId({
					fromUserId: findOrder.userId,
					toUserId: driver.id,
					title: "New Order",
					body: `Order ${findOrder.type} with id #${findOrder.id}`,
					data: {
						type: "NEW_ORDER",
						orderId: findOrder.id,
						deeplink: `akademove://driver/order/${findOrder.id}`,
					},
					android: {
						priority: "high",
						notification: { clickAction: "DRIVER_OPEN_ORDER_DETAIL" },
					},
					apns: {
						payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
					},
					webpush: { fcmOptions: { link: orderUrl } },
				}),
			);
		}
		const driversWs = this.findByIds(driverIds);
		this.#broadcasted.set(findOrder.id, driversWs);

		await Promise.allSettled(tasks);
	}

	async #handleOrderAccepted(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const detail = data.p.detail;

		if (!detail) {
			logger.warn(data, "Invalid order accepted payload");
			return;
		}

		const userId = detail.order.userId;
		const orderId = detail.order.id;

		const driverId = this.findUserIdBySocket(ws);
		if (!driverId) return;

		const opts = { tx };

		// Use SELECT FOR UPDATE to prevent race condition when multiple drivers accept
		// This locks the order row until the transaction completes
		// FIX: Use parameterized query to prevent SQL injection
		const lockedOrderResult = await tx.execute(
			sql`SELECT * FROM "order" WHERE id = ${orderId} FOR UPDATE NOWAIT`,
		);
		const lockedOrder = lockedOrderResult[0] as
			| { id: string; status: string; type: string; driverId: string | null }
			| undefined;

		// Check if order is still available (not already accepted by another driver)
		if (
			lockedOrder?.status !== "MATCHING" &&
			lockedOrder?.status !== "REQUESTED"
		) {
			logger.warn(
				{ orderId, currentStatus: lockedOrder?.status, driverId },
				"[OrderRoom] Order already accepted by another driver",
			);

			// Notify this driver that the order is no longer available
			const unavailablePayload: OrderEnvelope = {
				e: "UNAVAILABLE",
				f: "s",
				t: "c",
				tg: "DRIVER",
				p: { cancelReason: "Order already accepted by another driver" },
			};
			ws.send(JSON.stringify(unavailablePayload));
			return;
		}

		// For FOOD orders, validate stock availability before accepting
		// This prevents accepting orders for out-of-stock items
		if (lockedOrder?.type === "FOOD") {
			try {
				const { OrderValidationService } = await import(
					"@/features/order/services/order-validation-service"
				);
				await OrderValidationService.validateStockAvailability(orderId, tx);
			} catch (stockError) {
				logger.warn(
					{ orderId, driverId, error: stockError },
					"[OrderRoom] FOOD order rejected due to insufficient stock",
				);

				// Notify driver that order cannot be accepted due to stock issues
				const stockErrorPayload: OrderEnvelope = {
					e: "UNAVAILABLE",
					f: "s",
					t: "c",
					tg: "DRIVER",
					p: {
						cancelReason:
							stockError instanceof Error
								? stockError.message
								: "Some items are out of stock",
					},
				};
				ws.send(JSON.stringify(stockErrorPayload));
				return;
			}
		}

		// FIX: Atomically check and update driver's isTakingOrder status
		// Use SELECT FOR UPDATE NOWAIT on driver to prevent race condition
		// where driver could accept multiple orders simultaneously
		const lockedDriverResult = await tx.execute(
			sql`SELECT id, "isTakingOrder" FROM "driver" WHERE id = ${driverId} FOR UPDATE NOWAIT`,
		);
		const lockedDriver = lockedDriverResult[0] as
			| { id: string; isTakingOrder: boolean }
			| undefined;

		if (!lockedDriver) {
			logger.warn({ orderId, driverId }, "[OrderRoom] Driver not found");
			const errorPayload: OrderEnvelope = {
				e: "UNAVAILABLE",
				f: "s",
				t: "c",
				tg: "DRIVER",
				p: { cancelReason: "Driver not found" },
			};
			ws.send(JSON.stringify(errorPayload));
			return;
		}

		// Check if driver is already taking an order
		if (lockedDriver.isTakingOrder) {
			logger.warn(
				{ orderId, driverId },
				"[OrderRoom] Driver is already taking another order",
			);
			const busyPayload: OrderEnvelope = {
				e: "UNAVAILABLE",
				f: "s",
				t: "c",
				tg: "DRIVER",
				p: { cancelReason: "You are already taking another order" },
			};
			ws.send(JSON.stringify(busyPayload));
			return;
		}

		// Now safe to update - we have locks on both order and driver
		const [updatedOrder, updatedDriver] = await Promise.all([
			this.#repo.order.update(orderId, { status: "ACCEPTED", driverId }, opts),
			this.#repo.driver.main.update(driverId, { isTakingOrder: true }, opts),
		]);
		detail.order = updatedOrder;

		// Notify other drivers that the order is no longer available
		const broadcastedDrivers = this.#broadcasted.get(orderId);

		if (broadcastedDrivers) {
			for (const driverWs of broadcastedDrivers) {
				if (
					driverWs === ws ||
					!driverWs.readyState ||
					driverWs.readyState !== WebSocket.OPEN
				) {
					continue;
				}
				const unavailablePayload: OrderEnvelope = {
					e: "UNAVAILABLE",
					f: "s",
					t: "c",
					tg: "DRIVER",
					p: {},
				};
				safeSync(() => driverWs.send(JSON.stringify(unavailablePayload)));
			}

			this.#broadcasted.delete(orderId);
		}

		const userWs = this.findById(userId);

		const acceptedPayload: OrderEnvelope = {
			e: "DRIVER_ACCEPTED",
			f: "s",
			t: "c",
			p: {
				detail,
				driverAssigned: updatedDriver,
			},
		};

		userWs?.send(JSON.stringify(acceptedPayload));
	}

	async #handleDriverUpdateLocation(ws: WebSocket, data: OrderEnvelope) {
		const payload: OrderEnvelope = {
			e: "DRIVER_LOCATION_UPDATE",
			f: "s",
			t: "c",
			p: data.p,
		};
		this.broadcast(payload, { excludes: [ws] });
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

		// Apply commission reduction from driver badges
		if (order.driverId) {
			const driver = await tx.query.driver.findFirst({
				where: (f, op) => op.eq(f.id, order.driverId ?? ""),
			});

			if (driver?.userId) {
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
			}
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

		// Get driver wallet
		const driverwallet = await this.#repo.wallet.getByUserId(
			order.driverId ?? "",
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
		await Promise.all([
			// Update order with commission details
			this.#repo.order.update(
				done.orderId,
				{
					status: "COMPLETED",
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

		const completedPayload: OrderEnvelope = {
			e: "COMPLETED",
			f: "s",
			t: "c",
			p: data.p,
		};
		this.broadcast(completedPayload, { excludes: [ws] });
	}

	async #handleChatMessage(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const userId = this.findUserIdBySocket(ws);
		if (!userId) {
			logger.warn("[OrderRoom] No userId found for chat message sender");
			return;
		}

		const messagePayload = data.p.message;
		if (!messagePayload) {
			logger.warn(data, "Invalid chat message payload");
			return;
		}

		const opts = { tx };

		try {
			// Create the chat message in the database
			const chatMessage = await this.#repo.chat.create(
				{
					orderId: messagePayload.orderId,
					message: messagePayload.message,
					userId,
				},
				opts,
			);

			logger.info(
				{ messageId: chatMessage.id, orderId: chatMessage.orderId, userId },
				"[OrderRoom] Chat message created",
			);

			// Broadcast the message to all participants except the sender
			const broadcastPayload: OrderEnvelope = {
				e: "CHAT_MESSAGE",
				f: "s",
				t: "c",
				p: {
					message: {
						id: chatMessage.id,
						orderId: chatMessage.orderId,
						senderId: chatMessage.senderId,
						senderName: chatMessage.sender?.name ?? "Unknown",
						message: chatMessage.message,
						sentAt: chatMessage.sentAt,
					},
				},
			};

			this.broadcast(broadcastPayload, { excludes: [ws] });
		} catch (error) {
			logger.error(
				{ error, userId, orderId: messagePayload.orderId },
				"[OrderRoom] Failed to handle chat message",
			);
			throw error;
		}
	}

	async #handleMerchantAccept(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const merchantAction = data.p.merchantAction;
		if (!merchantAction) {
			logger.warn(data, "Invalid merchant accept payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.acceptOrder(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			logger.info(
				{ orderId: updatedOrder.id, merchantId: merchantAction.merchantId },
				"[OrderRoom] Merchant accepted order",
			);

			const response: OrderEnvelope = {
				e: "MERCHANT_ACCEPTED",
				f: "s",
				t: "c",
				p: {
					detail: {
						order: updatedOrder,
						payment: data.p.detail?.payment ?? null,
						transaction: data.p.detail?.transaction ?? null,
					},
				},
			};

			this.broadcast(response, { excludes: [ws] });
		} catch (error) {
			logger.error(
				{ error, merchantAction },
				"[OrderRoom] Failed to handle merchant accept",
			);
			throw error;
		}
	}

	async #handleMerchantReject(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const merchantAction = data.p.merchantAction;
		if (!merchantAction) {
			logger.warn(data, "Invalid merchant reject payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.rejectOrder(
				merchantAction.orderId,
				merchantAction.merchantId,
				merchantAction.reason ?? "Rejected by merchant",
				undefined,
				opts,
			);

			logger.info(
				{
					orderId: updatedOrder.id,
					merchantId: merchantAction.merchantId,
					reason: merchantAction.reason,
				},
				"[OrderRoom] Merchant rejected order",
			);

			const response: OrderEnvelope = {
				e: "MERCHANT_REJECTED",
				f: "s",
				t: "c",
				p: {
					detail: {
						order: updatedOrder,
						payment: data.p.detail?.payment ?? null,
						transaction: data.p.detail?.transaction ?? null,
					},
					cancelReason: merchantAction.reason,
				},
			};

			this.broadcast(response, { excludes: [ws] });
		} catch (error) {
			logger.error(
				{ error, merchantAction },
				"[OrderRoom] Failed to handle merchant reject",
			);
			throw error;
		}
	}

	async #handleMerchantMarkPreparing(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const merchantAction = data.p.merchantAction;
		if (!merchantAction) {
			logger.warn(data, "Invalid merchant mark preparing payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.markPreparing(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			logger.info(
				{ orderId: updatedOrder.id, merchantId: merchantAction.merchantId },
				"[OrderRoom] Merchant marked order as preparing",
			);

			const response: OrderEnvelope = {
				e: "MERCHANT_PREPARING",
				f: "s",
				t: "c",
				p: {
					detail: {
						order: updatedOrder,
						payment: data.p.detail?.payment ?? null,
						transaction: data.p.detail?.transaction ?? null,
					},
				},
			};

			this.broadcast(response, { excludes: [ws] });
		} catch (error) {
			logger.error(
				{ error, merchantAction },
				"[OrderRoom] Failed to handle merchant mark preparing",
			);
			throw error;
		}
	}

	async #handleMerchantMarkReady(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const merchantAction = data.p.merchantAction;
		if (!merchantAction) {
			logger.warn(data, "Invalid merchant mark ready payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.markReady(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			logger.info(
				{ orderId: updatedOrder.id, merchantId: merchantAction.merchantId },
				"[OrderRoom] Merchant marked order as ready",
			);

			const response: OrderEnvelope = {
				e: "MERCHANT_READY",
				f: "s",
				t: "c",
				p: {
					detail: {
						order: updatedOrder,
						payment: data.p.detail?.payment ?? null,
						transaction: data.p.detail?.transaction ?? null,
					},
				},
			};

			this.broadcast(response, { excludes: [ws] });
		} catch (error) {
			logger.error(
				{ error, merchantAction },
				"[OrderRoom] Failed to handle merchant mark ready",
			);
			throw error;
		}
	}

	/**
	 * Handle no-show report from driver
	 *
	 * When a driver arrives at pickup location but user is not present,
	 * the driver can report a no-show. This results in:
	 * - Order status changed to NO_SHOW
	 * - 50% penalty charged to user
	 * - Driver receives 80% of penalty as compensation
	 * - Platform keeps 20% of penalty as commission
	 */
	async #handleNoShow(
		ws: WebSocket,
		data: OrderEnvelope,
		tx: DatabaseTransaction,
	) {
		const noShowPayload = data.p.noShow;
		if (!noShowPayload) {
			logger.warn(data, "Invalid no-show payload");
			return;
		}

		const opts = { tx };
		const { orderId, driverId, reason } = noShowPayload;

		try {
			// Get order details
			const order = await this.#repo.order.get(orderId, opts);

			// Validate order status - can only report no-show when driver has arrived
			if (!OrderCancellationService.canReportNoShow(order.status)) {
				logger.warn(
					{ orderId, currentStatus: order.status },
					"[OrderRoom] Cannot report no-show - invalid order status",
				);
				ws.send(
					JSON.stringify({
						e: "ERROR",
						f: "s",
						t: "c",
						p: {
							message:
								"Cannot report no-show. Order must be in ARRIVING status.",
						},
					}),
				);
				return;
			}

			// Validate that the driver reporting is the assigned driver
			if (order.driverId !== driverId) {
				logger.warn(
					{
						orderId,
						requestingDriverId: driverId,
						assignedDriverId: order.driverId,
					},
					"[OrderRoom] Driver not authorized to report no-show",
				);
				ws.send(
					JSON.stringify({
						e: "ERROR",
						f: "s",
						t: "c",
						p: {
							message:
								"You are not authorized to report no-show for this order.",
						},
					}),
				);
				return;
			}

			// Get business configuration for fee calculations
			const businessConfig = await BusinessConfigurationService.getConfig(
				this.#svc.db,
				this.#svc.kv,
			);

			// Calculate no-show fees using config from database
			const { refundAmount, penaltyAmount, driverCompensation } =
				OrderCancellationService.calculateNoShowRefund(
					order.totalPrice,
					businessConfig,
				);

			// Find payment transaction for this order using OrderRefundService
			const paymentTransaction =
				await OrderRefundService.findPaymentTransaction(tx, orderId);

			// Get driver wallet for compensation
			const driverWallet = await this.#repo.wallet.getByUserId(driverId, opts);

			// Update order status
			const updatedOrder = await this.#repo.order.update(
				orderId,
				{
					status: "NO_SHOW",
					cancelReason: reason ?? "User not present at pickup location",
				},
				opts,
			);

			// Process partial refund to user and compensation to driver
			if (paymentTransaction) {
				const userWallet = await OrderRefundService.findWallet(
					tx,
					paymentTransaction.walletId,
				);
				const payment = await OrderRefundService.findPayment(
					tx,
					paymentTransaction.id,
				);

				if (userWallet && payment) {
					// Perform atomic balance updates first and get balance info
					const [userBalanceResult, driverBalanceResult] = await Promise.all([
						// Refund partial amount to user wallet (50%) - atomic
						this.#svc.walletServices.balance.add(
							{ walletId: userWallet.id, amount: toNumberSafe(refundAmount) },
							{ tx: opts.tx },
						),
						// Credit driver wallet with compensation - atomic
						this.#svc.walletServices.balance.add(
							{
								walletId: driverWallet.id,
								amount: toNumberSafe(driverCompensation),
							},
							{ tx: opts.tx },
						),
					]);

					await Promise.all([
						// Update user transaction as partial refund
						this.#repo.transaction.update(
							paymentTransaction.id,
							{
								status: "REFUNDED",
								balanceBefore: userBalanceResult.balanceBefore,
								balanceAfter: userBalanceResult.balanceAfter,
							},
							opts,
						),
						// Update payment status
						this.#repo.payment.update(payment.id, { status: "REFUNDED" }, opts),
						// Create penalty transaction for audit trail
						this.#repo.transaction.insert(
							{
								walletId: userWallet.id,
								type: "COMMISSION",
								amount: toNumberSafe(penaltyAmount),
								status: "SUCCESS",
								description: `No-show penalty for order #${orderId.slice(0, 8)}`,
								referenceId: orderId,
								metadata: {
									type: "NO_SHOW_PENALTY",
									orderId,
									reason: reason ?? "User not present",
								},
							},
							opts,
						),
						// Create earning transaction for driver
						this.#repo.transaction.insert(
							{
								walletId: driverWallet.id,
								type: "EARNING",
								amount: toNumberSafe(driverCompensation),
								balanceBefore: driverBalanceResult.balanceBefore,
								balanceAfter: driverBalanceResult.balanceAfter,
								status: "SUCCESS",
								description: `No-show compensation for order #${orderId.slice(0, 8)}`,
								referenceId: orderId,
								metadata: {
									type: "NO_SHOW_COMPENSATION",
									orderId,
									penaltyAmount: toNumberSafe(penaltyAmount),
									driverCompensation: toNumberSafe(driverCompensation),
								},
							},
							opts,
						),
					]);

					logger.info(
						{
							orderId,
							driverId,
							userId: order.userId,
							penaltyAmount: toNumberSafe(penaltyAmount),
							refundAmount: toNumberSafe(refundAmount),
							driverCompensation: toNumberSafe(driverCompensation),
						},
						"[OrderRoom] No-show processed successfully",
					);
				}
			}

			// Reset driver availability
			// FIX: Pass transaction context (opts) to ensure atomicity
			await this.#repo.driver.main.update(
				driverId,
				{ isTakingOrder: false },
				opts,
			);

			// Notify user about no-show
			const userWs = this.findById(order.userId);

			const noShowResponse: OrderEnvelope = {
				e: "NO_SHOW",
				f: "s",
				t: "c",
				p: {
					detail: {
						order: updatedOrder,
						payment: data.p.detail?.payment ?? null,
						transaction: data.p.detail?.transaction ?? null,
					},
					noShow: {
						orderId,
						driverId,
						reason: reason ?? "User not present at pickup location",
					},
				},
			};

			// Send to user
			if (userWs) {
				userWs.send(JSON.stringify(noShowResponse));
			}

			// Send confirmation to driver
			ws.send(JSON.stringify(noShowResponse));

			// Send notification to user
			await this.#repo.notification.sendNotificationToUserId({
				fromUserId: driverId,
				toUserId: order.userId,
				title: "Order Marked as No-Show",
				body: `Your order #${orderId.slice(0, 8)} was marked as no-show. 50% of the order amount has been charged as a penalty.`,
				data: {
					type: "NO_SHOW",
					orderId,
					deeplink: `akademove://order/${orderId}`,
				},
			});
		} catch (error) {
			logger.error(
				{ error, noShowPayload },
				"[OrderRoom] Failed to handle no-show",
			);
			throw error;
		}
	}
}
