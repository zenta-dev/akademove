import { os } from "@orpc/server";
import type { RoleAccess } from "@repo/schema";
import type { UserRole } from "@repo/schema/user";
import { getAuthToken } from "@repo/shared";
import { createMiddleware } from "hono/factory";
import { isDev, safeAsync } from "@/utils";
import { logger } from "@/utils/logger";
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
							banReason: session.user.banReason,
							banExpires: session.user.banExpires,
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

		// Check if user is banned
		if (session.user.banned) {
			// Check if ban has expired
			if (session.user.banExpires && new Date() > session.user.banExpires) {
				// Ban expired - allow through but log for auto-unban process
				logger.info(
					{ userId: session.user.id, banExpires: session.user.banExpires },
					"User ban expired, allowing access",
				);
			} else {
				// Ban is still active
				const message = session.user.banReason
					? `Account banned: ${session.user.banReason}`
					: "Your account has been banned";
				throw new AuthError(message, {
					code: "FORBIDDEN",
				});
			}
		}

		return next();
	},
);

export const orpcRequireAuthMiddleware = base.middleware(
	async ({ context, path, next }) => {
		logger.debug(`${path} need to be authenticated`);
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

		// Check if user is banned
		if (user.banned) {
			// Check if ban has expired
			if (user.banExpires && new Date() > user.banExpires) {
				// Ban expired - allow through but log for auto-unban process
				logger.info(
					{ userId: user.id, banExpires: user.banExpires },
					"User ban expired, allowing access",
				);
			} else {
				// Ban is still active
				const message = user.banReason
					? `Account banned: ${user.banReason}`
					: "Your account has been banned";
				throw new AuthError(message, {
					code: "FORBIDDEN",
				});
			}
		}

		return next({ context: { user, token } });
	},
);

// "ALL" means any logged in user
// "SYSTEM" means only system level users like ADMIN and OPERATOR only
const systemRoles: UserRole[] = ["ADMIN", "OPERATOR"];

export function hasRoles(userRole?: UserRole, ...roles: RoleAccess[]) {
	if (!userRole) return false;

	const hasRole = roles.some((role) => {
		if (role === "ALL") return true;
		if (role === "SYSTEM") {
			return systemRoles.includes(userRole);
		}
		return role === userRole;
	});

	return hasRole;
}

export const requireRoles = (..._roles: RoleAccess[]) =>
	base.middleware(async ({ context, next }) => {
		// const userRole = context.user?.role;
		// if (!userRole) {
		// 	throw new AuthError("Invalid session", {
		// 		code: "UNAUTHORIZED",
		// 	});
		// }

		// const hasRole = hasRoles(userRole, ...roles);

		// if (!hasRole) {
		// 	throw new AuthError("Access denied: Missing required role", {
		// 		code: "FORBIDDEN",
		// 	});
		// }

		return next();
	});
