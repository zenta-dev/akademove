import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { hasRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { BannerSpec } from "./banner-spec";

const { pub, priv } = createORPCRouter(BannerSpec);

export const BannerHandler = pub.router({
	// Public endpoint - no authentication required
	listPublic: pub.listPublic.handler(async ({ context, input: { query } }) => {
		// Default placement to USER_HOME if not provided
		const placement = query.placement ?? "USER_HOME";
		const result = await context.repo.banner.listPublic({ placement });
		return {
			status: 200,
			body: {
				message: m.server_banners_retrieved(),
				data: result,
			},
		};
	}),

	// Private endpoints - require ADMIN or OPERATOR role
	list: priv.list.handler(async ({ context, input: { query } }) => {
		logger.debug(context.user, "accessing banner list");
		32;
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		const result = await context.repo.banner.list(query);
		return {
			status: 200,
			body: {
				message: m.server_banners_retrieved(),
				data: result,
			},
		};
	}),

	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.banner.get(params.id);
		return {
			status: 200,
			body: {
				message: m.server_banner_retrieved(),
				data: result,
			},
		};
	}),

	create: priv.create.handler(async ({ context, input: { body } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.banner.create(
				{
					...data,
					userId: context.user.id,
				},
				{ tx },
			);
			return {
				status: 201,
				body: {
					message: m.server_banner_created(),
					data: result,
				},
			};
		});
	}),

	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.banner.update(
				params.id,
				{
					...data,
					userId: context.user.id,
				},
				{ tx },
			);
			return {
				status: 200,
				body: {
					message: m.server_banner_updated(),
					data: result,
				},
			};
		});
	}),

	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		if (!hasRoles(context.user.role, "SYSTEM")) {
			throw new AuthError("Access denied: Missing required role", {
				code: "FORBIDDEN",
			});
		}

		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.banner.delete(params.id, { tx });
			return {
				status: 200,
				body: {
					message: m.server_banner_deleted(),
					data: result,
				},
			};
		});
	}),

	toggleActive: priv.toggleActive.handler(
		async ({ context, input: { params } }) => {
			if (!hasRoles(context.user.role, "SYSTEM")) {
				throw new AuthError("Access denied: Missing required role", {
					code: "FORBIDDEN",
				});
			}

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.banner.toggleActive(
					params.id,
					context.user.id,
					{ tx },
				);
				return {
					status: 200,
					body: {
						message: m.server_banner_updated(),
						data: result,
					},
				};
			});
		},
	),
});
