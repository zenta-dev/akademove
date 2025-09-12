import { env } from "cloudflare:workers";
import { Scalar } from "@scalar/hono-api-reference";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import { openAPIRouteHandler } from "hono-openapi";
import { getAuth } from "@/lib/services/auth";
import { getDatabase } from "@/lib/services/db";
import { createHono } from "./lib/hono";
import { CloudflareKVService } from "./lib/services/kv";
import { router } from "./routers";
import { isCloudflare } from "./utils";

const app = createHono();

app.use(logger());
app.use("*", async (c, next) => {
	const db = getDatabase();
	c.set("db", db);
	const auth = getAuth(db, new CloudflareKVService(env.SESSION_KV));
	c.set("auth", auth);

	try {
		await next();
	} finally {
		if (isCloudflare) await db.$client.end();
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
app.onError((err, c) => {
	console.error("Error:", err);
	if ("getResponse" in err) {
		return err.getResponse();
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
