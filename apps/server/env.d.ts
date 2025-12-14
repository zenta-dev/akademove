// This file infers types for the cloudflare:workers environment from your Alchemy Worker.
// @see https://alchemy.run/concepts/bindings/#type-safe-bindings

import type {
	NotificationQueueMessage,
	OrderQueueMessage,
	ProcessingQueueMessage,
	QueueMessage,
} from "@repo/schema/queue";
import type { ServerEnv } from "../../alchemy.run";
import type {
	DriverLocationRoom,
	MerchantRoom,
	OrderRoom,
	PaymentRoom,
	SupportChatRoom,
} from "./src";

export interface CloudflareEnv extends ServerEnv {
	ORDER_ROOM: DurableObjectNamespace<OrderRoom>;
	PAYMENT_ROOM: DurableObjectNamespace<PaymentRoom>;
	MERCHANT_ROOM: DurableObjectNamespace<MerchantRoom>;
	DRIVER_LOCATION_ROOM: DurableObjectNamespace<DriverLocationRoom>;
	SUPPORT_CHAT: DurableObjectNamespace<SupportChatRoom>;
	// Queue bindings with typed message bodies
	ORDER_QUEUE: Queue<OrderQueueMessage>;
	NOTIFICATION_QUEUE: Queue<NotificationQueueMessage>;
	PROCESSING_QUEUE: Queue<ProcessingQueueMessage>;
	ORDER_DLQ: Queue<QueueMessage>;
}

declare global {
	type Env = CloudflareEnv;
}

declare module "cloudflare:workers" {
	namespace Cloudflare {
		export interface Env extends CloudflareEnv {}
	}
}
