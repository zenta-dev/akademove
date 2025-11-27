import { type PaymentEnvelope, PaymentEnvelopeSchema } from "@repo/schema/ws";
import { BaseDurableObject, type BroadcastOptions } from "@/core/base";
import { log } from "@/utils";

export class PaymentRoom extends BaseDurableObject {
	broadcast(message: PaymentEnvelope, opts?: BroadcastOptions): void {
		const parse = PaymentEnvelopeSchema.safeParse(message);
		if (!parse.success) {
			log.warn(parse, "Invalid payment WS message");
			return;
		}
		super.broadcast(parse.data, opts);
	}
}
