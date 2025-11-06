import type {
	InsertMerchantMenu,
	MerchantMenu,
	UpdateMerchantMenu,
} from "@repo/schema/merchant";
import { getFileExtension } from "@repo/shared";
import { count, eq, gt, ilike } from "drizzle-orm";
import { v7 } from "uuid";
import {
	CACHE_PREFIXES,
	CACHE_TTLS,
	type StorageBucket,
} from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { GetAllOptions, GetOptions } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantMenuDatabase } from "@/core/tables/merchant";
import { log } from "@/utils";
import { MerchantMenuSortBySchema } from "./merchant-menu-spec";

interface CountCache {
	total: number;
}

interface ListResult {
	rows: MerchantMenu[];
	totalPages?: number;
}

interface MerchantMenuWithImage extends MerchantMenu {
	imageId?: string;
}

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
	): Promise<MerchantMenuWithImage> {
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

	private async getFromKV(id: string): Promise<MerchantMenu | null> {
		try {
			const cached = await this.#kv.get<MerchantMenu>(this.composeCacheKey(id));
			return cached ?? null;
		} catch (error) {
			log.error({ id, error }, "Failed to get from KV cache");
			return null;
		}
	}

	private async getFromDB(id: string): Promise<MerchantMenuWithImage | null> {
		try {
			const result = await this.#db.query.merchantMenu.findFirst({
				where: eq(tables.merchantMenu.id, id),
			});
			return result ? await this.composeEntity(result) : null;
		} catch (error) {
			log.error({ id, error }, "Failed to get from DB");
			return null;
		}
	}

	private async setCache(id: string, data: MerchantMenu): Promise<void> {
		try {
			await this.#kv.put(this.composeCacheKey(id), data, {
				expirationTtl: CACHE_TTLS["24h"],
			});
		} catch (error) {
			log.error({ id, error }, "Failed to set cache");
		}
	}

	private async setTotalRowCache(total: number): Promise<void> {
		try {
			await this.#kv.put<CountCache>(
				this.composeCacheKey("count"),
				{ total },
				{
					expirationTtl: CACHE_TTLS["24h"],
				},
			);
		} catch (error) {
			log.error({ error }, "Failed to set total row cache");
		}
	}

	private async getTotalRow(): Promise<number> {
		try {
			const kvResult = await this.#kv.get<CountCache>(
				this.composeCacheKey("count"),
			);

			if (kvResult?.total !== undefined) {
				return kvResult.total;
			}

			const [dbResult] = await this.#db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu);

			const total = dbResult?.count ?? 0;
			await this.setTotalRowCache(total);
			return total;
		} catch (error) {
			log.error({ error }, "Failed to get total row count");
			return 0;
		}
	}

	private async getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.#db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu)
				.where(ilike(tables.merchantMenu.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(opts?: GetAllOptions): Promise<ListResult> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query,
				sortBy,
				order = "asc",
			} = opts ?? {};

			if (cursor) {
				const result = await this.#db.query.merchantMenu.findMany({
					where: gt(tables.merchantMenu.updatedAt, new Date(cursor)),
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) => this.composeEntity(r)),
				);
				return { rows };
			}

			if (page !== undefined) {
				const offset = (page - 1) * limit;

				const result = await this.#db.query.merchantMenu.findMany({
					offset,
					limit,
					where: query
						? ilike(tables.merchantMenu.name, `%${query}%`)
						: undefined,
					orderBy: (f, op) => {
						if (sortBy) {
							const parsed = MerchantMenuSortBySchema.safeParse(sortBy);
							const field = parsed.success ? f[parsed.data] : f.id;
							return op[order](field);
						}
						return op[order](f.id);
					},
				});

				const rows = await Promise.all(
					result.map((r) => this.composeEntity(r)),
				);

				const totalCount = query
					? await this.getQueryCount(query)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.#db.query.merchantMenu.findMany();
			const rows = await Promise.all(result.map((r) => this.composeEntity(r)));
			return { rows };
		} catch (error) {
			log.error({ error }, "Failed to list merchant menus");
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
			if (!result) {
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error({ id, error }, "Failed to get merchant menu");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(`Failed to get merchant menu by id "${id}"`);
		}
	}

	async create(
		item: InsertMerchantMenu & { merchantId: string },
	): Promise<MerchantMenu> {
		try {
			const id = v7();
			const imageFile = item.image;
			const imageKey = imageFile
				? `MM-${id}.${getFileExtension(imageFile)}`
				: undefined;

			const [operation] = await Promise.all([
				this.#db
					.insert(tables.merchantMenu)
					.values({ ...item, id, image: imageKey })
					.returning()
					.then((r) => r[0]),
				imageFile && imageKey
					? this.#storage.upload({
							bucket: this.#bucket,
							key: imageKey,
							file: imageFile,
							isPublic: true,
						})
					: Promise.resolve(),
			]);

			if (!operation) {
				throw new RepositoryError("Failed to insert merchant menu into DB");
			}

			const result = await this.composeEntity(operation);
			const currentCount = await this.getTotalRow();

			await Promise.all([
				this.setCache(result.id, result),
				this.setTotalRowCache(currentCount + 1),
			]);

			return result;
		} catch (error) {
			log.error({ error }, "Failed to create merchant menu");
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
			if (!existing) {
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const imageFile = item.image;
			const key = imageFile
				? `MM-${id}.${getFileExtension(imageFile)}`
				: undefined;
			const uploadPromise = imageFile
				? this.#storage.upload({
						bucket: this.#bucket,
						key: key ?? `MM-${id}.${getFileExtension(imageFile)}`,
						file: imageFile,
						isPublic: true,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				this.#db
					.update(tables.merchantMenu)
					.set({
						...item,
						image: existing.imageId ?? key,
						createdAt: new Date(existing.createdAt),
						updatedAt: new Date(),
					})
					.where(eq(tables.merchantMenu.id, id))
					.returning()
					.then((r) => r[0]),
				uploadPromise,
			]);

			if (!operation) {
				throw new RepositoryError("Failed to update merchant menu in DB");
			}

			const result = await this.composeEntity(operation);
			await this.setCache(id, result);
			return result;
		} catch (error) {
			log.error({ id, error }, "Failed to update merchant menu");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to update merchant menu with id "${id}"`,
			);
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const existing = await this.getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const currentCount = await this.getTotalRow();

			const [result] = await Promise.all([
				this.#db
					.delete(tables.merchantMenu)
					.where(eq(tables.merchantMenu.id, id))
					.returning({ id: tables.merchantMenu.id }),
				existing.imageId
					? this.#storage.delete({
							bucket: this.#bucket,
							key: existing.imageId,
						})
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				await Promise.all([
					this.#kv.delete(this.composeCacheKey(id)),
					this.setTotalRowCache(Math.max(0, currentCount - 1)),
				]);
			}
		} catch (error) {
			log.error({ id, error }, "Failed to delete merchant menu");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError(
				`Failed to delete merchant menu with id "${id}"`,
			);
		}
	}
}
