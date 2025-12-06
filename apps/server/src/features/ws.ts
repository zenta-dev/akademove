export * from "./order/order-ws";
export * from "./payment/payment-ws";
export * from "./support-chat/support-chat-ws";

import type { Hono } from "hono";
import { DRIVER_POOL_KEY } from "@/core/constants";
import type { HonoContext } from "@/core/interface";
import {
	honoAuthMiddleware,
	honoRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { honoWebsocketHeader } from "@/core/middlewares/header";
import { withQueryParams } from "@/utils";
import { OrderRepository } from "./order/order-repository";
import { PaymentRepository } from "./payment/payment-repository";
import { SupportChatRepository } from "./support-chat/support-chat-repository";

export const setupWebsocketRouter = (app: Hono<HonoContext>) =>
	app
		.use(honoAuthMiddleware)
		.use(honoRequireAuthMiddleware)
		.use(honoWebsocketHeader)
		.get("/ws/payment/:id", async (c) => {
			const { id } = c.req.param();
			const stub = PaymentRepository.getRoomStubByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/driver-pool", async (c) => {
			const stub = OrderRepository.getRoomStubByName(DRIVER_POOL_KEY);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/order/:id", async (c) => {
			const { id } = c.req.param();
			const stub = OrderRepository.getRoomStubByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/support-chat/:ticketId", async (c) => {
			const { ticketId } = c.req.param();
			const stub = SupportChatRepository.getRoomStubByName(ticketId);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId, ticketId });

			return await stub.fetch(req);
		});
