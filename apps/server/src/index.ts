import { env } from "cloudflare:workers";
import { Scalar } from "@scalar/hono-api-reference";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import { openAPIRouteHandler } from "hono-openapi";
import { getAuth } from "@/lib/services/auth";
import { getDatabase } from "@/lib/services/db";
import { createHono } from "./lib/hono";
import { router } from "./routers";

const app = createHono();

app.use(logger());
app.use("*", async (c, next) => {
	const db = getDatabase();
	c.set("db", db);
	const auth = getAuth(db);
	c.set("auth", auth);

	try {
		await next();
	} finally {
		await db.$client.end();
	}
});

app.use(
	"/*",
	cors({
		origin: env.CORS_ORIGIN || "",
		allowMethods: ["GET", "POST", "OPTIONS"],
		allowHeaders: ["Content-Type", "Authorization"],
		credentials: true,
	}),
);

app.on(["POST", "GET"], "/auth/**", (c) => c.var.auth.handler(c.req.raw));
app.route("/", router);
app.get(
	"/openapi.json",
	openAPIRouteHandler(router, {
		documentation: {
			info: {
				title: "AkadeMove API",
				version: "1.0.0",
				description: "API for the AkadeMove application",
			},
		},
	}),
);
app.get(
	"/",
	Scalar({
		theme: "saturn",
		url: "/openapi.json",
	}),
);

export default app;
