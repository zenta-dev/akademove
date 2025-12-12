import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { shouldBypassAuthorization } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverScheduleSpec } from "./driver-schedule-spec";

const { priv } = createORPCRouter(DriverScheduleSpec);

export const DriverScheduleHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		// FIX: Drivers can only list their own schedules
		// Admins/Operators can list all schedules
		let driverId: string | undefined;

		if (!shouldBypassAuthorization() && context.user.role === "DRIVER") {
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			driverId = driver.id;
		}

		const { rows, totalPages } = await context.repo.driver.schedule.list({
			...query,
			driverId,
		});

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

		// FIX: Drivers can only view their own schedules
		if (!shouldBypassAuthorization() && context.user.role === "DRIVER") {
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			if (result.driverId !== driver.id) {
				throw new AuthError(
					"Access denied: Cannot view other drivers' schedules",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return {
			status: 200,
			body: { message: m.server_schedule_retrieved(), data: result },
		};
	}),
	create: priv.create.handler(async ({ context, input: { body } }) => {
		// Only DRIVER role can create schedules for themselves
		if (
			!shouldBypassAuthorization() &&
			context.user.role !== "DRIVER" &&
			context.user.role !== "ADMIN" &&
			context.user.role !== "OPERATOR"
		) {
			throw new AuthError("Access denied: Only drivers can create schedules", {
				code: "FORBIDDEN",
			});
		}

		// FIX: Get the driver ID from the user to set as driverId
		const driver = await context.repo.driver.main.getByUserId(context.user.id);

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.schedule.create(
				{
					...data,
					driverId: driver.id,
					userId: context.user.id,
				},
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_schedule_created(), data: result },
			};
		});
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		// FIX: Drivers can only update their own schedules
		if (!shouldBypassAuthorization() && context.user.role === "DRIVER") {
			const schedule = await context.repo.driver.schedule.get(params.id);
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			if (schedule.driverId !== driver.id) {
				throw new AuthError(
					"Access denied: Cannot update other drivers' schedules",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.schedule.update(
				params.id,
				data,
				{ tx },
			);

			return {
				status: 200,
				body: { message: m.server_schedule_updated(), data: result },
			};
		});
	}),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		// FIX: Drivers can only remove their own schedules
		if (!shouldBypassAuthorization() && context.user.role === "DRIVER") {
			const schedule = await context.repo.driver.schedule.get(params.id);
			const driver = await context.repo.driver.main.getByUserId(
				context.user.id,
			);
			if (schedule.driverId !== driver.id) {
				throw new AuthError(
					"Access denied: Cannot delete other drivers' schedules",
					{
						code: "FORBIDDEN",
					},
				);
			}
		}

		return await context.svc.db.transaction(async (tx) => {
			await context.repo.driver.schedule.remove(params.id, { tx });

			return {
				status: 200,
				body: { message: m.server_schedule_deleted(), data: null },
			};
		});
	}),
});
