import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { AuthError } from "@/core/error";
import { createORPCRouter } from "@/core/router/orpc";
import { DriverMainSpec } from "./driver-main-spec";

const { priv } = createORPCRouter(DriverMainSpec);

export const DriverMainHandler = priv.router({
	getMine: priv.getMine.handler(async ({ context }) => {
		const result = await context.repo.driver.main.getByUserId(context.user.id);

		return {
			status: 200,
			body: { message: m.server_driver_retrieved(), data: result },
		};
	}),
	list: priv.list.handler(async ({ context, input: { query } }) => {
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
	nearby: priv.nearby.handler(async ({ context, input: { query } }) => {
		const result = await context.repo.driver.main.nearby(query);
		return {
			status: 200,
			body: { message: m.server_drivers_retrieved(), data: result },
		};
	}),
	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driver.main.get(params.id);

		return {
			status: 200,
			body: { message: m.server_driver_retrieved(), data: result },
		};
	}),
	update: priv.update.handler(async ({ context, input: { params, body } }) => {
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
	markAsOnline: priv.markAsOnline.handler(
		async ({ context, input: { params } }) => {
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

			const result = await context.repo.driver.main.markAsOnline(params.id);

			return {
				status: 200,
				body: { message: "Mark online success", data: result },
			};
		},
	),
	markAsOffline: priv.markAsOffline	.handler(
		async ({ context, input: { params } }) => {
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

			const result = await context.repo.driver.main.markAsOffline(params.id);

			return {
				status: 200,
				body: { message: "Mark offline success", data: result },
			};
		},
	),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		await context.repo.driver.main.remove(params.id);

		return {
			status: 200,
			body: { message: m.server_driver_deleted(), data: null },
		};
	}),
	getAnalytics: priv.getAnalytics.handler(
		async ({ context, input: { params, query } }) => {
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
		},
	),
	approve: priv.approve.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driver.main.approve(params.id);

		// Send approval notification to driver
		try {
			await context.repo.notification.sendNotificationToUserId({
				toUserId: result.userId,
				title: "Driver Application Approved",
				body: "Congratulations! Your driver application and quiz have been approved. You can now start accepting orders.",
				data: {
					type: "DRIVER_APPROVED",
					driverId: result.id,
					deeplink: "akademove://driver/home",
				},
				apns: {
					payload: { aps: { category: "DRIVER_APPROVED", sound: "default" } },
				},
				fromUserId: context.user.id,
			});
		} catch (error) {
			// Log but don't fail the request if notification sending fails
			console.error(
				`Failed to send approval notification to user ${result.userId}:`,
				error,
			);
		}

		return {
			status: 200,
			body: { message: m.server_driver_approved(), data: result },
		};
	}),
	reject: priv.reject.handler(async ({ context, input: { params, body } }) => {
		const data = trimObjectValues(body);
		const result = await context.repo.driver.main.reject(
			params.id,
			data.reason,
		);

		// Send rejection notification to driver with reason
		try {
			await context.repo.notification.sendNotificationToUserId({
				toUserId: result.userId,
				title: "Driver Application Declined",
				body: `Your driver application has been declined. Reason: ${data.reason || "Your application does not meet our requirements. Please contact support for more information."}`,
				data: {
					type: "DRIVER_DECLINED",
					driverId: result.id,
					reason: data.reason || "",
					deeplink: "akademove://contact-support",
				},
				apns: {
					payload: { aps: { category: "DRIVER_DECLINED", sound: "default" } },
				},
				fromUserId: context.user.id,
			});
		} catch (error) {
			// Log but don't fail the request if notification sending fails
			console.error(
				`Failed to send rejection notification to user ${result.userId}:`,
				error,
			);
		}

		return {
			status: 200,
			body: { message: m.server_driver_rejected(), data: result },
		};
	}),
	suspend: priv.suspend.handler(
		async ({ context, input: { params, body } }) => {
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
		},
	),
	activate: priv.activate.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.driver.main.activate(params.id);

		return {
			status: 200,
			body: { message: m.server_driver_activated(), data: result },
		};
	}),
});
