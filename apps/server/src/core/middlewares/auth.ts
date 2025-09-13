import { createMiddleware } from "hono/factory";
import { MiddlewareError } from "../error";
import type { HonoContext } from "../hono";

export const requireAuthMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		try {
			const headers = new Headers();
			for (const [k, v] of Object.entries(c.req.header())) {
				headers.set(k, v);
			}
			const session = await c.var.auth.api.getSession({ headers });
			if (!session) {
				throw new MiddlewareError("Failed to authenticate session");
			}
			c.set("userId", session.user.id);
			await next();
		} catch (error) {
			throw new MiddlewareError("Failed to authenticate session", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	},
);
