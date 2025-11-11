import { env } from "cloudflare:workers";
import type { Driver } from "@repo/schema/driver";
import {
	type WSOrderEnvelope,
	WSOrderEnvelopeSchema,
	type WSPlaceOrderEnvelope,
	WSPlaceOrderEnvelopeSchema,
} from "@repo/schema/websocket";
import Decimal from "decimal.js";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type { RepositoryContext, ServiceContext } from "@/core/interface";
import type { DatabaseTransaction } from "@/core/services/db";
import { toNumberSafe } from "@/utils";

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

	broadcast(
		message: WSPlaceOrderEnvelope | WSOrderEnvelope,
		opts?: BroadcastOptions,
	): void {
		super.broadcast(message, opts);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);
		const session = this.findUserIdBySocket(ws);
		if (!session) throw new Error("Session not found");

		const raw = JSON.parse(message.toString());

		if (raw.type === "driver:location_update") {
			await this.#handleDriverUpdateLocation(ws, raw);
		}

		if (raw.type === "order:request") {
			await this.#svc.db.transaction(
				async (tx) => await this.#handleOrderRequst(ws, raw, tx),
			);
		}
		if (raw.type === "order:accepted") {
			await this.#svc.db.transaction(
				async (tx) => await this.#handleOrderAccepted(ws, raw, tx),
			);
		}
	}

	async #handleDriverUpdateLocation(ws: WebSocket, raw: unknown) {
		const parse = await WSOrderEnvelopeSchema.safeParseAsync(raw);
		if (parse.data) {
			const driverUpdateLocation = parse.data.payload.driverUpdateLocation;
			if (!driverUpdateLocation) return;

			this.broadcast(
				{
					type: "driver:location_update",
					from: "client",
					to: "client",
					payload: { driverUpdateLocation },
				},
				{ excludes: [ws] },
			);

			const driverId = this.findUserIdBySocket(ws);
			if (!driverId) return;
			await this.#repo.driver.main.update(driverId, {
				currentLocation: driverUpdateLocation,
			});
		}
	}

	async #handleOrderAccepted(
		ws: WebSocket,
		raw: unknown,
		tx: DatabaseTransaction,
	) {
		const parse = await WSPlaceOrderEnvelopeSchema.safeParseAsync(raw);
		const payload = parse.data?.payload;
		if (!payload) return;

		const userId = payload.order.userId;
		const orderId = payload.order.id;

		const broadcastedDrivers = this.#broadcasted.get(orderId);

		if (!broadcastedDrivers) return;

		const driverId = this.findUserIdBySocket(ws);
		if (!driverId) return;

		const opts = { tx };
		const [updatedOrder] = await Promise.all([
			this.#repo.order.update(orderId, { status: "accepted", driverId }, opts),
			this.#repo.driver.main.update(driverId, { isTakingOrder: true }),
		]);
		payload.order = updatedOrder;

		const userWs = this.findById(userId);
		const acceptedMsg = JSON.stringify({
			type: "order:accepted",
			from: "server",
			to: "client",
			payload,
		});

		userWs?.send(acceptedMsg);

		ws.send(acceptedMsg);

		for (const driverWs of broadcastedDrivers) {
			if (driverWs !== ws) {
				try {
					driverWs.send(
						JSON.stringify({
							type: "order:unavailable",
							from: "server",
							to: "client",
							payload,
						}),
					);
				} catch (err) {
					console.warn("Failed to send unavailable notice:", err);
				}
			}
		}

		this.#broadcasted.delete(orderId);
	}

	async #handleOrderRequst(
		ws: WebSocket,
		raw: unknown,
		tx: DatabaseTransaction,
	) {
		const opts = { tx };
		const parse = await WSPlaceOrderEnvelopeSchema.safeParseAsync(raw);
		const payload = parse.data?.payload;
		if (!payload) return;
		const updateOrder = await this.#repo.order.update(
			payload.order.id,
			{
				...payload.order,
				status: "matching",
			},
			opts,
		);
		const data: WSPlaceOrderEnvelope = {
			type: "order:matching",
			from: "server",
			to: "client",
			payload: { ...payload, order: updateOrder },
		};
		const msg = JSON.stringify(data);
		ws.send(msg);
		let nearbyDrivers: Driver[] = [];
		let radiusKm = 20;
		const maxRadiusKm = 100;
		const searchDelayMs = 3000; // delay between searches (3 seconds)

		while (nearbyDrivers.length === 0 && radiusKm <= maxRadiusKm) {
			nearbyDrivers = await this.#repo.driver.main.nearby({
				x: updateOrder.pickupLocation.x,
				y: updateOrder.pickupLocation.y,
				radiusKm,
				limit: 1,
				gender: updateOrder.gender,
			});

			if (nearbyDrivers.length === 0) {
				console.info(
					`No drivers within ${radiusKm}km — retrying after ${searchDelayMs / 1000}s.`,
				);
				radiusKm *= 2;
				await new Promise((resolve) => setTimeout(resolve, searchDelayMs));
			}
		}

		if (nearbyDrivers.length === 0) {
			console.warn("No nearby driver found — cancelling order.");
			const [cancelledOrder, payment] = await Promise.all([
				this.#repo.order.update(
					payload.order.id,
					{
						...payload.order,
						status: "cancelled_by_system",
						cancelReason: "No driver around you",
					},
					opts,
				),
				opts.tx.query.payment.findFirst({
					with: { transaction: { with: { wallet: true } } },
					where: (f, op) => op.eq(f.id, payload.payment.id),
				}),
			]);

			const data: WSPlaceOrderEnvelope = {
				type: "order:cancelled",
				from: "server",
				to: "client",
				payload: { ...payload, order: cancelledOrder },
			};
			if (payment) {
				const { transaction } = payment;
				const wallet = transaction.wallet;
				const safeCurrentBalance = new Decimal(wallet.balance);
				const safeAmount = new Decimal(cancelledOrder.totalPrice);
				const safeNewBalance = safeCurrentBalance.plus(safeAmount);

				const [updatedTransaction, updatedPayment, _] = await Promise.all([
					this.#repo.transaction.update(
						transaction.id,
						{
							status: "refunded",
							balanceBefore: toNumberSafe(safeCurrentBalance),
							balanceAfter: toNumberSafe(safeNewBalance),
						},
						opts,
					),
					this.#repo.payment.update(payment.id, { status: "refunded" }, opts),
					this.#repo.wallet.update(
						wallet.id,
						{ balance: toNumberSafe(safeNewBalance) },
						opts,
					),
				]);

				data.payload = {
					transaction: updatedTransaction,
					payment: updatedPayment,
					order: cancelledOrder,
				};
			}
			ws.send(JSON.stringify(data));
			ws.close(1000, "No driver around you");
			return;
		}

		const tasks: Promise<unknown>[] = [];
		const driverIds = [];
		for (const driver of nearbyDrivers) {
			const driverWs = this.findById(driver.userId);
			if (driverWs) {
				driverWs.send(msg);
				driverIds.push(driver.id);
			}
			const orderUrl = `${env.CORS_ORIGIN}/dash/merchant/orders/${updateOrder.id}`;
			tasks.push(
				this.#repo.notification.sendNotificationToUserId({
					fromUserId: updateOrder.userId,
					toUserId: driver.id,
					title: "New Order",
					body: `Order ${updateOrder.type} with id #${updateOrder.id}`,
					data: {
						type: "NEW_ORDER",
						orderId: updateOrder.id,
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
		this.#broadcasted.set(updateOrder.id, driversWs);

		await Promise.allSettled([tasks]);
	}
}
