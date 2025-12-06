import { trimObjectValues } from "@repo/shared";
import { createORPCRouter } from "@/core/router/orpc";
import { BROADCAST_STATUS, BROADCAST_TYPE } from "@/core/tables/broadcast";
import { log } from "@/utils";
import { BroadcastSpec } from "./broadcast-spec";
import { BroadcastService } from "./services/broadcast-service";

const { priv } = createORPCRouter(BroadcastSpec);

export const BroadcastHandler = priv.router({
	list: priv.list.handler(async ({ context, input: { query } }) => {
		const { broadcasts, total } = await context.repo.broadcast.findMany({
			page: query.page,
			limit: query.limit,
			status: query.status,
			type: query.type,
			targetAudience: query.targetAudience,
			search: query.search,
		});

		const totalPages = Math.ceil(total / query.limit);

		return {
			status: 200,
			body: {
				message: "Broadcasts retrieved successfully",
				data: broadcasts,
				totalPages,
			},
		} as const;
	}),

	get: priv.get.handler(async ({ context, input: { params } }) => {
		const broadcast = await context.repo.broadcast.findById(params.id);

		if (!broadcast) {
			throw new Error("Broadcast not found");
		}

		return {
			status: 200,
			body: {
				message: "Broadcast retrieved successfully",
				data: broadcast,
			},
		} as const;
	}),

	create: priv.create.handler(async ({ context, input: { body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);

			const broadcast = await context.repo.broadcast.create(
				{
					...data,
					createdBy: context.user.id,
				},
				{ tx },
			);

			log.info(
				{
					broadcastId: broadcast.id,
					type: broadcast.type,
					targetAudience: broadcast.targetAudience,
				},
				"[BroadcastHandler] Created broadcast",
			);

			return {
				status: 201,
				body: {
					message: "Broadcast created successfully",
					data: broadcast,
				},
			} as const;
		});
	}),

	update: priv.update.handler(async ({ context, input: { params, body } }) => {
		return await context.svc.db.transaction(async (tx) => {
			const data = trimObjectValues(body);

			// Check if broadcast exists and can be updated
			const existing = await context.repo.broadcast.findById(params.id, { tx });
			if (!existing) {
				throw new Error("Broadcast not found");
			}

			if (existing.status === BROADCAST_STATUS.SENT) {
				throw new Error("Cannot update sent broadcast");
			}

			if (existing.status === BROADCAST_STATUS.SENDING) {
				throw new Error("Cannot update broadcast that is currently sending");
			}

			const broadcast = await context.repo.broadcast.update(params.id, data, {
				tx,
			});

			log.info(
				{ broadcastId: broadcast.id },
				"[BroadcastHandler] Updated broadcast",
			);

			return {
				status: 200,
				body: {
					message: "Broadcast updated successfully",
					data: broadcast,
				},
			} as const;
		});
	}),

	delete: priv.delete.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			// Check if broadcast exists and can be deleted
			const existing = await context.repo.broadcast.findById(params.id, { tx });
			if (!existing) {
				throw new Error("Broadcast not found");
			}

			if (existing.status === BROADCAST_STATUS.SENT) {
				throw new Error("Cannot delete sent broadcast");
			}

			if (existing.status === BROADCAST_STATUS.SENDING) {
				throw new Error("Cannot delete broadcast that is currently sending");
			}

			await context.repo.broadcast.delete(params.id, { tx });

			log.info(
				{ broadcastId: params.id },
				"[BroadcastHandler] Deleted broadcast",
			);

			return {
				status: 200,
				body: {
					message: "Broadcast deleted successfully",
					data: { ok: true },
				},
			} as const;
		});
	}),

	send: priv.send.handler(async ({ context, input: { params } }) => {
		return await context.svc.db.transaction(async (tx) => {
			// Check if broadcast exists and can be sent
			const existing = await context.repo.broadcast.findById(params.id, { tx });
			if (!existing) {
				throw new Error("Broadcast not found");
			}

			if (existing.status !== BROADCAST_STATUS.PENDING) {
				throw new Error("Only pending broadcasts can be sent");
			}

			// Update status to SENDING
			const broadcast = await context.repo.broadcast.updateStatus(
				params.id,
				BROADCAST_STATUS.SENDING,
				{ tx },
			);

			// Create broadcast service for sending
			const broadcastService = new BroadcastService(
				context.svc.db,
				context.svc.mail,
				context.repo.notification,
			);

			// Send broadcast (this will be processed asynchronously)
			try {
				if (
					broadcast.type === BROADCAST_TYPE.EMAIL ||
					broadcast.type === BROADCAST_TYPE.ALL
				) {
					await broadcastService.sendEmailBroadcast(broadcast, { tx });
				}

				if (
					broadcast.type === BROADCAST_TYPE.IN_APP ||
					broadcast.type === BROADCAST_TYPE.ALL
				) {
					await broadcastService.sendInAppBroadcast(broadcast, { tx });
				}

				// Update status to SENT
				const sentBroadcast = await context.repo.broadcast.updateStatus(
					params.id,
					BROADCAST_STATUS.SENT,
					{ tx },
				);

				log.info(
					{
						broadcastId: params.id,
						type: broadcast.type,
						targetAudience: broadcast.targetAudience,
					},
					"[BroadcastHandler] Sent broadcast",
				);

				return {
					status: 200,
					body: {
						message: "Broadcast sent successfully",
						data: sentBroadcast,
					},
				} as const;
			} catch (error) {
				// Update status to FAILED
				await context.repo.broadcast.updateStatus(
					params.id,
					BROADCAST_STATUS.FAILED,
					{ tx },
				);

				log.error(
					{
						error,
						broadcastId: params.id,
					},
					"[BroadcastHandler] Failed to send broadcast",
				);

				throw new Error("Failed to send broadcast");
			}
		});
	}),

	stats: priv.stats.handler(async ({ context }) => {
		const stats = await context.repo.broadcast.getStats();
		return {
			status: 200,
			body: {
				message: "Broadcast stats retrieved successfully",
				data: stats,
			},
		} as const;
	}),
});
