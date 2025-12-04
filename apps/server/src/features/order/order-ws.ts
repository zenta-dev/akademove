import { env } from "cloudflare:workers";
import { type OrderEnvelope, OrderEnvelopeSchema } from "@repo/schema/ws";
import Decimal from "decimal.js";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
import { BadgeAwardService } from "@/features/badge/services/badge-award-service";
import { DriverPriorityService } from "@/features/driver/services/driver-priority-service";
import { log, safeSync, toNumberSafe } from "@/utils";

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
			log.warn(parse, "Invalid order WS message");
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
			log.warn(data, "Invalid order WS message format");
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
			} catch (error) {
				log.error(
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
			log.warn(data, "Invalid order matching payload");
			return;
		}

		const findOrder = await this.#repo.order.get(detail.order.id, opts);

		// REFACTOR: Use OrderMatchingService for driver discovery
		// Service encapsulates matching business logic (radius, gender preference, availability)
		const matchedDrivers =
			await this.#svc.orderServices.matching.findAvailableDrivers(
				{
					pickupLocation: findOrder.pickupLocation,
					orderType: findOrder.type,
					genderPreference: findOrder.genderPreference,
					userGender: findOrder.gender,
					radiusKm: 50, // Max radius for initial search
				},
				10, // Get multiple drivers to increase acceptance chance
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

			log.info(
				{
					orderId: findOrder.id,
					availableDrivers: nearbyDrivers.length,
					sortedByPriority: true,
				},
				"[OrderRoom] Drivers sorted by priority (badges + leaderboard)",
			);
		}

		log.info(
			{
				orderId: findOrder.id,
				availableDrivers: nearbyDrivers.length,
			},
			"[OrderRoom] Driver matching completed via OrderMatchingService",
		);

		if (nearbyDrivers.length === 0) {
			log.warn(
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
					const safeCurrentBalance = new Decimal(wallet.balance);
					const safeAmount = new Decimal(updatedOrder.totalPrice);
					const safeNewBalance = safeCurrentBalance.plus(safeAmount);

					const [updatedTransaction, updatedPayment, _] = await Promise.all([
						this.#repo.transaction.update(
							transaction.id,
							{
								status: "REFUNDED",
								balanceBefore: toNumberSafe(safeCurrentBalance),
								balanceAfter: toNumberSafe(safeNewBalance),
							},
							opts,
						),
						this.#repo.payment.update(
							findPayment.id,
							{ status: "REFUNDED" },
							opts,
						),
						this.#repo.wallet.update(
							wallet.id,
							{ balance: toNumberSafe(safeNewBalance) },
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

					log.info(
						{
							orderId: updatedOrder.id,
							userId: wallet.userId,
							refundAmount: toNumberSafe(safeAmount),
						},
						"[OrderRoom] Refund processed successfully",
					);
				} catch (refundError) {
					log.error(
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
				log.warn({ driver }, "[OrderRoom] Skipping driver with missing fields");
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
			log.warn(data, "Invalid order accepted payload");
			return;
		}

		const userId = detail.order.userId;
		const orderId = detail.order.id;

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

		const driverId = this.findUserIdBySocket(ws);
		if (!driverId) return;

		const opts = { tx };
		const [updatedOrder, updatedDriver] = await Promise.all([
			this.#repo.order.update(orderId, { status: "ACCEPTED", driverId }, opts),
			this.#repo.driver.main.update(driverId, { isTakingOrder: true }),
		]);
		detail.order = updatedOrder;

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
			log.warn(data, "Invalid order done payload");
			return;
		}

		const opts = { tx };

		// Get order details to calculate commission
		const order = await this.#repo.order.get(done.orderId, opts);

		// Get commission configuration
		const commissionConfig =
			await this.#repo.configuration.get("commission_rates");
		const commissionRates = commissionConfig.value as {
			rideCommissionRate: number;
			deliveryCommissionRate: number;
			foodCommissionRate: number;
			merchantCommissionRate: number;
		};

		// Calculate commission based on order type
		let commissionRate = 0;
		if (order.type === "RIDE") {
			commissionRate = commissionRates.rideCommissionRate || 0.15;
		} else if (order.type === "DELIVERY") {
			commissionRate = commissionRates.deliveryCommissionRate || 0.15;
		} else if (order.type === "FOOD") {
			commissionRate = commissionRates.foodCommissionRate || 0.2;
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
					log.info(
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
		const driverEarning = totalPrice.minus(platformCommission);
		const merchantCommission =
			order.type === "FOOD"
				? totalPrice.times(commissionRates.merchantCommissionRate || 0.1)
				: new Decimal(0);

		// Get driver wallet
		const driverwallet = await this.#repo.wallet.getByUserId(
			order.driverId ?? "",
			opts,
		);

		// Create transaction records for driver earning and platform commission
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

			// Credit driver wallet with earnings
			this.#repo.transaction.insert(
				{
					walletId: driverwallet.id,
					type: "EARNING",
					amount: toNumberSafe(driverEarning.toString()),
					balanceBefore: driverwallet.balance,
					balanceAfter:
						driverwallet.balance + toNumberSafe(driverEarning.toString()),
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
			this.#repo.driver.main.update(done.driverId, {
				isTakingOrder: false,
				currentLocation: done.driverCurrentLocation,
			}),
		]);

		// Update driver wallet balance
		await this.#repo.wallet.update(
			driverwallet.id,
			{
				balance: driverwallet.balance + toNumberSafe(driverEarning.toString()),
			},
			opts,
		);

		// Award badges to driver after order completion
		if (order.driverId) {
			const badgeAwardService = new BadgeAwardService(this.#svc.db, this.#repo);
			await badgeAwardService
				.evaluateAndAwardBadges(order.driverId, opts)
				.catch((error) => {
					log.error(
						{ error, driverId: order.driverId },
						"[OrderRoom] Failed to award badges",
					);
				});
		}

		log.info(
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
			log.warn("[OrderRoom] No userId found for chat message sender");
			return;
		}

		const messagePayload = data.p.message;
		if (!messagePayload) {
			log.warn(data, "Invalid chat message payload");
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

			log.info(
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
			log.error(
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
			log.warn(data, "Invalid merchant accept payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.acceptOrder(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			log.info(
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
			log.error(
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
			log.warn(data, "Invalid merchant reject payload");
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

			log.info(
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
			log.error(
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
			log.warn(data, "Invalid merchant mark preparing payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.markPreparing(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			log.info(
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
			log.error(
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
			log.warn(data, "Invalid merchant mark ready payload");
			return;
		}

		const opts = { tx };

		try {
			const updatedOrder = await this.#repo.merchant.order.markReady(
				merchantAction.orderId,
				merchantAction.merchantId,
				opts,
			);

			log.info(
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
			log.error(
				{ error, merchantAction },
				"[OrderRoom] Failed to handle merchant mark ready",
			);
			throw error;
		}
	}
}
