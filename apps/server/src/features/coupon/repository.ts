import type { Coupon, InsertCoupon, UpdateCoupon } from "@repo/schema/coupon";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";

export const createCouponRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.COUPON}${id}`;
	}

	function _composeEntity(item: CouponDatabase): Coupon {
		return {
			...item,
			discountAmount: item.discountAmount ?? undefined,
			discountPercentage: item.discountPercentage ?? undefined,
			periodStart: item.periodStart.getTime(),
			periodEnd: item.periodEnd.getTime(),
			createdAt: item.createdAt.getTime(),
		};
	}

	async function _getFromKV(id: string): Promise<Coupon | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Coupon | undefined> {
		const result = await db.query.coupon.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Coupon | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Coupon[]> {
		try {
			let stmt = db.query.coupon.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.coupon.findMany({
						where: (f, op) => op.gt(f.createdAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.coupon.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing coupons", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get coupon from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get coupon by id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function create(
		item: InsertCoupon & { userId: string },
	): Promise<Coupon> {
		try {
			const [operation] = await db
				.insert(tables.coupon)
				.values({
					...item,
					usedCount: 0,
					periodStart: new Date(item.periodStart),
					periodEnd: new Date(item.periodEnd),
					createdById: item.userId,
					createdAt: new Date(),
				})
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			throw new RepositoryError("Failed to create coupon", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(id: string, item: UpdateCoupon): Promise<Coupon> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Coupon with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.coupon)
				.set({
					...existing,
					...item,
					periodStart: new Date(item.periodStart ?? existing.periodStart),
					periodEnd: new Date(item.periodEnd ?? existing.periodEnd),
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.coupon.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update coupon with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.coupon)
				.where(eq(tables.coupon.id, id))
				.returning({ id: tables.coupon.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			throw new RepositoryError(`Failed to delete coupon with id "${id}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	return { list, get, create, update, remove };
};

export type CouponRepository = ReturnType<typeof createCouponRepository>;
