import { os } from "@orpc/server";
import type { UserRole } from "@repo/schema/user";
import type { Permissions } from "@repo/shared";
import { getAuthToken } from "@repo/shared";
import { createMiddleware } from "hono/factory";
import { isDev, log, safeAsync } from "@/utils";
import { AuthError } from "../error";
import type { HonoContext, ORPCContext } from "../interface";

const base = os.$context<ORPCContext>();
export const honoAuthMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		if (c.var.session) return next();

		const token = getAuthToken({ request: c.req.raw, isDev });
		if (!token) return next();
		const res = await safeAsync(c.var.repo.auth.getSession(token));
		const session = res.data;
		c.set(
			"session",
			session
				? {
						user: {
							id: session.user.id,
							role: session.user.role,
							banned: session.user.banned,
						},
						token,
					}
				: undefined,
		);
		return next();
	},
);
export const orpcAuthMiddleware = base.middleware(async ({ context, next }) => {
	const token = getAuthToken({ request: context.req, isDev });
	if (!token) return next();

	return next({
		context: {
			user: context.user,
			token,
		},
	});
});

export const honoRequireAuthMiddleware = createMiddleware<HonoContext>(
	async (c, next) => {
		const session = c.var.session;
		if (!session) {
			throw new AuthError("Missing or invalid authentication token", {
				code: "BAD_REQUEST",
			});
		}

		return next();
	},
);

export const orpcRequireAuthMiddleware = base.middleware(
	async ({ context, path, next }) => {
		log.debug(`${path} need to be authenticated`);
		const { token, user } = context;
		if (!token) {
			throw new AuthError("Missing or invalid authentication token", {
				code: "BAD_REQUEST",
			});
		}
		if (!user) {
			throw new AuthError("Invalid session", {
				code: "UNAUTHORIZED",
			});
		}

		return next({ context: { user, token } });
	},
);

export const hasPermission = (permissions: Permissions) =>
	base.middleware(async (props) => {
		const { context, next } = props;
		// const { user, svc } = context;
		// if (!user) {
		// 	throw new AuthError("Invalid session", {
		// 		code: "UNAUTHORIZED",
		// 	});
		// }
		// const ok = svc.rbac.hasPermission({ role: user.role, permissions });
		// if (!ok) {
		// 	throw new MiddlewareError(
		// 		`Access denied: Missing required permission '${permissions}'`,
		// 		{
		// 			code: "UNAUTHORIZED",
		// 		},
		// 	);
		// }
		return await next();
	});

// "ALL" means any logged in user
// "SYSTEM" means only system level users like ADMIN and OPERATOR only
type Roles = UserRole | "ALL" | "SYSTEM";
const systemRoles: UserRole[] = ["ADMIN", "OPERATOR"];
export const requireRoles = (...roles: Roles[]) =>
	base.middleware(async ({ context, next }) => {
		const userRole = context.user?.role;

		if (!userRole) {
			throw new AuthError("Invalid session", {
				code: "UNAUTHORIZED",
			});
		}

		const hasRole = roles.some((role) => {
			if (role === "ALL") return true;
			if (role === "SYSTEM") {
				return systemRoles.includes(userRole);
			}
			return role === userRole;
		});

		if (!hasRole) {
			throw new AuthError("Access denied: Missing required role", {
				code: "UNAUTHORIZED",
			});
		}

		return next();
	});
