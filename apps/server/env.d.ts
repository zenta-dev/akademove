// This file infers types for the cloudflare:workers environment from your Alchemy Worker.
// @see https://alchemy.run/concepts/bindings/#type-safe-bindings

import type { ServerEnv } from "../../alchemy.run";
import type { PaymentRoom, ListingRoom, OrderRoom } from "./src";

export interface CloudflareEnv extends ServerEnv {
	ORDER_ROOM: DurableObjectNamespace<OrderRoom>;
	// WALLET_ROOM: DurableObjectNamespace<WalletRoom>;
	LISTING_ROOM: DurableObjectNamespace<ListingRoom>;
	PAYMENT_ROOM: DurableObjectNamespace<PaymentRoom>;
}

declare global {
	type Env = CloudflareEnv;
}

declare module "cloudflare:workers" {
	namespace Cloudflare {
		export interface Env extends CloudflareEnv {}
	}
}
