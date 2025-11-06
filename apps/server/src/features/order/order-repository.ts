import type { ChargeResponse } from "@erhahahaa/midtrans-client-typescript";
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
	UpdateOrder,
} from "@repo/schema/order";
import type { Payment } from "@repo/schema/payment";
import type { User, UserRole } from "@repo/schema/user";
import Decimal from "decimal.js";
import { eq, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	CONFIGURATION_KEYS,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	GetAllOptions,
	GetOptions,
	WithTx,
	WithUserId,
} from "@/core/interface";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MapService } from "@/core/services/map";
import type { PaymentService } from "@/core/services/payment";
import type { OrderDatabase } from "@/core/tables/order";
import { log, safeAsync, toNumberSafe, toStringNumberSafe } from "@/utils";
import { PricingCalculator } from "@/utils/pricing";
import type { WalletRepository } from "../wallet/wallet-repository";

export class OrderRepository {
	#kv: KeyValueService;
	#map: MapService;
	#payment: PaymentService;
	#wallet: WalletRepository;

	constructor(
		kv: KeyValueService,
		map: MapService,
		payment: PaymentService,
		wallet: WalletRepository,
	) {
		this.#kv = kv;
		this.#map = map;
		this.#payment = payment;
		this.#wallet = wallet;
	}

