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

export const createConfigurationRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(key: string): string {
		return `${CACHE_PREFIXES.CONFIGURATION}${key}`;
	}

	function _composeEntity(item: ConfigurationDatabase): Configuration {
		return {
			...item,
			description: item?.description ?? undefined,
			updatedAt: item.updatedAt.getTime(),
		};
	}

	async function _getFromKV(key: string): Promise<Configuration | undefined> {
		try {
			return await kv.get(_composeCacheKey(key));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(key: string): Promise<Configuration | undefined> {
		const result = await db.query.configuration.findFirst({
			where: (f, op) => op.eq(f.key, key),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(key: string, data: Configuration | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(key), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Configuration[]> {
		try {
			let stmt = db.query.configuration.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.configuration.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.configuration.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			throw new RepositoryError("Failed to listing configurations", {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function get(key: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(key);
				if (cached) return cached;
			}

			const result = await _getFromDB(key);

			if (!result)
				throw new RepositoryError("Failed get configuration from db");

			await _setCache(key, {
				...result,
				description: result?.description ?? undefined,
			});

			return result;
		} catch (error) {
			throw new RepositoryError(`Failed to get configuration by key "${key}"`, {
				prevError: error instanceof Error ? error : undefined,
			});
		}
	}

	async function update(
		key: string,
		item: UpdateConfiguration,
	): Promise<Configuration> {
		try {
			const existing = await _getFromDB(key);
			if (!existing) {
				throw new RepositoryError(`Configuration with key "${key}" not found`);
			}

			const [operation] = await db
				.update(tables.configuration)
				.set({
					...existing,
					...item,
					updatedAt: new Date(),
				})
				.where(eq(tables.configuration.key, key))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(key, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update configuration with key "${key}"`,
				{
					prevError: error instanceof Error ? error : undefined,
				},
			);
		}
	}

	return { list, get, update };
};

export type ConfigurationRepositoryFactory =
	typeof createConfigurationRepository;
export type ConfigurationRepository =
	ReturnType<ConfigurationRepositoryFactory>;
