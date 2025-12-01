import {
	type Emergency,
	EmergencyKeySchema,
	type InsertEmergency,
	type UpdateEmergency,
} from "@repo/schema/emergency";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, eq, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
	WithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { EmergencyDatabase } from "@/core/tables/emergency";
import { log } from "@/utils";

export class EmergencyRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("emergency", kv, db);
	}

	static composeEntity(item: EmergencyDatabase): Emergency {
		return {
			...item,
			orderId: item.orderId ?? undefined,
			driverId: item.driverId ?? undefined,
			location: item.location
				? {
						latitude: item.location.x,
						longitude: item.location.y,
					}
				: undefined,
			contactedAuthorities:
				(item.contactedAuthorities as string[]) ?? undefined,
			respondedById: item.respondedById ?? undefined,
			resolution: item.resolution ?? undefined,
			acknowledgedAt: item.acknowledgedAt ?? undefined,
			respondingAt: item.respondingAt ?? undefined,
			resolvedAt: item.resolvedAt ?? undefined,
		};
	}

	async #getFromDB(
		id: string,
		opts?: PartialWithTx,
	): Promise<Emergency | undefined> {
		const result = await (opts?.tx ?? this.db).query.emergency.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? EmergencyRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string, opts?: PartialWithTx): Promise<number> {
		try {
			const [dbResult] = await (opts?.tx ?? this.db)
				.select({ count: count(tables.emergency.id) })
				.from(tables.emergency)
				.where(ilike(tables.emergency.description, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error(
				{ query, error },
				"[EmergencyRepository] Failed to get query count",
			);
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery,
		opts?: PartialWithTx,
	): Promise<ListResult<Emergency>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "desc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.emergency._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = EmergencyKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.reportedAt;
					return op[order](field);
				}
				return op[order](f.reportedAt);
			};

			const clauses: SQL[] = [];

			if (search)
				clauses.push(ilike(tables.emergency.description, `%${search}%`));

			if (cursor) {
				const result = await (opts?.tx ?? this.db).query.emergency.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = result.map(EmergencyRepository.composeEntity);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await (opts?.tx ?? this.db).query.emergency.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = result.map(EmergencyRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search, opts)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await (opts?.tx ?? this.db).query.emergency.findMany({
				where: (_f, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = result.map(EmergencyRepository.composeEntity);
			return { rows };
		} catch (error) {
			log.error({ error }, "[EmergencyRepository] Failed to list emergencies");
			return { rows: [] };
		}
	}

	async listByOrder(
		orderId: string,
		opts?: PartialWithTx,
	): Promise<Emergency[]> {
		try {
			const result = await (opts?.tx ?? this.db).query.emergency.findMany({
				where: (f, op) => op.eq(f.orderId, orderId),
				orderBy: (f, op) => op.desc(f.reportedAt),
			});

			return result.map(EmergencyRepository.composeEntity);
		} catch (error) {
			log.error(
				{ orderId, error },
				"[EmergencyRepository] Failed to list emergencies by order",
			);
			return [];
		}
	}

	async listByUser(userId: string, opts?: PartialWithTx): Promise<Emergency[]> {
		try {
			const result = await (opts?.tx ?? this.db).query.emergency.findMany({
				where: (f, op) => op.eq(f.userId, userId),
				orderBy: (f, op) => op.desc(f.reportedAt),
			});

			return result.map(EmergencyRepository.composeEntity);
		} catch (error) {
			log.error(
				{ userId, error },
				"[EmergencyRepository] Failed to list emergencies by user",
			);
			return [];
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<Emergency> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) {
					throw new RepositoryError("Emergency not found", {
						code: "NOT_FOUND",
					});
				}
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
				return res;
			};
			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertEmergency, opts: WithTx): Promise<Emergency> {
		try {
			const location = item.location
				? `POINT(${item.location.longitude} ${item.location.latitude})`
				: undefined;

			const values: Record<string, unknown> = {
				id: v7(),
				orderId: item.orderId,
				userId: item.userId,
				type: item.type,
				status: item.status,
				description: item.description,
			};

			if (item.driverId) values.driverId = item.driverId;
			if (location) values.location = location;
			if (item.contactedAuthorities)
				values.contactedAuthorities = item.contactedAuthorities;
			if (item.respondedById) values.respondedById = item.respondedById;
			if (item.resolution) values.resolution = item.resolution;

			const [operation] = await (opts.tx ?? this.db)
				.insert(tables.emergency)
				.values(values as never)
				.returning();

			if (!operation) {
				throw new RepositoryError("Failed to create emergency", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const result = EmergencyRepository.composeEntity(operation);

			log.info(
				{
					emergencyId: result.id,
					orderId: result.orderId,
					userId: result.userId,
				},
				"[EmergencyRepository] Emergency created",
			);

			// Cache the new emergency
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});
			await this.deleteCache("count"); // Invalidate count cache

			return result;
		} catch (error) {
			log.error(
				{ item, error },
				"[EmergencyRepository] Failed to create emergency",
			);
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: UpdateEmergency,
		opts: WithTx,
	): Promise<Emergency> {
		try {
			const updateData: Record<string, unknown> = { ...item };

			if (item.location) {
				updateData.location = `POINT(${item.location.longitude} ${item.location.latitude})`;
			}

			if (item.contactedAuthorities) {
				updateData.contactedAuthorities = item.contactedAuthorities as unknown;
			}

			// Set timestamps based on status updates
			if (item.status === "ACKNOWLEDGED") {
				updateData.acknowledgedAt = new Date();
			} else if (item.status === "RESPONDING") {
				updateData.respondingAt = new Date();
			} else if (item.status === "RESOLVED") {
				updateData.resolvedAt = new Date();
			}

			const [operation] = await (opts.tx ?? this.db)
				.update(tables.emergency)
				.set(updateData)
				.where(eq(tables.emergency.id, id))
				.returning();

			if (!operation) {
				throw new RepositoryError("Emergency not found", { code: "NOT_FOUND" });
			}

			const result = EmergencyRepository.composeEntity(operation);

			log.info(
				{ emergencyId: id, updates: item },
				"[EmergencyRepository] Emergency updated",
			);

			// Invalidate caches
			await this.deleteCache(id);

			return result;
		} catch (error) {
			log.error(
				{ id, item, error },
				"[EmergencyRepository] Failed to update emergency",
			);
			throw this.handleError(error, "update");
		}
	}

	async delete(id: string, opts: WithTx): Promise<void> {
		try {
			const result = await (opts.tx ?? this.db)
				.delete(tables.emergency)
				.where(eq(tables.emergency.id, id))
				.returning();

			if (!result || result.length === 0) {
				throw new RepositoryError("Emergency not found", { code: "NOT_FOUND" });
			}

			log.info({ emergencyId: id }, "[EmergencyRepository] Emergency deleted");

			// Invalidate caches
			await this.deleteCache(id);
			await this.deleteCache("count"); // Invalidate count cache
		} catch (error) {
			log.error(
				{ id, error },
				"[EmergencyRepository] Failed to delete emergency",
			);
			throw this.handleError(error, "delete");
		}
	}
}
