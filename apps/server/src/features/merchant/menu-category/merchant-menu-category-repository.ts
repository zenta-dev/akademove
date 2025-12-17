// Note: Using generic error messages as menu category specific ones need to be added to i18n
import type {
	InsertMerchantMenuCategory,
	MerchantMenuCategory,
	UpdateMerchantMenuCategory,
} from "@repo/schema/merchant";
import { MerchantMenuCategoryKeySchema } from "@repo/schema/merchant";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { and, count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	CountCache,
	ListResult,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MerchantMenuCategoryDatabase } from "@/core/tables/merchant";
import { logger } from "@/utils/logger";

export class MerchantMenuCategoryRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("merchantMenuCategory", kv, db);
	}

	static composeEntity(
		item: MerchantMenuCategoryDatabase,
	): MerchantMenuCategory {
		return {
			...item,
			description: item.description ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<MerchantMenuCategory | null> {
		try {
			const result = await this.db.query.merchantMenuCategory.findFirst({
				where: eq(tables.merchantMenuCategory.id, id),
			});
			return result
				? MerchantMenuCategoryRepository.composeEntity(result)
				: null;
		} catch (error) {
			logger.error({ id, error }, "Failed to get from DB");
			return null;
		}
	}

	async #setTotalRowCache(merchantId: string, total: number): Promise<void> {
		try {
			await this.setCache<CountCache>(
				`count:${merchantId}`,
				{ total },
				{ expirationTtl: CACHE_TTLS["24h"] },
			);
		} catch (error) {
			logger.error({ error }, "Failed to set total row cache");
		}
	}

	async #getTotalRow(merchantId: string): Promise<number> {
		try {
			const fallback = async () => {
				const [dbResult] = await this.db
					.select({ count: count(tables.merchantMenuCategory.id) })
					.from(tables.merchantMenuCategory)
					.where(eq(tables.merchantMenuCategory.merchantId, merchantId));
				const total = dbResult.count;
				await this.#setTotalRowCache(merchantId, total);
				return { total };
			};
			const res = await this.getCache<CountCache>(`count:${merchantId}`, {
				fallback,
			});

			return res.total;
		} catch (error) {
			logger.error({ error }, "Failed to get total row count");
			return 0;
		}
	}

	async #getQueryCount(query: string, merchantId: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.merchantMenuCategory.id) })
				.from(tables.merchantMenuCategory)
				.where(
					and(
						eq(tables.merchantMenuCategory.merchantId, merchantId),
						ilike(tables.merchantMenuCategory.name, `%${query}%`),
					),
				);

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery & { merchantId: string },
	): Promise<ListResult<MerchantMenuCategory>> {
		try {
			const {
				cursor,
				page,
				limit = 50,
				query: search,
				sortBy,
				order = "asc",
				merchantId,
			} = query ?? {};

			if (!merchantId) {
				throw new RepositoryError("merchantId is required", {
					code: "BAD_REQUEST",
				});
			}

			const orderBy = (
				f: typeof tables.merchantMenuCategory._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = MerchantMenuCategoryKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.sortOrder;
					return op[order](field);
				}
				return op[order](f.sortOrder);
			};

			const clauses: SQL[] = [
				eq(tables.merchantMenuCategory.merchantId, merchantId),
			];

			if (search) {
				clauses.push(ilike(tables.merchantMenuCategory.name, `%${search}%`));
			}

			if (cursor) {
				clauses.push(
					gt(tables.merchantMenuCategory.updatedAt, new Date(cursor)),
				);

				const result = await this.db.query.merchantMenuCategory.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = result.map((r) =>
					MerchantMenuCategoryRepository.composeEntity(r),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.merchantMenuCategory.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = result.map((r) =>
					MerchantMenuCategoryRepository.composeEntity(r),
				);

				const totalCount = search
					? await this.#getQueryCount(search, merchantId)
					: await this.#getTotalRow(merchantId);

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.merchantMenuCategory.findMany({
				where: (_f, op) => op.and(...clauses),
				orderBy,
			});
			const rows = result.map((r) =>
				MerchantMenuCategoryRepository.composeEntity(r),
			);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<MerchantMenuCategory> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) {
					throw new RepositoryError("Menu category not found", {
						code: "NOT_FOUND",
					});
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

	async create(
		item: InsertMerchantMenuCategory & { merchantId: string },
		opts?: PartialWithTx,
	): Promise<MerchantMenuCategory> {
		try {
			const db = opts?.tx ?? this.db;
			const id = v7();

			// Check if category with same name already exists for this merchant
			const existing = await db.query.merchantMenuCategory.findFirst({
				where: and(
					eq(tables.merchantMenuCategory.merchantId, item.merchantId),
					eq(tables.merchantMenuCategory.name, item.name),
				),
			});

			if (existing) {
				throw new RepositoryError(
					`Menu category "${item.name}" already exists`,
					{
						code: "BAD_REQUEST",
					},
				);
			}

			const [operation] = await db
				.insert(tables.merchantMenuCategory)
				.values({
					...item,
					id,
				})
				.returning();

			if (!operation) {
				throw new RepositoryError("Failed to create menu category");
			}

			const result = MerchantMenuCategoryRepository.composeEntity(operation);
			const currentCount = await this.#getTotalRow(item.merchantId);

			await Promise.all([
				this.setCache(result.id, result, { expirationTtl: CACHE_TTLS["24h"] }),
				this.#setTotalRowCache(item.merchantId, currentCount + 1),
			]);

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: UpdateMerchantMenuCategory & { merchantId: string },
		opts?: PartialWithTx,
	): Promise<MerchantMenuCategory> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(
					`Merchant menu category with id "${id}" not found`,
					{
						code: "NOT_FOUND",
					},
				);
			}

			// Check ownership
			if (existing.merchantId !== item.merchantId) {
				throw new RepositoryError(
					"Cannot update menu category for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}

			// Check if new name conflicts with existing category
			if (item.name && item.name !== existing.name) {
				const conflict = await db.query.merchantMenuCategory.findFirst({
					where: and(
						eq(tables.merchantMenuCategory.merchantId, item.merchantId),
						eq(tables.merchantMenuCategory.name, item.name),
					),
				});

				if (conflict) {
					throw new RepositoryError(
						`Menu category "${item.name}" already exists`,
						{
							code: "BAD_REQUEST",
						},
					);
				}
			}

			const [operation] = await db
				.update(tables.merchantMenuCategory)
				.set({
					...item,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.merchantMenuCategory.id, id))
				.returning();

			if (!operation) {
				throw new RepositoryError("Failed to update menu category");
			}

			const result = MerchantMenuCategoryRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(
		id: string,
		merchantId: string,
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(
					`Merchant menu category with id "${id}" not found`,
					{
						code: "NOT_FOUND",
					},
				);
			}

			// Check ownership
			if (existing.merchantId !== merchantId) {
				throw new RepositoryError(
					"Cannot delete menu category for other merchants",
					{
						code: "FORBIDDEN",
					},
				);
			}

			const currentCount = await this.#getTotalRow(merchantId);

			// Set categoryId to null for all menus using this category
			await db
				.update(tables.merchantMenu)
				.set({ categoryId: null })
				.where(eq(tables.merchantMenu.categoryId, id));

			const [result] = await db
				.delete(tables.merchantMenuCategory)
				.where(eq(tables.merchantMenuCategory.id, id))
				.returning({ id: tables.merchantMenuCategory.id });

			if (result) {
				await Promise.all([
					this.deleteCache(id),
					this.#setTotalRowCache(merchantId, Math.max(0, currentCount - 1)),
				]);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}
