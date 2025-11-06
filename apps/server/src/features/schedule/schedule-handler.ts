import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import {
	hasPermission,
	orpcAuthMiddleware,
	orpcRequireAuthMiddleware,
} from "@/core/middlewares/auth";
import { DriverScheduleSpec } from "./schedule-spec";

const os = implement(DriverScheduleSpec)
	.$context<ORPCContext>()
	.use(orpcAuthMiddleware)
	.use(orpcRequireAuthMiddleware);

export const DriverScheduleHandler = os.router({
	list: os.list
		.use(hasPermission({ schedule: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.schedule.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved schedules data",
					data: result,
				},
			};
		}),
	get: os.get
		.use(hasPermission({ schedule: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.schedule.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved schedule data", data: result },
			};
		}),
	create: os.create
		.use(hasPermission({ schedule: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.schedule.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Schedule created successfully", data: result },
			};
		}),
	update: os.update
		.use(hasPermission({ schedule: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.schedule.update(params.id, body);

			return {
				status: 200,
				body: { message: "Schedule updated successfully", data: result },
			};
		}),
	remove: os.remove
		.use(hasPermission({ schedule: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.schedule.remove(params.id);

			return {
				status: 200,
				body: { message: "Schedule deleted successfully", data: null },
			};
		}),
});
