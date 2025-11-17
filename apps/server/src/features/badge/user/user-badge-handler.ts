import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { UserBadgeSpec } from "./user-badge-spec";

const { priv } = createORPCRouter(UserBadgeSpec);

export const UserBadgeHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.badge.user.list(query);
		return {
			status: 200,
			body: {
				message: "Successfully retrieved userbadges data",
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.badge.user.get(params.id);

		return {
			status: 200,
			body: {
				message: "Successfully retrieved userbadge data",
				data: result,
			},
		};
	}),
	create: priv.create.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.badge.user.create({
			...data,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: { message: "UserBadge created successfully", data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.badge.user.update(params.id, data);

		return {
			status: 200,
			body: { message: "UserBadge updated successfully", data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.badge.user.remove(params.id);

		return {
			status: 200,
			body: { message: "UserBadge deleted successfully", data: null },
		};
	}),
});
