import {
	type Badge,
	BadgeKeySchema,
	type InsertBadge,
	type UpdateBadge,
} from "@repo/schema/badge";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { getFileExtension, nullsToUndefined } from "@repo/shared";
import { count, eq, gt, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { BadgeDatabase } from "@/core/tables/badge";
import { log } from "@/utils";

const BUCKET = "badges";

export class BadgeRepository extends BaseRepository {
	readonly #storage: StorageService;
	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("badge", kv, db);
		this.#storage = storage;
	}

	static composeEntity(item: BadgeDatabase, storage: StorageService): Badge {
		if (item.icon) {
			item.icon = storage.getPublicUrl({
				key: item.icon,
				bucket: BUCKET,
			});
		}
		return nullsToUndefined(item);
	}

	async #getFromDB(id: string, opts?: WithTx): Promise<Badge | undefined> {
		const tx = opts?.tx ?? this.db;
		const result = await tx.query.badge.findFirst({
			where: (f, op) => op.eq(f.id, id),
		});

		return result
			? BadgeRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.badge.id) })
				.from(tables.badge)
				.where(ilike(tables.badge.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: UnifiedPaginationQuery): Promise<ListResult<Badge>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.badge._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = BadgeKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.badge.name, `%${query}%`));

			if (cursor) {
				clauses.push(gt(tables.badge.createdAt, new Date(cursor)));

				const res = await this.db.query.badge.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = res.map((r) =>
					BadgeRepository.composeEntity(r, this.#storage),
				);

				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const res = await this.db.query.badge.findMany({
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = res.map((r) =>
					BadgeRepository.composeEntity(r, this.#storage),
				);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const res = await this.db.query.badge.findMany({
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit: limit,
			});

			const rows = res.map((r) =>
				BadgeRepository.composeEntity(r, this.#storage),
			);

			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async get(id: string, opts?: WithTx): Promise<Badge> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) throw new RepositoryError("Failed to get badge from db");
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async getByCode(code: string, opts?: WithTx): Promise<Badge> {
		try {
			const fallback = async () => {
				const tx = opts?.tx ?? this.db;
				const result = await tx.query.badge.findFirst({
					where: (f, op) => op.eq(f.code, code),
				});
				const res = result
					? BadgeRepository.composeEntity(result, this.#storage)
					: undefined;
				if (!res) throw new RepositoryError("Failed to get badge from db");
				await this.setCache(code, res, { expirationTtl: CACHE_TTLS["24h"] });
				return res;
			};

			const result = await this.getCache(code, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by code");
		}
	}

	async create(item: InsertBadge, opts?: WithTx): Promise<Badge> {
		try {
			let iconKey: string | undefined;

			if (item.icon) {
				const extension = getFileExtension(item.icon);
				iconKey = `${item.code}.${extension}`;
			}

			const tx = opts?.tx ?? this.db;
			const [operation] = await Promise.all([
				tx
					.insert(tables.badge)
					.values({
						...item,
						icon: iconKey,
						id: v7(),
						createdAt: new Date(),
					})
					.returning()
					.then(([r]) => r),
				item.icon &&
					iconKey &&
					this.#storage.upload({
						bucket: BUCKET,
						key: iconKey,
						file: item.icon,
					}),
			]);

			const result = BadgeRepository.composeEntity(operation, this.#storage);
			await this.setCache(result.id, result);
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateBadge, opts?: WithTx): Promise<Badge> {
		try {
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Badge with id "${id}" not found`);

			let iconKey: string | undefined;

			if (item.icon) {
				const extension = getFileExtension(item.icon);
				iconKey = `${item.code ?? existing.code}.${extension}`;
			}

			const tx = opts?.tx ?? this.db;
			const [operation] = await Promise.all([
				tx
					.update(tables.badge)
					.set({
						...item,
						icon: iconKey,
					})
					.where(eq(tables.badge.id, id))
					.returning()
					.then(([r]) => r),
				this.deleteCache(existing.code),
				item.icon &&
					iconKey &&
					this.#storage.upload({
						bucket: BUCKET,
						key: iconKey,
						file: item.icon,
					}),
			]);

			const result = BadgeRepository.composeEntity(operation, this.#storage);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.badge)
				.where(eq(tables.badge.id, id))
				.returning({ id: tables.badge.id, code: tables.badge.code })
				.then(([r]) => r);

			await Promise.all([this.deleteCache(id), this.deleteCache(result.code)]);
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}
}
