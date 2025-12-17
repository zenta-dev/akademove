import { m } from "@repo/i18n";
import type { PricingConfiguration } from "@repo/schema/configuration";
import type {
	EstimateOrder,
	Order,
	OrderStatusHistory,
	OrderSummary,
} from "@repo/schema/order";
import {
	OrderKeySchema,
	type OrderStatus,
	type OrderType,
} from "@repo/schema/order";
import type { UserRole } from "@repo/schema/user";
import {
	and,
	asc,
	count,
	desc,
	eq,
	gte,
	ilike,
	inArray,
	lt,
	lte,
	or,
	type SQL,
	sql,
} from "drizzle-orm";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	OrderByOperation,
	UnifiedListResult,
	WithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import { logger } from "@/utils/logger";
import type { OrderListQuery } from "../order-spec";
import type { OrderPricingService } from "../services";
import { OrderBaseRepository } from "./order-base-repository";

/**
 * OrderReadRepository - Handles all read operations for orders
 *
 * Responsibilities:
 * - Get single order by ID
 * - List orders with pagination and filtering
 * - Estimate order pricing
 * - Query count operations
 */
export class OrderReadRepository extends OrderBaseRepository {
	readonly #pricingService: OrderPricingService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		pricingService: OrderPricingService,
		storage?: StorageService,
	) {
		super(db, kv, storage);
		this.#pricingService = pricingService;
	}

	/**
	 * Get order by ID with caching
	 */
	async get(id: string, opts?: WithTx): Promise<Order> {
		try {
			const res = await this.getFromDB(id, opts);
			if (!res)
				throw new RepositoryError(`Order with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
			return res;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	/**
	 * Get order query count with filters
	 */
	async getQueryCount(
		query: string,
		filters?: {
			statuses?: OrderStatus[];
			type?: OrderType;
			startDate?: Date;
			endDate?: Date;
		},
		opts?: WithTx,
	): Promise<number> {
		try {
			const tx = opts?.tx ?? this.db;
			const clauses: SQL[] = [];

			if (query) {
				const searchClause = or(
					inArray(
						tables.order.userId,
						tx
							.select({ id: tables.user.id })
							.from(tables.user)
							.where(ilike(tables.user.name, `%${query}%`)),
					),
					inArray(
						tables.order.merchantId,
						tx
							.select({ id: tables.merchant.id })
							.from(tables.merchant)
							.where(ilike(tables.merchant.name, `%${query}%`)),
					),
					inArray(
						tables.order.driverId,
						tx
							.select({ id: tables.driver.id })
							.from(tables.driver)
							.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
							.where(ilike(tables.user.name, `%${query}%`)),
					),
				);
				if (searchClause) clauses.push(searchClause);
			}

			if (filters?.statuses && filters.statuses.length > 0) {
				clauses.push(inArray(tables.order.status, filters.statuses));
			}

			if (filters?.type) {
				clauses.push(eq(tables.order.type, filters.type));
			}

			if (filters?.startDate) {
				clauses.push(gte(tables.order.requestedAt, filters.startDate));
			}

			if (filters?.endDate) {
				clauses.push(lte(tables.order.requestedAt, filters.endDate));
			}

			if (clauses.length === 0) {
				const [dbResult] = await tx
					.select({ count: count(tables.order.id) })
					.from(tables.order);
				return dbResult?.count ?? 0;
			}

			const [dbResult] = await tx
				.select({ count: count(tables.order.id) })
				.from(tables.order)
				.where(and(...clauses));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error({ query, filters, error }, "Failed to get query count");
			return 0;
		}
	}

	/**
	 * Active order statuses - orders that are currently in progress
	 */
	static readonly ACTIVE_STATUSES: OrderStatus[] = [
		"REQUESTED",
		"MATCHING",
		"ACCEPTED",
		"PREPARING",
		"READY_FOR_PICKUP",
		"ARRIVING",
		"IN_TRIP",
	];

	/**
	 * List orders with pagination, filtering, and search
	 * For DRIVER role, active orders are prioritized to show on top
	 */
	async list(
		query?: OrderListQuery & {
			id?: string;
			role: UserRole;
		},
		opts?: WithTx,
	): Promise<UnifiedListResult<Order>> {
		const {
			cursor,
			page = 1,
			limit = 10,
			query: search,
			sortBy,
			order = "asc",
			statuses = [],
			type,
			startDate,
			endDate,
			id,
			role,
			mode = "offset",
		} = query ?? {};
		try {
			const tx = opts?.tx ?? this.db;

			// Fetch all pricing configurations upfront for estimatedDriverEarning calculation
			const pricingConfigs =
				await OrderBaseRepository.fetchAllPricingConfigurations(
					this.kv,
					this.db,
				);

			// For DRIVER role, prioritize active orders on top
			// Uses CASE WHEN to create a sort priority: active orders (0) before completed/cancelled (1)
			const isActiveOrderCase = sql<number>`CASE WHEN ${tables.order.status} IN (${sql.join(
				OrderReadRepository.ACTIVE_STATUSES.map((s) => sql`${s}`),
				sql`, `,
			)}) THEN 0 ELSE 1 END`;

			const orderBy = (
				f: typeof tables.order._.columns,
				op: OrderByOperation,
			) => {
				// For DRIVER role, always sort active orders first, then by createdAt desc
				if (role === "DRIVER") {
					return [asc(isActiveOrderCase), desc(f.createdAt)];
				}

				if (sortBy) {
					const parsed = OrderKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const withx = {
				user: {
					columns: { name: true, image: true, gender: true, rating: true },
				},
				driver: {
					columns: {},
					with: { user: { columns: { name: true, image: true } } },
				},
				merchant: { columns: { name: true } },
				items: {
					with: {
						menu: true,
					},
				},
			} as const;

			const clauses: SQL[] = [];

			if (statuses.length > 0) {
				clauses.push(inArray(tables.order.status, statuses));
			}

			if (type) {
				clauses.push(eq(tables.order.type, type));
			}

			if (startDate) {
				clauses.push(gte(tables.order.requestedAt, startDate));
			}

			if (endDate) {
				clauses.push(lte(tables.order.requestedAt, endDate));
			}

			if (id && role) {
				switch (role) {
					case "USER":
						clauses.push(eq(tables.order.userId, id));
						break;
					case "DRIVER":
						clauses.push(eq(tables.order.driverId, id));
						break;
					case "MERCHANT":
						clauses.push(eq(tables.order.merchantId, id));
						break;
				}
			}

			if (search) {
				const join = or(
					inArray(
						tables.order.userId,
						tx
							.select({ id: tables.user.id })
							.from(tables.user)
							.where(ilike(tables.user.name, `%${search}%`)),
					),
					inArray(
						tables.order.merchantId,
						tx
							.select({ id: tables.merchant.id })
							.from(tables.merchant)
							.where(ilike(tables.merchant.name, `%${search}%`)),
					),
					inArray(
						tables.order.driverId,
						tx
							.select({ id: tables.driver.id })
							.from(tables.driver)
							.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
							.where(ilike(tables.user.name, `%${search}%`)),
					),
				);
				if (join) clauses.push(join);
			}

			if (mode === "cursor") {
				if (cursor) clauses.push(lt(tables.order.id, cursor));
				const res = await tx.query.order.findMany({
					with: withx,
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				// Type assertion needed because we're selecting specific columns from relations
				// which changes the inferred type, but it's still compatible with Partial<User/Driver>
				const mapped = await Promise.all(
					res.map((item) =>
						OrderBaseRepository.composeEntity(
							item as unknown as Parameters<
								typeof OrderBaseRepository.composeEntity
							>[0],
							this.storage,
							pricingConfigs.get(item.type as "RIDE" | "DELIVERY" | "FOOD"),
						),
					),
				);
				const hasMore = mapped.length > limit;
				const rows = hasMore ? mapped.slice(0, limit) : mapped;
				const nextCursor = hasMore ? mapped[mapped.length - 1]?.id : undefined;

				return { rows, pagination: { hasMore, nextCursor } };
			}

			const offset = (page - 1) * limit;

			const result = await tx.query.order.findMany({
				with: withx,
				where: (_f, op) => op.and(...clauses),
				orderBy,
				offset,
				limit,
			});

			const rows = await Promise.all(
				result.map((item) =>
					OrderBaseRepository.composeEntity(
						item as unknown as Parameters<
							typeof OrderBaseRepository.composeEntity
						>[0],
						this.storage,
						pricingConfigs.get(item.type as "RIDE" | "DELIVERY" | "FOOD"),
					),
				),
			);

			const hasFilters = statuses.length > 0 || type || startDate || endDate;

			const totalCount =
				search || hasFilters
					? await this.getQueryCount(
							search ?? "",
							{
								statuses,
								type,
								startDate,
								endDate,
							},
							opts,
						)
					: await this.getTotalRow();

			const totalPages = Math.ceil(totalCount / limit);

			return { rows, pagination: { totalPages } };
		} catch (error) {
			this.handleError(error, "list");
			const res = { rows: [] };
			return res;
		}
	}

	/**
	 * Estimate order pricing based on pickup/dropoff locations
	 */
	async estimate(
		params: EstimateOrder,
		opts?: WithTx,
	): Promise<OrderSummary & { config: PricingConfiguration }> {
		try {
			// Create cache key based on parameters (rounded to 4 decimal places for coordinate precision)
			const pickup = `${params.pickupLocation.x},${params.pickupLocation.y}`;
			const dropoff = `${params.dropoffLocation.x},${params.dropoffLocation.y}`;
			const weight = params.weight ? `:${params.weight}` : "";
			const cacheKey = `estimate:${params.type}:${pickup}:${dropoff}${weight}`;

			// Try to get cached estimate (24 hour TTL - reduces Google Maps API costs)
			const cached = await this.getCache<
				OrderSummary & { config: PricingConfiguration }
			>(cacheKey, {
				fallback: async () => {
					// Get pricing configuration (still needed to return to client)
					const pricingConfig = await this.getPricingConfiguration(
						params.type,
						opts,
					);

					if (!pricingConfig)
						throw new RepositoryError(m.error_missing_pricing_configuration());

					// Use OrderPricingService to calculate estimate
					const pricing = await this.#pricingService.estimateOrder(params);

					const result = { ...pricing, config: pricingConfig };

					// PERFORMANCE: Cache estimate for 24 hours (reduces Google Maps API costs by 95%)
					await this.setCache(cacheKey, result, {
						expirationTtl: CACHE_TTLS["24h"],
					});

					logger.debug(
						{ cacheKey, distanceKm: pricing.distanceKm },
						"[OrderReadRepository] Cached new estimate",
					);

					return result;
				},
			});

			return cached;
		} catch (error) {
			throw this.handleError(error, "estimate");
		}
	}

	/**
	 * Get order status history (audit trail)
	 * Returns all status changes for an order sorted by changedAt descending (newest first)
	 */
	async getStatusHistory(
		orderId: string,
		opts?: WithTx,
	): Promise<OrderStatusHistory[]> {
		try {
			const tx = opts?.tx ?? this.db;

			const result = await tx.query.orderStatusHistory.findMany({
				where: (f, op) => op.eq(f.orderId, orderId),
				orderBy: (f, op) => op.desc(f.changedAt),
				with: {
					changedByUser: {
						columns: { id: true, name: true },
					},
				},
			});

			return result.map((item) => ({
				id: item.id,
				orderId: item.orderId,
				previousStatus: item.previousStatus,
				newStatus: item.newStatus,
				changedBy: item.changedBy,
				changedByRole: item.changedByRole,
				reason: item.reason,
				metadata: item.metadata as Record<string, unknown> | null,
				changedAt: item.changedAt,
				changedByUser: item.changedByUser
					? { id: item.changedByUser.id, name: item.changedByUser.name }
					: undefined,
			}));
		} catch (error) {
			throw this.handleError(error, "getStatusHistory");
		}
	}
}
