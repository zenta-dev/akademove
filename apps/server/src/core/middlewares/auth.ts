import { ORPCError, os } from "@orpc/server";
import { createMiddleware } from "hono/factory";
import { validateToken } from "@/utils/jwt";
import { MiddlewareError } from "../error";
import type { HonoContext } from "../hono";
import type { ORPCCOntext } from "../orpc";
import type { PermissionRole, Permissions } from "../services/auth";

export const requireAuthMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		try {
			const h = c.req.header();
			const authHeader = h.authorization;
			if (authHeader) {
				const token = authHeader.split(" ")[1];
				const payload = await validateToken(token, c.var.auth);
				if (!payload.id) {
					throw new MiddlewareError("Failed to authenticate session");
				}
				c.set("user", {
					id: payload.id,
					role: payload.role,
					banned: payload.banned,
				});
			} else {
				const headers = new Headers();
				for (const [k, v] of Object.entries(c.req.header())) {
					headers.set(k, v);
				}
				const session = await c.var.auth.api.getSession({ headers });
				if (!session) {
					throw new MiddlewareError("Failed to authenticate session");
				}
				c.set("user", {
					id: session.user.id,
					role: session.user.role as PermissionRole,
					banned: session.user.banned ?? true,
				});
			}
			await next();
		} catch (error) {
			throw new MiddlewareError("Failed to authenticate session", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	},
);

export const requiredPermissions = (permissions: Permissions) =>
	createMiddleware<HonoContext>(async (c, next) => {
		try {
			const { error, success } = await c.var.auth.api.userHasPermission({
				body: {
					userId: c.var.user.id,
					role: c.var.user.role,
					permissions: permissions,
				},
			});

			if (error || !success) throw new MiddlewareError("Unathorized access");
			await next();
		} catch (error) {
			throw new MiddlewareError("Failed to authorize session", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	});

export const authMiddleware = os
	.$context<ORPCCOntext>()
	.middleware(async ({ context, next }) => {
		const session = await context.svc.auth.api.getSession({
			headers: context.req.headers,
		});
		if (!session) {
			throw new ORPCError("UNAUTHORIZED", {
				message: "Failed to authenticate session",
			});
		}

		return await next({
			context: {
				user: {
					id: session.user.id,
					role: (session.user.role ?? "user") as PermissionRole,
					banned: session.user.banned ?? true,
				},
			},
		});
	});

export const hasPermission = (permissions: Permissions) =>
	os.$context<ORPCCOntext>().middleware(async ({ context, next }) => {
		const { error, success } = await context.svc.auth.api.userHasPermission({
			body: {
				userId: context.user.id,
				role: context.user.role,
				permissions: permissions,
			},
		});

		if (error || !success) throw new MiddlewareError("Unathorized access");
		return await next();
	});
