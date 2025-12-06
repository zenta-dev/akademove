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
import type {
	ListResult,
	ORPCContext,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { CouponDatabase } from "@/core/tables/coupon";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";
import { CouponCalculationService } from "./services/coupon-calculation-service";
import { CouponValidationService } from "./services/coupon-validation-service";

export class CouponRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("coupon", kv, db);
	}

	static composeEntity(item: CouponDatabase): Coupon {
		return {
			...item,
			couponType: item.couponType ?? "GENERAL",
			discountAmount: item.discountAmount
				? toNumberSafe(item.discountAmount)
				: undefined,
			discountPercentage: item.discountPercentage ?? undefined,
			eventName: item.eventName ?? undefined,
			eventDescription: item.eventDescription ?? undefined,
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

			if (search) clauses.push(ilike(tables.coupon.name, `%${search}%`));

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

	async create(
		item: InsertCoupon & { userId: string },
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Coupon> {
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

			// Audit log
			if (context) {
				await AuditService.logChange(
					{
						tableName: "coupon",
						recordId: result.id,
						operation: "INSERT",
						oldData: null,
						newData: operation,
						updatedById: item.userId,
						metadata: AuditService.extractMetadata(context),
					},
					context,
					opts,
				);

				log.info(
					{ couponId: result.id, userId: item.userId },
					"[CouponRepository] Coupon created and audited",
				);
			}

			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: UpdateCoupon,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Coupon> {
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

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "coupon",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: context.user.id,
						metadata: AuditService.extractMetadata(context),
					},
					context,
					opts,
				);

				log.info(
					{ couponId: id, userId: context.user.id },
					"[CouponRepository] Coupon updated and audited",
				);
			}

			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(
		id: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<void> {
		try {
			const existing = context ? await this.#getFromDB(id) : undefined;

			const result = await this.db
				.delete(tables.coupon)
				.where(eq(tables.coupon.id, id))
				.returning({ id: tables.coupon.id });

			if (result.length > 0) {
				await this.deleteCache(id);

				// Audit log
				if (context?.user && existing) {
					await AuditService.logChange(
						{
							tableName: "coupon",
							recordId: id,
							operation: "DELETE",
							oldData: existing,
							newData: null,
							updatedById: context.user.id,
							metadata: AuditService.extractMetadata(context),
						},
						context,
						opts,
					);

					log.info(
						{ couponId: id, userId: context.user.id },
						"[CouponRepository] Coupon deleted and audited",
					);
				}
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

			// Create validation callbacks
			const getUserUsageCount = CouponValidationService.createGetUserUsageCount(
				this.db,
			);
			const getUserOrderCount = CouponValidationService.createGetUserOrderCount(
				this.db,
			);

			// Filter eligible coupons using validation service
			const eligibleCoupons: Coupon[] = [];

			for (const couponData of coupons) {
				const coupon = CouponRepository.composeEntity(couponData);

				const validation =
					await CouponValidationService.validateCouponEligibility(coupon, {
						orderAmount: totalAmount,
						userId,
						merchantId,
						getUserUsageCount,
						getUserOrderCount,
					});

				if (validation.valid) {
					eligibleCoupons.push(coupon);
				}
			}

			// Calculate best coupon using calculation service
			const { bestCoupon, bestDiscountAmount, allDiscounts } =
				CouponCalculationService.calculateBestCoupon(
					eligibleCoupons,
					totalAmount,
				);

			log.info(
				{
					userId,
					merchantId,
					totalAmount,
					eligibleCount: eligibleCoupons.length,
					bestCouponCode: bestCoupon?.code,
					bestDiscountAmount,
				},
				"[CouponRepository] Eligible coupons calculated",
			);

			return {
				coupons: allDiscounts.map((d) => d.coupon),
				bestCoupon,
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

			// Create validation callbacks
			const getUserUsageCount = CouponValidationService.createGetUserUsageCount(
				this.db,
			);
			const getUserOrderCount = CouponValidationService.createGetUserOrderCount(
				this.db,
			);

			// Validate coupon using validation service
			const validation = await CouponValidationService.validateCouponCode(
				coupon,
				{
					orderAmount,
					userId,
					merchantId,
					getUserUsageCount,
					getUserOrderCount,
				},
			);

			if (!validation.valid) {
				return {
					valid: false,
					coupon,
					discountAmount: 0,
					finalAmount: orderAmount,
					reason: validation.reason,
				};
			}

			// Calculate discount using calculation service
			const { discountAmount, finalAmount } =
				CouponCalculationService.calculateDiscount(coupon, orderAmount);

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

	async activate(
		id: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Coupon> {
		try {
			log.info({ couponId: id }, "[CouponRepository] Activating coupon");

			const coupon = await this.#getFromDB(id);
			if (!coupon) {
				throw new RepositoryError(m.error_failed_get_coupon(), {
					code: "NOT_FOUND",
				});
			}

			if (coupon.isActive) {
				throw new RepositoryError("Coupon is already active", {
					code: "BAD_REQUEST",
				});
			}

			const [updated] = await this.db
				.update(tables.coupon)
				.set({ isActive: true })
				.where(eq(tables.coupon.id, id))
				.returning();

			const result = CouponRepository.composeEntity(updated);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "coupon",
						recordId: id,
						operation: "UPDATE",
						oldData: coupon,
						newData: updated,
						updatedById: context.user.id,
						metadata: AuditService.extractMetadata(context),
					},
					context,
					opts,
				);

				log.info(
					{ couponId: id, userId: context.user.id },
					"[CouponRepository] Coupon activated and audited",
				);
			}

			return result;
		} catch (error) {
			throw this.handleError(error, "activate");
		}
	}

	async deactivate(
		id: string,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<Coupon> {
		try {
			log.info({ couponId: id }, "[CouponRepository] Deactivating coupon");

			const coupon = await this.#getFromDB(id);
			if (!coupon) {
				throw new RepositoryError(m.error_failed_get_coupon(), {
					code: "NOT_FOUND",
				});
			}

			if (!coupon.isActive) {
				throw new RepositoryError("Coupon is already inactive", {
					code: "BAD_REQUEST",
				});
			}

			const [updated] = await this.db
				.update(tables.coupon)
				.set({ isActive: false })
				.where(eq(tables.coupon.id, id))
				.returning();

			const result = CouponRepository.composeEntity(updated);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "coupon",
						recordId: id,
						operation: "UPDATE",
						oldData: coupon,
						newData: updated,
						updatedById: context.user.id,
						metadata: AuditService.extractMetadata(context),
					},
					context,
					opts,
				);

				log.info(
					{ couponId: id, userId: context.user.id },
					"[CouponRepository] Coupon deactivated and audited",
				);
			}

			return result;
		} catch (error) {
			throw this.handleError(error, "deactivate");
		}
	}
}
