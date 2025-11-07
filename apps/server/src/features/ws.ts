export * from "./order/order-ws";
export * from "./payment/payment-ws";

import type { Hono } from "hono";
import type { HonoContext } from "@/core/interface";
import {
	honoAuthMiddleware,
	honoRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { honoWebsocketHeader } from "@/core/middlewares/header";
import { withQueryParams } from "@/utils";
import type { OrderRoom } from "./order/order-ws";
import type { PaymentRoom } from "./payment/payment-ws";

export const setupWebsocketRouter = (app: Hono<HonoContext>) =>
	app
		.use(honoAuthMiddleware)
		.use(honoRequireAuthMiddleware)
		.use(honoWebsocketHeader)
		.get("/ws/order/:id", async (c) => {
			const { id } = c.req.param();
			const stub: DurableObjectStub<OrderRoom> = c.env.ORDER_ROOM.getByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/payment/:id", async (c) => {
			const { id } = c.req.param();
			const stub: DurableObjectStub<PaymentRoom> =
				c.env.PAYMENT_ROOM.getByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/driver-pool", async (c) => {
			const stub: DurableObjectStub<OrderRoom> =
				c.env.ORDER_ROOM.getByName("driver-pool");

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		});
