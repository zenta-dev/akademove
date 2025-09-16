import { createMiddleware } from "hono/factory";
import { validateToken } from "@/utils/jwt";
import { MiddlewareError } from "../error";
import type { HonoContext } from "../hono";

export const requireAuthMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		try {
			const h = c.req.header();
			const authHeader = h["authorization"];
			if (authHeader) {
				const token = authHeader.split(" ")[1];
				console.log(token);
				const payload = await validateToken(token, c.var.auth);
				if (!payload.id) {
					throw new MiddlewareError("Failed to authenticate session");
				}
				c.set("userId", payload.id);
			} else {
				const headers = new Headers();
				for (const [k, v] of Object.entries(c.req.header())) {
					headers.set(k, v);
				}
				const session = await c.var.auth.api.getSession({ headers });
				if (!session) {
					throw new MiddlewareError("Failed to authenticate session");
				}
				c.set("userId", session.user.id);
			}
			await next();
		} catch (error) {
			throw new MiddlewareError("Failed to authenticate session", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	},
);
