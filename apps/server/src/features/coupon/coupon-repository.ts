import {
	type Coupon,
	CouponKeySchema,
	type InsertCoupon,
	type UpdateCoupon,
} from "@repo/schema/coupon";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";

export class CouponRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.COUPON, "coupon", kv, db);
	}

	static composeEntity(item: CouponDatabase): Coupon {
		return {
			...item,
			discountAmount: item.discountAmount
				? toNumberSafe(item.discountAmount)
				: undefined,
			discountPercentage: item.discountPercentage ?? undefined,
		};
	}

	async #getFromDB(id: string): Promise<Coupon | undefined> {
		const result = await this.db.query.coupon.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? CouponRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.coupon.id) })
				.from(tables.coupon)
				.where(ilike(tables.coupon.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Coupon>> {
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
				f: typeof tables.coupon._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = CouponKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.coupon.name, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.coupon.createdAt, new Date(cursor)));

				const res = await this.db.query.coupon.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(CouponRepository.composeEntity);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.coupon.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map(CouponRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.coupon.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map(CouponRepository.composeEntity);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string): Promise<Coupon> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get coupon from db");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertCoupon & { userId: string }): Promise<Coupon> {
		try {
			const [operation] = await this.db
				.insert(tables.coupon)
				.values({
					...item,
					id: v7(),
					usedCount: 0,
					discountAmount: item.discountAmount
						? toStringNumberSafe(item.discountAmount)
						: undefined,
					periodStart: new Date(item.periodStart),
					periodEnd: new Date(item.periodEnd),
					createdById: item.userId,
					createdAt: new Date(),
				})
				.returning();

			const result = CouponRepository.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateCoupon): Promise<Coupon> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Coupon with id "${id}" not found`);

			const [operation] = await this.db
				.update(tables.coupon)
				.set({
					...item,
					discountAmount: item.discountAmount
						? toStringNumberSafe(item.discountAmount)
						: undefined,
					periodStart: new Date(item.periodStart ?? existing.periodStart),
					periodEnd: new Date(item.periodEnd ?? existing.periodEnd),
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.coupon.id, id))
				.returning();

			const result = CouponRepository.composeEntity(operation);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.coupon)
				.where(eq(tables.coupon.id, id))
				.returning({ id: tables.coupon.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}
