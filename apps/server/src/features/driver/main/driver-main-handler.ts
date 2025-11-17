import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverMainSpec } from "./driver-main-spec";

const { priv } = createORPCRouter(DriverMainSpec);

export const DriverMainHandler = priv.router({
	getMine: priv.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context }) => {
			const result = await context.repo.driver.main.getByUserId(
				context.user.id,
			);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: priv.list
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.driver.main.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved drivers data",
					data: rows,
					totalPages,
				},
			};
		}),
	nearby: priv.nearby
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.driver.main.nearby(query);
			return {
				status: 200,
				body: { message: "Successfully retrieved drivers data", data: result },
			};
		}),
	get: priv.get
		.use(hasPermission({ driver: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.main.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved driver data", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.update(params.id, data);

			return {
				status: 200,
				body: { message: "Driver updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.driver.main.remove(params.id);

			return {
				status: 200,
				body: { message: "Driver deleted successfully", data: null },
			};
		}),
});
