import type {
	InsertMerchantMenu,
	MerchantMenu,
	UpdateMerchantMenu,
} from "@repo/schema/merchant";
import { getFileExtension } from "@repo/shared";
import { count, eq, ilike } from "drizzle-orm";
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
import type { MerchantMenuDatabase } from "@/core/tables/merchant";
import { MerchantMenuSortBySchema } from "./spec";

export class MerchantMenuRepository {
	readonly #db: DatabaseService;
	readonly #kv: KeyValueService;
	readonly #storage: StorageService;
	readonly #bucket: StorageBucket = "merchant-menu";

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
		return `${CACHE_PREFIXES.MERCHANT_MENU}${id}`;
	}

	private async composeEntity(
		item: MerchantMenuDatabase,
	): Promise<MerchantMenu & { imageId?: string }> {
		const image = item.image
			? this.#storage.getPublicUrl({
					bucket: this.#bucket,
					key: item.image,
				})
			: undefined;

		return {
			...item,
			category: item.category ?? undefined,
			imageId: item.image ?? undefined,
			image,
		};
	}

	private async getFromKV(id: string): Promise<MerchantMenu | undefined> {
		try {
			return await this.#kv.get(this.composeCacheKey(id));
		} catch {
			return undefined;
		}
	}

	private async getFromDB(
		id: string,
	): Promise<(MerchantMenu & { imageId?: string }) | undefined> {
		const result = await this.#db.query.merchantMenu.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});
		return result ? await this.composeEntity(result) : undefined;
	}

	private async setCache(
		id: string,
		data: MerchantMenu | undefined,
	): Promise<void> {
		if (!data) return;
		try {
			await this.#kv.put(this.composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch {}
	}

	private async setTotalRowCache(total: number) {
		try {
			await this.#kv.put(
				this.composeCacheKey("count"),
				{ total },
				{
					expirationTtl: CACHE_TTLS["24h"],
				},
			);
		} catch {}
	}

	private async getTotalRow() {
		try {
			const kvResult = await this.#kv.get<{ total: number }>(
				this.composeCacheKey("count"),
			);
			if (kvResult?.total) return kvResult.total;
			const [dbResult] = await this.#db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu);
			return dbResult.count;
		} catch {
			return undefined;
		}
	}

	async list(
		opts?: GetAllOptions,
	): Promise<{ rows: MerchantMenu[]; totalPages?: number }> {
		try {
			let totalPages: number | undefined;
			let stmt = this.#db.query.merchantMenu.findMany();

			if (opts) {
				const { cursor, page, limit, query, sortBy, order } = opts;

				if (cursor) {
					stmt = this.#db.query.merchantMenu.findMany({
						where: (f, op) => op.gt(f.updatedAt, new Date(cursor)),
						limit: limit + 1,
					});
				} else if (page) {
					const offset = (page - 1) * limit;
					stmt = this.#db.query.merchantMenu.findMany({
						offset,
						limit,
						where: (f, op) => {
							if (!query) return undefined;
							return op.ilike(f.name, `%${query}%`);
						},
						orderBy: (f, op) => {
							if (sortBy) {
								const parse = MerchantMenuSortBySchema.safeParse(sortBy);
								if (!parse.success) return op[order](f.id);
								return op[order](f[parse.data]);
							}
							return op[order](f.id);
						},
					});
					if (!query) {
						const count = (await this.getTotalRow()) ?? 0;
						await this.setTotalRowCache(count);
						totalPages = Math.ceil(count / limit);
					} else {
						try {
							const [dbResult] = await this.#db
								.select({ count: count(tables.merchantMenu.id) })
								.from(tables.merchantMenu)
								.where(ilike(tables.merchantMenu.name, `%${query}%`));
							const dbCount = dbResult.count;
							totalPages = Math.ceil(dbCount / limit);
						} catch {}
					}
				}
			}

			const result = await stmt;
			const rows = await Promise.all(result.map((r) => this.composeEntity(r)));
			return { rows, totalPages };
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list merchant menus");
		}
	}

	async get(id: string, opts?: GetOptions): Promise<MerchantMenu> {
		try {
			if (opts?.fromCache) {
				const cached = await this.getFromKV(id);
				if (cached) return cached;
			}

			const result = await this.getFromDB(id);
			if (!result)
				throw new RepositoryError("Failed to get merchant menu from DB");

			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get merchant menu by id "${id}"`);
		}
	}

	async create(
		item: InsertMerchantMenu & { merchantId: string },
	): Promise<MerchantMenu> {
		try {
			const id = v7();
			const image = item.image;
			const imageKey = image
				? `MM-${id}.${getFileExtension(image)}`
				: undefined;

			const [operation] = await Promise.all([
				this.#db
					.insert(tables.merchantMenu)
					.values({ ...item, id, image: imageKey })
					.returning()
					.then((r) => r[0]),
				image && imageKey
					? this.#storage.upload({
							bucket: this.#bucket,
							key: imageKey,
							file: image,
							isPublic: true,
						})
					: Promise.resolve(),
			]);

			const [result, count] = await Promise.all([
				this.composeEntity(operation),
				this.getTotalRow(),
			]);
			await Promise.all([
				this.setCache(result.id, result),
				this.setTotalRowCache((count ?? 0) + 1),
			]);

			return result;
		} catch (error) {
			log.error(error);
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to create merchant menu");
		}
	}

	async update(
		id: string,
		item: UpdateMerchantMenu & { merchantId: string },
	): Promise<MerchantMenu> {
		try {
			const existing = await this.getFromDB(id);
			if (!existing)
				throw new RepositoryError(`Merchant menu with id "${id}" not found`);

			const upload = item.image
				? this.#storage.upload({
						bucket: this.#bucket,
						key: `MM-${id}.${getFileExtension(item.image)}`,
						file: item.image,
						isPublic: true,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				this.#db
					.update(tables.merchantMenu)
					.set({
						...item,
						image: existing.imageId,
						createdAt: new Date(existing.createdAt),
						updatedAt: new Date(),
					})
					.where(eq(tables.merchantMenu.id, id))
					.returning()
					.then((r) => r[0]),
				upload,
			]);

			const result = await this.composeEntity(operation);
			await this.setCache(id, result);
			return result;
		} catch (error) {
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update merchant menu with id "${id}"`,
			);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const find = await this.getFromDB(id);
			if (!find)
				throw new RepositoryError("Merchant menu not found", {
					code: "NOT_FOUND",
				});

			const count = await this.getTotalRow();

			const [result] = await Promise.all([
				this.#db
					.delete(tables.merchantMenu)
					.where(eq(tables.merchantMenu.id, id))
					.returning({ id: tables.merchantMenu.id }),
				find.imageId
					? this.#storage.delete({ bucket: this.#bucket, key: find.imageId })
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				try {
					await Promise.all([
						this.#kv.delete(this.composeCacheKey(id)),
						this.setTotalRowCache((count ?? 1) - 1),
					]);
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
}

export type MerchantMenuRepositoryType = InstanceType<
	typeof MerchantMenuRepository
>;
