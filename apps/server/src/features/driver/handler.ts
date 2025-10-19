import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import { DriverSpec } from "./spec";

const os = implement(DriverSpec).$context<ORPCContext>().use(authMiddleware);

export const DriverHandler = os.router({
	getMine: os.getMine
		.use(hasPermission({ merchant: ["get"] }))
		.handler(async ({ context }) => {
			const result = await context.repo.driver.getByUserId(context.user.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved merchant data", data: result },
			};
		}),
	list: os.list
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.driver.list(query);

			return {
				status: 200,
				body: { message: "Successfully retrieved drivers data", data: result },
			};
		}),
	get: os.get
		.use(hasPermission({ driver: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved driver data", data: result },
			};
		}),
	// create: os.create
	// 	.use(hasPermission({ driver: ["create"] }))
	// 	.handler(async ({ context, input: { body } }) => {
	// 		const result = await context.repo.driver.create({
	// 			...body,
	// 			userId: context.user.id,
	// 		});

	// 		return {
	// 			status: 200,
	// 			body: { message: "Driver created successfully", data: result },
	// 		};
	// 	}),
	update: os.update
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.driver.update(params.id, body);

			return {
				status: 200,
				body: { message: "Driver updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.driver.remove(params.id);

			return {
				status: 200,
				body: { message: "Driver deleted successfully", data: null },
			};
		}),
});
