import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { UserAdminSpec } from "./user-admin-spec";

const { priv } = createORPCRouter(UserAdminSpec);

export const UserAdminHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.user.admin.list({
			...query,
			requesterId: context.user.id,
		});

		return {
			status: 200,
			body: {
				message: m.server_users_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.user.admin.get(params.id);

		return {
			status: 200,
			body: { message: m.server_user_retrieved(), data: result },
		};
	}),
	create: priv.create.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.user.admin.create(data);

		return {
			status: 200,
			body: { message: m.server_user_created(), data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.user.admin.update(
			params.id,
			data,
			{},
			context.req.headers,
			context,
		);

		return {
			status: 200,
			body: { message: m.server_user_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.user.admin.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_user_deleted(), data: null },
		};
	}),
	dashboardStats: priv.dashboardStats.handler(
		async ({ context, input: { query } }) => {
			const result = await context.repo.user.admin.getDashboardStats({
				startDate: query.startDate,
				endDate: query.endDate,
				period: query.period,
			});

			return {
				status: 200,
				body: {
					message: m.server_users_retrieved(),
					data: result,
				},
			};
		},
	),
});
