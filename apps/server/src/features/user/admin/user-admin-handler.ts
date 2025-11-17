import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { UserAdminSpec } from "./user-admin-spec";

const { priv } = createORPCRouter(UserAdminSpec);

export const UserAdminHandler = priv.router({
	list: priv.list
		.use(hasPermission({ user: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.user.admin.list({
				...query,
				requesterId: context.user.id,
			});

			return {
				status: 200,
				body: {
					message: "Successfully retrieved users data",
					data: rows,
					totalPages,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ user: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.user.admin.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved user data", data: result },
			};
		}),
	create: priv.create
		.use(hasPermission({ user: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.user.admin.create(data);

			return {
				status: 200,
				body: { message: "User created successfully", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ user: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.user.admin.update(
				params.id,
				data,
				{},
				context.req.headers,
			);

			return {
				status: 200,
				body: { message: "User updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ user: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.user.admin.remove(params.id);

			return {
				status: 200,
				body: { message: "User deleted successfully", data: null },
			};
		}),
});
