import { env } from "cloudflare:workers";
import { Scalar } from "@scalar/hono-api-reference";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import { openAPIRouteHandler } from "hono-openapi";
import { getAuth } from "@/core/services/auth";
import { getDatabase } from "@/core/services/db";
import { TRUSTED_ORIGINS } from "./core/constants";
import { BaseError } from "./core/error";
import { createHono } from "./core/hono";
import { CloudflareKVService } from "./core/services/kv";
import { DriverRepository } from "./features/driver/repository";
import { AppHandler } from "./features/handler";
import { MerchantRepository } from "./features/merchant/repository";
import { OrderRepository } from "./features/order/repository";
import { PromoRepository } from "./features/promo/repository";
import { ScheduleRepository } from "./features/schedule/repository";
import { isCloudflare } from "./utils";

const app = createHono();

app.use(logger());
app.use("*", async (c, next) => {
	const db = getDatabase();
	c.set("db", db);
	const auth = getAuth(db, new CloudflareKVService(env.SESSION_KV));
	c.set("auth", auth);
	const kv = new CloudflareKVService(env.MAIN_KV);
	c.set("kv", kv);
	const repo = {
		driver: new DriverRepository(db, kv),
		merchant: new MerchantRepository(db, kv),
		order: new OrderRepository(db, kv),
		schedule: new ScheduleRepository(db, kv),
		promo: new PromoRepository(db, kv),
	};
	c.set("repo", repo);

	try {
		await next();
	} finally {
		if (isCloudflare) await db.$client.end();
	}
});

app.use(
	"/*",
	cors({
		origin: TRUSTED_ORIGINS,
		allowMethods: ["GET", "POST", "OPTIONS"],
		allowHeaders: ["Content-Type", "Authorization"],
		credentials: true,
	}),
);

app.on(["POST", "GET"], "/auth/**", (c) => c.var.auth.handler(c.req.raw));
app.route("/", AppHandler);
app.get(
	"/openapi.json",
	openAPIRouteHandler(AppHandler, {
		documentation: {
			info: {
				title: "AkadeMove API",
				version: "1.0.0",
				description: "API for the AkadeMove application",
			},
			components: {
				securitySchemes: {
					"Bearer Auth": {
						type: "http",
						scheme: "bearer",
						bearerFormat: "JWT",
					},
				},
			},
			security: [
				{
					"Bearer Auth": [],
				},
			],
			servers: [
				{
					url: env.AUTH_URL,
				},
			],
		},
	}),
);
app.get(
	"/",
	Scalar({
		theme: "saturn",
		sources: [
			{ url: "/openapi.json", title: "API" },
			{ url: "/auth/open-api/generate-schema", title: "AUTH" },
		],
	}),
);
app.onError((err, c) => {
	console.error("Error:", err);
	if ("getResponse" in err) {
		return err.getResponse();
	}
	if (err instanceof BaseError) {
		return err.toResponse();
	}
	if (err instanceof Error) {
		return c.json(
			{
				success: false,
				message: err.message,
			},
			500,
		);
	}
	return c.json(
		{
			success: false,
			message: "Internal Server Error",
		},
		500,
	);
});

export default app;
