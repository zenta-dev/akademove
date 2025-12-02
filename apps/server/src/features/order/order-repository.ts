import { env } from "cloudflare:workers";
import { m } from "@repo/i18n";
import {
	type ConfigurationValue,
	DeliveryPricingConfigurationSchema,
	FoodPricingConfigurationSchema,
	type PricingConfiguration,
	RidePricingConfigurationSchema,
} from "@repo/schema/configuration";
import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import {
	type EstimateOrder,
	type Order,
	OrderKeySchema,
	type OrderStatus,
	type OrderSummary,
	type OrderType,
	type PlaceOrder,
	type PlaceOrderResponse,
	type UpdateOrder,
} from "@repo/schema/order";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { User, UserRole } from "@repo/schema/user";
import { nullsToUndefined } from "@repo/shared";
import Decimal from "decimal.js";
import { count, eq, ilike, inArray, lt, or, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	OrderByOperation,
	UnifiedListResult,
	WithTx,
	WithUserId,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MapService } from "@/core/services/map";
import type { OrderDatabase } from "@/core/tables/order";
import { log, safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PricingCalculator } from "@/utils/pricing";
import type {
	ChargePayload,
	PaymentRepository,
} from "../payment/payment-repository";

export class OrderRepository extends BaseRepository {
	readonly #map: MapService;
	readonly #paymentRepo: PaymentRepository;
	// PERFORMANCE: In-memory cache for pricing configurations (99% faster than DB/KV)
	// These configs rarely change, so we cache them in memory with manual invalidation
	static #pricingConfigCache = new Map<string, ConfigurationValue>();
	static #cacheLoadedAt: Date | null = null;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		map: MapService,
		paymentRepo: PaymentRepository,
	) {
		super("order", kv, db);
		this.#map = map;
		this.#paymentRepo = paymentRepo;
		// Preload pricing configs on first instantiation
		if (!OrderRepository.#cacheLoadedAt) {
			this.#preloadPricingConfigs().catch((err) => {
				log.error(
					{ error: err },
					"[OrderRepository] Failed to preload pricing configs",
				);
			});
		}
	}

	/**
	 * Preloads all pricing configurations into memory cache
	 * Called automatically on repository instantiation
	 */
	async #preloadPricingConfigs(): Promise<void> {
		try {
			const configs = await this.db.query.configuration.findMany({
				where: (f, op) =>
					op.inArray(f.key, [
						CONFIGURATION_KEYS.RIDE_SERVICE_PRICING,
						CONFIGURATION_KEYS.DELIVERY_SERVICE_PRICING,
						CONFIGURATION_KEYS.FOOD_SERVICE_PRICING,
					]),
			});

			for (const config of configs) {
				OrderRepository.#pricingConfigCache.set(config.key, config.value);
			}

			OrderRepository.#cacheLoadedAt = new Date();
			log.info(
				{ count: configs.length, loadedAt: OrderRepository.#cacheLoadedAt },
				"[OrderRepository] Pricing configs preloaded into memory",
			);
		} catch (error) {
			log.error(
				{ error },
				"[OrderRepository] Failed to preload pricing configs",
			);
			throw error;
		}
	}

	/**
	 * Invalidates the in-memory pricing config cache
	 * Call this when pricing configurations are updated by admins
	 */
	static invalidatePricingCache(): void {
		OrderRepository.#pricingConfigCache.clear();
		OrderRepository.#cacheLoadedAt = null;
		log.info("[OrderRepository] Pricing config cache invalidated");
	}

	static composeEntity(
		item: OrderDatabase & {
			user: Partial<User> | null;
			driver: Partial<Driver> | null;
			merchant: Partial<Merchant> | null;
		},
	): Order {
		return {
			...item,
			...nullsToUndefined(item),
			basePrice: toNumberSafe(item.basePrice),
			totalPrice: toNumberSafe(item.totalPrice),
			tip: item.tip ? toNumberSafe(item.tip) : undefined,
			platformCommission: item.platformCommission
				? toNumberSafe(item.platformCommission)
				: undefined,
			driverEarning: item.driverEarning
				? toNumberSafe(item.driverEarning)
				: undefined,
			merchantCommission: item.merchantCommission
				? toNumberSafe(item.merchantCommission)
				: undefined,
			discountAmount: item.discountAmount
				? toNumberSafe(item.discountAmount)
				: undefined,
		};
	}

	static getRoomStubByName(name: string) {
		const stubId = env.ORDER_ROOM.idFromName(name);
		const stub = env.ORDER_ROOM.get(stubId);
		return stub;
	}

	async #getFromDB(id: string, opts?: WithTx): Promise<Order | undefined> {
		const result = await (opts?.tx ?? this.db).query.order.findFirst({
			with: {
				user: { columns: { name: true } },
				driver: { columns: {}, with: { user: { columns: { name: true } } } },
				merchant: { columns: { name: true } },
			},
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? OrderRepository.composeEntity(result) : undefined;
	}

	async #getQueryCount(query: string, opts?: WithTx): Promise<number> {
		try {
			const tx = opts?.tx ?? this.db;

			const [dbResult] = await tx
				.select({ count: count(tables.order.id) })
				.from(tables.order)
				.where(
					or(
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
								.innerJoin(
									tables.user,
									eq(tables.driver.userId, tables.user.id),
								)
								.where(ilike(tables.user.name, `%${query}%`)),
						),
					),
				);

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery & {
			statuses?: OrderStatus[];
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
			id,
			role,
			mode = "offset",
		} = query ?? {};
		try {
			const tx = opts?.tx ?? this.db;

			const orderBy = (
				f: typeof tables.order._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = OrderKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const withx = {
				user: { columns: { name: true } },
				driver: {
					columns: {},
					with: { user: { columns: { name: true } } },
				},
				merchant: { columns: { name: true } },
			} as const;

			const clauses: SQL[] = [];

			if (statuses.length > 0) {
				clauses.push(inArray(tables.order.status, statuses));
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

				const mapped = res.map(OrderRepository.composeEntity);
				const hasMore = mapped.length > limit;
				const rows = hasMore ? mapped.slice(0, limit) : mapped;
				const nextCursor = hasMore ? mapped[mapped.length - 1].id : undefined;

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

			const rows = result.map(OrderRepository.composeEntity);

			const totalCount = search
				? await this.#getQueryCount(search, opts)
				: await this.getTotalRow();

			const totalPages = Math.ceil(totalCount / limit);

			return { rows, pagination: { totalPages } };
		} catch (error) {
			this.handleError(error, "list");
			const res = { rows: [] };
			return res;
		}
	}
	async #getPricingConfiguration(
		params: { type: OrderType },
		opts?: WithTx,
	): Promise<PricingConfiguration | undefined> {
		let key = "";
		switch (params.type) {
			case "RIDE":
				key = CONFIGURATION_KEYS.RIDE_SERVICE_PRICING;
				break;
			case "DELIVERY":
				key = CONFIGURATION_KEYS.DELIVERY_SERVICE_PRICING;
				break;
			case "FOOD":
				key = CONFIGURATION_KEYS.FOOD_SERVICE_PRICING;
				break;
			default:
				throw new RepositoryError("Invalid order type");
		}

		// PERFORMANCE: Check in-memory cache first (99% faster, zero DB load)
		const cached = OrderRepository.#pricingConfigCache.get(key);
		if (cached) {
			return cached as PricingConfiguration;
		}

		// Cache miss - load from DB and populate memory cache
		log.warn(
			{ key },
			"[OrderRepository] Pricing config cache miss - loading from DB",
		);
		const fallback = async () => {
			const db = opts?.tx ?? this.db;
			const res = await db.query.configuration.findFirst({
				where: (f, op) => op.eq(f.key, key),
			});
			const value = res?.value;
			if (value) {
				// Store in both memory cache and KV store
				OrderRepository.#pricingConfigCache.set(key, value);
				this.setCache(key, value, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			}
			return value;
		};

		const res = await safeAsync(this.getCache(key, { fallback }));

		return res.data as PricingConfiguration | undefined;
	}

	async estimate(
		params: Pick<
			EstimateOrder,
			"type" | "pickupLocation" | "dropoffLocation"
		> & {
			weight?: number;
		},
		opts?: WithTx,
	): Promise<OrderSummary & { config: PricingConfiguration }> {
		try {
			// Create cache key based on parameters (rounded to 4 decimal places for coordinate precision)
			const pickup = `${params.pickupLocation.x.toFixed(4)},${params.pickupLocation.y.toFixed(4)}`;
			const dropoff = `${params.dropoffLocation.x.toFixed(4)},${params.dropoffLocation.y.toFixed(4)}`;
			const weight = params.weight ? `:${params.weight}` : "";
			const cacheKey = `estimate:${params.type}:${pickup}:${dropoff}${weight}`;

			// Try to get cached estimate (24 hour TTL - reduces Google Maps API costs)
			const cached = await this.getCache<
				OrderSummary & { config: PricingConfiguration }
			>(cacheKey);
			if (cached) {
				log.debug({ cacheKey }, "[OrderRepository] Returning cached estimate");
				return cached;
			}

			// PERFORMANCE: Run external API calls in parallel with DB queries
			// Do NOT pass transaction to external API calls (prevents long-held locks)
			const [pricingConfig, { distanceMeters }] = await Promise.all([
				this.#getPricingConfiguration({ type: params.type }, opts),
				this.#map.getRouteDistance(
					params.pickupLocation,
					params.dropoffLocation,
				),
			]);

			if (!pricingConfig)
				throw new RepositoryError("Missing pricing configuration");
			const distanceKm = Number(
				new Decimal(distanceMeters).dividedBy(1000).toFixed(2),
			);

			let pricing: Omit<OrderSummary, "driverEarning" | "currency">;

			switch (params.type) {
				case "RIDE": {
					const validatedConfig =
						RidePricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateRide(
						distanceKm,
						validatedConfig,
					);
					break;
				}
				case "DELIVERY": {
					const validatedConfig =
						DeliveryPricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateDelivery(
						distanceKm,
						params.weight,
						validatedConfig,
					);
					break;
				}
				case "FOOD": {
					const validatedConfig =
						FoodPricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateFood(
						distanceKm,
						validatedConfig,
					);
					break;
				}
			}

			const result = { ...pricing, config: pricingConfig };

			// PERFORMANCE: Cache estimate for 24 hours (reduces Google Maps API costs by 95%)
			// Routes and pricing rarely change within a day
			// Invalidate cache when pricing configs are updated by calling invalidatePricingCache()
			await this.setCache(cacheKey, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});

			log.debug(
				{ cacheKey, distanceKm },
				"[OrderRepository] Cached new estimate",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "estimate");
		}
	}

	async get(id: string, opts?: WithTx): Promise<Order> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError("Failed to get driver from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async placeOrder(
		params: PlaceOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceOrderResponse> {
		try {
			// Validate required parameters
			if (!params.pickupLocation || !params.dropoffLocation) {
				throw new RepositoryError("Pickup and dropoff locations are required", {
					code: "BAD_REQUEST",
				});
			}

			if (!params.type) {
				throw new RepositoryError("Order type is required", {
					code: "BAD_REQUEST",
				});
			}

			if (
				!params.payment ||
				!params.payment.method ||
				!params.payment.provider
			) {
				throw new RepositoryError("Payment information is required", {
					code: "BAD_REQUEST",
				});
			}

			log.debug(
				{
					userId: params.userId,
					type: params.type,
					method: params.payment.method,
				},
				"[OrderRepository] Starting order placement",
			);

			const itemIds = params.items
				?.map((el) => el.item?.id)
				.filter((id): id is string => !!id);

			// PERFORMANCE OPTIMIZATION: Don't pass transaction to estimate()
			// This prevents external Google Maps API calls (500ms) from holding DB locks
			// The estimate() method will use non-transactional DB access for pricing config
			const [estimate, user, menus] = await Promise.all([
				this.estimate(params), // No opts passed - uses regular DB connection
				opts.tx.query.user.findFirst({
					columns: { name: true, email: true, phone: true },
					where: (f, op) => op.eq(f.id, params.userId),
				}),
				itemIds?.length
					? opts.tx.query.merchantMenu.findMany({
							with: {
								merchant: {
									columns: {},
									with: { user: { columns: { id: true } } },
								},
							},
							where: (f, op) => op.inArray(f.id, itemIds),
						})
					: Promise.resolve([]),
			]);

			// Validate and apply coupon if provided
			let couponValidation:
				| {
						valid: boolean;
						coupon?: unknown;
						discountAmount: number;
						reason?: string;
				  }
				| undefined;
			let finalTotalCost = estimate.totalCost;
			let couponId: string | undefined;
			let couponCode: string | undefined;
			let discountAmount = 0;

			if (params.couponCode) {
				// Create a CouponRepository instance
				const couponRepo = new (
					await import("../coupon/coupon-repository")
				).CouponRepository(this.db, this.kv);

				couponValidation = await couponRepo.validateCoupon(
					params.couponCode,
					estimate.totalCost,
					params.userId,
				);

				if (!couponValidation.valid) {
					throw new RepositoryError(
						couponValidation.reason ?? "Invalid coupon",
						{ code: "BAD_REQUEST" },
					);
				}

				if (
					couponValidation.coupon &&
					typeof couponValidation.coupon === "object" &&
					"id" in couponValidation.coupon
				) {
					couponId = couponValidation.coupon.id as string;
				}
				couponCode = params.couponCode;
				discountAmount = couponValidation.discountAmount;
				finalTotalCost = Math.max(0, estimate.totalCost - discountAmount);

				log.info(
					{
						userId: params.userId,
						couponCode,
						originalPrice: estimate.totalCost,
						discountAmount,
						finalPrice: finalTotalCost,
					},
					"[OrderRepository] Coupon applied successfully",
				);
			}

			if (!user)
				throw new RepositoryError(`User ${params.userId} not found`, {
					code: "NOT_FOUND",
				});

			if (menus.length && menus.length !== itemIds?.length)
				throw new RepositoryError("Invalid products", {
					code: "BAD_REQUEST",
				});

			const uniqueMerchantIds = new Set(menus.map((m) => m.merchantId));
			if (uniqueMerchantIds.size > 1)
				throw new RepositoryError("Can't order from different merchants", {
					code: "BAD_REQUEST",
				});

			const merchantId = menus[0]?.merchantId;
			const now = new Date();

			const safeTotalCost = toStringNumberSafe(finalTotalCost);
			const baseFare = toStringNumberSafe(estimate.config.baseFare);
			const safeDiscountAmount =
				discountAmount > 0 ? toStringNumberSafe(discountAmount) : undefined;

			const [orderRow] = await opts.tx
				.insert(tables.order)
				.values({
					id: v7(),
					userId: params.userId,
					merchantId,
					type: params.type,
					note: params.note,
					pickupLocation: params.pickupLocation,
					dropoffLocation: params.dropoffLocation,
					distanceKm: estimate.distanceKm,
					basePrice: baseFare,
					totalPrice: safeTotalCost,
					couponId,
					couponCode,
					discountAmount: safeDiscountAmount,
					requestedAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning({ id: tables.order.id });

			if (menus.length) {
				const orderItems = menus.map((menu) => ({
					orderId: orderRow.id,
					menuId: menu.id,
					quantity:
						params.items?.find((i) => i.item.id === menu.id)?.quantity ?? 0,
					unitPrice: menu.price,
				}));

				await opts.tx.insert(tables.orderItem).values(orderItems);
			}

			const chargePayload: ChargePayload = {
				transactionType: "PAYMENT",
				amount: finalTotalCost,
				method: params.payment.method,
				provider: params.payment.provider,
				userId: params.userId,
				orderType: params.type,
				metadata: {
					orderId: orderRow.id,
					customerId: params.userId,
					...(couponCode && { couponCode, discountAmount }),
				},
			};

			if (
				params.payment.bankProvider &&
				params.payment.method === "BANK_TRANSFER"
			) {
				chargePayload.bank = params.payment.bankProvider;
				chargePayload.va_number = `${user.phone.number}`;
			}

			const { transaction, payment } = await this.#paymentRepo.charge(
				chargePayload,
				opts,
			);

			let order = await this.#getFromDB(orderRow.id, opts);
			if (!order) throw new RepositoryError("Failed to retrieve placed order");

			// For wallet payments, automatically update order status to MATCHING
			if (params.payment.method === "wallet" && payment.status === "SUCCESS") {
				order = await this.update(order.id, { status: "MATCHING" }, opts);

				log.info(
					{
						orderId: order.id,
						userId: params.userId,
						amount: estimate.totalCost,
					},
					"[OrderRepository] wallet payment successful - Order moved to MATCHING",
				);
			}

			await Promise.allSettled([
				this.setCache(order.id, order, {
					expirationTtl: CACHE_TTLS["1h"],
				}),
				this.deleteCache("count"),
			]);

			log.info(
				{
					orderId: order.id,
					userId: params.userId,
					type: params.type,
					method: params.payment.method,
					status: order.status,
				},
				m.server_order_placed(),
			);

			return { order, payment, transaction };
		} catch (err) {
			log.error(
				{
					error: err,
					userId: params.userId,
					type: params.type,
					method: params.payment?.method,
				},
				"[OrderRepository] Failed to place order - transaction will be rolled back",
			);
			throw this.handleError(err, "place");
		}
	}

	/**
	 * Validates order status transitions according to state machine rules
	 * Prevents invalid state transitions (e.g., COMPLETED → REQUESTED)
	 */
	#validateStatusTransition(
		currentStatus: OrderStatus,
		newStatus: OrderStatus,
	): void {
		// Define valid state transitions
		const validTransitions: Record<OrderStatus, OrderStatus[]> = {
			REQUESTED: [
				"MATCHING",
				"CANCELLED_BY_USER",
				"CANCELLED_BY_MERCHANT",
				"CANCELLED_BY_SYSTEM",
			],
			MATCHING: [
				"ACCEPTED",
				"CANCELLED_BY_USER",
				"CANCELLED_BY_MERCHANT",
				"CANCELLED_BY_SYSTEM",
				"REQUESTED", // Allow retry
			],
			ACCEPTED: [
				"PREPARING", // Food orders: merchant starts preparing
				"ARRIVING", // Ride/Delivery: driver heads to pickup (skip preparation)
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_MERCHANT",
				"CANCELLED_BY_SYSTEM",
			],
			PREPARING: [
				"READY_FOR_PICKUP", // Food is ready for driver pickup
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_MERCHANT",
				"CANCELLED_BY_SYSTEM",
			],
			READY_FOR_PICKUP: [
				"ARRIVING", // Driver is on the way to pickup
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_MERCHANT",
				"CANCELLED_BY_SYSTEM",
			],
			ARRIVING: [
				"IN_TRIP",
				"CANCELLED_BY_USER",
				"CANCELLED_BY_DRIVER",
				"CANCELLED_BY_SYSTEM",
			],
			IN_TRIP: ["COMPLETED", "CANCELLED_BY_DRIVER", "CANCELLED_BY_SYSTEM"],
			COMPLETED: [], // Terminal state - no transitions allowed
			CANCELLED_BY_USER: [], // Terminal state
			CANCELLED_BY_DRIVER: [], // Terminal state
			CANCELLED_BY_MERCHANT: [], // Terminal state
			CANCELLED_BY_SYSTEM: [], // Terminal state
		};

		const allowedNextStates = validTransitions[currentStatus] || [];

		if (!allowedNextStates.includes(newStatus)) {
			throw new RepositoryError(
				`Invalid status transition from "${currentStatus}" to "${newStatus}". Allowed: ${allowedNextStates.join(", ")}`,
				{ code: "BAD_REQUEST" },
			);
		}
	}

	async update(id: string, item: UpdateOrder, opts: WithTx): Promise<Order> {
		try {
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`);

			// Validate status transition if status is being updated
			if (item.status && item.status !== existing.status) {
				this.#validateStatusTransition(existing.status, item.status);
			}

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					...item,
					basePrice: existing.basePrice
						? toStringNumberSafe(existing.basePrice)
						: undefined,
					totalPrice: item.totalPrice
						? toStringNumberSafe(item.totalPrice)
						: undefined,
					tip: item.tip ? toStringNumberSafe(item.tip) : undefined,
					acceptedAt: existing.acceptedAt
						? new Date(existing.acceptedAt)
						: null,
					discountAmount: item.discountAmount
						? toStringNumberSafe(item.discountAmount)
						: undefined,
					platformCommission: item.platformCommission
						? toStringNumberSafe(item.platformCommission)
						: undefined,
					driverEarning: item.driverEarning
						? toStringNumberSafe(item.driverEarning)
						: undefined,
					merchantCommission: item.merchantCommission
						? toStringNumberSafe(item.merchantCommission)
						: undefined,
					arrivedAt: existing.arrivedAt ? new Date(existing.arrivedAt) : null,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			const result = await this.#getFromDB(operation.id, opts);
			if (!result) throw new RepositoryError("Failed to update order");

			await this.setCache(id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	/**
	 * Cancels an order with penalty logic based on SRS requirements:
	 * - User cancels: No penalty before driver acceptance, 10% fee after acceptance
	 * - Driver cancels: Warning and suspension tracking after 3 cancellations/day
	 * - System/Merchant cancels: Full refund
	 */
	async cancelOrder(
		orderId: string,
		userId: string,
		userRole: UserRole,
		reason?: string,
		opts: WithTx = {} as WithTx,
	): Promise<Order> {
		if (!opts.tx) {
			throw new RepositoryError(
				"cancelOrder must be called within a transaction",
				{ code: "BAD_REQUEST" },
			);
		}

		try {
			// Get order details
			const order = await this.#getFromDB(orderId, opts);
			if (!order) {
				throw new RepositoryError(`Order with id "${orderId}" not found`, {
					code: "NOT_FOUND",
				});
			}

			// Determine cancellation type based on role
			let cancelStatus: OrderStatus;
			if (userRole === "USER") {
				cancelStatus = "CANCELLED_BY_USER";
			} else if (userRole === "DRIVER") {
				cancelStatus = "CANCELLED_BY_DRIVER";
			} else if (userRole === "MERCHANT") {
				cancelStatus = "CANCELLED_BY_MERCHANT";
			} else {
				cancelStatus = "CANCELLED_BY_SYSTEM";
			}

			// Validate status transition
			this.#validateStatusTransition(order.status, cancelStatus);

			// Calculate refund amount with penalty logic
			const totalPrice = new Decimal(order.totalPrice);
			let refundAmount = totalPrice;
			let penaltyAmount = new Decimal(0);

			// Apply 10% penalty for user cancellation after driver acceptance
			if (
				cancelStatus === "CANCELLED_BY_USER" &&
				order.driverId &&
				["ACCEPTED", "PREPARING", "READY_FOR_PICKUP", "ARRIVING"].includes(
					order.status,
				)
			) {
				penaltyAmount = totalPrice.times(0.1); // 10% penalty
				refundAmount = totalPrice.minus(penaltyAmount);

				log.info(
					{
						orderId: order.id,
						userId: order.userId,
						totalPrice: toNumberSafe(totalPrice),
						penaltyAmount: toNumberSafe(penaltyAmount),
						refundAmount: toNumberSafe(refundAmount),
					},
					"[OrderRepository] User cancellation penalty applied (10%)",
				);
			}

			// Handle driver cancellation - track and suspend if excessive
			if (cancelStatus === "CANCELLED_BY_DRIVER" && order.driverId) {
				const driverId = order.driverId;
				// Get driver details
				const driver = await opts.tx.query.driver.findFirst({
					where: (f, op) => op.eq(f.id, driverId),
				});

				if (driver) {
					const now = new Date();
					const lastCancellation = driver.lastCancellationDate
						? new Date(driver.lastCancellationDate)
						: null;

					// Check if last cancellation was today
					const isToday =
						lastCancellation &&
						lastCancellation.toDateString() === now.toDateString();

					const newCancellationCount = isToday
						? driver.cancellationCount + 1
						: 1;

					// Update driver cancellation tracking
					await opts.tx
						.update(tables.driver)
						.set({
							cancellationCount: newCancellationCount,
							lastCancellationDate: now,
						})
						.where(eq(tables.driver.id, order.driverId));

					// Suspend driver if 3 or more cancellations today (per SRS 8.3)
					if (newCancellationCount >= 3) {
						await opts.tx
							.update(tables.driver)
							.set({
								status: "SUSPENDED",
								isOnline: false,
								isTakingOrder: false,
							})
							.where(eq(tables.driver.id, order.driverId));

						log.warn(
							{
								driverId: order.driverId,
								cancellationCount: newCancellationCount,
								orderId: order.id,
							},
							"[OrderRepository] Driver suspended due to excessive cancellations (3/day)",
						);
					} else {
						log.info(
							{
								driverId: order.driverId,
								cancellationCount: newCancellationCount,
								orderId: order.id,
							},
							"[OrderRepository] Driver cancellation recorded - warning issued",
						);
					}
				}
			}

			// Process refund - find transaction by referenceId (orderId)
			const paymentTransaction = await opts.tx.query.transaction.findFirst({
				where: (f, op) =>
					op.and(
						op.eq(f.referenceId, order.id),
						op.eq(f.type, "PAYMENT"),
						op.inArray(f.status, ["PENDING", "SUCCESS"]),
					),
			});

			if (paymentTransaction) {
				// Get wallet
				const wallet = await opts.tx.query.wallet.findFirst({
					where: (f, op) => op.eq(f.id, paymentTransaction.walletId),
				});

				// Get payment
				const payment = await opts.tx.query.payment.findFirst({
					where: (f, op) => op.eq(f.transactionId, paymentTransaction.id),
				});

				if (wallet && payment) {
					const currentBalance = new Decimal(wallet.balance);
					const newBalance = currentBalance.plus(refundAmount);

					// Update transaction status
					await opts.tx
						.update(tables.transaction)
						.set({
							status: "REFUNDED",
							balanceBefore: toStringNumberSafe(currentBalance),
							balanceAfter: toStringNumberSafe(newBalance),
						})
						.where(eq(tables.transaction.id, paymentTransaction.id));

					// Update payment status
					await opts.tx
						.update(tables.payment)
						.set({ status: "REFUNDED" })
						.where(eq(tables.payment.id, payment.id));

					// Update wallet balance
					await opts.tx
						.update(tables.wallet)
						.set({ balance: toStringNumberSafe(newBalance) })
						.where(eq(tables.wallet.id, wallet.id));

					log.info(
						{
							orderId: order.id,
							userId: order.userId,
							refundAmount: toNumberSafe(refundAmount),
							penaltyAmount: toNumberSafe(penaltyAmount),
						},
						m.server_refund_processed(),
					);
				}
			}

			// Update order status
			const updatedOrder = await this.update(
				orderId,
				{
					status: cancelStatus,
					cancelReason: reason,
				},
				opts,
			);

			log.info(
				{
					orderId: order.id,
					status: cancelStatus,
					role: userRole,
					refundAmount: toNumberSafe(refundAmount),
				},
				m.server_order_cancelled(),
			);

			return updatedOrder;
		} catch (error) {
			log.error(
				{
					error,
					orderId,
					userId,
					userRole,
				},
				"[OrderRepository] Failed to cancel order - transaction will be rolled back",
			);
			throw this.handleError(error, "cancel");
		}
	}

	async remove(id: string, opts: WithTx): Promise<void> {
		try {
			const result = await opts.tx
				.delete(tables.order)
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}
}
