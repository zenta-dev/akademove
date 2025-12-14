import { m } from "@repo/i18n";
import type { EmergencyWithContact } from "@repo/schema/emergency-contact";
import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { logger } from "@/utils/logger";
import { EmergencySpec } from "./emergency-spec";

const { priv } = createORPCRouter(EmergencySpec);

export const EmergencyHandler = priv.router({
	trigger: priv.trigger.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);

			// Verify order exists and is in active trip
			const order = await context.repo.order.get(data.orderId, { tx });

			if (order.status !== "IN_TRIP") {
				throw new Error(
					"Emergency can only be triggered during active trip (IN_TRIP status)",
				);
			}

			// Verify user is part of the order (either passenger or driver)
			const userId = context.user.id;
			// Check if user is the driver by looking up their driver record
			const userDriver = await context.repo.driver.main
				.getByUserId(userId)
				.catch(() => null);
			const isDriver =
				order.driverId !== null &&
				userDriver !== null &&
				order.driverId === userDriver.id;
			if (order.userId !== userId && !isDriver) {
				throw new Error(
					"You are not authorized to trigger emergency for this order",
				);
			}

			// Create emergency record
			const result = await context.repo.emergency.create(
				{
					...data,
					userId: context.user.id,
				},
				{ tx },
			);

			logger.info(
				{
					emergencyId: result.id,
					orderId: result.orderId,
					userId: result.userId,
					type: result.type,
				},
				"[EmergencyHandler] Emergency triggered",
			);

			// Send emergency notification to operators and campus security
			try {
				await context.repo.notification.sendToTopic(
					{
						topic: "OPERATOR",
						title: `🚨 Emergency Alert: ${result.type}`,
						body: `Order #${result.orderId.substring(0, 8)} - ${result.description || "Emergency triggered"}`,
						data: {
							type: "EMERGENCY",
							emergencyId: result.id,
							orderId: result.orderId,
							emergencyType: result.type,
							userId: result.userId,
							location: JSON.stringify(result.location),
						},
						userId: context.user.id,
					},
					{ tx },
				);

				logger.info(
					{ emergencyId: result.id },
					"[EmergencyHandler] Emergency notification sent to operators",
				);
			} catch (notifError) {
				// Log error but don't fail the emergency trigger
				logger.error(
					{ error: notifError, emergencyId: result.id },
					"[EmergencyHandler] Failed to send emergency notification",
				);
			}

			// Get emergency contacts for WhatsApp integration
			const contacts = await context.repo.emergencyContact.listActive({ tx });

			// Get user info
			const userRecord = await context.repo.user.admin.get(order.userId);

			// Get driver info if available
			let driverInfo: EmergencyWithContact["driverInfo"];
			if (order.driverId) {
				try {
					const driver = await context.repo.driver.main.get(order.driverId);
					const driverUser = await context.repo.user.admin.get(driver.userId);
					driverInfo = {
						id: driver.id,
						userId: driver.userId,
						name: driverUser.name,
						phone: driverUser.phone
							? `+${driverUser.phone.countryCode === "ID" ? "62" : driverUser.phone.countryCode}${driverUser.phone.number}`
							: undefined,
						gender: driverUser.gender ?? undefined,
						vehiclePlate: driver.licensePlate ?? undefined,
					};
				} catch (driverError) {
					logger.warn(
						{ error: driverError, driverId: order.driverId },
						"[EmergencyHandler] Failed to fetch driver info",
					);
				}
			}

			const responseData: EmergencyWithContact = {
				emergency: {
					id: result.id,
					orderId: result.orderId,
					userId: result.userId,
					driverId: result.driverId,
					type: result.type,
					status: result.status,
					description: result.description,
					location: result.location,
					reportedAt: result.reportedAt,
				},
				contacts,
				orderInfo: {
					id: order.id,
					type: order.type,
					status: order.status,
					pickupAddress: order.pickupAddress ?? undefined,
					dropoffAddress: order.dropoffAddress ?? undefined,
				},
				userInfo: {
					id: userRecord.id,
					name: userRecord.name,
					phone: userRecord.phone
						? `+${userRecord.phone.countryCode === "ID" ? "62" : userRecord.phone.countryCode}${userRecord.phone.number}`
						: undefined,
					gender: userRecord.gender ?? undefined,
				},
				driverInfo,
			};

			return {
				status: 200,
				body: {
					message: m.server_emergency_triggered(),
					data: responseData,
				},
			};
		});
	}),

	listByOrder: priv.listByOrder.handler(
		async ({ context, input: { params } }) => {
			const { orderId } = params;

			// Get order to verify access
			const order = await context.repo.order.get(orderId);

			// Check if user has access to this order
			const userId = context.user.id;
			const isOperatorOrAdmin = ["OPERATOR", "ADMIN"].includes(
				context.user.role,
			);
			// Check if user is the driver by looking up their driver record
			const userDriver = await context.repo.driver.main
				.getByUserId(userId)
				.catch(() => null);
			const isDriver =
				order.driverId !== null &&
				userDriver !== null &&
				order.driverId === userDriver.id;

			if (!isOperatorOrAdmin && order.userId !== userId && !isDriver) {
				throw new Error(
					"You are not authorized to view emergencies for this order",
				);
			}

			const rows = await context.repo.emergency.listByOrder(orderId);

			return {
				status: 200,
				body: {
					message: m.server_emergencies_retrieved(),
					data: rows,
				},
			};
		},
	),

	get: priv.get.handler(async ({ context, input: { params } }) => {
		const result = await context.repo.emergency.get(params.id);

		// Verify access
		const userId = context.user.id;
		const isOperatorOrAdmin = ["OPERATOR", "ADMIN"].includes(context.user.role);
		// Check if user is the driver by looking up their driver record
		const userDriver = await context.repo.driver.main
			.getByUserId(userId)
			.catch(() => null);
		const isDriver =
			result.driverId !== null &&
			userDriver !== null &&
			result.driverId === userDriver.id;

		if (!isOperatorOrAdmin && result.userId !== userId && !isDriver) {
			throw new Error("You are not authorized to view this emergency");
		}

		return {
			status: 200,
			body: {
				message: m.server_emergency_retrieved(),
				data: result,
			},
		};
	}),

	updateStatus: priv.updateStatus.handler(
		async ({ context, input: { params, body } }) => {
			return await context.svc.db.transaction(async (tx) => {
				const data = trimObjectValues(body);

				// Add respondedById if not provided
				const updateData = {
					...data,
					respondedById: data.respondedById || context.user.id,
				};

				const result = await context.repo.emergency.update(
					params.id,
					updateData,
					{ tx },
				);

				logger.info(
					{
						emergencyId: params.id,
						status: result.status,
						respondedById: result.respondedById,
					},
					"[EmergencyHandler] Emergency status updated",
				);

				return {
					status: 200,
					body: {
						message: m.server_emergency_updated(),
						data: result,
					},
				};
			});
		},
	),
});
