import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
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
				body: { message: m.server_driver_retrieved(), data: result },
			};
		}),
	list: priv.list
		.use(hasPermission({ driver: ["list"] }))
		.handler(async ({ context, input: { query } }) => {
			const { rows, totalPages } = await context.repo.driver.main.list(query);

			return {
				status: 200,
				body: {
					message: m.server_drivers_retrieved(),
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
				body: { message: m.server_drivers_retrieved(), data: result },
			};
		}),
	get: priv.get
		.use(hasPermission({ driver: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.main.get(params.id);

			return {
				status: 200,
				body: { message: m.server_driver_retrieved(), data: result },
			};
		}),
	update: priv.update
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
			// IDOR Protection: Drivers can only update their own profile
			// Admins/Operators can update any driver
			if (context.user.role === "DRIVER") {
				const driver = await context.repo.driver.main.get(params.id);
				if (driver.userId !== context.user.id) {
					throw new AuthError(m.error_only_update_own_driver_profile(), {
						code: "FORBIDDEN",
					});
				}
			}

			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.update(params.id, data);

			return {
				status: 200,
				body: { message: m.server_driver_updated(), data: result },
			};
		}),
	remove: priv.remove
		.use(hasPermission({ driver: ["update"] }))
		.handler(async ({ context, input: { params } }) => {
			await context.repo.driver.main.remove(params.id);

			return {
				status: 200,
				body: { message: m.server_driver_deleted(), data: null },
			};
		}),
	getAnalytics: priv.getAnalytics
		.use(hasPermission({ driver: ["get"] }))
		.handler(async ({ context, input: { params, query } }) => {
			// IDOR Protection: Drivers can only view their own analytics
			// Admins/Operators can view any driver's analytics
			if (context.user.role === "DRIVER") {
				const driver = await context.repo.driver.main.get(params.id);
				if (driver.userId !== context.user.id) {
					throw new AuthError(m.error_only_view_own_analytics(), {
						code: "FORBIDDEN",
					});
				}
			}

			const result = await context.repo.driver.main.getAnalytics(
				params.id,
				query,
			);

			return {
				status: 200,
				body: {
					message: m.server_driver_retrieved(),
					data: result,
				},
			};
		}),
	approve: priv.approve
		.use(hasPermission({ driver: ["approve"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.main.approve(params.id);

			return {
				status: 200,
				body: { message: m.server_driver_approved(), data: result },
			};
		}),
	reject: priv.reject
		.use(hasPermission({ driver: ["approve"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.reject(
				params.id,
				data.reason,
			);

			return {
				status: 200,
				body: { message: m.server_driver_rejected(), data: result },
			};
		}),
	suspend: priv.suspend
		.use(hasPermission({ driver: ["ban"] }))
		.handler(async ({ context, input: { params, body } }) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.suspend(
				params.id,
				data.reason,
				data.suspendUntil,
			);

			return {
				status: 200,
				body: { message: m.server_driver_suspended(), data: result },
			};
		}),
	activate: priv.activate
		.use(hasPermission({ driver: ["ban"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.driver.main.activate(params.id);

			return {
				status: 200,
				body: { message: m.server_driver_activated(), data: result },
			};
		}),
});
