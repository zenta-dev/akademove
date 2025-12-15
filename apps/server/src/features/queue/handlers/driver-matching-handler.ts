/**
 * Driver Matching Handler
 *
 * Handles DRIVER_MATCHING queue messages.
 * This is the core matching logic that runs with configurable timeout and radius expansion.
 * All configuration values come from the queue job payload (originally from database).
 *
 * Flow:
 * 1. Search for drivers within current radius
 * 2. If drivers found, broadcast OFFER via WebSocket AND send FCM push notifications
 * 3. If no drivers found, check if we've exceeded timeout
 * 4. If timeout exceeded, cancel order and process refund
 * 5. Otherwise, expand radius and schedule next attempt
 */

import type { DriverMatchingJob } from "@repo/schema/queue";
import type { OrderEnvelope } from "@repo/schema/ws";
import { sql } from "drizzle-orm";
import { DRIVER_POOL_KEY } from "@/core/constants";
import { OrderQueueService } from "@/core/services/queue";
import { order } from "@/core/tables/order";
import { OrderRepository } from "@/features/order/order-repository";
import type { MatchingConfig } from "@/features/order/services/order-matching-service";
import { logger } from "@/utils/logger";
import type { QueueHandlerContext } from "../queue-handler";

export async function handleDriverMatching(
	job: DriverMatchingJob,
	context: QueueHandlerContext,
	_ctx: ExecutionContext,
): Promise<void> {
	const { payload, meta: _meta } = job;
	const {
		orderId,
		pickupLocation,
		orderType,
		genderPreference,
		userGender,
		initialRadiusKm,
		maxRadiusKm,
		maxMatchingDurationMinutes,
		currentAttempt,
		maxExpansionAttempts,
		expansionRate,
		matchingIntervalSeconds,
		broadcastLimit,
		maxCancellationsPerDay,
		excludedDriverIds,
		isRetry,
	} = payload;

	logger.info(
		{
			orderId,
			attempt: currentAttempt,
			radiusKm: initialRadiusKm,
			maxRadiusKm,
			maxMinutes: maxMatchingDurationMinutes,
			isRetry: isRetry ?? false,
			excludedDriverCount: excludedDriverIds?.length ?? 0,
		},
		"[DriverMatchingHandler] Processing matching job",
	);

	try {
		// Use transaction with row-level locking to prevent race conditions
		// when multiple matching jobs run concurrently for the same order
		await context.svc.db.transaction(async (tx) => {
			// Use SELECT FOR UPDATE SKIP LOCKED to:
			// 1. Lock the order row to prevent concurrent modifications
			// 2. Skip if already locked by another matching job (avoid blocking)
			const lockedOrderResult = await tx.execute(
				sql`SELECT ${order.id}, ${order.status}, ${order.userId} FROM ${order} WHERE ${order.id} = ${orderId} FOR UPDATE SKIP LOCKED`,
			);
			const lockedOrder = lockedOrderResult[0] as
				| { id: string; status: string; user_id: string }
				| undefined;

			// If order not found or locked by another job, skip
			if (!lockedOrder) {
				logger.info(
					{ orderId },
					"[DriverMatchingHandler] Order not found or locked by another job - skipping",
				);
				return;
			}

			// Check if order is still in MATCHING status
			if (
				lockedOrder.status !== "MATCHING" &&
				lockedOrder.status !== "REQUESTED"
			) {
				logger.info(
					{ orderId, currentStatus: lockedOrder.status },
					"[DriverMatchingHandler] Order no longer needs matching - skipping",
				);
				return;
			}

			// Calculate current radius based on attempt, but cap at max radius
			let currentRadius =
				initialRadiusKm * (1 + expansionRate) ** (currentAttempt - 1);

			// Enforce max radius limit from config
			if (maxRadiusKm && currentRadius > maxRadiusKm) {
				logger.info(
					{
						orderId,
						calculatedRadius: currentRadius,
						maxRadiusKm,
					},
					"[DriverMatchingHandler] Capping radius at max limit",
				);
				currentRadius = maxRadiusKm;
			}

			// Build matching config from job payload (originally from database)
			const matchingConfig: MatchingConfig = {
				initialRadiusKm,
				maxRadiusKm: maxRadiusKm ?? 20, // Default fallback
				expansionRate,
				timeoutMs: matchingIntervalSeconds * 1000,
				broadcastLimit: broadcastLimit ?? 10, // Default fallback
				maxCancellationsPerDay: maxCancellationsPerDay ?? 3, // Default fallback
			};

			// Search for available drivers (outside lock scope for performance)
			const matchedDrivers =
				await context.svc.orderServices.matching.findAvailableDrivers(
					{
						orderId,
						pickupLocation,
						orderType,
						genderPreference,
						userGender,
						radiusKm: currentRadius,
						excludedDriverIds,
					},
					matchingConfig,
				);

			logger.info(
				{
					orderId,
					attempt: currentAttempt,
					radiusKm: currentRadius,
					maxRadiusKm,
					driversFound: matchedDrivers.length,
				},
				"[DriverMatchingHandler] Driver search completed",
			);

			if (matchedDrivers.length > 0) {
				// Get full order details for WebSocket broadcast
				const fullOrder = await context.repo.order.get(orderId, { tx });

				// Get payment info for the order
				const { OrderRefundService } = await import(
					"@/features/order/services/order-refund-service"
				);
				const { toNumberSafe } = await import("@/utils");
				const paymentTransaction =
					await OrderRefundService.findPaymentTransaction(tx, orderId);
				const paymentRow = paymentTransaction
					? await OrderRefundService.findPayment(tx, paymentTransaction.id)
					: null;

				// Convert DB rows to schema-compatible format (amounts from string to number)
				const payment = paymentRow
					? {
							...paymentRow,
							amount: toNumberSafe(paymentRow.amount),
							expiresAt: paymentRow.expiresAt ?? undefined,
							externalId: paymentRow.externalId ?? undefined,
							paymentUrl: paymentRow.paymentUrl ?? undefined,
							va_number: paymentRow.va_number ?? undefined,
							bankProvider: paymentRow.bankProvider ?? undefined,
						}
					: null;

				const transaction = paymentTransaction
					? {
							...paymentTransaction,
							amount: toNumberSafe(paymentTransaction.amount),
							balanceBefore: paymentTransaction.balanceBefore
								? toNumberSafe(paymentTransaction.balanceBefore)
								: undefined,
							balanceAfter: paymentTransaction.balanceAfter
								? toNumberSafe(paymentTransaction.balanceAfter)
								: undefined,
							description: paymentTransaction.description ?? undefined,
							referenceId: paymentTransaction.referenceId ?? undefined,
						}
					: null;

				// Create OFFER envelope for WebSocket broadcast
				const offerEnvelope: OrderEnvelope = {
					e: "OFFER",
					f: "s",
					t: "c",
					tg: "DRIVER",
					p: {
						detail: {
							order: fullOrder,
							payment,
							transaction,
						},
					},
				};

				// Broadcast OFFER to driver pool WebSocket
				// This notifies all connected drivers about the new order
				try {
					const driverPoolStub =
						OrderRepository.getRoomStubByName(DRIVER_POOL_KEY);
					const broadcastResponse = await driverPoolStub.fetch(
						new Request("http://internal/broadcast", {
							method: "POST",
							headers: { "Content-Type": "application/json" },
							body: JSON.stringify(offerEnvelope),
						}),
					);

					if (broadcastResponse.ok) {
						logger.info(
							{ orderId, driversFound: matchedDrivers.length },
							"[DriverMatchingHandler] OFFER broadcast sent to driver pool WebSocket",
						);
					} else {
						logger.warn(
							{
								orderId,
								status: broadcastResponse.status,
							},
							"[DriverMatchingHandler] Driver pool WebSocket broadcast failed",
						);
					}
				} catch (wsError) {
					// Log but don't fail - FCM notifications are fallback
					logger.error(
						{ error: wsError, orderId },
						"[DriverMatchingHandler] Failed to broadcast to driver pool WebSocket",
					);
				}

				// Create notification payload for drivers
				const driverUserIds = matchedDrivers
					.map((m) => m.driver.userId)
					.filter((id): id is string => id !== undefined);

				// Send push notifications to nearby drivers (FCM fallback for offline/background drivers)
				if (driverUserIds.length > 0) {
					await context.repo.notification.sendNotificationToUserIds({
						fromUserId: lockedOrder.user_id,
						toUserIds: driverUserIds,
						title: "New Order Available",
						body: `${orderType} order available near you`,
						data: {
							type: "NEW_ORDER",
							orderId,
							orderType,
							deeplink: `akademove://driver/order/${orderId}`,
						},
						android: {
							priority: "high",
							notification: { clickAction: "DRIVER_OPEN_ORDER_DETAIL" },
						},
						apns: {
							payload: { aps: { category: "ORDER_DETAIL", sound: "default" } },
						},
					});
				}

				logger.info(
					{
						orderId,
						wsNotified: true,
						fcmNotified: driverUserIds.length,
					},
					"[DriverMatchingHandler] Broadcasted to nearby drivers via WebSocket and FCM",
				);
			}

			// Check if we should continue matching
			// Don't continue if we've reached max radius or max attempts
			const atMaxRadius = maxRadiusKm && currentRadius >= maxRadiusKm;
			const shouldContinue =
				currentAttempt < maxExpansionAttempts &&
				matchedDrivers.length === 0 &&
				!atMaxRadius;

			if (shouldContinue) {
				// Calculate next radius (capped at max)
				const nextRadius = Math.min(
					currentRadius * (1 + expansionRate),
					maxRadiusKm ?? Number.POSITIVE_INFINITY,
				);

				// Schedule next matching attempt with expanded radius
				await OrderQueueService.enqueueDriverMatching(
					{
						...payload,
						currentAttempt: currentAttempt + 1,
						initialRadiusKm: nextRadius,
					},
					{ delaySeconds: matchingIntervalSeconds },
				);

				logger.info(
					{
						orderId,
						nextAttempt: currentAttempt + 1,
						nextRadius,
						maxRadiusKm,
						delaySeconds: matchingIntervalSeconds,
					},
					"[DriverMatchingHandler] Scheduled next matching attempt",
				);
			} else if (matchedDrivers.length === 0) {
				// No drivers found after all attempts - let the timeout handler deal with it
				logger.warn(
					{
						orderId,
						totalAttempts: currentAttempt,
						finalRadius: currentRadius,
						maxRadiusKm,
						atMaxRadius,
					},
					"[DriverMatchingHandler] Max attempts/radius reached with no drivers",
				);
			}
			// If drivers were found, we just wait for them to accept
		});
	} catch (error) {
		logger.error(
			{ error, orderId, attempt: currentAttempt },
			"[DriverMatchingHandler] Failed to process matching",
		);
		throw error;
	}
}
