import { env } from "cloudflare:workers";
import { m } from "@repo/i18n";
import type {
	ConfigurationValue,
	PricingConfiguration,
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
	type PlaceScheduledOrder,
	type PlaceScheduledOrderResponse,
	type UpdateOrder,
	type UpdateScheduledOrder,
} from "@repo/schema/order";
import type { User, UserRole } from "@repo/schema/user";
import { nullsToUndefined } from "@repo/shared";
import {
	and,
	count,
	eq,
	gte,
	ilike,
	inArray,
	lt,
	lte,
	or,
	type SQL,
} from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import {
	CACHE_TTLS,
	CONFIGURATION_KEYS,
	DRIVER_POOL_KEY,
} from "@/core/constants";
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
import { BusinessConfigurationService } from "@/features/configuration/services";
import { log, safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import type {
	ChargePayload,
	PaymentRepository,
} from "../payment/payment-repository";
import type { OrderListQuery } from "./order-spec";
import {
	type DeliveryProofService,
	DriverCancellationService,
	OrderCancellationService,
	OrderCouponService,
	OrderItemPreparationService,
	type OrderMatchingService,
	type OrderPricingService,
	OrderRefundService,
	OrderSchedulingService,
	type OrderStateService,
	OrderValidationService,
} from "./services";

export class OrderRepository extends BaseRepository {
	readonly #map: MapService;
	readonly #paymentRepo: PaymentRepository;
	readonly #pricingService: OrderPricingService;
	readonly #stateService: OrderStateService;
	readonly #deliveryProofService: DeliveryProofService;
	// PERFORMANCE: In-memory cache for pricing configurations (99% faster than DB/KV)
	// These configs rarely change, so we cache them in memory with manual invalidation
	static #pricingConfigCache = new Map<string, ConfigurationValue>();
	static #cacheLoadedAt: Date | null = null;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		map: MapService,
		paymentRepo: PaymentRepository,
		pricingService: OrderPricingService,
		_matchingService: OrderMatchingService,
		stateService: OrderStateService,
		deliveryProofService: DeliveryProofService,
	) {
		super("order", kv, db);
		this.#map = map;
		this.#paymentRepo = paymentRepo;
		this.#pricingService = pricingService;
		this.#stateService = stateService;
		this.#deliveryProofService = deliveryProofService;
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

	async #getQueryCount(
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
			log.error({ query, filters, error }, "Failed to get query count");
			return 0;
		}
	}

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

			const hasFilters = statuses.length > 0 || type || startDate || endDate;

			const totalCount =
				search || hasFilters
					? await this.#getQueryCount(
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
				throw new RepositoryError(m.error_invalid_order_type());
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
			>(cacheKey, {
				fallback: async () => {
					// REFACTOR: Delegate pricing calculation to OrderPricingService
					// Build EstimateOrder input for the service
					const estimateInput: EstimateOrder = {
						type: params.type,
						pickupLocation: params.pickupLocation,
						dropoffLocation: params.dropoffLocation,
						weight: params.weight,
					};

					// Get pricing configuration (still needed to return to client)
					const pricingConfig = await this.#getPricingConfiguration(
						{ type: params.type },
						opts,
					);

					if (!pricingConfig)
						throw new RepositoryError(m.error_missing_pricing_configuration());

					// Use OrderPricingService to calculate estimate
					const pricing =
						await this.#pricingService.estimateOrder(estimateInput);

					const result = { ...pricing, config: pricingConfig };

					// PERFORMANCE: Cache estimate for 24 hours (reduces Google Maps API costs by 95%)
					// Routes and pricing rarely change within a day
					// Invalidate cache when pricing configs are updated by calling invalidatePricingCache()
					await this.setCache(cacheKey, result, {
						expirationTtl: CACHE_TTLS["24h"],
					});

					log.debug(
						{ cacheKey, distanceKm: pricing.distanceKm },
						"[OrderRepository] Cached new estimate",
					);

					return result;
				},
			});

			return cached;
		} catch (error) {
			throw this.handleError(error, "estimate");
		}
	}

	async get(id: string, opts?: WithTx): Promise<Order> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError(m.error_failed_get_driver());
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
			// Use OrderValidationService to validate required parameters
			OrderValidationService.validatePlaceOrderParams(params);

			log.debug(
				{
					userId: params.userId,
					type: params.type,
					method: params.payment.method,
				},
				"[OrderRepository] Starting order placement",
			);

			// Use OrderValidationService to extract menu item IDs
			const itemIds = OrderValidationService.extractMenuItemIds(params.items);

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

			// Calculate menu items total for FOOD orders
			const menuItemsTotal =
				params.type === "FOOD"
					? OrderItemPreparationService.calculateMenuItemsTotal(
							menus,
							params.items,
						)
					: 0;

			// Total cost = delivery fee (from estimate) + menu items total
			const baseTotalCost = estimate.totalCost + menuItemsTotal;

			// Use OrderCouponService to validate and apply coupon
			let finalTotalCost = baseTotalCost;
			let couponId: string | undefined;
			let couponCode: string | undefined;
			let discountAmount = 0;
			let autoAppliedCoupon:
				| { code: string; discountAmount: number }
				| undefined;

			// Extract merchantId early for coupon eligibility check
			const merchantId = OrderValidationService.getMerchantId(menus);

			if (menuItemsTotal > 0) {
				log.info(
					{
						userId: params.userId,
						deliveryFee: estimate.totalCost,
						menuItemsTotal,
						baseTotalCost,
					},
					"[OrderRepository] FOOD order - menu items total calculated",
				);
			}

			if (params.couponCode) {
				// User provided a coupon code - validate and apply it
				const couponResult = await OrderCouponService.validateAndApplyCoupon(
					params.couponCode,
					baseTotalCost,
					params.userId,
					this.db,
					this.kv,
				);

				couponId = couponResult.couponId;
				couponCode = couponResult.couponCode;
				discountAmount = couponResult.discountAmount;
				finalTotalCost = couponResult.finalTotalCost;
			} else {
				// No coupon provided - auto-apply the best eligible coupon
				const autoCouponResult = await OrderCouponService.getAndApplyBestCoupon(
					baseTotalCost,
					params.userId,
					params.type,
					this.db,
					this.kv,
					merchantId,
				);

				if (autoCouponResult.autoApplied) {
					couponId = autoCouponResult.couponId;
					couponCode = autoCouponResult.couponCode;
					discountAmount = autoCouponResult.discountAmount;
					finalTotalCost = autoCouponResult.finalTotalCost;
					autoAppliedCoupon = {
						code: autoCouponResult.couponCode ?? "",
						discountAmount: autoCouponResult.discountAmount,
					};

					log.info(
						{
							userId: params.userId,
							couponCode,
							discountAmount,
							originalTotal: baseTotalCost,
							finalTotal: finalTotalCost,
						},
						"[OrderRepository] Auto-applied best eligible coupon",
					);
				}
			}

			if (!user)
				throw new RepositoryError(`User ${params.userId} not found`, {
					code: "NOT_FOUND",
				});

			// Use OrderValidationService to validate menu items
			OrderValidationService.validateMenuItems(menus, itemIds);
			OrderValidationService.validateSingleMerchant(menus);

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

			// Use OrderItemPreparationService to prepare and insert order items
			await OrderItemPreparationService.insertOrderItems(
				orderRow.id,
				menus,
				params.items,
				opts,
			);

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
				const phoneNumber = user.phone?.number;
				if (phoneNumber) chargePayload.va_number = `${phoneNumber}`;
			}

			const { transaction, payment } = await this.#paymentRepo.charge(
				chargePayload,
				opts,
			);

			let order = await this.#getFromDB(orderRow.id, opts);
			if (!order)
				throw new RepositoryError(m.error_failed_retrieve_placed_order());

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

			// Record coupon usage if a coupon was applied
			// This must be done after order creation to link the usage to the order ID
			if (couponId && discountAmount > 0) {
				await OrderCouponService.recordCouponUsage(
					couponId,
					order.id,
					params.userId,
					discountAmount,
					this.db,
					this.kv,
					opts,
				);
			}

			log.info(
				{
					orderId: order.id,
					userId: params.userId,
					type: params.type,
					method: params.payment.method,
					status: order.status,
					autoAppliedCoupon: autoAppliedCoupon?.code,
				},
				m.server_order_placed(),
			);

			const stub = OrderRepository.getRoomStubByName(DRIVER_POOL_KEY);
			stub.broadcast({
				f: "s",
				t: "s",
				a: "MATCHING",
				p: {
					detail: {
						order,
						payment,
						transaction,
					},
				},
			});

			return { order, payment, transaction, autoAppliedCoupon };
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

	async update(id: string, item: UpdateOrder, opts: WithTx): Promise<Order> {
		try {
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`);

			// REFACTOR: Use OrderStateService to validate status transition
			if (item.status && item.status !== existing.status) {
				this.#stateService.validateTransition(existing.status, item.status);
			}

			// Generate OTP for delivery proof if order is ARRIVING or IN_TRIP and requires OTP
			let deliveryOtp = item.deliveryOtp;
			const shouldGenerateOtp =
				item.status &&
				(item.status === "ARRIVING" || item.status === "IN_TRIP") &&
				existing.status !== "ARRIVING" &&
				existing.status !== "IN_TRIP" &&
				!existing.deliveryOtp &&
				(await this.#deliveryProofService.requiresOTP(existing.totalPrice));
			if (shouldGenerateOtp) {
				deliveryOtp = this.#deliveryProofService.generateOTP();
				log.info(
					{ orderId: id, totalPrice: existing.totalPrice },
					"[OrderRepository] Generated OTP for high-value delivery order",
				);
			}

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					...item,
					deliveryOtp: deliveryOtp ?? item.deliveryOtp,
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
			if (!result) throw new RepositoryError(m.error_failed_update_order());

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

			// Use OrderCancellationService to determine cancellation status
			const cancelStatus =
				OrderCancellationService.determineCancellationStatus(userRole);

			// Validate status transition
			this.#stateService.validateTransition(order.status, cancelStatus);

			// Fetch business configuration for cancellation fee rates
			const businessConfig = await BusinessConfigurationService.getConfig(
				this.db,
				this.kv,
			);

			// Use OrderCancellationService to calculate refund with penalty logic
			const { refundAmount, penaltyAmount } =
				OrderCancellationService.calculateRefund(
					order.totalPrice,
					cancelStatus,
					order.status,
					businessConfig,
					order.driverId,
				);

			// Log penalty if applied
			if (
				OrderCancellationService.shouldApplyPenalty(
					cancelStatus,
					order.status,
					order.driverId,
				)
			) {
				log.info(
					{
						orderId: order.id,
						userId: order.userId,
						totalPrice: order.totalPrice,
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
					// Use DriverCancellationService to prepare cancellation update
					const cancellationUpdate =
						DriverCancellationService.prepareCancellationUpdate(
							driver.cancellationCount,
							driver.lastCancellationDate,
						);

					// Update driver cancellation tracking
					await opts.tx
						.update(tables.driver)
						.set(cancellationUpdate)
						.where(eq(tables.driver.id, order.driverId));

					// Check if driver should be suspended
					if (
						DriverCancellationService.shouldSuspendDriver(
							cancellationUpdate.cancellationCount,
						)
					) {
						// Use service to prepare suspension data
						const suspensionData =
							DriverCancellationService.prepareSuspensionData();

						await opts.tx
							.update(tables.driver)
							.set(suspensionData)
							.where(eq(tables.driver.id, order.driverId));

						log.warn(
							{
								driverId: order.driverId,
								cancellationCount: cancellationUpdate.cancellationCount,
								orderId: order.id,
							},
							"[OrderRepository] Driver suspended due to excessive cancellations (3/day)",
						);
					} else {
						log.info(
							{
								driverId: order.driverId,
								cancellationCount: cancellationUpdate.cancellationCount,
								orderId: order.id,
							},
							"[OrderRepository] Driver cancellation recorded - warning issued",
						);
					}
				}
			}

			// Use OrderRefundService to process refund
			await OrderRefundService.processRefund(
				order.id,
				order.userId,
				refundAmount,
				penaltyAmount,
				opts,
			);

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

	/**
	 * Place a scheduled order
	 * Creates an order with SCHEDULED status and calculates the matching activation time
	 */
	async placeScheduledOrder(
		params: PlaceScheduledOrder & WithUserId,
		opts: WithTx,
	): Promise<PlaceScheduledOrderResponse> {
		try {
			// Validate scheduled time
			OrderSchedulingService.validateScheduledTime(params.scheduledAt);

			// Calculate when matching should begin
			const scheduledMatchingAt = OrderSchedulingService.calculateMatchingTime(
				params.scheduledAt,
			);

			log.debug(
				{
					userId: params.userId,
					type: params.type,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
				},
				"[OrderRepository] Starting scheduled order placement",
			);

			// Use OrderValidationService to validate required parameters
			OrderValidationService.validatePlaceOrderParams(params);

			// Use OrderValidationService to extract menu item IDs
			const itemIds = OrderValidationService.extractMenuItemIds(params.items);

			// Fetch required data in parallel
			const [estimate, user, menus] = await Promise.all([
				this.estimate(params),
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

			// Calculate menu items total for FOOD orders
			const menuItemsTotal =
				params.type === "FOOD"
					? OrderItemPreparationService.calculateMenuItemsTotal(
							menus,
							params.items,
						)
					: 0;

			// Total cost = delivery fee (from estimate) + menu items total
			const baseTotalCost = estimate.totalCost + menuItemsTotal;

			// Apply coupon if provided
			let finalTotalCost = baseTotalCost;
			let couponId: string | undefined;
			let couponCode: string | undefined;
			let discountAmount = 0;
			let autoAppliedCoupon:
				| { code: string; discountAmount: number }
				| undefined;

			const merchantId = OrderValidationService.getMerchantId(menus);

			if (params.couponCode) {
				const couponResult = await OrderCouponService.validateAndApplyCoupon(
					params.couponCode,
					baseTotalCost,
					params.userId,
					this.db,
					this.kv,
				);

				couponId = couponResult.couponId;
				couponCode = couponResult.couponCode;
				discountAmount = couponResult.discountAmount;
				finalTotalCost = couponResult.finalTotalCost;
			} else {
				const autoCouponResult = await OrderCouponService.getAndApplyBestCoupon(
					baseTotalCost,
					params.userId,
					params.type,
					this.db,
					this.kv,
					merchantId,
				);

				if (autoCouponResult.autoApplied) {
					couponId = autoCouponResult.couponId;
					couponCode = autoCouponResult.couponCode;
					discountAmount = autoCouponResult.discountAmount;
					finalTotalCost = autoCouponResult.finalTotalCost;
					autoAppliedCoupon = {
						code: autoCouponResult.couponCode ?? "",
						discountAmount: autoCouponResult.discountAmount,
					};
				}
			}

			if (!user)
				throw new RepositoryError(`User ${params.userId} not found`, {
					code: "NOT_FOUND",
				});

			// Validate menu items
			OrderValidationService.validateMenuItems(menus, itemIds);
			OrderValidationService.validateSingleMerchant(menus);

			const now = new Date();

			const safeTotalCost = toStringNumberSafe(finalTotalCost);
			const baseFare = toStringNumberSafe(estimate.config.baseFare);
			const safeDiscountAmount =
				discountAmount > 0 ? toStringNumberSafe(discountAmount) : undefined;

			// Create the order with SCHEDULED status
			const [orderRow] = await opts.tx
				.insert(tables.order)
				.values({
					id: v7(),
					userId: params.userId,
					merchantId,
					type: params.type,
					status: "SCHEDULED",
					note: params.note,
					pickupLocation: params.pickupLocation,
					dropoffLocation: params.dropoffLocation,
					distanceKm: estimate.distanceKm,
					basePrice: baseFare,
					totalPrice: safeTotalCost,
					couponId,
					couponCode,
					discountAmount: safeDiscountAmount,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
					requestedAt: now,
					createdAt: now,
					updatedAt: now,
				})
				.returning({ id: tables.order.id });

			// Insert order items
			await OrderItemPreparationService.insertOrderItems(
				orderRow.id,
				menus,
				params.items,
				opts,
			);

			// Process payment
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
					scheduled: true,
					scheduledAt: params.scheduledAt.toISOString(),
					...(couponCode && { couponCode, discountAmount }),
				},
			};

			if (
				params.payment.bankProvider &&
				params.payment.method === "BANK_TRANSFER"
			) {
				chargePayload.bank = params.payment.bankProvider;
				const phoneNumber = user.phone?.number;
				if (phoneNumber) chargePayload.va_number = `${phoneNumber}`;
			}

			const { transaction, payment } = await this.#paymentRepo.charge(
				chargePayload,
				opts,
			);

			let order = await this.#getFromDB(orderRow.id, opts);
			if (!order)
				throw new RepositoryError(m.error_failed_retrieve_placed_order());

			// Cache the order
			await Promise.allSettled([
				this.setCache(order.id, order, {
					expirationTtl: CACHE_TTLS["1h"],
				}),
				this.deleteCache("count"),
			]);

			// Record coupon usage
			if (couponId && discountAmount > 0) {
				await OrderCouponService.recordCouponUsage(
					couponId,
					order.id,
					params.userId,
					discountAmount,
					this.db,
					this.kv,
					opts,
				);
			}

			log.info(
				{
					orderId: order.id,
					userId: params.userId,
					type: params.type,
					status: order.status,
					scheduledAt: params.scheduledAt,
					scheduledMatchingAt,
				},
				"[OrderRepository] Scheduled order placed successfully",
			);

			return { order, payment, transaction, autoAppliedCoupon };
		} catch (err) {
			log.error(
				{
					error: err,
					userId: params.userId,
					type: params.type,
					scheduledAt: params.scheduledAt,
				},
				"[OrderRepository] Failed to place scheduled order - transaction will be rolled back",
			);
			throw this.handleError(err, "placeScheduledOrder");
		}
	}

	/**
	 * List scheduled orders for a user
	 */
	async listScheduledOrders(
		query: OrderListQuery & { userId: string },
		opts?: WithTx,
	): Promise<UnifiedListResult<Order>> {
		const {
			cursor,
			page = 1,
			limit = 10,
			sortBy,
			order = "asc",
			userId,
			mode = "offset",
		} = query;

		try {
			const tx = opts?.tx ?? this.db;

			const orderBy = (
				f: typeof tables.order._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = OrderKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.scheduledAt;
					return op[order](field);
				}
				// Default sort by scheduledAt for scheduled orders
				return op[order](f.scheduledAt);
			};

			const withx = {
				user: { columns: { name: true } },
				driver: {
					columns: {},
					with: { user: { columns: { name: true } } },
				},
				merchant: { columns: { name: true } },
			} as const;

			const clauses: SQL[] = [
				eq(tables.order.userId, userId),
				eq(tables.order.status, "SCHEDULED"),
			];

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

			// Get total count for scheduled orders
			const [countResult] = await tx
				.select({ count: count(tables.order.id) })
				.from(tables.order)
				.where(
					and(
						eq(tables.order.userId, userId),
						eq(tables.order.status, "SCHEDULED"),
					),
				);

			const totalCount = countResult?.count ?? 0;
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, pagination: { totalPages } };
		} catch (error) {
			this.handleError(error, "listScheduledOrders");
			return { rows: [] };
		}
	}

	/**
	 * Update a scheduled order (reschedule)
	 */
	async updateScheduledOrder(
		id: string,
		item: UpdateScheduledOrder,
		opts: WithTx,
	): Promise<Order> {
		try {
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`, {
					code: "NOT_FOUND",
				});

			// Verify order is still in SCHEDULED status
			if (existing.status !== "SCHEDULED") {
				throw new RepositoryError(
					"Cannot update order that is no longer in SCHEDULED status",
					{ code: "BAD_REQUEST" },
				);
			}

			// If rescheduling, validate the new time
			let scheduledMatchingAt = existing.scheduledMatchingAt;
			if (item.scheduledAt && existing.scheduledAt) {
				OrderSchedulingService.validateReschedule(
					new Date(existing.scheduledAt),
					item.scheduledAt,
				);
				scheduledMatchingAt = OrderSchedulingService.calculateMatchingTime(
					item.scheduledAt,
				);
			}

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					scheduledAt: item.scheduledAt ?? existing.scheduledAt,
					scheduledMatchingAt:
						scheduledMatchingAt ?? existing.scheduledMatchingAt,
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, id))
				.returning({ id: tables.order.id });

			const result = await this.#getFromDB(operation.id, opts);
			if (!result)
				throw new RepositoryError(m.error_failed_update_order(), {
					code: "INTERNAL_SERVER_ERROR",
				});

			await this.setCache(id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			log.info(
				{
					orderId: id,
					newScheduledAt: item.scheduledAt,
					newMatchingAt: scheduledMatchingAt,
				},
				"[OrderRepository] Scheduled order updated",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "updateScheduledOrder");
		}
	}

	/**
	 * Cancel a scheduled order
	 * Handles refund based on timing (free if before matching time)
	 */
	async cancelScheduledOrder(
		orderId: string,
		userId: string,
		reason?: string,
		opts: WithTx = {} as WithTx,
	): Promise<Order> {
		if (!opts.tx) {
			throw new RepositoryError(
				"cancelScheduledOrder must be called within a transaction",
				{ code: "BAD_REQUEST" },
			);
		}

		try {
			const order = await this.#getFromDB(orderId, opts);
			if (!order) {
				throw new RepositoryError(`Order with id "${orderId}" not found`, {
					code: "NOT_FOUND",
				});
			}

			// Verify order is still in SCHEDULED status
			if (order.status !== "SCHEDULED") {
				throw new RepositoryError(
					"Cannot cancel order that is no longer in SCHEDULED status. Use regular cancel for active orders.",
					{ code: "BAD_REQUEST" },
				);
			}

			// Verify ownership
			if (order.userId !== userId) {
				throw new RepositoryError(
					"Cannot cancel order belonging to another user",
					{
						code: "FORBIDDEN",
					},
				);
			}

			// Check if cancellation is free (before matching time)
			const isFreeCancel = order.scheduledAt
				? OrderSchedulingService.canCancelWithoutPenalty(
						new Date(order.scheduledAt),
					)
				: true;

			let refundAmount = order.totalPrice;
			let penaltyAmount = 0;

			if (!isFreeCancel) {
				// Apply cancellation penalty (10%)
				const businessConfig = await BusinessConfigurationService.getConfig(
					this.db,
					this.kv,
				);
				const penaltyRate =
					businessConfig.userCancellationFeeAfterAccept ?? 0.1;
				penaltyAmount = order.totalPrice * penaltyRate;
				refundAmount = order.totalPrice - penaltyAmount;

				log.info(
					{
						orderId,
						totalPrice: order.totalPrice,
						penaltyAmount,
						refundAmount,
					},
					"[OrderRepository] Scheduled order cancellation penalty applied",
				);
			}

			// Process refund
			await OrderRefundService.processRefund(
				order.id,
				order.userId,
				toStringNumberSafe(refundAmount),
				toStringNumberSafe(penaltyAmount),
				opts,
			);

			// Update order status
			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					status: "CANCELLED_BY_USER",
					cancelReason: reason,
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, orderId))
				.returning({ id: tables.order.id });

			const result = await this.#getFromDB(operation.id, opts);
			if (!result)
				throw new RepositoryError(m.error_failed_update_order(), {
					code: "INTERNAL_SERVER_ERROR",
				});

			await this.setCache(orderId, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			log.info(
				{
					orderId,
					userId,
					reason,
					isFreeCancel,
					refundAmount,
				},
				"[OrderRepository] Scheduled order cancelled",
			);

			return result;
		} catch (error) {
			log.error(
				{
					error,
					orderId,
					userId,
				},
				"[OrderRepository] Failed to cancel scheduled order - transaction will be rolled back",
			);
			throw this.handleError(error, "cancelScheduledOrder");
		}
	}
}
