export * from "./order/order-ws";
export * from "./wallet/wallet-ws";

import { env } from "cloudflare:workers";
import { upgradeDurableIteratorRequest } from "@orpc/experimental-durable-iterator/durable-object";
import type { Hono } from "hono";
import type { HonoContext } from "@/core/interface";
import {
	honoAuthMiddleware,
	honoRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { withQueryParams } from "@/utils";
import type { OrderRoom } from "./order/order-ws";
import type { WalletRoom } from "./wallet/wallet-ws";

export const setupWebsocketRouter = (app: Hono<HonoContext>) =>
	app
		.use(honoAuthMiddleware)
		.use(honoRequireAuthMiddleware)
		.get("/ws/order-track/:id", async (c) => {
			const upgradeHeader = c.req.header("Upgrade");
			if (upgradeHeader !== "websocket") {
				return new Response("Durable Object expected Upgrade: websocket", {
					status: 426,
				});
			}

			const { id } = c.req.param();
			const stub: DurableObjectStub<OrderRoom> = c.env.ORDER_ROOM.getByName(id);

			const userId = c.var.session?.user.id ?? c.req.query()["user-id"];
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/wallet/:id", async (c) => {
			const upgradeHeader = c.req.header("Upgrade");
			if (upgradeHeader !== "websocket") {
				return new Response("Durable Object expected Upgrade: websocket", {
					status: 426,
				});
			}

			const { id } = c.req.param();
			const stub: DurableObjectStub<WalletRoom> =
				c.env.WALLET_ROOM.getByName(id);

			const userId = c.var.session?.user.id ?? c.req.query()["user-id"];
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/driver-pool", async (c) => {
			const upgradeHeader = c.req.header("Upgrade");
			if (upgradeHeader !== "websocket") {
				return new Response("Durable Object expected Upgrade: websocket", {
					status: 426,
				});
			}

			const stub: DurableObjectStub<WalletRoom> =
				c.env.WALLET_ROOM.getByName("driver-pool");

			const userId = c.var.session?.user.id ?? c.req.query()["user-id"];
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/pg", async (c) => {
			return upgradeDurableIteratorRequest(c.req.raw, {
				signingKey: "key",
				namespace: env.PLAYGROUND_ROOM,
			});
		});
