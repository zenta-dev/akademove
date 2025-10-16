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
import {
	type DatabaseService,
	type DatabaseTransaction,
	tables,
} from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantDatabase } from "@/core/tables/merchant";

export class MerchantMainRepository {
	readonly #db: DatabaseService;
	readonly #kv: KeyValueService;
	readonly #storage: StorageService;
	readonly #bucket: StorageBucket = "merchant";

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		this.#db = db;
		this.#kv = kv;
		this.#storage = storage;
	}

	private composeCacheKey(id: string): string {
		return `${CACHE_PREFIXES.MERCHANT}${id}`;
	}

	private async composeEntity(
		item: MerchantDatabase,
	): Promise<Merchant & { documentId?: string }> {
		const document = item.document
			? await this.#storage.getPresignedUrl({
					bucket: this.#bucket,
					key: item.document,
				})
			: undefined;

		return {
			...item,
			location: item.location ?? undefined,
			documentId: item.document ?? undefined,
			document,
		};
	}

	private async getFromKV(id: string): Promise<Merchant | undefined> {
		try {
			return await this.#kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async getFromDB(
		id: string,
	): Promise<(Merchant & { documentId?: string }) | undefined> {
		const result = await this.#db.query.merchant.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? await this.composeEntity(result) : undefined;
	}

	private async setCache(
		id: string,
		data: Merchant | undefined,
	): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {}
	}

	async list(opts?: GetAllOptions): Promise<Merchant[]> {
		try {
			let stmt = this.#db.query.merchant.findMany();

			if (opts) {
				const { cursor, page, limit } = opts;

				if (cursor) {
					stmt = this.#db.query.merchant.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				} else if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.merchant.findMany({
						offset,
						limit,
					});
				}
			}

			const result = await stmt;
			return await Promise.all(result.map((r) => this.composeEntity(r)));
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list merchants");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<Merchant> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.getFromDB(id);
			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get merchant by id "${id}"`);
		}
	}

	async getByUserId(userId: string): Promise<Merchant> {
		try {
			const result = await this.#db.query.merchant.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError("Failed to get merchant from DB");

			return await this.composeEntity(result);
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to get merchant by user id "${userId}"`,
			);
		}
	}

	async create(
		item: InsertMerchant & { userId: string },
		opts?: { tx?: DatabaseTransaction },
	): Promise<Merchant> {
		try {
			const id = v7();
			const doc = item.document;
			const docKey = doc ? `M-${id}.${getFileExtension(doc)}` : undefined;

			const [operation] = await Promise.all([
				(opts?.tx ?? this.#db)
					.insert(tables.merchant)
					.values({ ...item, id, document: docKey })
					.returning()
					.then((r) => r[0]),
				doc && docKey
					? this.#storage.upload({
							bucket: this.#bucket,
							key: docKey,
							file: doc,
						})
					: Promise.resolve(),
			]);

			const result = await this.composeEntity(operation);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create merchant");
		}
	}

	async update(id: string, item: UpdateMerchant): Promise<Merchant> {
		try {
			const existing = await this.getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Merchant with id "${id}" not found`);

			const upload = item.document
				? this.#storage.upload({
						bucket: this.#bucket,
						key: `M-${id}.${getFileExtension(item.document)}`,
						file: item.document,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				this.#db
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

			const result = await this.composeEntity(operation);
			await this.setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to update merchant with id "${id}"`);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.getFromDB(id);
			if (!find)
				throw new RepositoryError("Merchant not found", { code: "NOT_FOUND" });

			const [result] = await Promise.all([
				this.#db
					.delete(tables.merchant)
					.where(eq(tables.merchant.id, id))
					.returning({ id: tables.merchant.id }),
				find.documentId
					? this.#storage.delete({ bucket: this.#bucket, key: find.documentId })
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				try {
					await this.#kv.delete(this.composeCacheKey(id));
				} catch {}
			}
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to delete merchant with id "${id}"`);
		}
	}
}

export type MerchantMainRepositoryType = InstanceType<
	typeof MerchantMainRepository
>;
