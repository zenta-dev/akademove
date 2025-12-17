import { env } from "cloudflare:workers";
import type { PricingConfiguration } from "@repo/schema/configuration";
import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import type { Order, OrderType } from "@repo/schema/order";
import type { User } from "@repo/schema/user";
import { nullsToUndefined } from "@repo/shared";
import Decimal from "decimal.js";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS } from "@/core/constants";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantMenuDatabase } from "@/core/tables/merchant";
import type { OrderDatabase } from "@/core/tables/order";
import { MenuImageService } from "@/features/merchant/services";
import { UserProfileService } from "@/features/user/services/user-profile-service";
import { safeAsync, toNumberSafe } from "@/utils";

/**
 * Database row type for order items with menu relation
 */
interface OrderItemRow {
	id: number;
	orderId: string;
	menuId: string;
	quantity: number;
	unitPrice: string;
	menu: MerchantMenuDatabase | null;
}

/**
 * OrderBaseRepository - Shared base class for all order repositories
 *
 * Contains common utilities:
 * - Entity composition
 * - Pricing configuration (KV cached)
 * - DB access helpers
 * - Room stub access for WebSocket broadcasting
 *
 * Note: No in-memory caching since Cloudflare Workers are stateless
 * and each request can hit a different isolate.
 */
export class OrderBaseRepository extends BaseRepository {
	protected readonly storage?: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage?: StorageService,
	) {
		super("order", kv, db);
		this.storage = storage;
	}

	/**
	 * Compose order items from database rows to API format
	 * Transforms { menuId, quantity, unitPrice, menu } to { quantity, item: MerchantMenu }
	 *
	 * @param items - Raw database order item rows
	 * @param storage - Optional storage service to convert image keys to URLs
	 */
	static composeOrderItems(
		items: OrderItemRow[] | undefined,
		storage?: StorageService,
	): Order["items"] | undefined {
		if (!items || items.length === 0) return undefined;

		return items
			.filter(
				(
					item,
				): item is OrderItemRow & { menu: NonNullable<OrderItemRow["menu"]> } =>
					item.menu !== null,
			)
			.map((item) => {
				// Convert image key to full URL if storage service is provided
				const imageUrl =
					item.menu.image && storage
						? storage.getPublicUrl({
								bucket: MenuImageService.BUCKET,
								key: item.menu.image,
							})
						: undefined;

				return {
					quantity: item.quantity,
					item: {
						id: item.menu.id,
						merchantId: item.menu.merchantId,
						name: item.menu.name,
						category: item.menu.category ?? undefined,
						price: toNumberSafe(item.menu.price),
						stock: item.menu.stock,
						image: imageUrl,
						createdAt: item.menu.createdAt,
						updatedAt: item.menu.updatedAt,
					},
				};
			});
	}

	/**
	 * Calculate estimated driver earning for an order based on pricing configuration
	 *
	 * @param totalPrice - Order total price
	 * @param orderType - Order type (RIDE, DELIVERY, FOOD)
	 * @param pricingConfig - Pricing configuration for the order type
	 * @param merchantCommission - Merchant commission (for FOOD orders)
	 * @returns Estimated driver earning or undefined if calculation not possible
	 */
	static calculateEstimatedDriverEarning(
		totalPrice: number,
		orderType: OrderType,
		pricingConfig?: PricingConfiguration,
		merchantCommission?: number,
	): number | undefined {
		if (!pricingConfig) return undefined;

		const platformFeeRate = new Decimal(pricingConfig.platformFeeRate);
		const total = new Decimal(totalPrice);
		const platformFee = total.mul(platformFeeRate);

		let earning = total.minus(platformFee);

		// For FOOD orders, also subtract merchant commission
		if (orderType === "FOOD" && merchantCommission !== undefined) {
			earning = earning.minus(new Decimal(merchantCommission));
		}

		return earning.toNumber();
	}

	/**
	 * Compose an Order entity from database row with related entities
	 *
	 * @param item - Raw database order row with relations
	 * @param storage - Optional storage service to convert image keys to URLs for menu items and user profiles
	 * @param pricingConfig - Optional pricing configuration for calculating estimatedDriverEarning
	 */
	static async composeEntity(
		item: OrderDatabase & {
			user: Partial<User> | null;
			driver: Partial<Driver> | null;
			merchant: Partial<Merchant> | null;
			items?: OrderItemRow[];
		},
		storage?: StorageService,
		pricingConfig?: PricingConfiguration,
	): Promise<Order> {
		const composedItems = OrderBaseRepository.composeOrderItems(
			item.items,
			storage,
		);

		// Convert user image key to presigned URL (private bucket)
		let userImageUrl: string | undefined;
		if (item.user?.image && storage) {
			userImageUrl = await storage.getPresignedUrl({
				bucket: UserProfileService.BUCKET,
				key: item.user.image,
			});
		}

		// Convert driver's user image key to presigned URL (private bucket)
		let driverUserImageUrl: string | undefined;
		if (item.driver?.user?.image && storage) {
			driverUserImageUrl = await storage.getPresignedUrl({
				bucket: UserProfileService.BUCKET,
				key: item.driver.user.image,
			});
		}

		const result = nullsToUndefined(item);
		const totalPrice = toNumberSafe(item.totalPrice);
		const driverEarning = item.driverEarning
			? toNumberSafe(item.driverEarning)
			: undefined;
		const merchantCommission = item.merchantCommission
			? toNumberSafe(item.merchantCommission)
			: undefined;
		const merchantEarning = item.merchantEarning
			? toNumberSafe(item.merchantEarning)
			: undefined;

		// Calculate estimated driver earning for orders that don't have final driverEarning yet
		// (i.e., orders before completion)
		let estimatedDriverEarning: number | undefined;
		if (driverEarning === undefined && pricingConfig) {
			estimatedDriverEarning =
				OrderBaseRepository.calculateEstimatedDriverEarning(
					totalPrice,
					item.type as OrderType,
					pricingConfig,
					merchantCommission,
				);
		}

		return {
			...item,
			...result,
			user: result.user
				? {
						...result.user,
						image: userImageUrl,
					}
				: undefined,
			driver: result.driver
				? {
						...result.driver,
						user: result.driver.user
							? {
									...result.driver.user,
									image: driverUserImageUrl,
								}
							: undefined,
					}
				: undefined,
			basePrice: toNumberSafe(item.basePrice),
			totalPrice,
			tip: item.tip ? toNumberSafe(item.tip) : undefined,
			platformCommission: item.platformCommission
				? toNumberSafe(item.platformCommission)
				: undefined,
			driverEarning,
			merchantCommission,
			merchantEarning,
			discountAmount: item.discountAmount
				? toNumberSafe(item.discountAmount)
				: undefined,
			estimatedDriverEarning,
			items: composedItems,
			itemCount: composedItems?.length,
		};
	}

	/**
	 * Get WebSocket room stub by name for broadcasting order updates
	 */
	static getRoomStubByName(name: string) {
		const stubId = env.ORDER_ROOM.idFromName(name);
		const stub = env.ORDER_ROOM.get(stubId);
		return stub;
	}

	/**
	 * Get order from database with related entities
	 *
	 * Note: Explicitly excludes driver.currentLocation geometry column to avoid
	 * EWKB parsing errors when the geometry data is malformed or empty.
	 */
	protected async getFromDB(
		id: string,
		opts?: WithTx,
	): Promise<Order | undefined> {
		const result = await (opts?.tx ?? this.db).query.order.findFirst({
			with: {
				user: {
					columns: { name: true, image: true, gender: true, rating: true },
				},
				driver: {
					columns: { userId: true },
					with: { user: { columns: { name: true, image: true } } },
				},
				merchant: { columns: { name: true } },
				items: {
					with: {
						menu: true,
					},
				},
			},
			where: (f, op) => op.eq(f.id, id),
		});
		if (!result) return undefined;

		// Fetch pricing config for estimated driver earning calculation
		const pricingConfig = await this.getPricingConfiguration(
			result.type as "RIDE" | "DELIVERY" | "FOOD",
			opts,
		);

		// Type assertion needed because we're selecting specific columns from driver
		// which changes the inferred type, but it's still compatible with Partial<Driver>
		return OrderBaseRepository.composeEntity(
			result as unknown as Parameters<
				typeof OrderBaseRepository.composeEntity
			>[0],
			this.storage,
			pricingConfig,
		);
	}

	/**
	 * Get pricing configuration for an order type (static version for use outside repository context)
	 * Uses KV cache with DB fallback
	 *
	 * @param type - Order type (RIDE, DELIVERY, FOOD)
	 * @param kv - KV service instance
	 * @param db - Database service instance
	 */
	static async fetchPricingConfiguration(
		type: "RIDE" | "DELIVERY" | "FOOD",
		kv: KeyValueService,
		db: DatabaseService,
	): Promise<PricingConfiguration | undefined> {
		let key = "";
		switch (type) {
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
				throw new Error(`Invalid order type: ${type}`);
		}

		// Try KV cache first
		const cached = await safeAsync(kv.get(key));
		if (cached.data) {
			return cached.data as PricingConfiguration;
		}

		// Fallback to DB
		const res = await db.query.configuration.findFirst({
			where: (f, op) => op.eq(f.key, key),
		});
		const value = res?.value;
		if (value) {
			// Store in KV cache
			await safeAsync(kv.put(key, value, { expirationTtl: CACHE_TTLS["24h"] }));
		}
		return value as PricingConfiguration | undefined;
	}

	/**
	 * Get all pricing configurations for all order types
	 * Useful for batch processing orders of mixed types
	 *
	 * @param kv - KV service instance
	 * @param db - Database service instance
	 * @returns Map of order type to pricing configuration
	 */
	static async fetchAllPricingConfigurations(
		kv: KeyValueService,
		db: DatabaseService,
	): Promise<
		Map<"RIDE" | "DELIVERY" | "FOOD", PricingConfiguration | undefined>
	> {
		const [rideConfig, deliveryConfig, foodConfig] = await Promise.all([
			OrderBaseRepository.fetchPricingConfiguration("RIDE", kv, db),
			OrderBaseRepository.fetchPricingConfiguration("DELIVERY", kv, db),
			OrderBaseRepository.fetchPricingConfiguration("FOOD", kv, db),
		]);

		const configMap = new Map<
			"RIDE" | "DELIVERY" | "FOOD",
			PricingConfiguration | undefined
		>();
		configMap.set("RIDE", rideConfig);
		configMap.set("DELIVERY", deliveryConfig);
		configMap.set("FOOD", foodConfig);

		return configMap;
	}

	/**
	 * Get pricing configuration for an order type
	 * Uses KV cache with DB fallback
	 */
	protected async getPricingConfiguration(
		type: "RIDE" | "DELIVERY" | "FOOD",
		opts?: WithTx,
	): Promise<PricingConfiguration | undefined> {
		let key = "";
		switch (type) {
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
				throw new Error(`Invalid order type: ${type}`);
		}

		// Use KV cache with DB fallback
		const fallback = async () => {
			const db = opts?.tx ?? this.db;
			const res = await db.query.configuration.findFirst({
				where: (f, op) => op.eq(f.key, key),
			});
			const value = res?.value;
			if (value) {
				// Store in KV cache
				await this.setCache(key, value, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			}
			return value;
		};

		const res = await safeAsync(this.getCache(key, { fallback }));

		return res.data as PricingConfiguration | undefined;
	}
}
