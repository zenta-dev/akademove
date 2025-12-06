import { and, count, desc, eq, ilike, or } from "drizzle-orm";
import { v7 as uuidv7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import {
	BROADCAST_STATUS,
	type Broadcast,
	broadcast,
	type InsertBroadcast,
	type UpdateBroadcast,
} from "@/core/tables/broadcast";
import { log } from "@/utils";

export class BroadcastRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("broadcast", kv, db);
	}

	async create(data: InsertBroadcast, opts?: WithTx): Promise<Broadcast> {
		try {
			const db = opts?.tx ?? this.db;

			const result = await db
				.insert(broadcast)
				.values({
					id: uuidv7(),
					...data,
				})
				.returning();

			const newBroadcast = result[0];
			if (!newBroadcast) {
				throw new Error("Failed to create broadcast");
			}

			// Cache the new broadcast
			await this.setCache(`broadcast:${newBroadcast.id}`, newBroadcast, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			log.info(
				{ broadcastId: newBroadcast.id },
				"[BroadcastRepository] Created broadcast",
			);
			return BroadcastRepository.composeEntity(newBroadcast);
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async findById(id: string, opts?: WithTx): Promise<Broadcast | null> {
		try {
			const fallback = async () => {
				const db = opts?.tx ?? this.db;

				const result = await db.query.broadcast.findFirst({
					where: eq(broadcast.id, id),
				});

				if (!result) return null;

				// Cache the result
				await this.setCache(`broadcast:${id}`, result, {
					expirationTtl: CACHE_TTLS["1h"],
				});

				return BroadcastRepository.composeEntity(result);
			};

			return await this.getCache(`broadcast:${id}`, { fallback });
		} catch (error) {
			throw this.handleError(error, "findById");
		}
	}

	async findMany(
		options: {
			page?: number;
			limit?: number;
			status?: string;
			type?: string;
			targetAudience?: string;
			search?: string;
		},
		opts?: WithTx,
	): Promise<{ broadcasts: Broadcast[]; total: number }> {
		try {
			const db = opts?.tx ?? this.db;
			const {
				page = 1,
				limit = 20,
				status,
				type,
				targetAudience,
				search,
			} = options;
			const offset = (page - 1) * limit;

			// Build where conditions
			const conditions = [];

			if (status) {
				conditions.push(eq(broadcast.status, status as any));
			}

			if (type) {
				conditions.push(eq(broadcast.type, type as any));
			}

			if (targetAudience) {
				conditions.push(eq(broadcast.targetAudience, targetAudience as any));
			}

			if (search) {
				conditions.push(
					or(
						ilike(broadcast.title, `%${search}%`),
						ilike(broadcast.message, `%${search}%`),
					),
				);
			}

			const whereClause =
				conditions.length > 0 ? and(...conditions) : undefined;

			// Get total count
			const [{ total }] = await db
				.select({ total: count() })
				.from(broadcast)
				.where(whereClause);

			// Get broadcasts
			const results = await db
				.select()
				.from(broadcast)
				.where(whereClause)
				.orderBy(desc(broadcast.createdAt))
				.limit(limit)
				.offset(offset);

			const broadcasts = results.map((result) =>
				BroadcastRepository.composeEntity(result),
			);

			return { broadcasts, total };
		} catch (error) {
			throw this.handleError(error, "findMany");
		}
	}

	async update(
		id: string,
		data: UpdateBroadcast,
		opts?: WithTx,
	): Promise<Broadcast> {
		try {
			const db = opts?.tx ?? this.db;

			const result = await db
				.update(broadcast)
				.set({
					...data,
					updatedAt: new Date(),
				})
				.where(eq(broadcast.id, id))
				.returning();

			const updatedBroadcast = result[0];
			if (!updatedBroadcast) {
				throw new Error("Broadcast not found");
			}

			// Update cache
			await this.setCache(`broadcast:${id}`, updatedBroadcast, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			log.info({ broadcastId: id }, "[BroadcastRepository] Updated broadcast");
			return BroadcastRepository.composeEntity(updatedBroadcast);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async delete(id: string, opts?: WithTx): Promise<void> {
		try {
			const db = opts?.tx ?? this.db;

			await db.delete(broadcast).where(eq(broadcast.id, id));

			// Remove from cache
			await this.deleteCache(`broadcast:${id}`);

			log.info({ broadcastId: id }, "[BroadcastRepository] Deleted broadcast");
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}

	async getStats(opts?: WithTx): Promise<{
		total: number;
		pending: number;
		sending: number;
		sent: number;
		failed: number;
	}> {
		try {
			const db = opts?.tx ?? this.db;

			const stats = await db
				.select({
					total: count(),
					pending: count(broadcast.id).where(
						eq(broadcast.status, BROADCAST_STATUS.PENDING),
					),
					sending: count(broadcast.id).where(
						eq(broadcast.status, BROADCAST_STATUS.SENDING),
					),
					sent: count(broadcast.id).where(
						eq(broadcast.status, BROADCAST_STATUS.SENT),
					),
					failed: count(broadcast.id).where(
						eq(broadcast.status, BROADCAST_STATUS.FAILED),
					),
				})
				.from(broadcast);

			return (
				stats[0] || {
					total: 0,
					pending: 0,
					sending: 0,
					sent: 0,
					failed: 0,
				}
			);
		} catch (error) {
			throw this.handleError(error, "getStats");
		}
	}

	async findByStatus(status: string, opts?: WithTx): Promise<Broadcast[]> {
		try {
			const db = opts?.tx ?? this.db;

			const results = await db
				.select()
				.from(broadcast)
				.where(eq(broadcast.status, status as any))
				.orderBy(broadcast.createdAt);

			return results.map((result) => BroadcastRepository.composeEntity(result));
		} catch (error) {
			throw this.handleError(error, "findByStatus");
		}
	}

	async updateStatus(
		id: string,
		status: string,
		opts?: WithTx,
	): Promise<Broadcast> {
		try {
			const updateData: Partial<Broadcast> = {
				status: status as any,
				updatedAt: new Date(),
			};

			if (status === BROADCAST_STATUS.SENT) {
				updateData.sentAt = new Date();
			}

			return await this.update(id, updateData, opts);
		} catch (error) {
			throw this.handleError(error, "updateStatus");
		}
	}

	async updateCounts(
		id: string,
		counts: {
			sentCount?: number;
			failedCount?: number;
			totalRecipients?: number;
		},
		opts?: WithTx,
	): Promise<Broadcast> {
		try {
			return await this.update(id, counts, opts);
		} catch (error) {
			throw this.handleError(error, "updateCounts");
		}
	}

	private static composeEntity(row: any): Broadcast {
		return {
			...row,
			scheduledAt: row.scheduledAt ? new Date(row.scheduledAt) : null,
			sentAt: row.sentAt ? new Date(row.sentAt) : null,
			createdAt: new Date(row.createdAt),
			updatedAt: new Date(row.updatedAt),
		};
	}
}
