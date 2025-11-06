import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverSpec } from "./driver-spec";

const { priv } = createORPCRouter(DriverSpec);

export const DriverHandler = priv.router({
	getMine: priv.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context }) => {
			const result = await context.repo.driver.getByUserId(context.user.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: priv.list
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.driver.list(query);

			return {
				status: 200,
				body: { message: "Successfully retrieved drivers data", data: result },
			};
		}),
	nearby: priv.nearby
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.driver.nearby(query);
			return {
				status: 200,
				body: { message: "Successfully retrieved drivers data", data: result },
			};
		}),
	get: priv.get
		.use(hasPermission({ driver: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved driver data", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.driver.update(params.id, body);

			return {
				status: 200,
				body: { message: "Driver updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.driver.remove(params.id);

			return {
				status: 200,
				body: { message: "Driver deleted successfully", data: null },
			};
		}),
});
