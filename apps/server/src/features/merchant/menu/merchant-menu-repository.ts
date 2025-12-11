import { m } from "@repo/i18n";
import type { Merchant } from "@repo/schema/merchant";
import {
	type InsertMerchantMenu,
	type MerchantMenu,
	MerchantMenuKeySchema,
	type UpdateMerchantMenu,
} from "@repo/schema/merchant";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { and, count, desc, eq, gt, ilike, type SQL, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	CountCache,
	ListResult,
	OrderByOperation,
	PartialWithTx,
	WithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantMenuDatabase } from "@/core/tables/merchant";
import {
	BestSellersService,
	MenuImageService,
} from "@/features/merchant/services";
import { toNumberSafe, toStringNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

interface MerchantMenuWithImage extends MerchantMenu {
	imageId?: string;
}

export class MerchantMenuRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("merchantMenu", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: MerchantMenuDatabase,
		storage: StorageService,
	): Promise<MerchantMenuWithImage> {
		const image = item.image
			? storage.getPublicUrl({
					bucket: MenuImageService.BUCKET,
					key: item.image,
				})
			: undefined;

		return {
			...item,
			category: item.category ?? undefined,
			imageId: item.image ?? undefined,
			price: toNumberSafe(item.price),
			image,
		};
	}

	async #getFromDB(id: string): Promise<MerchantMenuWithImage | null> {
		try {
			const result = await this.db.query.merchantMenu.findFirst({
				where: eq(tables.merchantMenu.id, id),
			});
			return result
				? await MerchantMenuRepository.composeEntity(result, this.#storage)
				: null;
		} catch (error) {
			logger.error({ id, error }, "Failed to get from DB");
			return null;
		}
	}

	async #setTotalRowCache(total: number): Promise<void> {
		try {
			await this.setCache<CountCache>(
				"count",
				{ total },
				{ expirationTtl: CACHE_TTLS["24h"] },
			);
		} catch (error) {
			logger.error({ error }, "Failed to set total row cache");
		}
	}

	async #getTotalRow(): Promise<number> {
		try {
			const fallback = async () => {
				const [dbResult] = await this.db
					.select({ count: count(tables.merchantMenu.id) })
					.from(tables.merchantMenu);
				const total = dbResult.count;
				await this.#setTotalRowCache(total);
				return { total };
			};
			const res = await this.getCache<CountCache>("count", { fallback });

			return res.total;
		} catch (error) {
			logger.error({ error }, "Failed to get total row count");
			return 0;
		}
	}

	async #getMerchantMenuCount(merchantId: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu)
				.where(eq(tables.merchantMenu.merchantId, merchantId));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error({ merchantId, error }, "Failed to get merchant menu count");
			return 0;
		}
	}

	async #getQueryCount(query: string, merchantId?: string): Promise<number> {
		try {
			const clauses: SQL[] = [ilike(tables.merchantMenu.name, `%${query}%`)];
			if (merchantId) {
				clauses.push(eq(tables.merchantMenu.merchantId, merchantId));
			}

			const [dbResult] = await this.db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu)
				.where(and(...clauses));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery & { merchantId?: string },
	): Promise<ListResult<MerchantMenu>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
				merchantId,
			} = query ?? {};

			const orderBy = (
				f: typeof tables.merchantMenu._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = MerchantMenuKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			// CRITICAL: Filter by merchantId if provided
			if (merchantId) {
				clauses.push(eq(tables.merchantMenu.merchantId, merchantId));
			}

			if (search) clauses.push(ilike(tables.merchantMenu.name, `%${search}%`));

			if (cursor) {
				clauses.push(gt(tables.merchantMenu.updatedAt, new Date(cursor)));

				const result = await this.db.query.merchantMenu.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						MerchantMenuRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.merchantMenu.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = await Promise.all(
					result.map((r) =>
						MerchantMenuRepository.composeEntity(r, this.#storage),
					),
				);

				const totalCount = search
					? await this.#getQueryCount(search, merchantId)
					: merchantId
						? await this.#getMerchantMenuCount(merchantId)
						: await this.#getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.merchantMenu.findMany();
			const rows = await Promise.all(
				result.map((r) =>
					MerchantMenuRepository.composeEntity(r, this.#storage),
				),
			);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<MerchantMenu> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_menu());
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
		item: InsertMerchantMenu & { merchantId: string },
		opts?: PartialWithTx,
	): Promise<MerchantMenu> {
		try {
			const db = opts?.tx ?? this.db;
			const id = v7();
			const imageFile = item.image;
			const imageKey = MenuImageService.generateImageKey(id, imageFile);

			const [operation] = await Promise.all([
				db
					.insert(tables.merchantMenu)
					.values({
						...item,
						id,
						image: imageKey,
						price: toStringNumberSafe(item.price),
					})
					.returning()
					.then((r) => r[0]),
				imageFile && imageKey
					? this.#storage.upload({
							bucket: MenuImageService.BUCKET,
							key: imageKey,
							file: imageFile,
							isPublic: true,
						})
					: Promise.resolve(),
			]);

			if (!operation) {
				throw new RepositoryError(m.error_failed_insert_merchant_menu());
			}

			const result = await MerchantMenuRepository.composeEntity(
				operation,
				this.#storage,
			);
			const currentCount = await this.#getTotalRow();

			await Promise.all([
				this.setCache(result.id, result, { expirationTtl: CACHE_TTLS["24h"] }),
				this.#setTotalRowCache(currentCount + 1),
			]);

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: UpdateMerchantMenu & { merchantId: string },
		opts?: PartialWithTx,
	): Promise<MerchantMenu> {
		try {
			const db = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const imageFile = item.image;
			const imageKey = MenuImageService.resolveUpdateImageKey(
				id,
				existing.imageId,
				imageFile,
			);
			const uploadPromise = imageFile
				? this.#storage.upload({
						bucket: MenuImageService.BUCKET,
						key: imageKey ?? existing.imageId ?? "",
						file: imageFile,
						isPublic: true,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				db
					.update(tables.merchantMenu)
					.set({
						...item,
						price: item.price ? toStringNumberSafe(item.price) : undefined,
						image: imageKey,
						createdAt: new Date(existing.createdAt),
						updatedAt: new Date(),
					})
					.where(eq(tables.merchantMenu.id, id))
					.returning()
					.then((r) => r[0]),
				uploadPromise,
			]);

			if (!operation) {
				throw new RepositoryError(m.error_failed_update_merchant_menu());
			}

			const result = await MerchantMenuRepository.composeEntity(
				operation,
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
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
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const currentCount = await this.#getTotalRow();

			const [result] = await Promise.all([
				db
					.delete(tables.merchantMenu)
					.where(eq(tables.merchantMenu.id, id))
					.returning({ id: tables.merchantMenu.id }),
				MenuImageService.shouldDelete(existing.imageId)
					? this.#storage.delete({
							bucket: MenuImageService.BUCKET,
							key: existing.imageId ?? "",
						})
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				await Promise.all([
					this.deleteCache(id),
					this.#setTotalRowCache(Math.max(0, currentCount - 1)),
				]);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}

	async getBestSellers(
		params: { limit?: number; category?: string },
		opts?: WithTx,
	): Promise<
		Array<{
			menu: MerchantMenu;
			merchant: Pick<Merchant, "id" | "name" | "image" | "rating">;
			orderCount: number;
		}>
	> {
		try {
			const { limit = 10, category } = params;
			const cacheKey = BestSellersService.getCacheKey(params);

			// Try cache first
			const result = await this.getCache<
				Array<{
					menu: MerchantMenu;
					merchant: Pick<Merchant, "id" | "name" | "image" | "rating">;
					orderCount: number;
				}>
			>(cacheKey, {
				fallback: async () => {
					const tx = opts?.tx ?? this.db;

					// Build category filter for merchants
					const categoryFilter = category
						? sql`${tables.merchant.categories} @> ARRAY[${category}]::text[]`
						: sql`${tables.merchant.categories} && ARRAY['ATK', 'Printing', 'Food']::text[]`;

					// Use LEFT JOIN to include menus without orders
					// Order by: order count DESC, then by merchant rating DESC, then by menu creation date DESC
					const result = await tx
						.select({
							menuId: tables.merchantMenu.id,
							menuName: tables.merchantMenu.name,
							menuImage: tables.merchantMenu.image,
							menuPrice: tables.merchantMenu.price,
							menuCategory: tables.merchantMenu.category,
							menuStock: tables.merchantMenu.stock,
							menuCreatedAt: tables.merchantMenu.createdAt,
							menuUpdatedAt: tables.merchantMenu.updatedAt,
							merchantId: tables.merchant.id,
							merchantName: tables.merchant.name,
							merchantImage: tables.merchant.image,
							merchantRating: tables.merchant.rating,
							orderCount: sql<number>`cast(count(${tables.orderItem.id}) as integer)`,
						})
						.from(tables.merchantMenu)
						.innerJoin(
							tables.merchant,
							eq(tables.merchantMenu.merchantId, tables.merchant.id),
						)
						.leftJoin(
							tables.orderItem,
							eq(tables.orderItem.menuId, tables.merchantMenu.id),
						)
						.leftJoin(
							tables.order,
							and(
								eq(tables.orderItem.orderId, tables.order.id),
								eq(tables.order.type, "FOOD"),
								eq(tables.order.status, "COMPLETED"),
							),
						)
						.where(
							and(
								eq(tables.merchant.status, "APPROVED"),
								eq(tables.merchant.isActive, true),
								eq(tables.merchant.operatingStatus, "OPEN"),
								gt(tables.merchantMenu.stock, 0),
								categoryFilter,
							),
						)
						.groupBy(
							tables.merchantMenu.id,
							tables.merchantMenu.name,
							tables.merchantMenu.image,
							tables.merchantMenu.price,
							tables.merchantMenu.category,
							tables.merchantMenu.stock,
							tables.merchantMenu.createdAt,
							tables.merchantMenu.updatedAt,
							tables.merchant.id,
							tables.merchant.name,
							tables.merchant.image,
							tables.merchant.rating,
						)
						.orderBy(
							desc(sql<number>`cast(count(${tables.orderItem.id}) as integer)`),
							desc(tables.merchant.rating),
							desc(tables.merchantMenu.createdAt),
						)
						.limit(limit);

					// Use service to transform results
					const bestSellers = await BestSellersService.transformBestSellers(
						result,
						{
							getMenuImageUrl: (key) =>
								this.#storage.getPublicUrl({
									bucket: MenuImageService.BUCKET,
									key,
								}),
							getMerchantImageUrl: (key) =>
								this.#storage.getPublicUrl({ bucket: "merchant", key }),
							toNumberSafe,
						},
					);

					// Cache for 1 hour
					await this.setCache(cacheKey, bestSellers, {
						expirationTtl: CACHE_TTLS["1h"],
					});

					logger.info(
						{ category, limit, count: bestSellers.length },
						"[MerchantMenuRepository] Retrieved best sellers",
					);

					return bestSellers;
				},
			});
			return result;
		} catch (error) {
			logger.error(
				{ error, params },
				"[MerchantMenuRepository] getBestSellers failed",
			);
			throw this.handleError(error, "get best sellers");
		}
	}
}
