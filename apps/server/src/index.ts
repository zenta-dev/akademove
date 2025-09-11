import { env } from "cloudflare:workers";
import { Hono } from "hono";
import { cors } from "hono/cors";
import { logger } from "hono/logger";
import type { HonoContext } from "@/lib/context";
import { getAuth } from "@/lib/services/auth";
import { getDatabase } from "@/lib/services/db";

const app = new Hono<HonoContext>();

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

app.get("/", (c) => {
	return c.text("OK");
});

export default app;
