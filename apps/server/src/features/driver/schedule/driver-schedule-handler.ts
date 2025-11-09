import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverScheduleSpec } from "./driver-schedule-spec";

const { priv } = createORPCRouter(DriverScheduleSpec);

export const DriverScheduleHandler = priv.router({
	list: priv.list
		.use(hasPermission({ schedule: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const result = await context.repo.driver.schedule.list(query);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved schedules data",
					data: result,
				},
			};
		}),
	get: priv.get
		.use(hasPermission({ schedule: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.schedule.get(params.id);

			return {
				status: 200,
				body: { message: "Successfully retrieved schedule data", data: result },
			};
		}),
	create: priv.create
		.use(hasPermission({ schedule: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
			const result = await context.repo.driver.schedule.create({
				...body,
				userId: context.user.id,
			});

			return {
				status: 200,
				body: { message: "Schedule created successfully", data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ schedule: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const result = await context.repo.driver.schedule.update(params.id, body);

			return {
				status: 200,
				body: { message: "Schedule updated successfully", data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ schedule: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.driver.schedule.remove(params.id);

			return {
				status: 200,
				body: { message: "Schedule deleted successfully", data: null },
			};
		}),
});
