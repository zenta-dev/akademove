import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverScheduleSpec } from "./driver-schedule-spec";

const { priv } = createORPCRouter(DriverScheduleSpec);

export const DriverScheduleHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { rows, totalPages } = await context.repo.driver.schedule.list(query);

		return {
			status: 200,
			body: {
				message: m.server_schedules_retrieved(),
				data: rows,
				totalPages,
			},
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driver.schedule.get(params.id);

		return {
			status: 200,
			body: { message: m.server_schedule_retrieved(), data: result },
		};
	}),
	create: priv.create.handler(async ({ context, input: { body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.driver.schedule.create({
			...data,
			userId: context.user.id,
		});

		return {
			status: 200,
			body: { message: m.server_schedule_created(), data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.driver.schedule.update(params.id, data);

		return {
			status: 200,
			body: { message: m.server_schedule_updated(), data: result },
		};
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.driver.schedule.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_schedule_deleted(), data: null },
		};
	}),
});
