import { env } from "cloudflare:workers";
import type { PricingConfiguration } from "@repo/schema/configuration";
import type { Driver } from "@repo/schema/driver";
import type { Merchant } from "@repo/schema/merchant";
import type { Order } from "@repo/schema/order";
import type { User } from "@repo/schema/user";
import { nullsToUndefined } from "@repo/shared";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS } from "@/core/constants";
import type { WithTx } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { OrderDatabase } from "@/core/tables/order";
import { safeAsync, toNumberSafe } from "@/utils";

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
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("order", kv, db);
	}

	/**
	 * Compose an Order entity from database row with related entities
	 */
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
	 */
	protected async getFromDB(
		id: string,
		opts?: WithTx,
	): Promise<Order | undefined> {
		const result = await (opts?.tx ?? this.db).query.order.findFirst({
			with: {
				user: { columns: { name: true } },
				driver: { columns: {}, with: { user: { columns: { name: true } } } },
				merchant: { columns: { name: true } },
			},
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? OrderBaseRepository.composeEntity(result) : undefined;
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
