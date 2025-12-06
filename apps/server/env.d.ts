// This file infers types for the cloudflare:workers environment from your Alchemy Worker.
// @see https://alchemy.run/concepts/bindings/#type-safe-bindings

import type { ServerEnv } from "../../alchemy.run";
import type { PaymentRoom, OrderRoom, SupportChatRoom } from "./src";

export interface CloudflareEnv extends ServerEnv {
	ORDER_ROOM: DurableObjectNamespace<OrderRoom>;
	PAYMENT_ROOM: DurableObjectNamespace<PaymentRoom>;
	SUPPORT_CHAT_ROOM: DurableObjectNamespace<SupportChatRoom>;
}

declare global {
	type Env = CloudflareEnv;
}

declare module "cloudflare:workers" {
	namespace Cloudflare {
		export interface Env extends CloudflareEnv {}
	}
}
