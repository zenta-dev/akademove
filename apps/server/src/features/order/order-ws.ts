import type { Driver } from "@repo/schema/driver";
import {
	type WSOrderEnvelope,
	WSOrderEnvelopeSchema,
	type WSPlaceOrderEnvelope,
	WSPlaceOrderEnvelopeSchema,
} from "@repo/schema/websocket";
import Decimal from "decimal.js";
import { BaseDurableObject } from "@/core/base";
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
			this.excludeSession(ws).forEach((connectedWS, _) => {
				const data: WSOrderEnvelope = {
					type: "driver:location_update",
					from: "client",
					to: "client",
					payload: { driverUpdateLocation },
				};
				connectedWS.send(JSON.stringify(data));
			});

			const driverId = this.findUserIdBySocket(ws);
			if (!driverId) return;
			await this.#repo.driver.update(driverId, {
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

		const driverId = this.findUserIdBySocket(ws);
		const userId = payload.order.userId;
		const orderId = payload.order.id;

		const opts = { tx };
		payload.order = await this.#repo.order.update(
			payload.order.id,
			{ status: "accepted", driverId },
			opts,
		);

		const userWs = this.findById(userId);
		const msg = JSON.stringify(payload);
		userWs?.send(msg);

		const orderDriverRoom = this.#broadcasted.get(orderId) ?? [];
		for (const ws of orderDriverRoom) {
			ws.send(msg);
		}
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
			nearbyDrivers = await this.#repo.driver.nearby({
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
			const cancelledOrder = await this.#repo.order.update(
				payload.order.id,
				{
					...payload.order,
					status: "cancelled_by_system",
					cancelReason: "No driver around you",
				},
				opts,
			);
			const payment = await this.#svc.db.query.payment.findFirst({
				with: { transaction: { with: { wallet: true } } },
				where: (f, op) => op.eq(f.id, payload.payment.id),
			});

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
						{
							balance: toNumberSafe(safeNewBalance),
						},
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

		const driverIds = [];
		for (const driver of nearbyDrivers) {
			const driverWs = this.findById(driver.userId);
			if (driverWs) {
				driverWs.send(msg);
				driverIds.push(driver.id);
			}
		}
		const driversWs = this.findByIds(driverIds);
		this.#broadcasted.set(updateOrder.id, driversWs);
	}
}
