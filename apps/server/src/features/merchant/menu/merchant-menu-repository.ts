import type {
	InsertMerchantMenu,
	MerchantMenu,
	UpdateMerchantMenu,
} from "@repo/schema/merchant";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { getFileExtension } from "@repo/shared";
import { count, eq, gt, ilike } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS, FEATURE_TAGS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { CountCache, ListResult } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { MerchantMenuDatabase } from "@/core/tables/merchant";
import { log, toNumberSafe, toStringNumberSafe } from "@/utils";
import { MerchantMenuSortBySchema } from "./merchant-menu-spec";

interface MerchantMenuWithImage extends MerchantMenu {
	imageId?: string;
}

const BUCKET = "merchant-menu";

export class MerchantMenuRepository extends BaseRepository {
	readonly #storage: StorageService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super(FEATURE_TAGS.MERCHANT_MENU, "merchantMenu", kv, db);
		this.#storage = storage;
	}

	static async composeEntity(
		item: MerchantMenuDatabase,
		storage: StorageService,
	): Promise<MerchantMenuWithImage> {
		const image = item.image
			? storage.getPublicUrl({
					bucket: BUCKET,
					key: item.image,
				})
			: undefined;

		return {
			...item,
			category: item.category ?? undefined,
			imageId: item.image ?? undefined,
			price: toNumberSafe(item.price),
			image,
		};
	}

	async #getFromDB(id: string): Promise<MerchantMenuWithImage | null> {
		try {
			const result = await this.db.query.merchantMenu.findFirst({
				where: eq(tables.merchantMenu.id, id),
			});
			return result
				? await MerchantMenuRepository.composeEntity(result, this.#storage)
				: null;
		} catch (error) {
			log.error({ id, error }, "Failed to get from DB");
			return null;
		}
	}

	async #setTotalRowCache(total: number): Promise<void> {
		try {
			await this.setCache<CountCache>(
				"count",
				{ total },
				{ expirationTtl: CACHE_TTLS["24h"] },
			);
		} catch (error) {
			log.error({ error }, "Failed to set total row cache");
		}
	}

	async #getTotalRow(): Promise<number> {
		try {
			const fallback = async () => {
				const [dbResult] = await this.db
					.select({ count: count(tables.merchantMenu.id) })
					.from(tables.merchantMenu);
				const total = dbResult.count;
				await this.#setTotalRowCache(total);
				return { total };
			};
			const res = await this.getCache<CountCache>("count", { fallback });

			return res.total;
		} catch (error) {
			log.error({ error }, "Failed to get total row count");
			return 0;
		}
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.merchantMenu.id) })
				.from(tables.merchantMenu)
				.where(ilike(tables.merchantMenu.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery,
	): Promise<ListResult<MerchantMenu>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
			} = query ?? {};

			if (cursor) {
				const result = await this.db.query.merchantMenu.findMany({
					where: gt(tables.merchantMenu.updatedAt, new Date(cursor)),
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						MerchantMenuRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page !== undefined) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.merchantMenu.findMany({
					offset,
					limit,
					where: search
						? ilike(tables.merchantMenu.name, `%${search}%`)
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
					result.map((r) =>
						MerchantMenuRepository.composeEntity(r, this.#storage),
					),
				);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.#getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.merchantMenu.findMany();
			const rows = await Promise.all(
				result.map((r) =>
					MerchantMenuRepository.composeEntity(r, this.#storage),
				),
			);
			return { rows };
		} catch (error) {
			log.error({ error }, "Failed to list merchant menus");
			if (error instanceof RepositoryError) throw error;
			throw new RepositoryError("Failed to list merchant menus");
		}
	}

	async get(id: string): Promise<MerchantMenu> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get menu from DB");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
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
				this.db
					.insert(tables.merchantMenu)
					.values({
						...item,
						id,
						image: imageKey,
						price: toStringNumberSafe(item.price),
					})
					.returning()
					.then((r) => r[0]),
				imageFile && imageKey
					? this.#storage.upload({
							bucket: BUCKET,
							key: imageKey,
							file: imageFile,
							isPublic: true,
						})
					: Promise.resolve(),
			]);

			if (!operation) {
				throw new RepositoryError("Failed to insert merchant menu into DB");
			}

			const result = await MerchantMenuRepository.composeEntity(
				operation,
				this.#storage,
			);
			const currentCount = await this.#getTotalRow();

			await Promise.all([
				this.setCache(result.id, result, { expirationTtl: CACHE_TTLS["24h"] }),
				this.#setTotalRowCache(currentCount + 1),
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
			const existing = await this.#getFromDB(id);
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
						bucket: BUCKET,
						key: key ?? `MM-${id}.${getFileExtension(imageFile)}`,
						file: imageFile,
						isPublic: true,
					})
				: Promise.resolve();

			const [operation] = await Promise.all([
				this.db
					.update(tables.merchantMenu)
					.set({
						...item,
						price: item.price ? toStringNumberSafe(item.price) : undefined,
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

			const result = await MerchantMenuRepository.composeEntity(
				operation,
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
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
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`Merchant menu with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			const currentCount = await this.#getTotalRow();

			const [result] = await Promise.all([
				this.db
					.delete(tables.merchantMenu)
					.where(eq(tables.merchantMenu.id, id))
					.returning({ id: tables.merchantMenu.id }),
				existing.imageId
					? this.#storage.delete({
							bucket: BUCKET,
							key: existing.imageId,
						})
					: Promise.resolve(),
			]);

			if (result.length > 0) {
				await Promise.all([
					this.deleteCache(id),
					this.#setTotalRowCache(Math.max(0, currentCount - 1)),
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
