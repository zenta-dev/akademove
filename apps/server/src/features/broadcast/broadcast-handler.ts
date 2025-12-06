import { BROADCAST_STATUS, BROADCAST_TYPE } from "@repo/schema/broadcast";
import { hasPermission } from "@/core/middlewares/auth";
import { createORPCRouter } from "@/core/router/orpc";
import { log, trimObjectValues } from "@/utils";
import { BroadcastSpec } from "./broadcast-spec";

export const BroadcastHandler = createORPCRouter(BroadcastSpec);

// Private endpoints
BroadcastHandler.priv.list = BroadcastHandler.priv.list.handler(
	async ({ context, input: { query } }) => {
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
			data: broadcasts,
			pagination: {
				page: query.page,
				limit: query.limit,
				total,
				totalPages,
			},
		};
	},
);

BroadcastHandler.priv.get = BroadcastHandler.priv.get
	.use(hasPermission({ broadcast: ["read"] }))
	.handler(async ({ context, input: { params } }) => {
		const broadcast = await context.repo.broadcast.findById(params.id);

		if (!broadcast) {
			throw new Error("Broadcast not found");
		}

		return broadcast;
	});

BroadcastHandler.priv.create = BroadcastHandler.priv.create
	.use(hasPermission({ broadcast: ["create"] }))
	.handler(async ({ context, input: { body } }) => {
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

			return broadcast;
		});
	});

BroadcastHandler.priv.update = BroadcastHandler.priv.update
	.use(hasPermission({ broadcast: ["update"] }))
	.handler(async ({ context, input: { params, body } }) => {
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
			return broadcast;
		});
	});

BroadcastHandler.priv.delete = BroadcastHandler.priv.delete
	.use(hasPermission({ broadcast: ["delete"] }))
	.handler(async ({ context, input: { params } }) => {
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
		});
	});

BroadcastHandler.priv.send = BroadcastHandler.priv.send
	.use(hasPermission({ broadcast: ["send"] }))
	.handler(async ({ context, input: { params } }) => {
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

			// Send broadcast (this will be processed asynchronously)
			try {
				if (
					broadcast.type === BROADCAST_TYPE.EMAIL ||
					broadcast.type === BROADCAST_TYPE.ALL
				) {
					await context.svc.broadcast.sendEmailBroadcast(broadcast, { tx });
				}

				if (
					broadcast.type === BROADCAST_TYPE.IN_APP ||
					broadcast.type === BROADCAST_TYPE.ALL
				) {
					await context.svc.broadcast.sendInAppBroadcast(broadcast, { tx });
				}

				// Update status to SENT
				await context.repo.broadcast.updateStatus(
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

			return broadcast;
		});
	});

BroadcastHandler.priv.stats = BroadcastHandler.priv.stats
	.use(hasPermission({ broadcast: ["read"] }))
	.handler(async ({ context }) => {
		const stats = await context.repo.broadcast.getStats();
		return stats;
	});
