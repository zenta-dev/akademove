import { env } from "cloudflare:workers";
import type { Driver } from "@repo/schema/driver";
import { type OrderEnvelope, OrderEnvelopeSchema } from "@repo/schema/ws";
import Decimal from "decimal.js";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
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

		let nearbyDrivers: Driver[] = [];
		const initialRadiusKm = 10;
		const radiusIncrement = 10;
		const maxRadiusKm = 100;
		const searchDelayMs = 2000; // Reduced to 2 seconds for faster response

		let radiusKm = initialRadiusKm;

		while (nearbyDrivers.length === 0 && radiusKm <= maxRadiusKm) {
			const foundDrivers = await this.#repo.driver.main.nearby({
				x: findOrder.pickupLocation.x,
				y: findOrder.pickupLocation.y,
				radiusKm,
				limit: 5, // Get multiple drivers to increase acceptance chance
				gender: findOrder.gender,
			});

			// Filter out busy drivers
			nearbyDrivers = foundDrivers.filter((d) => !d.isTakingOrder);

			if (nearbyDrivers.length === 0) {
				log.info(
					{ radius: radiusKm, maxRadius: maxRadiusKm },
					`No available drivers within ${radiusKm}km — expanding search`,
				);
				radiusKm += radiusIncrement;
				if (radiusKm <= maxRadiusKm) {
					await new Promise((resolve) => setTimeout(resolve, searchDelayMs));
				}
			}
		}

		if (nearbyDrivers.length === 0) {
			log.warn(
				{ orderId: findOrder.id, userId: findOrder.userId },
				"[OrderRoom] No nearby driver found — cancelling order and processing refund",
			);

			const [updatedOrder, findPayment] = await Promise.all([
				this.#repo.order.update(
					findOrder.id,
					{
						status: "CANCELLED_BY_SYSTEM",
						cancelReason: "No driver around you",
					},
					opts,
				),
				opts.tx.query.payment.findFirst({
					with: { transaction: { with: { wallet: true } } },
					where: (f, op) => op.eq(f.id, detail.payment.id),
				}),
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
		const driverIds = [];
		for (const driver of nearbyDrivers) {
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
						deeplink: "akademove://driver/order", // TODO: replace with actual android url
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
		await Promise.all([
			this.#repo.order.update(done.orderId, { status: "COMPLETED" }, opts),
			this.#repo.driver.main.update(done.driverId, {
				isTakingOrder: false,
				currentLocation: done.driverCurrentLocation,
			}),
		]);

		const completedPayload: OrderEnvelope = {
			e: "COMPLETED",
			f: "s",
			t: "c",
			p: data.p,
		};
		this.broadcast(completedPayload, { excludes: [ws] });
	}
}
