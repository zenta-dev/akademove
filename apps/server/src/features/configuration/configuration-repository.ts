import { m } from "@repo/i18n";
import type {
	Configuration,
	UpdateConfiguration,
} from "@repo/schema/configuration";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { eq } from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, CONFIGURATION_KEYS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ConfigurationDatabase } from "@/core/tables/configuration";
import { OrderRepository } from "@/features/order/order-repository";
import { log, safeAsync } from "@/utils";
import {
	BusinessConfigurationService,
	ConfigurationAuditService,
} from "./services";

/** Pricing configuration keys that require cache invalidation when updated */
const PRICING_CONFIG_KEYS = [
	CONFIGURATION_KEYS.RIDE_SERVICE_PRICING,
	CONFIGURATION_KEYS.DELIVERY_SERVICE_PRICING,
	CONFIGURATION_KEYS.FOOD_SERVICE_PRICING,
	CONFIGURATION_KEYS.BUSINESS_CONFIGURATION,
] as const;

export class ConfigurationRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("configuration", kv, db);
	}

	static composeEntity(item: ConfigurationDatabase): Configuration {
		return {
			...item,
			description: item?.description ?? undefined,
		};
	}

	async #getFromDB(key: string): Promise<Configuration | undefined> {
		const result = await this.db.query.configuration.findFirst({
			where: (f, op) => op.eq(f.key, key),
		});
		return result ? ConfigurationRepository.composeEntity(result) : undefined;
	}

	async list(query?: UnifiedPaginationQuery): Promise<Configuration[]> {
		try {
			let stmt = this.db.query.configuration.findMany();

			if (query) {
				const { cursor, page, limit } = query;

				if (cursor) {
					stmt = this.db.query.configuration.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.db.query.configuration.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((item) => ConfigurationRepository.composeEntity(item));
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(key: string): Promise<Configuration> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(key);
				if (!res) throw new RepositoryError(m.error_failed_get_configuration());
				await this.setCache(key, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(key, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async update(
		key: string,
		item: UpdateConfiguration & WithUserId,
	): Promise<Configuration> {
		try {
			const existing = await this.#getFromDB(key);
			if (!existing)
				throw new RepositoryError(`Configuration with key "${key}" not found`);

			const updateData = ConfigurationAuditService.prepareUpdateData(
				item.userId,
			);

			const [[operation]] = await Promise.all([
				this.db
					.update(tables.configuration)
					.set({
						...item,
						...updateData,
					})
					.where(eq(tables.configuration.key, key))
					.returning(),
				this.deleteCache(key),
			]);

			const result = ConfigurationRepository.composeEntity(operation);
			const auditLogEntry = ConfigurationAuditService.prepareAuditLogEntry(
				key,
				existing as unknown as ConfigurationDatabase,
				operation,
				item.userId,
			);

			await safeAsync(
				Promise.all([
					this.setCache(key, result, { expirationTtl: CACHE_TTLS["24h"] }),
					this.db.insert(tables.configurationAuditLog).values(auditLogEntry),
				]),
			);

			// Invalidate OrderRepository's in-memory pricing cache when pricing config is updated
			if (
				PRICING_CONFIG_KEYS.includes(
					key as (typeof PRICING_CONFIG_KEYS)[number],
				)
			) {
				OrderRepository.invalidatePricingCache();
				log.info(
					{ key },
					"[ConfigurationRepository] Pricing config updated - invalidated OrderRepository cache",
				);
			}

			// Invalidate business configuration cache when business config is updated
			if (key === CONFIGURATION_KEYS.BUSINESS_CONFIGURATION) {
				await BusinessConfigurationService.invalidateCache(this.kv);
				log.info(
					{ key },
					"[ConfigurationRepository] Business config updated - invalidated cache",
				);
			}

			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}
}
