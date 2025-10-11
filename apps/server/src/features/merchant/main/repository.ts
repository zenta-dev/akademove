import type {
	InsertMerchant,
	Merchant,
	UpdateMerchant,
} from "@repo/schema/merchant";
import { eq } from "drizzle-orm";
import { CACHE_PREFIXES, CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MerchantDatabase } from "@/core/tables/merchant";

export const createMerchantMainRepository = (
	db: DatabaseService,
	kv: KeyValueService,
) => {
	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT}${id}`;
	}

	function _composeEntity(item: MerchantDatabase): Merchant {
		return {
			...item,
			location: item.location ?? undefined,
		};
	}

	async function _getFromKV(id: string): Promise<Merchant | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(id: string): Promise<Merchant | undefined> {
		const result = await db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		if (result) return _composeEntity(result);
		return undefined;
	}

	async function _setCache(id: string, data: Merchant | undefined) {
		if (data) {
			try {
				await kv.put(_composeCacheKey(id), data, {
					expirationTtl: CACHE_TTLS["24h"],
				});
			} catch {}
		}
	}

	async function list(opts?: GetAllOptions): Promise<Merchant[]> {
		try {
			let stmt = db.query.merchant.findMany();
			if (opts) {
				const { cursor, page, limit } = opts;
				if (cursor) {
					stmt = db.query.merchant.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				}
				if (page) {
					const pageNum = page;
					const offset = (pageNum - 1) * limit;
					stmt = db.query.merchant.findMany({
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

			throw new RepositoryError("Failed to listing merchants");
		}
	}

	async function get(id: string, opts?: GetOptions) {
		try {
			if (opts?.fromCache) {
				const cached = await _getFromKV(id);
				if (cached) return cached;
			}

			const result = await _getFromDB(id);

			if (!result) throw new RepositoryError("Failed get merchant from db");

			await _setCache(id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get merchant by id "${id}"`);
		}
	}

	async function getByUserId(id: string) {
		try {
			const result = await db.query.merchant.findFirst({
				where: (f, op) => op.eq(f.userId, id),
			});

			if (!result) throw new RepositoryError("Failed get merchant from db");
			return _composeEntity(result);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to get merchant by user id "${id}"`);
		}
	}

	async function create(
		item: InsertMerchant & { userId: string },
	): Promise<Merchant> {
		try {
			const [operation] = await db
				.insert(tables.merchant)
				.values(item)
				.returning();

			const result = _composeEntity(operation);
			await _setCache(result.id, result);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError("Failed to create merchant");
		}
	}

	async function update(id: string, item: UpdateMerchant): Promise<Merchant> {
		try {
			const existing = await _getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Merchant with id "${id}" not found`);
			}

			const [operation] = await db
				.update(tables.merchant)
				.set({
					...existing,
					...item,
					createdAt: new Date(existing.createdAt),
					updatedAt: new Date(),
				})
				.where(eq(tables.merchant.id, id))
				.returning();

			const result = _composeEntity(operation);

			await _setCache(id, result);

			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update merchant with id "${id}"`);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const result = await db
				.delete(tables.merchant)
				.where(eq(tables.merchant.id, id))
				.returning({ id: tables.merchant.id });

			if (result.length > 0) {
				try {
					await kv.delete(_composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;

			throw new RepositoryError(`Failed to delete merchant with id "${id}"`);
		}
	}

	return { list, get, getByUserId, create, update, remove };
};

export type MerchantMainRepository = ReturnType<
	typeof createMerchantMainRepository
>;
