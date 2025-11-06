import type {
	InsertMerchant,
	Merchant,
	UpdateMerchant,
} from "@repo/schema/merchant";
import { getFileExtension } from "@repo/shared";
import { eq, sql } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	type StorageBucket,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantDatabase } from "@/core/tables/merchant";
import { log } from "@/utils";

export class MerchantMainRepository {
	readonly #db: DatabaseService;
	readonly #kv: KeyValueService;
	readonly #storage: StorageService;
	readonly #privBucket: StorageBucket = "merchant-priv";
	readonly #pubBucket: StorageBucket = "merchant";

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		this.#db = db;
		this.#kv = kv;
		this.#storage = storage;
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT}${id}`;
	}

	private async composeEntity(
		item: MerchantDatabase,
	): Promise<Merchant & { documentId?: string; imageId?: string }> {
		const document = item.document
			? await this.#storage.getPresignedUrl({
					bucket: this.#privBucket,
					key: item.document,
				})
			: undefined;
		const image = item.image
			? this.#storage.getPublicUrl({
					bucket: this.#pubBucket,
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

	private async getFromKV(id: string): Promise<Merchant | undefined> {
		try {
			return await this.#kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async getFromDB(
		id: string,
	): Promise<
		(Merchant & { documentId?: string; imageId?: string }) | undefined
	> {
		const result = await this.#db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? await this.composeEntity(result) : undefined;
	}

	private async setCache(
		id: string,
		data: Merchant | undefined,
	): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {}
	}

	async list(opts?: GetAllOptions): Promise<Merchant[]> {
		try {
			let stmt = this.#db.query.merchant.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor && limit) {
					stmt = this.#db.query.merchant.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				} else if (page && limit) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.merchant.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return await Promise.all(result.map((r) => this.composeEntity(r)));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list merchants");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Merchant> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get merchant by id "${id}"`);
		}
	}

	async getByUserId(userId: string): Promise<Merchant> {
		try {
			const result = await this.#db.query.merchant.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			return await this.composeEntity(result);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to get merchant by user id "${userId}"`,
			);
		}
	}

	async getPopularMerchants(opts?: GetAllOptions): Promise<Merchant[]> {
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

			const rows = await this.#db.execute<{
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

			const merchants = await this.#db.query.merchant.findMany({
				where: (f, op) => op.inArray(f.id, merchantIds),
			});

			const merchantMap = new Map(merchants.map((m) => [m.id, m]));
			const ordered = rows
				.map((r) => merchantMap.get(r.merchant_id))
				.filter(Boolean);

			return await Promise.all(ordered.map((m) => this.composeEntity(m!)));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to get popular merchants");
		}
	}

	async create(
		item: InsertMerchant & { userId: string },
		opts?: { tx?: DatabaseTransaction },
	): Promise<Merchant> {
		try {
			const id = v7();
			const doc = item.document;
			const image = item.image;
			const docKey = doc ? `M-${id}.${getFileExtension(doc)}` : undefined;
			const imageKey = image ? `M-${id}.${getFileExtension(image)}` : undefined;

			const [operation] = await Promise.all([
				(opts?.tx ?? this.#db)
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
							bucket: this.#privBucket,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: this.#pubBucket,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

			const result = await this.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create merchant");
		}
	}

	async update(id: string, item: UpdateMerchant): Promise<Merchant> {
		try {
			const existing = await this.getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Merchant with id "${id}" not found`);

			const doc = item.document;
			const image = item.image;
			const docKey = doc ? `M-${id}.${getFileExtension(doc)}` : undefined;
			const imageKey = image ? `M-${id}.${getFileExtension(image)}` : undefined;

			const [operation] = await Promise.all([
				this.#db
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
							bucket: this.#privBucket,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
				image && imageKey
					? this.#storage.upload({
							bucket: this.#pubBucket,
							key: imageKey,
							file: image,
						})
					: Promise.resolve(),
			]);

			const result = await this.composeEntity(operation);
			await this.setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update merchant with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.getFromDB(id);
			if (!find)
				throw new RepositoryError("Merchant not found", { code: "NOT_FOUND" });

			const [result] = await Promise.all([
				this.#db
					.delete(tables.merchant)
					.where(eq(tables.merchant.id, id))
					.returning({ id: tables.merchant.id }),
				find.documentId
					? this.#storage.delete({
							bucket: this.#privBucket,
							key: find.documentId,
						})
					: Promise.resolve(),
				find.imageId
					? this.#storage.delete({
							bucket: this.#pubBucket,
							key: find.imageId,
						})
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete merchant with id "${id}"`);
		}
	}
}

export type MerchantMainRepositoryType = InstanceType<
	typeof MerchantMainRepository
>;
