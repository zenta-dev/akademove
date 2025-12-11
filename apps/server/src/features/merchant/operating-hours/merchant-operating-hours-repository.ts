import { m } from "@repo/i18n";
import type {
	InsertMerchantOperatingHours,
	MerchantOperatingHours,
	UpdateMerchantOperatingHours,
} from "@repo/schema/merchant";
import { and, eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, PartialWithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MerchantOperatingHoursDatabase } from "@/core/tables/merchant";
import { logger } from "@/utils/logger";

export class MerchantOperatingHoursRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("merchantOperatingHours", kv, db);
	}

	static composeEntity(
		item: MerchantOperatingHoursDatabase,
	): MerchantOperatingHours {
		return {
			...item,
			openTime: item.openTime ?? undefined,
			closeTime: item.closeTime ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<MerchantOperatingHours | null> {
		try {
			const result = await this.db.query.merchantOperatingHours.findFirst({
				where: eq(tables.merchantOperatingHours.id, id),
			});
			return result
				? MerchantOperatingHoursRepository.composeEntity(result)
				: null;
		} catch (error) {
			logger.error({ id, error }, "Failed to get operating hours from DB");
			return null;
		}
	}

	async listByMerchant(
		merchantId: string,
	): Promise<ListResult<MerchantOperatingHours>> {
		try {
			const result = await this.db.query.merchantOperatingHours.findMany({
				where: eq(tables.merchantOperatingHours.merchantId, merchantId),
				orderBy: (t, op) => op.asc(t.dayOfWeek),
			});

			const rows = result.map(MerchantOperatingHoursRepository.composeEntity);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	override async get(id: string): Promise<MerchantOperatingHours> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) {
					throw new RepositoryError(m.error_not_found(), { code: "NOT_FOUND" });
				}
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async getByMerchantAndDay(
		merchantId: string,
		dayOfWeek: MerchantOperatingHours["dayOfWeek"],
	): Promise<MerchantOperatingHours | null> {
		try {
			const result = await this.db.query.merchantOperatingHours.findFirst({
				where: and(
					eq(tables.merchantOperatingHours.merchantId, merchantId),
					eq(tables.merchantOperatingHours.dayOfWeek, dayOfWeek),
				),
			});
			return result
				? MerchantOperatingHoursRepository.composeEntity(result)
				: null;
		} catch (error) {
			logger.error(
				{ merchantId, dayOfWeek, error },
				"Failed to get operating hours by merchant and day",
			);
			return null;
		}
	}

	override async create(
		item: InsertMerchantOperatingHours & { merchantId: string },
		opts?: PartialWithTx,
	): Promise<MerchantOperatingHours> {
		try {
			const db = opts?.tx ?? this.db;
			const id = v7();

			const [operation] = await db
				.insert(tables.merchantOperatingHours)
				.values({
					...item,
					id,
				})
				.returning();

			if (!operation) {
				throw new RepositoryError("Failed to create operating hours", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const result = MerchantOperatingHoursRepository.composeEntity(operation);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});

			logger.info(
				{ id: result.id, merchantId: item.merchantId },
				"[MerchantOperatingHoursRepository] Created operating hours",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	override async update(
		id: string,
		item: UpdateMerchantOperatingHours,
		opts?: PartialWithTx,
	): Promise<MerchantOperatingHours> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Operating hours with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const [operation] = await db
				.update(tables.merchantOperatingHours)
				.set({
					...item,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.merchantOperatingHours.id, id))
				.returning();

			if (!operation) {
				throw new RepositoryError("Failed to update operating hours", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const result = MerchantOperatingHoursRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			logger.info(
				{ id },
				"[MerchantOperatingHoursRepository] Updated operating hours",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string, opts?: PartialWithTx): Promise<void> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Operating hours with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			await db
				.delete(tables.merchantOperatingHours)
				.where(eq(tables.merchantOperatingHours.id, id));

			await this.deleteCache(id);

			logger.info(
				{ id },
				"[MerchantOperatingHoursRepository] Deleted operating hours",
			);
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}

	async bulkUpsert(
		merchantId: string,
		hours: InsertMerchantOperatingHours[],
		opts?: PartialWithTx,
	): Promise<MerchantOperatingHours[]> {
		try {
			const db = opts?.tx ?? this.db;
			const results: MerchantOperatingHours[] = [];

			for (const hour of hours) {
				const existing = await this.getByMerchantAndDay(
					merchantId,
					hour.dayOfWeek,
				);

				if (existing) {
					// Update existing record
					const updated = await db
						.update(tables.merchantOperatingHours)
						.set({
							...hour,
							createdAt: new Date(existing.createdAt),
							updatedAt: new Date(),
						})
						.where(eq(tables.merchantOperatingHours.id, existing.id))
						.returning();

					if (updated[0]) {
						const result = MerchantOperatingHoursRepository.composeEntity(
							updated[0],
						);
						await this.setCache(result.id, result, {
							expirationTtl: CACHE_TTLS["24h"],
						});
						results.push(result);
					}
				} else {
					// Create new record
					const id = v7();
					const created = await db
						.insert(tables.merchantOperatingHours)
						.values({
							...hour,
							id,
							merchantId,
						})
						.returning();

					if (created[0]) {
						const result = MerchantOperatingHoursRepository.composeEntity(
							created[0],
						);
						await this.setCache(result.id, result, {
							expirationTtl: CACHE_TTLS["24h"],
						});
						results.push(result);
					}
				}
			}

			logger.info(
				{ merchantId, count: results.length },
				"[MerchantOperatingHoursRepository] Bulk upserted operating hours",
			);

			return results;
		} catch (error) {
			throw this.handleError(error, "bulk upsert");
		}
	}
}
