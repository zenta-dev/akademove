import { m } from "@repo/i18n";
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
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";

export class CouponRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("coupon", kv, db);
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
				if (!res) throw new RepositoryError(m.error_failed_get_coupon());
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

	async getEligibleCoupons(params: {
		serviceType: string;
		totalAmount: number;
		userId: string;
		merchantId?: string;
	}): Promise<{
		coupons: Coupon[];
		bestCoupon: Coupon | null;
		bestDiscountAmount: number;
	}> {
		try {
			const { totalAmount, userId, merchantId } = params;
			const now = new Date();

			// Query active coupons within validity period
			const coupons = await this.db.query.coupon.findMany({
				where: (f, op) =>
					op.and(
						op.eq(f.isActive, true),
						op.lte(f.periodStart, now),
						op.gte(f.periodEnd, now),
						op.lt(f.usedCount, f.usageLimit),
						// Filter by merchantId if specified
						merchantId
							? op.or(op.isNull(f.merchantId), op.eq(f.merchantId, merchantId))
							: op.isNull(f.merchantId), // Only platform-wide if no merchantId
					),
			});

			const eligibleCoupons: Array<Coupon & { calculatedDiscount: number }> =
				[];

			// Validate each coupon and calculate discount
			for (const couponData of coupons) {
				const coupon = CouponRepository.composeEntity(couponData);

				// Check service type compatibility
				const couponServiceType = coupon.rules?.general?.type;
				if (
					couponServiceType &&
					couponServiceType !== "FIXED" &&
					couponServiceType !== "PERCENTAGE"
				) {
					continue; // Skip if type doesn't match (future: add ORDER_TYPE filter)
				}

				// Check minimum order amount
				const minOrderAmount = coupon.rules?.general?.minOrderAmount;
				if (minOrderAmount !== undefined && totalAmount < minOrderAmount) {
					continue;
				}

				// Check per-user usage limit
				const userUsageCount = await this.getUserUsageCount(coupon.id, userId);
				const perUserLimit = coupon.rules?.user?.perUserLimit ?? 1;
				if (userUsageCount >= perUserLimit) {
					continue;
				}

				// Check if new user only
				if (coupon.rules?.user?.newUserOnly) {
					const userOrderCount = await this.db
						.select({ count: count(tables.order.id) })
						.from(tables.order)
						.where(eq(tables.order.userId, userId));

					if (userOrderCount[0]?.count > 0) {
						continue;
					}
				}

				// Calculate discount
				let discountAmount = 0;
				if (coupon.discountAmount !== undefined && coupon.discountAmount > 0) {
					discountAmount = coupon.discountAmount;
				} else if (
					coupon.discountPercentage !== undefined &&
					coupon.discountPercentage > 0
				) {
					discountAmount = (totalAmount * coupon.discountPercentage) / 100;
				}

				// Apply max discount cap
				const maxDiscountAmount = coupon.rules?.general?.maxDiscountAmount;
				if (
					maxDiscountAmount !== undefined &&
					discountAmount > maxDiscountAmount
				) {
					discountAmount = maxDiscountAmount;
				}

				if (discountAmount > 0) {
					eligibleCoupons.push({
						...coupon,
						calculatedDiscount: discountAmount,
					});
				}
			}

			// Sort by discount amount (best first)
			eligibleCoupons.sort(
				(a, b) => b.calculatedDiscount - a.calculatedDiscount,
			);

			// Auto-select best coupon
			const bestCoupon = eligibleCoupons[0] ?? null;
			const bestDiscountAmount = bestCoupon?.calculatedDiscount ?? 0;

			// Remove calculated discount from return (not in schema)
			const cleanCoupons = eligibleCoupons.map(
				({ calculatedDiscount, ...c }) => c,
			);

			return {
				coupons: cleanCoupons,
				bestCoupon: bestCoupon
					? ({ ...bestCoupon, calculatedDiscount: undefined } as Coupon)
					: null,
				bestDiscountAmount,
			};
		} catch (error) {
			log.error({ params, error }, "Failed to get eligible coupons");
			throw this.handleError(error, "getEligibleCoupons");
		}
	}

	async validateCoupon(
		code: string,
		orderAmount: number,
		userId: string,
		_serviceType?: string,
		merchantId?: string,
	): Promise<{
		valid: boolean;
		coupon?: Coupon;
		discountAmount: number;
		finalAmount: number;
		reason?: string;
	}> {
		try {
			// Find coupon by code
			const couponData = await this.db.query.coupon.findFirst({
				where: (f, op) => op.eq(f.code, code),
			});

			if (!couponData) {
				return {
					valid: false,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon code not found",
				};
			}

			const coupon = CouponRepository.composeEntity(couponData);

			// Check if coupon is active
			if (!coupon.isActive) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon is not active",
				};
			}

			// Check merchantId if specified
			if (merchantId && coupon.merchantId && coupon.merchantId !== merchantId) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon not valid for this merchant",
				};
			}

			// Check date validity
			const now = new Date();
			const startDate = new Date(coupon.periodStart);
			const endDate = new Date(coupon.periodEnd);

			if (now < startDate) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon is not yet valid",
				};
			}

			if (now > endDate) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon has expired",
				};
			}

			// Check usage limit
			if (coupon.usedCount >= coupon.usageLimit) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "Coupon usage limit reached",
				};
			}

			// Check per-user usage limit (if applicable)
			const userUsageCount = await this.getUserUsageCount(coupon.id, userId);
			// Assuming a default per-user limit of 1, can be made configurable in rules
			const perUserLimit = coupon.rules?.user?.perUserLimit ?? 1;
			if (userUsageCount >= perUserLimit) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: "You have already used this coupon",
				};
			}

			// Check if coupon is for new users only
			if (coupon.rules?.user?.newUserOnly) {
				const userOrderCount = await this.db
					.select({ count: count(tables.order.id) })
					.from(tables.order)
					.where(eq(tables.order.userId, userId));

				if (userOrderCount[0]?.count > 0) {
					return {
						valid: false,
						coupon,
						discountAmount: 0,
						finalAmount: orderAmount,
						reason: "This coupon is for new users only",
					};
				}
			}

			// Check minimum order amount
			const minOrderAmount = coupon.rules?.general?.minOrderAmount;
			if (minOrderAmount !== undefined && orderAmount < minOrderAmount) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: `Minimum order amount is ${minOrderAmount}`,
				};
			}

			// Check time-based rules
			if (coupon.rules?.time) {
				const currentDay = [
					"SUNDAY",
					"MONDAY",
					"TUESDAY",
					"WEDNESDAY",
					"THURSDAY",
					"FRIDAY",
					"SATURDAY",
				][now.getDay()];
				const currentHour = now.getHours();

				if (
					coupon.rules.time.allowedDays &&
					coupon.rules.time.allowedDays.length > 0 &&
					!coupon.rules.time.allowedDays.includes(
						currentDay as
							| "SUNDAY"
							| "MONDAY"
							| "TUESDAY"
							| "WEDNESDAY"
							| "THURSDAY"
							| "FRIDAY"
							| "SATURDAY",
					)
				) {
					return {
						valid: false,
						coupon,
						discountAmount: 0,
						finalAmount: orderAmount,
						reason: "Coupon not valid on this day",
					};
				}

				if (
					coupon.rules.time.allowedHours &&
					coupon.rules.time.allowedHours.length > 0 &&
					!coupon.rules.time.allowedHours.includes(currentHour)
				) {
					return {
						valid: false,
						coupon,
						discountAmount: 0,
						finalAmount: orderAmount,
						reason: "Coupon not valid at this hour",
					};
				}
			}

			// Calculate discount
			let discountAmount = 0;
			if (coupon.discountAmount !== undefined && coupon.discountAmount > 0) {
				discountAmount = coupon.discountAmount;
			} else if (
				coupon.discountPercentage !== undefined &&
				coupon.discountPercentage > 0
			) {
				discountAmount = (orderAmount * coupon.discountPercentage) / 100;
			}

			// Apply max discount limit if set
			const maxDiscountAmount = coupon.rules?.general?.maxDiscountAmount;
			if (
				maxDiscountAmount !== undefined &&
				discountAmount > maxDiscountAmount
			) {
				discountAmount = maxDiscountAmount;
			}

			const finalAmount = Math.max(0, orderAmount - discountAmount);

			return {
				valid: true,
				coupon,
				discountAmount,
				finalAmount,
			};
		} catch (error) {
			log.error(
				{ code, orderAmount, userId, error },
				"Failed to validate coupon",
			);
			throw this.handleError(error, "validateCoupon");
		}
	}

	async getUserUsageCount(couponId: string, userId: string): Promise<number> {
		try {
			const usages = await this.db.query.couponUsage.findMany({
				where: (f, op) =>
					op.and(op.eq(f.couponId, couponId), op.eq(f.userId, userId)),
			});

			return usages.length;
		} catch (error) {
			log.error({ couponId, userId, error }, "Failed to get user usage count");
			throw this.handleError(error, "getUserUsageCount");
		}
	}

	async incrementUsageCount(id: string): Promise<void> {
		try {
			await this.db
				.update(tables.coupon)
				.set({
					usedCount: count(tables.couponUsage.id),
				})
				.where(eq(tables.coupon.id, id));

			await this.deleteCache(id);
		} catch (error) {
			log.error({ id, error }, "Failed to increment usage count");
			throw this.handleError(error, "incrementUsageCount");
		}
	}

	async recordUsage(
		couponId: string,
		orderId: string,
		userId: string,
		discountApplied: number,
	): Promise<void> {
		try {
			await this.db.insert(tables.couponUsage).values({
				id: v7(),
				couponId,
				orderId,
				userId,
				discountApplied: toStringNumberSafe(discountApplied),
			});
		} catch (error) {
			log.error(
				{ couponId, orderId, userId, discountApplied, error },
				"Failed to record coupon usage",
			);
			throw this.handleError(error, "recordUsage");
		}
	}
}
