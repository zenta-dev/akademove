import type { Driver } from "@repo/schema/driver";
import {
	type WSEnvelope,
	WSEnvelopeSchema,
	type WSPlaceOrderEnvelope,
	WSPlaceOrderEnvelopeSchema,
} from "@repo/schema/websocket";
import { BaseDurableObject } from "@/core/base";
import { getManagers, getRepositories, getServices } from "@/core/factory";
import type {
	RepositoryContext,
	ServiceContext,
	WebsocketAttachment,
} from "@/core/interface";

export class OrderRoom extends BaseDurableObject {
	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		const session = this.sessions.get(ws);
		if (!session) throw new Error("Session not found");

		const parse = await WSEnvelopeSchema.safeParseAsync(
			JSON.parse(message.toString()),
		);
		if (parse.data) {
			this.excludeSession(ws).forEach((_, connectedWS) => {
				connectedWS.send(message);
			});
		}
	}

	excludeSession(ws: WebSocket): Map<WebSocket, WebsocketAttachment> {
		const _ses = new Map<WebSocket, WebsocketAttachment>();
		for (const [k, v] of this.sessions) {
			if (k !== ws) _ses.set(k, v);
		}
		return _ses;
	}

	broadcast(message: WSEnvelope) {
		this.sessions.forEach((_, connectedWS) => {
			connectedWS.send(JSON.stringify(message));
		});
	}

	async webSocketClose(
		ws: WebSocket,
		code: number,
		_reason: string,
		_wasClean: boolean,
	) {
		this.sessions.delete(ws);
		ws.close(code, "Durable Object is closing WebSocket");
	}
}

export class ListingRoom extends BaseDurableObject {
	#svc: ServiceContext;
	#repo: RepositoryContext;

	constructor(ctx: DurableObjectState, env: Env) {
		super(ctx, env);
		this.#svc = getServices();
		this.#repo = getRepositories(this.#svc, getManagers());
	}

	async fetch(request: Request): Promise<Response> {
		return super.fetch(request);
	}

	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		const session = this.sessions.get(ws);
		if (!session) throw new Error("Session not found");

		const raw = JSON.parse(message.toString());
		if (raw.type === "order:request") {
			await this.#handleOrderRequst(ws, raw);
		} else {
			const parse = await WSEnvelopeSchema.safeParseAsync(raw);
			if (parse.data) {
				if (parse.data.type === "order:request") {
				}
				this.excludeSession(ws).forEach((_, connectedWS) => {
					connectedWS.send(message);
				});
			}
		}
	}

	async #handleOrderRequst(ws: WebSocket, raw: string) {
		const parse = await WSPlaceOrderEnvelopeSchema.safeParseAsync(raw);
		const order = parse.data?.payload;
		if (!order) return;
		const updateOrder = await this.#repo.order.update(order.id, {
			...order,
			status: "matching",
		});
		const data: WSPlaceOrderEnvelope = {
			type: "order:matching",
			from: "server",
			to: "client",
			payload: updateOrder,
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
			const cancelledOrder = await this.#repo.order.update(order.id, {
				...order,
				status: "cancelled_by_system",
				cancelReason: "No driver around you",
			});
			const data: WSPlaceOrderEnvelope = {
				type: "order:cancelled",
				from: "server",
				to: "client",
				payload: cancelledOrder,
			};
			ws.send(JSON.stringify(data));
			ws.close(1000, "No driver around you");
			return;
		}

		for (const driver of nearbyDrivers) {
			const driverWs = this.findById(driver.userId);
			driverWs?.send(msg);
		}
	}

	excludeSession(ws: WebSocket): Map<WebSocket, WebsocketAttachment> {
		const _ses = new Map<WebSocket, WebsocketAttachment>();
		for (const [k, v] of this.sessions) {
			if (k !== ws) _ses.set(k, v);
		}
		return _ses;
	}

	broadcast(message: WSEnvelope) {
		this.sessions.forEach((_, connectedWS) => {
			connectedWS.send(JSON.stringify(message));
		});
	}

	async webSocketClose(
		ws: WebSocket,
		code: number,
		_reason: string,
		_wasClean: boolean,
	) {
		this.sessions.delete(ws);
		ws.close(code, "Durable Object is closing WebSocket");
	}
}
