import type { Coupon, InsertCoupon, UpdateCoupon } from "@repo/schema/coupon";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";
import { toNumberSafe, toStringNumberSafe } from "@/utils";

export class CouponRepository extends BaseRepository {
	readonly #db: DatabaseService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		super(FEATURE_TAGS.COUPON, kv);
		this.#db = db;
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
		const result = await this.#db.query.coupon.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? CouponRepository.composeEntity(result) : undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<Coupon[]> {
		try {
			let stmt = this.#db.query.coupon.findMany();

			if (query) {
				const { cursor, page, limit } = query;

				if (cursor) {
					stmt = this.#db.query.coupon.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.#db.query.coupon.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((item) => CouponRepository.composeEntity(item));
		} catch (error) {
			throw this.handleError(error, "list");
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
			const [operation] = await this.#db
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

			const [operation] = await this.#db
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
			const result = await this.#db
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
