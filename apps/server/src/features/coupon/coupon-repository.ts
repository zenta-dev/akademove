import type { Coupon, InsertCoupon, UpdateCoupon } from "@repo/schema/coupon";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";

export class CouponRepository {
	#db: DatabaseService;
	#kv: KeyValueService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		this.#db = db;
		this.#kv = kv;
	}

	#composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.COUPON}${id}`;
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

	async #getFromKV(id: string): Promise<Coupon | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(id: string): Promise<Coupon | undefined> {
		const result = await this.#db.query.coupon.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? CouponRepository.composeEntity(result) : undefined;
	}

	async #setCache(id: string, data: Coupon | undefined): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			// ignore cache write failures
		}
	}

	async list(opts?: GetAllOptions): Promise<Coupon[]> {
		try {
			let stmt = this.#db.query.coupon.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

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
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list coupons");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Coupon> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get coupon from db");

			await this.#setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get coupon by id "${id}"`);
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
			await this.#setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create coupon");
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
			await this.#setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update coupon with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.#db
				.delete(tables.coupon)
				.where(eq(tables.coupon.id, id))
				.returning({ id: tables.coupon.id });

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.#composeCacheKey(id));
				} catch {
					// ignore cache delete failures
				}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete coupon with id "${id}"`);
		}
	}
}
