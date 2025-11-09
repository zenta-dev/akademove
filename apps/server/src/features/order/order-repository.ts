import {
	type ConfigurationValue,
	DeliveryPricingConfigurationSchema,
	FoodPricingConfigurationSchema,
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
import Decimal from "decimal.js";
import { count, eq, gt, ilike, inArray, or, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	WithTx,
	WithUserId,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MapService } from "@/core/services/map";
import type { OrderDatabase } from "@/core/tables/order";
import { log, safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PricingCalculator } from "@/utils/pricing";
import type { PaymentRepository } from "../payment/payment-repository";

export class OrderRepository extends BaseRepository {
	readonly #map: MapService;
	readonly #paymentRepo: PaymentRepository;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		map: MapService,
		paymentRepo: PaymentRepository,
	) {
		super(FEATURE_TAGS.ORDER, "order", kv, db);
		this.#map = map;
		this.#paymentRepo = paymentRepo;
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
			user: item.user ? { name: item.user.name } : undefined,
			driver: item.driver ? { user: item.driver.user } : undefined,
			merchant: item.merchant ? { name: item.merchant.name } : undefined,
			driverId: item.driverId ?? undefined,
			merchantId: item.merchantId ?? undefined,
			note: item.note ?? undefined,
			basePrice: toNumberSafe(item.basePrice),
			totalPrice: toNumberSafe(item.totalPrice),
			tip: item.tip ? toNumberSafe(item.tip) : undefined,
			acceptedAt: item.acceptedAt ?? undefined,
			arrivedAt: item.arrivedAt ?? undefined,
			cancelReason: item.cancelReason ?? undefined,
			gender: item.gender ?? undefined,
		};
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
	): Promise<ListResult<Order>> {
		try {
			const tx = opts?.tx ?? this.db;
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
				statuses = [],
				id,
				role,
			} = query ?? {};

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
					case "user":
						clauses.push(eq(tables.order.userId, id));
						break;
					case "driver":
						clauses.push(eq(tables.order.driverId, id));
						break;
					case "merchant":
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

			if (cursor) {
				clauses.push(gt(tables.order.updatedAt, new Date(cursor)));

				const res = await tx.query.order.findMany({
					with: withx,
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map(OrderRepository.composeEntity);
				return { rows };
			}

			if (page) {
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

				return { rows, totalPages };
			}

			const res = await tx.query.order.findMany({
				with: withx,
				orderBy,
				limit,
			});

			const rows = res.map(OrderRepository.composeEntity);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}
	async #getPricingConfiguration(
		params: { type: OrderType },
		opts: WithTx,
	): Promise<ConfigurationValue | undefined> {
		let key = "";
		switch (params.type) {
			case "ride":
				key = CONFIGURATION_KEYS.RIDE_SERVICE_PRICING;
				break;
			case "delivery":
				key = CONFIGURATION_KEYS.DELIVERY_SERVICE_PRICING;
				break;
			case "food":
				key = CONFIGURATION_KEYS.FOOD_SERVICE_PRICING;
				break;
			default:
				throw new RepositoryError("Invalid order type");
		}

		const fallback = async () => {
			const res = await opts.tx.query.configuration.findFirst({
				where: (f, op) => op.eq(f.key, key),
			});
			const value = res?.value;
			if (value) {
				this.setCache(key, value, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			}
			return value;
		};

		const res = await safeAsync(this.getCache(key, { fallback }));

		return res.data;
	}

	async estimate(
		params: EstimateOrder,
		opts: WithTx,
	): Promise<OrderSummary & { config: ConfigurationValue }> {
		try {
			const [pricingConfig, { distanceMeters }] = await Promise.all([
				this.#getPricingConfiguration({ type: params.type }, { tx: opts.tx }),
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
				case "ride": {
					const validatedConfig =
						RidePricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateRide(
						distanceKm,
						validatedConfig,
					);
					break;
				}
				case "delivery": {
					const validatedConfig =
						DeliveryPricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateDelivery(
						distanceKm,
						params.weight,
						validatedConfig,
					);
					break;
				}
				case "food": {
					const validatedConfig =
						FoodPricingConfigurationSchema.parse(pricingConfig);
					pricing = PricingCalculator.calculateFood(
						distanceKm,
						validatedConfig,
					);
					break;
				}
			}

			return { ...pricing, config: pricingConfig };
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
			const [estimate, user] = await Promise.all([
				this.estimate(params, opts),
				opts.tx.query.user.findFirst({
					columns: { name: true, email: true, phone: true },
					where: (f, op) => op.eq(f.id, params.userId),
				}),
			]);

			if (!user) {
				throw new RepositoryError(`User with id ${params.userId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const safeTotalCost = toStringNumberSafe(estimate.totalCost);

			const [createOrder] = await opts.tx
				.insert(tables.order)
				.values({
					id: v7(),
					userId: params.userId,
					type: params.type,
					note: params.note,
					pickupLocation: params.pickupLocation,
					dropoffLocation: params.dropoffLocation,
					distanceKm: estimate.distanceKm,
					basePrice: toStringNumberSafe(estimate.config.baseFare),
					totalPrice: safeTotalCost,
					requestedAt: new Date(),
					createdAt: new Date(),
					updatedAt: new Date(),
				})
				.returning({ id: tables.order.id });

			const { transaction, payment } = await this.#paymentRepo.charge(
				{
					transactionType: "payment",
					amount: estimate.totalCost,
					method: params.payment.method,
					provider: params.payment.provider,
					userId: params.userId,
					orderType: params.type,
				},
				opts,
			);

			const order = await this.#getFromDB(createOrder.id, opts);
			if (!order) throw new RepositoryError("Failed to place order");
			await this.setCache(order.id, order, {
				expirationTtl: CACHE_TTLS["1h"],
			});

			const result = { order, payment, transaction };

			return result;
		} catch (error) {
			throw this.handleError(error, "place");
		}
	}

	async update(id: string, item: UpdateOrder, opts: WithTx): Promise<Order> {
		try {
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Order with id "${id}" not found`);

			const [operation] = await opts.tx
				.update(tables.order)
				.set({
					...item,
					basePrice: existing.basePrice
						? toStringNumberSafe(existing.basePrice)
						: undefined,
					totalPrice: existing.totalPrice
						? toStringNumberSafe(existing.totalPrice)
						: undefined,
					tip: item.tip ? toStringNumberSafe(item.tip) : undefined,
					acceptedAt: existing.acceptedAt
						? new Date(existing.acceptedAt)
						: null,
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
