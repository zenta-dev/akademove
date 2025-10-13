import { os } from "@orpc/server";
import type { Permissions } from "@repo/shared";
import { getAuthToken } from "@repo/shared";
import { isDev } from "@/utils";
import { AuthError, MiddlewareError } from "../error";
import type { ORPCContext } from "../interface";

export const authMiddleware = os
	.$context<ORPCContext>()
	.middleware(async ({ context, next }) => {
		const token = getAuthToken({ headers: context.req.headers, isDev });
		if (!token) {
			throw new AuthError("Missing or invalid authentication token", {
				code: "BAD_REQUEST",
			});
		}

		const session = await context.repo.auth.getSession(token);

		return next({
			context: {
				user: {
					id: session.user.id,
					role: session.user.role,
					banned: session.user.banned,
				},
				token,
			},
		});
	});
export const hasPermission = (permissions: Permissions) =>
	os.$context<ORPCContext>().middleware(async ({ context, next }) => {
		const { user, svc } = context;
		const ok = svc.rbac.hasPermission({ role: user.role, permissions });
		if (!ok) throw new MiddlewareError("Unathorized access");
		return await next();
	});
