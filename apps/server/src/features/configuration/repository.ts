import type {
	Configuration,
	UpdateConfiguration,
} from "@repo/schema/configuration";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { ConfigurationDatabase } from "@/core/tables/configuration";
import { log, safeAsync } from "@/utils";

export class ConfigurationRepository {
	#db: DatabaseService;
	#kv: KeyValueService;

	constructor(db: DatabaseService, kv: KeyValueService) {
		this.#db = db;
		this.#kv = kv;
	}

	#composeCacheKey(key: string): string {
		return `${CACHE_PREFIXES.CONFIGURATION}${key}`;
	}

	#composeEntity(item: ConfigurationDatabase): Configuration {
		return {
			...item,
			description: item?.description ?? undefined,
		};
	}

	async #getFromKV(key: string): Promise<Configuration | undefined> {
		try {
			return await this.#kv.get(this.#composeCacheKey(key));
		} catch {
			return undefined;
		}
	}

	async #getFromDB(key: string): Promise<Configuration | undefined> {
		const result = await this.#db.query.configuration.findFirst({
			where: (f, op) => op.eq(f.key, key),
		});
		return result ? this.#composeEntity(result) : undefined;
	}

	async #setCache(key: string, data: Configuration | undefined) {
		if (!data) return;
		try {
			await this.#kv.put(this.#composeCacheKey(key), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {
			// ignore cache errors
		}
	}

	async list(opts?: GetAllOptions): Promise<Configuration[]> {
		try {
			let stmt = this.#db.query.configuration.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor) {
					stmt = this.#db.query.configuration.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}

				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = this.#db.query.configuration.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return result.map((item) => this.#composeEntity(item));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list configurations");
		}
	}

	async get(key: string, opts?: GetOptions): Promise<Configuration> {
		try {
			if (opts?.fromCache) {
				const cached = await this.#getFromKV(key);
				if (cached) return cached;
			}

			const result = await this.#getFromDB(key);
			if (!result)
				throw new RepositoryError("Failed to get configuration from db");

			await this.#setCache(key, {
				...result,
				description: result?.description ?? undefined,
			});

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get configuration by key "${key}"`);
		}
	}

	async update(
		key: string,
		item: UpdateConfiguration,
		userId?: string,
	): Promise<Configuration> {
		try {
			const existing = await this.#getFromDB(key);
			if (!existing)
				throw new RepositoryError(`Configuration with key "${key}" not found`);

			const [[operation]] = await Promise.all([
				this.#db
					.update(tables.configuration)
					.set({
						...existing,
						...item,
						updatedAt: new Date(),
					})
					.where(eq(tables.configuration.key, key))
					.returning(),
				safeAsync(this.#kv.delete(key)),
			]);

			const result = this.#composeEntity(operation);
			await safeAsync(
				Promise.all([
					this.#setCache(key, result),
					this.#db.insert(tables.configurationAuditLog).values({
						tableName: "configurations",
						recordId: key,
						operation: "UPDATE",
						oldData: existing,
						newData: operation,
						updatedById: userId,
					}),
				]),
			);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update configuration with key "${key}"`,
			);
		}
	}
}
