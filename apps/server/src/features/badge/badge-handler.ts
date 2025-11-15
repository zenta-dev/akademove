import { requireRoles } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { BadgeSpec } from "./badge-spec";

const { priv } = createORPCRouter(BadgeSpec);

const roleMiddleware = requireRoles("admin", "operator");

export const BadgeHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.badge.list(query);
		return {
			status: 200,
			body: {
				message: "Successfully retrieved badges data",
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.badge.get(params.id);

		return {
			status: 200,
			body: { message: "Successfully retrieved badge data", data: result },
		};
	}),
	create: priv.create
		.use(roleMiddleware)
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.badge.create(body);

			return {
				status: 200,
				body: { message: "Badge created successfully", data: result },
			};
		}),
	update: priv.update
		.use(roleMiddleware)
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.badge.update(params.id, body);

			return {
				status: 200,
				body: { message: "Badge updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(roleMiddleware)
		.handler(async ({ context, input: { params } }) => {
			await context.repo.badge.remove(params.id);

			return {
				status: 200,
				body: { message: "Badge deleted successfully", data: null },
			};
		}),
});
