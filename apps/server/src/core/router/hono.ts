import { Hono } from "hono";
import { cors } from "hono/cors";
import { matchedRoutes } from "hono/route";
import { BaseError } from "@/core/error";
import type { HonoContext } from "@/core/interface";
import { isCloudflare } from "@/utils";
import { logger } from "@/utils/logger";
import { TRUSTED_ORIGINS } from "../constants";
import { getManagers, getRepositories, getServices } from "../factory";
import { honoAuthMiddleware } from "../middlewares/auth";
import { honoClientAgentMiddleware } from "../middlewares/client";
import { localeMiddleware } from "../middlewares/language";
import { honoRateLimit, RATE_LIMITS } from "../middlewares/rate-limit";

export const createHono = () => new Hono<HonoContext>();

export const setupHonoRouter = () => {
	const app = createHono();

	app.use(logger());
	app.use(honoClientAgentMiddleware);
	app.use("*", async (c, next) => {
		if (matchedRoutes(c).some((route) => route.path.startsWith("/ws"))) {
			return next();
		}

		const corsMiddlewareHandler = cors({
			origin: TRUSTED_ORIGINS,
			allowMethods: ["GET", "POST", "PUT", "OPTIONS"],
			allowHeaders: [
				"Content-Type",
				"Authorization",
				"Accept-Language",
				"X-Client-Agent",
				"X-Orpc-Batch",
			],
			credentials: true,
		});
		return corsMiddlewareHandler(c, next);
	});

	app.use("*", async (c, next) => {
		const svc = getServices();
		const manager = getManagers();
		const repo = getRepositories(svc, manager);

		c.set("svc", svc);
		c.set("manager", manager);
		c.set("repo", repo);
		try {
			return await next();
		} catch (err) {
			logError(err);
			throw err;
		} finally {
			if (isCloudflare) await svc.db.$client.end();
		}
	});

	app.use(honoAuthMiddleware);
	app.use(localeMiddleware);

	// Apply global rate limiting (1000 requests per hour per IP)
	app.use("/rpc/*", honoRateLimit(RATE_LIMITS.GLOBAL));
	app.use("/api/*", honoRateLimit(RATE_LIMITS.GLOBAL));

	app.onError((err, c) => {
		logError(err);
		if ("getResponse" in err) {
			return err.getResponse();
		}
		if (err instanceof BaseError) {
			return err.toResponse();
		}
		const message =
			err instanceof Error ? err.message : "Internal Server Error";
		const response =
			err instanceof Error
				? { success: false, message }
				: {
						success: false,
						message: "Internal Server Error",
					};

		return c.json(response, 500);
	});

	return app;
};

function logError(err: unknown) {
	logger.error({ error: err }, "HONO ERROR");
}
