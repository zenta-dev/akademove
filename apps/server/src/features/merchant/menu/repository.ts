import type {
	InsertMerchantMenu,
	MerchantMenu,
	UpdateMerchantMenu,
} from "@repo/schema/merchant";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MerchantMenuDatabase } from "@/core/tables/merchant";

export const createMerchantMenuRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT_MENU}${id}`;
	}

	function _composeEntity(item: MerchantMenuDatabase): MerchantMenu {
		return {
			...item,
			category: item.category ?? undefined,
		};
	}

	async function _getFromKV(id: string): Promise<MerchantMenu | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<MerchantMenu | undefined> {
		const result = await db.query.merchantMenu.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: MerchantMenu | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<MerchantMenu[]> {
		try {
			let stmt = db.query.merchantMenu.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.merchantMenu.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.merchantMenu.findMany({
						offset,
						limit,
					});
				}
			}
			const result = await stmt;
			return result.map(_composeEntity);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to listing merchant menus");
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result)
				throw new RepositoryError("Failed get merchant menu from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get merchant menu by id "${id}"`);
		}
	}

	async function create(item: InsertMerchantMenu): Promise<MerchantMenu> {
		try {
			const [operation] = await db
				.insert(tables.merchantMenu)
				.values(item)
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to create merchant menu");
		}
	}

	async function update(
		id: string,
		item: UpdateMerchantMenu,
	): Promise<MerchantMenu> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Merchant Menu with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.merchantMenu)
				.set({
					...existing,
					...item,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.merchantMenu.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update merchant menu with id "${id}"`,
			);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.merchantMenu)
				.where(eq(tables.merchantMenu.id, id))
				.returning({ id: tables.merchantMenu.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(
				`Failed to delete merchant menu with id "${id}"`,
			);
		}
	}

	return { list, get, create, update, remove };
};

export type MerchantMenuRepository = ReturnType<
	typeof createMerchantMenuRepository
>;
