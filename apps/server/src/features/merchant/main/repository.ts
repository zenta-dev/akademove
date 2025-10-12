import type {
	InsertMerchant,
	Merchant,
	UpdateMerchant,
} from "@repo/schema/merchant";
import { getFileExtension } from "@repo/shared";
import { eq } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	type StorageBucket,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { log } from "@/core/logger";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantDatabase } from "@/core/tables/merchant";

export const createMerchantMainRepository = (
	db: DatabaseService,
	kv: KeyValueService,
	storage: StorageService,
) => {
	const bucket: StorageBucket = "merchant";

	function _composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT}${id}`;
	}

	async function _composeEntity(
		item: MerchantDatabase,
	): Promise<Merchant & { documentId?: string }> {
		const document = item.document
			? await storage.getPresignedUrl({ bucket, key: item.document })
			: undefined;

		return {
			...item,
			location: item.location ?? undefined,
			documentId: item.document ?? undefined,
			document,
		};
	}

	async function _getFromKV(id: string): Promise<Merchant | undefined> {
		try {
			return await kv.get(_composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	async function _getFromDB(
		id: string,
	): Promise<(Merchant & { documentId?: string }) | undefined> {
		const result = await db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? _composeEntity(result) : undefined;
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
			return await Promise.all(result.map(_composeEntity));
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
			const id = v7();
			const doc = item.document;
			const docKey = doc ? `D-${id}.${getFileExtension(doc)}` : undefined;

			const [operation] = await Promise.all([
				db
					.insert(tables.merchant)
					.values({ ...item, id, document: docKey })
					.returning()
					.then((r) => r[0]),
				doc && docKey
					? storage.upload({ bucket, key: docKey, file: doc })
					: Promise.resolve(),
			]);

			const result = await _composeEntity(operation);
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

			const upload = item.document
				? storage.upload({
						bucket,
						key: `D-${id}.${getFileExtension(item.document)}`,
						file: item.document,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				db
					.update(tables.merchant)
					.set({
						...item,
						document: existing.documentId,
						createdAt: new Date(existing.createdAt),
						updatedAt: new Date(),
					})
					.where(eq(tables.merchant.id, id))
					.returning()
					.then((r) => r[0]),
				upload,
			]);

			const result = await _composeEntity(operation);
			await _setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update merchant with id "${id}"`);
		}
	}

	async function remove(id: string): Promise<void> {
		try {
			const find = await _getFromDB(id);
			if (!find) {
				throw new RepositoryError("Merchant not found", { code: "NOT_FOUND" });
			}

			const [result] = await Promise.all([
				db
					.delete(tables.merchant)
					.where(eq(tables.merchant.id, id))
					.returning({ id: tables.merchant.id }),
				find.documentId
					? storage.delete({ bucket, key: find.documentId })
					: Promise.resolve(),
			]);

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
