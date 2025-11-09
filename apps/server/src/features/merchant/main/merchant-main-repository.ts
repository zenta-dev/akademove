import {
	type InsertMerchant,
	type Merchant,
	MerchantKeySchema,
	type UpdateMerchant,
} from "@repo/schema/merchant";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { getFileExtension } from "@repo/shared";
import { count, eq, gt, ilike, type SQL, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantDatabase } from "@/core/tables/merchant";
import { log } from "@/utils";

const PRIV_BUCKET = "merchant-priv";
const PUB_BUCKET = "merchant";

export class MerchantMainRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super(FEATURE_TAGS.MERCHANT, "merchant", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: MerchantDatabase,
		storage: StorageService,
	): Promise<Merchant & { documentId?: string; imageId?: string }> {
		const document = item.document
			? await storage.getPresignedUrl({
					bucket: PRIV_BUCKET,
					key: item.document,
				})
			: undefined;
		const image = item.image
			? storage.getPublicUrl({
					bucket: PUB_BUCKET,
					key: item.image,
				})
			: undefined;

		return {
			...item,
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

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.merchant.id) })
				.from(tables.merchant)
				.innerJoin(tables.user, eq(tables.merchant.userId, tables.user.id))
				.where(ilike(tables.user.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Merchant>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
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

				const totalCount = search
					? await this.#getQueryCount(search)
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
				if (!res) throw new RepositoryError("Failed to get merchant from DB");
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

			if (!result) throw new RepositoryError("Failed to get merchant from DB");

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
				WHERE o.status = 'completed'
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
			const docKey = doc ? `M-${id}.${getFileExtension(doc)}` : undefined;
			const imageKey = image ? `M-${id}.${getFileExtension(image)}` : undefined;

			const [operation] = await Promise.all([
				(opts?.tx ?? this.db)
					.insert(tables.merchant)
					.values({
						...item,
						id,
						document: docKey,
						image: imageKey,
					})
					.returning()
					.then((r) => r[0]),
				doc && docKey
					? this.#storage.upload({
							bucket: PRIV_BUCKET,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: PUB_BUCKET,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

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
			const docKey = doc ? `M-${id}.${getFileExtension(doc)}` : undefined;
			const imageKey = image ? `M-${id}.${getFileExtension(image)}` : undefined;

			const [operation] = await Promise.all([
				this.db
					.update(tables.merchant)
					.set({
						...existing,
						...item,
						document: docKey ?? existing.documentId,
						image: imageKey ?? existing.imageId,
						updatedAt: new Date(),
					})
					.where(eq(tables.merchant.id, id))
					.returning()
					.then((r) => r[0]),
				doc && docKey
					? this.#storage.upload({
							bucket: PRIV_BUCKET,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: PUB_BUCKET,
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
				throw new RepositoryError("Merchant not found", { code: "NOT_FOUND" });

			const [result] = await Promise.all([
				this.db
					.delete(tables.merchant)
					.where(eq(tables.merchant.id, id))
					.returning({ id: tables.merchant.id }),
				find.documentId
					? this.#storage.delete({
							bucket: PRIV_BUCKET,
							key: find.documentId,
						})
					: Promise.resolve(),
				find.imageId
					? this.#storage.delete({
							bucket: PUB_BUCKET,
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
}

export type MerchantMainRepositoryType = InstanceType<
	typeof MerchantMainRepository
>;
