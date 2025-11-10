import type {
	WSPaymentEnvelope,
	WSPlaceOrderEnvelope,
} from "@repo/schema/websocket";
import { BaseDurableObject } from "@/core/base";

export class PaymentRoom extends BaseDurableObject {
	broadcast(message: WSPaymentEnvelope | WSPlaceOrderEnvelope): void {
		this.sessions.forEach((connectedWS, _) => {
			connectedWS.send(JSON.stringify(message));
		});
	}
}