	#composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.ORDER}${id}`;
	}

	#composeEntity(
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

	async #getFromKV(id: string): Promise<Order | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(
		params: { id: string } & WithTx,
	): Promise<Order | undefined> {
		const result = await params.tx.query.order.findFirst({
			with: {
				user: { columns: { name: true } },
				driver: { columns: {}, with: { user: { columns: { name: true } } } },
				merchant: { columns: { name: true } },
			},
			where: (f, op) => op.eq(f.id, params.id),
		});
		return result ? this.#composeEntity(result) : undefined;
	}

	async #setCache(id: string, data: Order | undefined) {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			/* ignore cache errors */
		}
	}

	async list(
		params: WithTx,
		opts?: GetAllOptions & {
			statuses?: OrderStatus[];
			id: string;
			role: UserRole;
		},
	): Promise<Order[]> {
		try {
			let stmt = params.tx.query.order.findMany({
				with: {
					user: { columns: { name: true } },
					driver: { columns: {}, with: { user: { columns: { name: true } } } },
					merchant: { columns: { name: true } },
				},
				where: (f, op) => {
					const filters: SQL[] = [];
					const statuses = opts?.statuses ?? [];

					if (statuses.length > 0) filters.push(op.inArray(f.status, statuses));

					if (opts?.id && opts.role) {
						switch (opts.role) {
							case "user":
								filters.push(op.eq(f.userId, opts.id));
								break;
							case "driver":
								filters.push(op.eq(f.driverId, opts.id));
								break;
							case "merchant":
								filters.push(op.eq(f.merchantId, opts.id));
								break;
						}
					}

					return filters.length > 0 ? op.and(...filters) : undefined;
				},
			});

			if (opts) {
				const { cursor, page, limit = 10 } = opts;
				if (cursor) {
					stmt = params.tx.query.order.findMany({
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
							const statuses = opts?.statuses ?? [];
							if (statuses.length > 0)
								filters.push(op.inArray(f.status, statuses));
							if (opts?.id && opts.role) {
								switch (opts.role) {
									case "user":
										filters.push(op.eq(f.userId, opts.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, opts.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, opts.id));
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
					stmt = params.tx.query.order.findMany({
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
							const statuses = opts?.statuses ?? [];
							if (statuses.length > 0)
								filters.push(op.inArray(f.status, statuses));
							if (opts?.id && opts.role) {
								switch (opts.role) {
									case "user":
										filters.push(op.eq(f.userId, opts.id));
										break;
									case "driver":
										filters.push(op.eq(f.driverId, opts.id));
										break;
									case "merchant":
										filters.push(op.eq(f.merchantId, opts.id));
										break;
								}
							}
							return filters.length > 0 ? op.and(...filters) : undefined;
						},
					});
				}
			}

			const result = await stmt;
			return result.map((r) => this.#composeEntity(r));
		} catch (error) {
			log.error({ detail: error }, "Failed to list order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list orders");
		}
	}

	async #getPricingConfiguration(
		params: { type: OrderType } & WithTx,
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

		const res = await safeAsync(
			this.#kv.get(key, {
				fallback: async () => {
					const res = await params.tx.query.configuration.findFirst({
						where: (f, op) => op.eq(f.key, key),
					});
					const value = res?.value;
					if (value) {
						await safeAsync(
							this.#kv.put(key, value, {
								expirationTtl: CACHE_TTLS["24h"],
							}),
						);
					}
					return value;
				},
			}),
		);

		return res.data;
	}

	async estimate(
		params: EstimateOrder & WithTx,
	): Promise<OrderSummary & { config: ConfigurationValue }> {
		try {
			const [pricingConfig, { distanceMeters }] = await Promise.all([
				this.#getPricingConfiguration({ ...params }),
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
			log.error({ detail: error }, "Failed to estimate order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to estimate price");
		}
	}

	async get(
		params: { id: string } & WithTx,
		opts?: GetOptions,
	): Promise<Order> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(params.id);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(params);
			if (!result) throw new RepositoryError("Failed to get order from db");

			await this.#setCache(params.id, result);
			return result;
		} catch (error) {
			log.error({ detail: error }, "Failed to get order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get order by id "${params.id}"`);
		}
	}

	async placeOrder(
		params: PlaceOrder & WithUserId & WithTx,
	): Promise<Order & { payment: Payment }> {
		try {
			const [estimate, user, wallet] = await Promise.all([
				this.estimate(params),
				params.tx.query.user.findFirst({
					columns: { name: true, email: true, phone: true },
					where: (f, op) => op.eq(f.id, params.userId),
				}),
				this.#wallet.ensureWallet({ ...params }),
			]);

			if (!user) {
				throw new RepositoryError(`User with id ${params.userId} not found`, {
					code: "NOT_FOUND",
				});
			}

			const EXPIRY_MINUTES = 15;
			const expiresAt = new Date(Date.now() + EXPIRY_MINUTES * 60 * 1000);

			const safeTotalCost = toStringNumberSafe(estimate.totalCost);

			const [[createOrder], [transaction]] = await Promise.all([
				params.tx
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
					.returning({ id: tables.order.id }),
				params.tx
					.insert(tables.transaction)
					.values({
						id: v7(),
						walletId: wallet.id,
						type: "payment",
						amount: safeTotalCost,
						status: "pending",
						description: `Top-up ${params.payment.method}`,
					})
					.returning(),
			]);

			const paymentResponse = (await this.#payment.charge({
				externalId: createOrder.id,
				amount: estimate.totalCost,
				customer: {
					...user,
					phone: `${user?.phone.countryCode}-${user?.phone.number}`,
				},
				expiry: { duration: EXPIRY_MINUTES, unit: "minute" },
				method: params.payment.method,
				metadata: { type: "RIDE-HAILING" },
			})) as ChargeResponse;

			const actions = paymentResponse.actions as
				| {
						name: string;
						method: string;
						url: string;
				  }[]
				| undefined;
			const action = actions?.find((val) => val.name === "generate-qr-code");

			const [paymentResult] = await params.tx
				.insert(tables.payment)
				.values({
					id: v7(),
					transactionId: transaction.id,
					provider: params.payment.provider,
					method: params.payment.method,
					amount: safeTotalCost,
					status: "pending",
					externalId: transaction.id,
					expiresAt,
					response: paymentResponse,
					paymentUrl: action?.url,
					payload: {
						method: params.payment.method,
						amount: estimate.totalCost,
						userId: params.userId,
						provider: params.payment.provider,
					},
				})
				.returning();

			const order = await this.#getFromDB({
				id: createOrder.id,
				tx: params.tx,
			});
			if (!order) throw new RepositoryError("Failed to place order");

			const payment = this.#wallet.composePayment(paymentResult);
			await this.#setCache(order.id, order);

			return { ...order, payment };
		} catch (error) {
			log.error({ detail: error }, "Failed to place order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to place order");
		}
	}

	async update(
		params: { id: string; item: UpdateOrder } & WithTx,
	): Promise<Order> {
		try {
			const existing = await this.#getFromDB(params);
			if (!existing)
				throw new RepositoryError(`Order with id "${params.id}" not found`);

			const [operation] = await params.tx
				.update(tables.order)
				.set({
					...params.item,
					basePrice: existing.basePrice
						? toStringNumberSafe(existing.basePrice)
						: undefined,
					totalPrice: existing.totalPrice
						? toStringNumberSafe(existing.totalPrice)
						: undefined,
					tip: params.item.tip
						? toStringNumberSafe(params.item.tip)
						: undefined,
					acceptedAt: existing.acceptedAt
						? new Date(existing.acceptedAt)
						: null,
					arrivedAt: existing.arrivedAt ? new Date(existing.arrivedAt) : null,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.order.id, params.id))
				.returning({ id: tables.order.id });

			const result = await this.#getFromDB({ id: operation.id, tx: params.tx });
			if (!result) throw new RepositoryError("Failed to update order");

			await this.#setCache(params.id, result);
			return result;
		} catch (error) {
			log.error({ detail: error }, "Failed to update order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update order with id "${params.id}"`,
			);
		}
	}

	async remove(params: { id: string } & WithTx): Promise<void> {
		try {
			const result = await params.tx
				.delete(tables.order)
				.where(eq(tables.order.id, params.id))
				.returning({ id: tables.order.id });

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.#composeCacheKey(params.id));
				} catch {
					/* ignore cache errors */
				}
			}
		} catch (error) {
			log.error({ detail: error }, "Failed to remove order");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to delete order with id "${params.id}"`,
			);
		}
	}
}
