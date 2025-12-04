import { m } from "@repo/i18n";
import { unflattenData } from "@repo/schema/flatten.helper";
import { trimObjectValues } from "@repo/shared";
import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { BadgeMainSpec } from "./badge-main-spec";

const { priv } = createORPCRouter(BadgeMainSpec);

const roleMiddleware = requireRoles("ADMIN", "OPERATOR");

export const BadgeMainHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.badge.main.list(query);
		return {
			status: 200,
			body: {
				message: m.server_badges_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.badge.main.get(params.id);

		return {
			status: 200,
			body: { message: m.server_badge_retrieved(), data: result },
		};
	}),
	create: priv.create
		.use(roleMiddleware)
		.handler(async ({ context, input: { body } }) => {
			const data = trimObjectValues(unflattenData(body));
			const result = await context.repo.badge.main.create(data);

			return {
				status: 200,
				body: { message: m.server_badge_created(), data: result },
			};
		}),
	update: priv.update
		.use(roleMiddleware)
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(unflattenData(body));
			const result = await context.repo.badge.main.update(params.id, data);

			return {
				status: 200,
				body: { message: m.server_badge_updated(), data: result },
			};
		}),
	remove: priv.remove
		.use(roleMiddleware)
		.handler(async ({ context, input: { params } }) => {
			await context.repo.badge.main.remove(params.id);

			return {
				status: 200,
				body: { message: m.server_badge_deleted(), data: null },
			};
		}),
});
