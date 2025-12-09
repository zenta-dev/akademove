import { m } from "@repo/i18n";
import {
	type InsertMerchant,
	type Merchant,
	MerchantKeySchema,
	type UpdateMerchant,
} from "@repo/schema/merchant";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	and,
	count,
	eq,
	gt,
	gte,
	ilike,
	lte,
	or,
	type SQL,
	sql,
} from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantDatabase } from "@/core/tables/merchant";
import { log } from "@/utils";
import { MerchantDocumentService, MerchantStatsService } from "../services";
import type { MerchantListQuery } from "./merchant-main-spec";

export class MerchantMainRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("merchant", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: MerchantDatabase,
		storage: StorageService,
	): Promise<Merchant & { documentId?: string; imageId?: string }> {
		const document = item.document
			? await storage.getPresignedUrl({
					bucket: MerchantDocumentService.PRIV_BUCKET,
					key: item.document,
				})
			: undefined;
		const image = item.image
			? storage.getPublicUrl({
					bucket: MerchantDocumentService.PUB_BUCKET,
					key: item.image,
				})
			: undefined;

		return {
			...item,
			phone: item.phone ?? undefined,
			location: item.location ?? undefined,
			documentId: item.document ?? undefined,
			imageId: item.image ?? undefined,
			categories: item.categories ?? [],
			document,
			image,
		};
	}

	async #getFromDB(
		id: string,
	): Promise<
		(Merchant & { documentId?: string; imageId?: string }) | undefined
	> {
		const result = await this.db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? await MerchantMainRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async #getQueryCount(
		query: string,
		filters?: {
			categories?: string[];
			isActive?: boolean;
			minRating?: number;
			maxRating?: number;
			maxDistance?: number;
			latitude?: number;
			longitude?: number;
		},
	): Promise<number> {
		try {
			const clauses: SQL[] = [];

			if (query) {
				clauses.push(ilike(tables.merchant.name, `%${query}%`));
			}
			if (filters?.categories && filters.categories.length > 0) {
				// Match any of the categories in the array
				const categoryConditions = filters.categories.map(
					(cat) => sql`${tables.merchant.categories} @> ARRAY[${cat}]::text[]`,
				);
				const categoryClause = or(...categoryConditions);
				if (categoryClause) clauses.push(categoryClause);
			}
			if (filters?.isActive !== undefined) {
				clauses.push(eq(tables.merchant.isActive, filters.isActive));
			}
			if (filters?.minRating !== undefined) {
				clauses.push(gte(tables.merchant.rating, filters.minRating));
			}
			if (filters?.maxRating !== undefined) {
				clauses.push(lte(tables.merchant.rating, filters.maxRating));
			}
			// Add distance filter if coordinates provided
			if (
				filters?.maxDistance &&
				filters?.latitude !== undefined &&
				filters?.longitude !== undefined
			) {
				clauses.push(
					sql`ST_DWithin(
						${tables.merchant.location}::geography,
						ST_MakePoint(${filters.longitude}, ${filters.latitude})::geography,
						${filters.maxDistance}
					)`,
				);
			}

			const [dbResult] = await this.db
				.select({ count: count(tables.merchant.id) })
				.from(tables.merchant)
				.innerJoin(tables.user, eq(tables.merchant.userId, tables.user.id))
				.where(clauses.length > 0 ? and(...clauses) : undefined);

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, filters, error }, "Failed to get query count");
			return 0;
		}
	}

	override async list(
		query?: MerchantListQuery,
	): Promise<ListResult<Merchant>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
				categories,
				isActive,
				minRating,
				maxRating,
				maxDistance,
				latitude,
				longitude,
			} = query ?? {};

			const orderBy = (
				f: typeof tables.merchant._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = MerchantKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.merchant.name, `%${search}%`));

			// Add filter clauses
			if (categories && categories.length > 0) {
				// Match any of the categories in the array
				const categoryConditions = categories.map(
					(cat) => sql`${tables.merchant.categories} @> ARRAY[${cat}]::text[]`,
				);
				const categoryClause = or(...categoryConditions);
				if (categoryClause) clauses.push(categoryClause);
			}
			if (isActive !== undefined) {
				clauses.push(eq(tables.merchant.isActive, isActive));
			}
			if (minRating !== undefined) {
				clauses.push(gte(tables.merchant.rating, minRating));
			}
			if (maxRating !== undefined) {
				clauses.push(lte(tables.merchant.rating, maxRating));
			}

			// Add distance filtering using PostGIS if user location provided
			if (maxDistance && latitude && longitude) {
				// Filter merchants within max distance using PostGIS ST_DWithin
				// ST_DWithin uses meters as default unit for geography type
				clauses.push(
					sql`ST_DWithin(
						${tables.merchant.location}::geography,
						ST_MakePoint(${longitude}, ${latitude})::geography,
						${maxDistance}
					)`,
				);

				// Sort by distance if specified
				if (sortBy === "distance") {
					// Override orderBy to sort by distance
					const orderByDistance = (
						_f: typeof tables.merchant._.columns,
						op: OrderByOperation,
					) => {
						const distanceExpr = sql`ST_Distance(
							${tables.merchant.location}::geography,
							ST_MakePoint(${longitude}, ${latitude})::geography
						)`;
						return op.asc(distanceExpr);
					};

					// Execute with custom distance ordering
					if (cursor) {
						const result = await this.db.query.merchant.findMany({
							where: (_f, op) => op.and(...clauses),
							orderBy: orderByDistance,
							limit: limit + 1,
						});

						const rows = await Promise.all(
							result.map((r) =>
								MerchantMainRepository.composeEntity(r, this.#storage),
							),
						);
						return { rows };
					}

					const offset = ((page ?? 1) - 1) * limit;
					const result = await this.db.query.merchant.findMany({
						where: (_f, op) => op.and(...clauses),
						orderBy: orderByDistance,
						limit,
						offset,
					});

					const rows = await Promise.all(
						result.map((r) =>
							MerchantMainRepository.composeEntity(r, this.#storage),
						),
					);

					const totalCount = await this.#getQueryCount(search ?? "", {
						categories,
						isActive,
						minRating,
						maxRating,
						maxDistance,
						latitude,
						longitude,
					});
					const totalPages = Math.ceil(totalCount / limit);

					return { rows, totalPages };
				}
			}

			if (cursor) {
				clauses.push(gt(tables.merchant.updatedAt, new Date(cursor)));

				const result = await this.db.query.merchant.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						MerchantMainRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.merchant.findMany({
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = await Promise.all(
					result.map((r) =>
						MerchantMainRepository.composeEntity(r, this.#storage),
					),
				);

				const hasFilters =
					(categories && categories.length > 0) ||
					isActive !== undefined ||
					minRating !== undefined ||
					maxRating !== undefined;

				const totalCount =
					search || hasFilters
						? await this.#getQueryCount(search ?? "", {
								categories,
								isActive,
								minRating,
								maxRating,
							})
						: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.merchant.findMany({
				where: (_f, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = await Promise.all(
				result.map((r) =>
					MerchantMainRepository.composeEntity(r, this.#storage),
				),
			);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Merchant> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError(m.error_failed_get_merchant());
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async getByUserId(userId: string): Promise<Merchant> {
		try {
			const result = await this.db.query.merchant.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError(m.error_failed_get_merchant());

			return await MerchantMainRepository.composeEntity(result, this.#storage);
		} catch (error) {
			throw this.handleError(error, "get by user id");
		}
	}

	async getPopularMerchants(
		opts?: UnifiedPaginationQuery,
	): Promise<Merchant[]> {
		try {
			const limit = opts?.limit ?? 20;
			let paginationClause = sql``;

			if (opts?.cursor) {
				paginationClause = sql`AND m.created_at > ${new Date(opts.cursor)} LIMIT ${limit + 1}`;
			} else if (opts?.page) {
				const offset = (opts.page - 1) * limit;
				paginationClause = sql`OFFSET ${offset} LIMIT ${limit}`;
			} else {
				paginationClause = sql`LIMIT ${limit}`;
			}

			const rows = await this.db.execute<{
				merchant_id: string;
				popularity_score: number;
			}>(sql`
			WITH merchant_stats AS (
				SELECT
					o.merchant_id,
					COUNT(*) AS total_orders,
					SUM(o.total_price) AS total_revenue,
					MAX(o.requested_at) AS last_order_date,
					m.rating,
					m.created_at
				FROM am_orders o
				JOIN am_merchants m ON m.id = o.merchant_id
				WHERE o.status = 'COMPLETED'
					AND o.requested_at > NOW() - INTERVAL '30 days'
				GROUP BY o.merchant_id, m.rating, m.created_at
			),
			normalized AS (
				SELECT
					merchant_id,
					(total_orders - MIN(total_orders) OVER()) /
						NULLIF((MAX(total_orders) OVER() - MIN(total_orders) OVER()), 0) AS order_score,
					(total_revenue - MIN(total_revenue) OVER()) /
						NULLIF((MAX(total_revenue) OVER() - MIN(total_revenue) OVER()), 0) AS revenue_score,
					(rating - MIN(rating) OVER()) /
						NULLIF((MAX(rating) OVER() - MIN(rating) OVER()), 0) AS rating_score,
					EXTRACT(EPOCH FROM (NOW() - last_order_date)) AS seconds_since_last_order,
					created_at
				FROM merchant_stats
			),
			recency AS (
				SELECT
					merchant_id,
					order_score,
					revenue_score,
					rating_score,
					1 - (
						(seconds_since_last_order - MIN(seconds_since_last_order) OVER()) /
						NULLIF((MAX(seconds_since_last_order) OVER() - MIN(seconds_since_last_order) OVER()), 0)
					) AS recency_score,
					created_at
				FROM normalized
			)
			SELECT
				r.merchant_id,
				(
					0.40 * r.order_score +
					0.25 * r.revenue_score +
					0.20 * r.rating_score +
					0.15 * r.recency_score
				) AS popularity_score
			FROM recency r
			ORDER BY popularity_score DESC
			${paginationClause};
		`);

			if (!rows.length) return [];

			const merchantIds = rows.map((r) => r.merchant_id);

			const merchants = await this.db.query.merchant.findMany({
				where: (f, op) => op.inArray(f.id, merchantIds),
			});

			const merchantMap = new Map(merchants.map((m) => [m.id, m]));
			const ordered = rows
				.map((r) => merchantMap.get(r.merchant_id))
				.filter((m): m is MerchantDatabase => m !== undefined && m !== null);

			return await Promise.all(
				ordered.map((m) =>
					MerchantMainRepository.composeEntity(m, this.#storage),
				),
			);
		} catch (error) {
			throw this.handleError(error, "get popular merchants");
		}
	}

	async create(
		item: InsertMerchant & { userId: string },
		opts?: Partial<WithTx>,
	): Promise<Merchant> {
		try {
			const id = v7();
			const doc = item.document;
			const image = item.image;
			const docKey = MerchantDocumentService.generateDocumentKey(id, doc);
			const imageKey = MerchantDocumentService.generateImageKey(id, image);

			// First, insert into DB (within potential transaction)
			const [operation] = await (opts?.tx ?? this.db)
				.insert(tables.merchant)
				.values({
					...item,
					id,
					document: docKey,
					image: imageKey,
				})
				.returning();

			// Then upload files to S3 after DB insert succeeds
			// If S3 upload fails, clear the reference in DB
			const uploadPromises: Promise<unknown>[] = [];
			if (doc && docKey) {
				uploadPromises.push(
					this.#storage
						.upload({
							bucket: MerchantDocumentService.PRIV_BUCKET,
							key: docKey,
							file: doc,
						})
						.catch(async (uploadError) => {
							log.error(
								{ uploadError, merchantId: id, docKey },
								"[MerchantMainRepository] Failed to upload document",
							);
							await (opts?.tx ?? this.db)
								.update(tables.merchant)
								.set({ document: null })
								.where(eq(tables.merchant.id, id));
						}),
				);
			}
			if (image && imageKey) {
				uploadPromises.push(
					this.#storage
						.upload({
							bucket: MerchantDocumentService.PUB_BUCKET,
							key: imageKey,
							file: image,
						})
						.catch(async (uploadError) => {
							log.error(
								{ uploadError, merchantId: id, imageKey },
								"[MerchantMainRepository] Failed to upload image",
							);
							await (opts?.tx ?? this.db)
								.update(tables.merchant)
								.set({ image: null })
								.where(eq(tables.merchant.id, id));
						}),
				);
			}
			await Promise.all(uploadPromises);

			const result = await MerchantMainRepository.composeEntity(
				operation,
				this.#storage,
			);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateMerchant): Promise<Merchant> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Merchant with id "${id}" not found`);

			const doc = item.document;
			const image = item.image;
			const docKey = MerchantDocumentService.resolveUpdateDocumentKey(
				id,
				existing.documentId,
				doc,
			);
			const imageKey = MerchantDocumentService.resolveUpdateImageKey(
				id,
				existing.imageId,
				image,
			);

			const [operation] = await Promise.all([
				this.db
					.update(tables.merchant)
					.set({
						...existing,
						...item,
						document: docKey,
						image: imageKey,
						updatedAt: new Date(),
					})
					.where(eq(tables.merchant.id, id))
					.returning()
					.then((r) => r[0]),
				doc && docKey
					? this.#storage.upload({
							bucket: MerchantDocumentService.PRIV_BUCKET,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: MerchantDocumentService.PUB_BUCKET,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

			const result = await MerchantMainRepository.composeEntity(
				operation,
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.#getFromDB(id);
			if (!find)
				throw new RepositoryError(m.error_merchant_not_found(), {
					code: "NOT_FOUND",
				});

			const [result] = await Promise.all([
				this.db
					.delete(tables.merchant)
					.where(eq(tables.merchant.id, id))
					.returning({ id: tables.merchant.id }),
				find.documentId
					? this.#storage.delete({
							bucket: MerchantDocumentService.PRIV_BUCKET,
							key: find.documentId,
						})
					: Promise.resolve(),
				find.imageId
					? this.#storage.delete({
							bucket: MerchantDocumentService.PUB_BUCKET,
							key: find.imageId,
						})
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}

	async getAnalytics(
		merchantId: string,
		query?: {
			period?: "today" | "week" | "month" | "year";
			startDate?: Date;
			endDate?: Date;
		},
	): Promise<{
		totalOrders: number;
		totalRevenue: number;
		totalCommission: number;
		completedOrders: number;
		cancelledOrders: number;
		averageOrderValue: number;
		topSellingItems: Array<{
			menuId: string;
			menuName: string;
			menuImage?: string;
			totalOrders: number;
			totalRevenue: number;
		}>;
		revenueByDay: Array<{
			date: string;
			revenue: number;
			orders: number;
		}>;
	}> {
		try {
			// Calculate date range based on period (delegated to service)
			const { startDate, endDate } = MerchantStatsService.calculateDateRange(
				query?.period,
				query?.startDate,
				query?.endDate,
			);

			// Execute queries (SQL generation delegated to service)
			const [statsResult, topSellingResult, revenueByDayResult] =
				await Promise.all([
					this.db.execute<{
						total_orders: number;
						total_revenue: string;
						total_commission: string;
						completed_orders: number;
						cancelled_orders: number;
						average_order_value: string;
					}>(
						MerchantStatsService.getOverallStatsSQL(
							merchantId,
							startDate,
							endDate,
						),
					),
					this.db.execute<{
						menu_id: string;
						menu_name: string;
						menu_image: string | null;
						total_orders: number;
						total_revenue: string;
					}>(
						MerchantStatsService.getTopSellingItemsSQL(
							merchantId,
							startDate,
							endDate,
							10,
						),
					),
					this.db.execute<{
						date: string;
						revenue: string;
						orders: number;
					}>(
						MerchantStatsService.getRevenueByDaySQL(
							merchantId,
							startDate,
							endDate,
						),
					),
				]);

			// Compose analytics result (delegated to service)
			return MerchantStatsService.composeMerchantStats(
				statsResult[0],
				topSellingResult,
				revenueByDayResult,
				{
					getMenuImageUrl: (key: string | null) =>
						key
							? this.#storage.getPublicUrl({
									bucket: "merchant-menu",
									key,
								})
							: undefined,
				},
			);
		} catch (error) {
			throw this.handleError(error, "get analytics");
		}
	}

	async activate(id: string): Promise<Merchant> {
		try {
			log.info(
				{ merchantId: id },
				"[MerchantMainRepository] Activating merchant",
			);

			const merchant = await this.#getFromDB(id);
			if (!merchant) {
				throw new RepositoryError(m.error_merchant_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (merchant.isActive) {
				throw new RepositoryError("Merchant is already active", {
					code: "BAD_REQUEST",
				});
			}

			const [updated] = await this.db
				.update(tables.merchant)
				.set({ isActive: true, updatedAt: new Date() })
				.where(eq(tables.merchant.id, id))
				.returning();

			const result = await MerchantMainRepository.composeEntity(
				updated,
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			log.info(
				{ merchantId: id },
				"[MerchantMainRepository] Merchant activated",
			);
			return result;
		} catch (error) {
			throw this.handleError(error, "activate");
		}
	}

	async deactivate(id: string, reason: string): Promise<Merchant> {
		try {
			log.info(
				{ merchantId: id, reason },
				"[MerchantMainRepository] Deactivating merchant",
			);

			const merchant = await this.#getFromDB(id);
			if (!merchant) {
				throw new RepositoryError(m.error_merchant_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (!merchant.isActive) {
				throw new RepositoryError("Merchant is already inactive", {
					code: "BAD_REQUEST",
				});
			}

			const [updated] = await this.db
				.update(tables.merchant)
				.set({ isActive: false, updatedAt: new Date() })
				.where(eq(tables.merchant.id, id))
				.returning();

			const result = await MerchantMainRepository.composeEntity(
				updated,
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			log.info(
				{ merchantId: id, reason },
				"[MerchantMainRepository] Merchant deactivated",
			);
			return result;
		} catch (error) {
			throw this.handleError(error, "deactivate");
		}
	}

	/**
	 * Updates merchant online status
	 * @param id - Merchant ID
	 * @param isOnline - Online status
	 * @param opts - Optional transaction context
	 */
	async setOnlineStatus(
		id: string,
		isOnline: boolean,
		opts?: WithTx,
	): Promise<Merchant> {
		try {
			const db = opts?.tx ?? this.db;
			const result = await db
				.update(tables.merchant)
				.set({ isOnline, updatedAt: new Date() })
				.where(eq(tables.merchant.id, id))
				.returning();

			if (result.length === 0) {
				throw new RepositoryError(`Merchant with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const composed = await MerchantMainRepository.composeEntity(
				result[0],
				this.#storage,
			);
			await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
			return composed;
		} catch (error) {
			throw this.handleError(error, "setOnlineStatus");
		}
	}

	/**
	 * Updates merchant order-taking status
	 * @param id - Merchant ID
	 * @param isTakingOrders - Order-taking status
	 * @param opts - Optional transaction context
	 */
	async setOrderTakingStatus(
		id: string,
		isTakingOrders: boolean,
		opts?: WithTx,
	): Promise<Merchant> {
		try {
			const db = opts?.tx ?? this.db;
			const result = await db
				.update(tables.merchant)
				.set({ isTakingOrders, updatedAt: new Date() })
				.where(eq(tables.merchant.id, id))
				.returning();

			if (result.length === 0) {
				throw new RepositoryError(`Merchant with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const composed = await MerchantMainRepository.composeEntity(
				result[0],
				this.#storage,
			);
			await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
			return composed;
		} catch (error) {
			throw this.handleError(error, "setOrderTakingStatus");
		}
	}

	/**
	 * Updates merchant operating status
	 * @param id - Merchant ID
	 * @param operatingStatus - Operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
	 * @param opts - Optional transaction context
	 */
	async setOperatingStatus(
		id: string,
		operatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE",
		opts?: WithTx,
	): Promise<Merchant> {
		try {
			const db = opts?.tx ?? this.db;
			const result = await db
				.update(tables.merchant)
				.set({ operatingStatus, updatedAt: new Date() })
				.where(eq(tables.merchant.id, id))
				.returning();

			if (result.length === 0) {
				throw new RepositoryError(`Merchant with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const composed = await MerchantMainRepository.composeEntity(
				result[0],
				this.#storage,
			);
			await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
			return composed;
		} catch (error) {
			throw this.handleError(error, "setOperatingStatus");
		}
	}

	/**
	 * Gets merchant by ID with basic fields
	 * @param id - Merchant ID
	 * @param opts - Optional transaction context
	 */
	async getMerchantBasic(
		id: string,
		opts?: WithTx,
	): Promise<{
		id: string;
		isOnline: boolean;
		isTakingOrders: boolean;
		operatingStatus: "OPEN" | "CLOSED" | "BREAK" | "MAINTENANCE";
	} | null> {
		try {
			const db = opts?.tx ?? this.db;
			const result = await db.query.merchant.findFirst({
				where: (f, op) => op.eq(f.id, id),
				columns: {
					id: true,
					isOnline: true,
					isTakingOrders: true,
					operatingStatus: true,
				},
			});

			return result
				? {
						id: result.id,
						isOnline: result.isOnline,
						isTakingOrders: result.isTakingOrders,
						operatingStatus: result.operatingStatus as
							| "OPEN"
							| "CLOSED"
							| "BREAK"
							| "MAINTENANCE",
					}
				: null;
		} catch (error) {
			throw this.handleError(error, "getMerchantBasic");
		}
	}
}

export type MerchantMainRepositoryType = InstanceType<
	typeof MerchantMainRepository
>;
