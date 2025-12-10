import { m } from "@repo/i18n";
import type {
	BannerActionType,
	BannerPlacement,
	BannerTargetAudience,
	InsertBanner,
	UpdateBanner,
} from "@repo/schema/banner";
import { and, desc, eq, or, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, WithUserId } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type {
	Banner,
	BannerDatabase,
	PublicBanner,
} from "@/core/tables/banner";
import { log } from "@/utils";
import type { BannerListQuery } from "./banner-spec";

export class BannerRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("banner", kv, db);
	}

	static composeEntity(item: BannerDatabase): Banner {
		return {
			...item,
			actionType: item.actionType as BannerActionType,
			placement: item.placement as BannerPlacement,
			targetAudience: item.targetAudience as BannerTargetAudience,
			description: item.description ?? undefined,
			actionValue: item.actionValue ?? undefined,
			startAt: item.startAt ?? undefined,
			endAt: item.endAt ?? undefined,
			updatedById: item.updatedById ?? undefined,
		};
	}

	static composePublicEntity(item: BannerDatabase): PublicBanner {
		return {
			id: item.id,
			title: item.title,
			description: item.description ?? undefined,
			imageUrl: item.imageUrl,
			actionType: item.actionType as BannerActionType,
			actionValue: item.actionValue ?? undefined,
			placement: item.placement as BannerPlacement,
			targetAudience: item.targetAudience as BannerTargetAudience,
			isActive: item.isActive,
			priority: item.priority,
			startAt: item.startAt ?? undefined,
			endAt: item.endAt ?? undefined,
		};
	}

	/**
	 * List active banners for public (mobile app) - with caching
	 */
	async listPublic(query: { placement: string }): Promise<PublicBanner[]> {
		try {
			const cacheKey = `public:${query.placement}`;
			const fallback = async () => {
				const now = new Date();
				const result = await this.db.query.banner.findMany({
					where: (f, op) =>
						op.and(
							op.eq(f.isActive, true),
							op.eq(
								f.placement,
								query.placement as
									| "USER_HOME"
									| "DRIVER_HOME"
									| "MERCHANT_HOME",
							),
							// Check date range (null means no restriction)
							op.or(op.isNull(f.startAt), op.lte(f.startAt, now)),
							op.or(op.isNull(f.endAt), op.gte(f.endAt, now)),
						),
					orderBy: (f) => desc(f.priority),
				});
				const banners = result.map((item) =>
					BannerRepository.composePublicEntity(item),
				);
				await this.setCache(cacheKey, banners, {
					expirationTtl: CACHE_TTLS["5m"],
				});
				return banners;
			};
			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			throw this.handleError(error, "list public banners");
		}
	}

	/**
	 * List all banners for admin/operator
	 */
	async list(query: BannerListQuery): Promise<Banner[]> {
		try {
			const { page, limit, placement, targetAudience, isActive, search } =
				query;

			// Build where conditions
			const conditions = [];
			if (placement) {
				conditions.push(eq(tables.banner.placement, placement));
			}
			if (targetAudience) {
				conditions.push(eq(tables.banner.targetAudience, targetAudience));
			}
			if (isActive !== undefined) {
				conditions.push(eq(tables.banner.isActive, isActive));
			}
			if (search) {
				conditions.push(
					or(
						sql`${tables.banner.title} ILIKE ${`%${search}%`}`,
						sql`${tables.banner.description} ILIKE ${`%${search}%`}`,
					),
				);
			}

			const pageNum = page ?? 1;
			const limitNum = limit ?? 10;
			const offset = (pageNum - 1) * limitNum;

			const result = await this.db.query.banner.findMany({
				where: conditions.length > 0 ? and(...conditions) : undefined,
				orderBy: (f) => [desc(f.priority), desc(f.createdAt)],
				offset,
				limit: limitNum,
			});

			return result.map((item) => BannerRepository.composeEntity(item));
		} catch (error) {
			throw this.handleError(error, "list banners");
		}
	}

	/**
	 * Get a single banner by ID
	 */
	async get(id: string): Promise<Banner> {
		try {
			const fallback = async () => {
				const result = await this.db.query.banner.findFirst({
					where: (f, op) => op.eq(f.id, id),
				});
				if (!result) {
					throw new RepositoryError(
						m.error_not_found?.() ?? "Banner not found",
						{
							code: "NOT_FOUND",
						},
					);
				}
				const banner = BannerRepository.composeEntity(result);
				await this.setCache(id, banner, { expirationTtl: CACHE_TTLS["1h"] });
				return banner;
			};
			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get banner");
		}
	}

	/**
	 * Create a new banner
	 */
	async create(
		data: InsertBanner & WithUserId,
		opts?: PartialWithTx,
	): Promise<Banner> {
		try {
			const db = opts?.tx ?? this.db;
			const id = v7();

			const [result] = await db
				.insert(tables.banner)
				.values({
					id,
					title: data.title,
					description: data.description ?? null,
					imageUrl: data.imageUrl,
					actionType: data.actionType,
					actionValue: data.actionValue ?? null,
					placement: data.placement,
					targetAudience: data.targetAudience,
					isActive: data.isActive,
					priority: data.priority,
					startAt: data.startAt ?? null,
					endAt: data.endAt ?? null,
					createdById: data.userId,
				})
				.returning();

			const banner = BannerRepository.composeEntity(result);

			// Invalidate public cache for this placement
			await this.#invalidatePublicCache(data.placement);

			log.info({ bannerId: id }, "[BannerRepository] Banner created");
			return banner;
		} catch (error) {
			throw this.handleError(error, "create banner");
		}
	}

	/**
	 * Update an existing banner
	 */
	async update(
		id: string,
		data: UpdateBanner & WithUserId,
		opts?: PartialWithTx,
	): Promise<Banner> {
		try {
			const db = opts?.tx ?? this.db;

			// Get existing banner to know its placement for cache invalidation
			const existing = await this.db.query.banner.findFirst({
				where: (f, op) => op.eq(f.id, id),
			});
			if (!existing) {
				throw new RepositoryError(m.error_not_found?.() ?? "Banner not found", {
					code: "NOT_FOUND",
				});
			}

			const [result] = await db
				.update(tables.banner)
				.set({
					...data,
					updatedById: data.userId,
					updatedAt: new Date(),
				})
				.where(eq(tables.banner.id, id))
				.returning();

			const banner = BannerRepository.composeEntity(result);

			// Invalidate caches
			await Promise.all([
				this.deleteCache(id),
				this.#invalidatePublicCache(existing.placement),
				// If placement changed, also invalidate the new placement cache
				data.placement && data.placement !== existing.placement
					? this.#invalidatePublicCache(data.placement)
					: Promise.resolve(),
			]);

			log.info({ bannerId: id }, "[BannerRepository] Banner updated");
			return banner;
		} catch (error) {
			throw this.handleError(error, "update banner");
		}
	}

	/**
	 * Delete a banner
	 */
	async delete(id: string, opts?: PartialWithTx): Promise<{ ok: boolean }> {
		try {
			const db = opts?.tx ?? this.db;

			// Get existing banner for cache invalidation
			const existing = await this.db.query.banner.findFirst({
				where: (f, op) => op.eq(f.id, id),
			});
			if (!existing) {
				throw new RepositoryError(m.error_not_found?.() ?? "Banner not found", {
					code: "NOT_FOUND",
				});
			}

			await db.delete(tables.banner).where(eq(tables.banner.id, id));

			// Invalidate caches
			await Promise.all([
				this.deleteCache(id),
				this.#invalidatePublicCache(existing.placement),
			]);

			log.info({ bannerId: id }, "[BannerRepository] Banner deleted");
			return { ok: true };
		} catch (error) {
			throw this.handleError(error, "delete banner");
		}
	}

	/**
	 * Toggle banner active status
	 */
	async toggleActive(
		id: string,
		userId: string,
		opts?: PartialWithTx,
	): Promise<Banner> {
		try {
			const db = opts?.tx ?? this.db;

			const existing = await this.db.query.banner.findFirst({
				where: (f, op) => op.eq(f.id, id),
			});
			if (!existing) {
				throw new RepositoryError(m.error_not_found?.() ?? "Banner not found", {
					code: "NOT_FOUND",
				});
			}

			const [result] = await db
				.update(tables.banner)
				.set({
					isActive: !existing.isActive,
					updatedById: userId,
					updatedAt: new Date(),
				})
				.where(eq(tables.banner.id, id))
				.returning();

			const banner = BannerRepository.composeEntity(result);

			// Invalidate caches
			await Promise.all([
				this.deleteCache(id),
				this.#invalidatePublicCache(existing.placement),
			]);

			log.info(
				{ bannerId: id, isActive: banner.isActive },
				"[BannerRepository] Banner status toggled",
			);
			return banner;
		} catch (error) {
			throw this.handleError(error, "toggle banner status");
		}
	}

	/**
	 * Invalidate public cache for a specific placement
	 */
	async #invalidatePublicCache(placement: string): Promise<void> {
		await this.deleteCache(`public:${placement}`);
	}
}
