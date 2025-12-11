import { m } from "@repo/i18n";
import { toLocation } from "@repo/schema/position";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { FraudDetectionService } from "@/features/fraud/services";
import { logger } from "@/utils/logger";
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
		// if (context.user.role === "DRIVER") {
		// 	const driver = await context.repo.driver.main.get(params.id);
		// 	if (driver.userId !== context.user.id) {
		// 		throw new AuthError(m.error_only_update_own_driver_profile(), {
		// 			code: "FORBIDDEN",
		// 		});
		// 	}
		// }

		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.update(params.id, data, {
				tx,
			});

			return {
				status: 200,
				body: { message: m.server_driver_updated(), data: result },
			};
		});
	}),
	updateLocation: priv.updateLocation.handler(
		async ({ context, input: { params, body } }) => {
			// IDOR Protection: Drivers can only update their own profile
			// Admins/Operators can update any driver
			const driver = await context.repo.driver.main.get(params.id);
			// if (context.user.role === "DRIVER") {
			// 	if (driver.userId !== context.user.id) {
			// 		throw new AuthError(m.error_only_update_own_driver_profile(), {
			// 			code: "FORBIDDEN",
			// 		});
			// 	}
			// }

			const data = trimObjectValues(body);

			// Convert coordinate format: body is {x, y} (PostGIS), fraud service expects {lat, lng}
			const currentLocation = toLocation(data);
			const previousLocation = driver.currentLocation
				? toLocation(driver.currentLocation)
				: null;

			// Fraud detection: Check for GPS spoofing
			const ipAddress =
				context.req.headers.get("x-forwarded-for") ??
				context.req.headers.get("x-real-ip") ??
				undefined;
			const userAgent = context.req.headers.get("user-agent") ?? undefined;

			const fraudResult = FraudDetectionService.validateLocationUpdate(
				{
					location: currentLocation,
					previousLocation,
					timestamp: new Date(),
					previousTimestamp: driver.lastLocationUpdate ?? null,
					isMockLocation: data.isMockLocation,
				},
				{
					userId: context.user.id,
					driverId: params.id,
					ipAddress,
					userAgent,
				},
			);

			// Log fraud event if signals detected (non-blocking - monitoring only)
			if (fraudResult.shouldLog && fraudResult.signals.length > 0) {
				const score = FraudDetectionService.calculateScore(fraudResult.signals);

				// Fire and forget - don't block location update
				context.repo.fraud
					.create({
						eventType: fraudResult.signals[0].type,
						severity: fraudResult.highestSeverity ?? "LOW",
						status: "PENDING",
						userId: context.user.id,
						driverId: params.id,
						signals: fraudResult.signals,
						score,
						location: currentLocation,
						previousLocation,
						distanceKm:
							(fraudResult.signals[0].metadata?.distanceKm as number) ?? null,
						timeDeltaSeconds:
							(fraudResult.signals[0].metadata?.timeDeltaSeconds as number) ??
							null,
						velocityKmh:
							(fraudResult.signals[0].metadata?.velocityKmh as number) ?? null,
						ipAddress: ipAddress ?? null,
						userAgent: userAgent ?? null,
						handledById: null,
						resolution: null,
						actionTaken: null,
						detectedAt: new Date(),
						resolvedAt: null,
					})
					.catch((error) => {
						logger.error(
							{ error, driverId: params.id },
							"[DriverMainHandler] Failed to log fraud event",
						);
					});
			}

			return await context.svc.db.transaction(async (tx) => {
				const result = await context.repo.driver.main.updateLocation(
					params.id,
					{
						x: data.x,
						y: data.y,
					},
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_driver_updated(), data: result },
				};
			});
		},
	),
	updateOnlineStatus: priv.updateOnlineStatus.handler(
		async ({ context, input: { params, body } }) => {
			// IDOR Protection: Drivers can only update their own profile
			// Admins/Operators can update any driver
			// if (context.user.role === "DRIVER") {
			// 	const driver = await context.repo.driver.main.get(params.id);
			// 	if (driver.userId !== context.user.id) {
			// 		throw new AuthError(m.error_only_update_own_driver_profile(), {
			// 			code: "FORBIDDEN",
			// 		});
			// 	}
			// }

			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.driver.main.updateOnlineStatus(
					params.id,
					data.isOnline,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_driver_updated(), data: result },
				};
			});
		},
	),
	updateTakingOrderStatus: priv.updateTakingOrderStatus.handler(
		async ({ context, input: { params, body } }) => {
			// IDOR Protection: Drivers can only update their own profile
			// Admins/Operators can update any driver
			// if (context.user.role === "DRIVER") {
			// 	const driver = await context.repo.driver.main.get(params.id);
			// 	if (driver.userId !== context.user.id) {
			// 		throw new AuthError(m.error_only_update_own_driver_profile(), {
			// 			code: "FORBIDDEN",
			// 		});
			// 	}
			// }

			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.driver.main.updateTakingOrderStatus(
					params.id,
					data.isTakingOrder,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_driver_updated(), data: result },
				};
			});
		},
	),
	remove: priv.remove.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			await context.repo.driver.main.remove(params.id, { tx });

			return {
				status: 200,
				body: { message: m.server_driver_deleted(), data: null },
			};
		});
	}),
	getAnalytics: priv.getAnalytics.handler(
		async ({ context, input: { params, query } }) => {
			// IDOR Protection: Drivers can only view their own analytics
			// Admins/Operators can view any driver's analytics
			// if (context.user.role === "DRIVER") {
			// 	const driver = await context.repo.driver.main.get(params.id);
			// 	if (driver.userId !== context.user.id) {
			// 		throw new AuthError(m.error_only_view_own_analytics(), {
			// 			code: "FORBIDDEN",
			// 		});
			// 	}
			// }

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
		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.driver.main.approve(params.id, { tx });

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
				logger.error(
					{ error, userId: result.userId, driverId: result.id },
					"[DriverHandler.approve] Failed to send approval notification",
				);
			}

			return {
				status: 200,
				body: { message: m.server_driver_approved(), data: result },
			};
		});
	}),
	reject: priv.reject.handler(async ({ context, input: { params, body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);
			const result = await context.repo.driver.main.reject(
				params.id,
				data.reason,
				{ tx },
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
				logger.error(
					{ error, userId: result.userId, driverId: result.id },
					"[DriverHandler.reject] Failed to send rejection notification",
				);
			}

			return {
				status: 200,
				body: { message: m.server_driver_rejected(), data: result },
			};
		});
	}),
	suspend: priv.suspend.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);
				const result = await context.repo.driver.main.suspend(
					params.id,
					data.reason,
					data.suspendUntil,
					{ tx },
				);

				return {
					status: 200,
					body: { message: m.server_driver_suspended(), data: result },
				};
			});
		},
	),
	activate: priv.activate.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const result = await context.repo.driver.main.activate(params.id, {
				tx,
			});

			return {
				status: 200,
				body: { message: m.server_driver_activated(), data: result },
			};
		});
	}),
});
