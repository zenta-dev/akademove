import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { UserSpec } from "./user-spec";

const { priv } = createORPCRouter(UserSpec);

export const UserHandler = priv.router({
	list: priv.list
		.use(hasPermission({ user: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.user.list(context.user.id, query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved users data",
					data: result,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ user: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.user.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved user data", data: result },
			};
		}),
	create: priv.create
		.use(hasPermission({ user: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.user.create(body);

			return {
				status: 200,
				body: { message: "User created successfully", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ user: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.user.update(
				params.id,
				body,
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
			await context.repo.user.remove(params.id);

			return {
				status: 200,
				body: { message: "User deleted successfully", data: null },
			};
		}),
});
