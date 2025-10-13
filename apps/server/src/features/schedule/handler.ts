import { implement } from "@orpc/server";
import type { ORPCContext } from "@/core/interface";
import { authMiddleware, hasPermission } from "@/core/middlewares/auth";
import { ScheduleSpec } from "./spec";

const os = implement(ScheduleSpec).$context<ORPCContext>().use(authMiddleware);

export const ScheduleHandler = os.router({
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
