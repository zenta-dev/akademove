import {
	type ConfigurationValue,
	DeliveryPricingConfigurationSchema,
	FoodPricingConfigurationSchema,
	RidePricingConfigurationSchema,
} from "@repo/schema/configuration";
import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import type {
	EstimateOrder,
	Order,
	OrderStatus,
	OrderSummary,
	OrderType,
	PlaceOrder,
	PlaceOrderResponse,
	UpdateOrder,
} from "@repo/schema/order";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import type { User, UserRole } from "@repo/schema/user";
import Decimal from "decimal.js";
import { eq, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MapService } from "@/core/services/map";
import type { OrderDatabase } from "@/core/tables/order";
import { safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
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

	async list(
		query?: UnifiedPaginationQuery & {
			statuses?: OrderStatus[];
			id: string;
			role: UserRole;
		},
		opts?: WithTx,
	): Promise<Order[]> {
		try {
			let stmt = (opts?.tx ?? this.db).query.order.findMany({
				with: {
					user: { columns: { name: true } },
					driver: { columns: {}, with: { user: { columns: { name: true } } } },
					merchant: { columns: { name: true } },
				},
				where: (f, op) => {
					const filters: SQL[] = [];
					const statuses = query?.statuses ?? [];

					if (statuses.length > 0) filters.push(op.inArray(f.status, statuses));

					if (query?.id && query.role) {
						switch (query.role) {
							case "user":
								filters.push(op.eq(f.userId, query.id));
								break;
							case "driver":
								filters.push(op.eq(f.driverId, query.id));
								break;
							case "merchant":
								filters.push(op.eq(f.merchantId, query.id));
								break;
						}
					}

					return filters.length > 0 ? op.and(...filters) : undefined;
				},
			});

			if (query) {
				const { cursor, page, limit = 10 } = query;
				if (cursor) {
					stmt = (opts?.tx ?? this.db).query.order.findMany({
						with: {
							user: { columns: { name: true } },
							driver: {
								columns: {},
								with: { user: { columns: { name: true } } },
							},
							merchant: { columns: { name: true } },
						},
						where: (f, op) => {
							const filters: SQL[] = [op.gt(f.updatedAt, new Date(cursor))];
							const statuses = query?.statuses ?? [];
							if (statuses.length > 0)
								filters.push(op.inArray(f.status, statuses));
							if (query?.id && query.role) {
								switch (query.role) {
									case "user":
										filters.push(op.eq(f.userId, query.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, query.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, query.id));
										break;
								}
							}

							return filters.length > 0 ? op.and(...filters) : undefined;
						},
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = (opts?.tx ?? this.db).query.order.findMany({
						with: {
							user: { columns: { name: true } },
							driver: {
								columns: {},
								with: { user: { columns: { name: true } } },
							},
							merchant: { columns: { name: true } },
						},
						offset,
						limit,
						where: (f, op) => {
							const filters: SQL[] = [];
							const statuses = query?.statuses ?? [];
							if (statuses.length > 0)
								filters.push(op.inArray(f.status, statuses));
							if (query?.id && query.role) {
								switch (query.role) {
									case "user":
										filters.push(op.eq(f.userId, query.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, query.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, query.id));
										break;
								}
							}
							return filters.length > 0 ? op.and(...filters) : undefined;
						},
					});
				}
			}

			const result = await stmt;
			return result.map((r) => OrderRepository.composeEntity(r));
		} catch (error) {
			throw this.handleError(error, "list");
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
