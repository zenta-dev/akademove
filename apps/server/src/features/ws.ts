export * from "./merchant/merchant-ws";
export * from "./order/order-ws";
export * from "./payment/payment-ws";

import type { Hono } from "hono";
import { DRIVER_POOL_KEY } from "@/core/constants";
import type { HonoContext } from "@/core/interface";
import {
	honoAuthMiddleware,
	honoRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { honoWebsocketHeader } from "@/core/middlewares/header";
import { withQueryParams } from "@/utils";
import { logger } from "@/utils/logger";
import { MerchantRoom } from "./merchant/merchant-ws";
import { OrderRepository } from "./order/order-repository";
import { PaymentRepository } from "./payment/payment-repository";

export const setupWebsocketRouter = (app: Hono<HonoContext>) =>
	app
		.use(honoAuthMiddleware)
		.use(honoRequireAuthMiddleware)
		.use(honoWebsocketHeader)
		.get("/ws/payment/:id", async (c) => {
			const { id } = c.req.param();
			logger.info(`WebSocket connection to payment room: ${id}`);
			const stub = PaymentRepository.getRoomStubByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/driver-pool", async (c) => {
			logger.info("WebSocket connection to driver pool room");
			const stub = OrderRepository.getRoomStubByName(DRIVER_POOL_KEY);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/order/:id", async (c) => {
			const { id } = c.req.param();
			logger.info(`WebSocket connection to order room: ${id}`);

			const stub = OrderRepository.getRoomStubByName(id);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		})
		.get("/ws/merchant/:merchantId/orders", async (c) => {
			const { merchantId } = c.req.param();
			logger.info(
				`WebSocket connection to merchant orders room: ${merchantId}`,
			);

			const stub = MerchantRoom.getRoomStubByName(merchantId);

			const userId = c.var.session?.user.id;
			if (!userId) return c.json({ message: "Unauthenticated" }, 401);

			const req = withQueryParams(c.req.raw, { userId });

			return await stub.fetch(req);
		});
