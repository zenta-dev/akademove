import { m } from "@repo/i18n";
import { trimObjectValues } from "@repo/shared";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { log } from "@/utils";
import { EmergencySpec } from "./emergency-spec";

const { priv } = createORPCRouter(EmergencySpec);

export const EmergencyHandler = priv.router({
	trigger: priv.trigger
		.use(hasPermission({ emergency: ["create"] }))
		.handler(async ({ context, input: { body } }) => {
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
				const isDriver = order.driverId !== null && order.driverId === userId;
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

				log.info(
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

					log.info(
						{ emergencyId: result.id },
						"[EmergencyHandler] Emergency notification sent to operators",
					);
				} catch (notifError) {
					// Log error but don't fail the emergency trigger
					log.error(
						{ error: notifError, emergencyId: result.id },
						"[EmergencyHandler] Failed to send emergency notification",
					);
				}

				return {
					status: 200,
					body: {
						message: m.server_emergency_triggered(),
						data: result,
					},
				};
			});
		}),

	listByOrder: priv.listByOrder
		.use(hasPermission({ emergency: ["list"] }))
		.handler(async ({ context, input: { params } }) => {
			const { orderId } = params;

			// Get order to verify access
			const order = await context.repo.order.get(orderId);

			// Check if user has access to this order
			const userId = context.user.id;
			const isOperatorOrAdmin = ["OPERATOR", "ADMIN"].includes(
				context.user.role,
			);
			const isDriver = order.driverId !== null && order.driverId === userId;

			if (!isOperatorOrAdmin && order.userId !== userId && !isDriver) {
				throw new Error(
					"You are not authorized to view emergencies for this order",
				);
			}

			const rows = await context.repo.emergency.listByOrder(orderId);

			return {
				status: 200,
				body: {
					message: "Successfully retrieved emergencies for order",
					data: rows,
				},
			};
		}),

	get: priv.get
		.use(hasPermission({ emergency: ["get"] }))
		.handler(async ({ context, input: { params } }) => {
			const result = await context.repo.emergency.get(params.id);

			// Verify access
			const userId = context.user.id;
			const isOperatorOrAdmin = ["OPERATOR", "ADMIN"].includes(
				context.user.role,
			);
			const isDriver = result.driverId !== null && result.driverId === userId;

			if (!isOperatorOrAdmin && result.userId !== userId && !isDriver) {
				throw new Error("You are not authorized to view this emergency");
			}

			return {
				status: 200,
				body: {
					message: "Successfully retrieved emergency data",
					data: result,
				},
			};
		}),

	updateStatus: priv.updateStatus
		.use(hasPermission({ emergency: ["update"] }))
		.handler(async ({ context, input: { params, body } }) => {
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

				log.info(
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
		}),
});
