import type {
	WSPaymentEnvelope,
	WSPlaceOrderEnvelope,
} from "@repo/schema/websocket";
import { BaseDurableObject } from "@/core/base";

export class PaymentRoom extends BaseDurableObject {
	async webSocketMessage(ws: WebSocket, message: ArrayBuffer | string) {
		super.webSocketMessage(ws, message);
	}

	broadcast(message: WSPaymentEnvelope | WSPlaceOrderEnvelope): void {
		this.sessions.forEach((connectedWS, _) => {
			connectedWS.send(JSON.stringify(message));
		});
	}
}
