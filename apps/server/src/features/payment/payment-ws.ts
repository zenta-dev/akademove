import type { WSPaymentEnvelope } from "@repo/schema/websocket";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";

export class PaymentRoom extends BaseDurableObject {
	broadcast(message: WSPaymentEnvelope, opts?: BroadcastOptions): void {
		super.broadcast(message, opts);
	}
}
