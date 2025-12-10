import type {
	InsertQuickMessageTemplate,
	ListQuickMessageQuery,
	QuickMessageTemplate,
	UpdateQuickMessageTemplate,
} from "@repo/schema/quick-message";
import { eq, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { QuickMessageTemplateDatabase } from "@/core/tables/quick-message";
import { logger } from "@/utils/logger";
import { QuickMessageCacheService } from "./services";

export class QuickMessageRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("quickMessageTemplate", kv, db);
	}

	static composeEntity(
		item: QuickMessageTemplateDatabase,
	): QuickMessageTemplate {
		return {
			...item,
			role: item.role as "ADMIN" | "OPERATOR" | "MERCHANT" | "DRIVER" | "USER",
			orderType: (item.orderType as "RIDE" | "DELIVERY" | "FOOD") ?? null,
		};
	}

	async listTemplates(
		query: ListQuickMessageQuery,
		opts?: PartialWithTx,
	): Promise<QuickMessageTemplate[]> {
		try {
			const cacheKey = QuickMessageCacheService.generateListCacheKey(query);

			const fallback = async () => {
				const { role, orderType, locale, isActive } = query;
				const tx = opts?.tx ?? this.db;

				const conditions: SQL[] = [];
				if (role) conditions.push(eq(tables.quickMessageTemplate.role, role));
				if (orderType)
					conditions.push(eq(tables.quickMessageTemplate.orderType, orderType));
				if (locale)
					conditions.push(eq(tables.quickMessageTemplate.locale, locale));
				if (isActive !== undefined)
					conditions.push(eq(tables.quickMessageTemplate.isActive, isActive));

				const res = await tx.query.quickMessageTemplate.findMany({
					where: (_, op) =>
						conditions.length > 0 ? op.and(...conditions) : undefined,
					orderBy: (f, op) => [op.asc(f.displayOrder), op.asc(f.createdAt)],
				});

				await this.setCache(cacheKey, res, {
					expirationTtl: CACHE_TTLS["1h"],
				});

				return res;
			};

			const res = await this.getCache(cacheKey, { fallback });

			return res.map(QuickMessageRepository.composeEntity);
		} catch (error) {
			logger.error(
				{ error, query },
				"[QuickMessageRepository] Failed to list templates",
			);
			throw this.handleError(error, "list");
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<QuickMessageTemplate> {
		try {
			const fallback = async () => {
				const tx = opts?.tx ?? this.db;
				const res = await tx.query.quickMessageTemplate.findFirst({
					where: (f, op) => op.eq(f.id, id),
				});

				if (!res) {
					throw new RepositoryError("Quick message template not found", {
						code: "NOT_FOUND",
					});
				}

				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });

				return res;
			};

			const res = await this.getCache(id, { fallback });

			return QuickMessageRepository.composeEntity(res);
		} catch (error) {
			logger.error(
				{ error, id },
				"[QuickMessageRepository] Failed to get template",
			);
			throw this.handleError(error, "get");
		}
	}

	async create(
		data: InsertQuickMessageTemplate,
		opts: WithTx,
	): Promise<QuickMessageTemplate> {
		try {
			const now = new Date();
			const id = v7();

			const [res] = await opts.tx
				.insert(tables.quickMessageTemplate)
				.values({
					...data,
					id,
					createdAt: now,
					updatedAt: now,
				})
				.returning();

			// Invalidate list cache
			const invalidationPatterns =
				QuickMessageCacheService.generateInvalidationPatterns(
					data.role,
					data.orderType,
					data.locale,
				);
			await Promise.all(
				invalidationPatterns.map((pattern) => this.deleteCache(pattern)),
			);

			logger.info(
				{ templateId: res.id, role: data.role },
				"[QuickMessageRepository] Template created",
			);

			return QuickMessageRepository.composeEntity(res);
		} catch (error) {
			logger.error(
				{ error, data },
				"[QuickMessageRepository] Failed to create template",
			);
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		data: UpdateQuickMessageTemplate,
		opts: WithTx,
	): Promise<QuickMessageTemplate> {
		try {
			const [res] = await opts.tx
				.update(tables.quickMessageTemplate)
				.set({ ...data, updatedAt: new Date() })
				.where(eq(tables.quickMessageTemplate.id, id))
				.returning();

			if (!res) {
				throw new RepositoryError("Quick message template not found", {
					code: "NOT_FOUND",
				});
			}

			// Invalidate caches
			await Promise.all([
				this.deleteCache(id),
				this.deleteCache(QuickMessageCacheService.generateWildcardPattern()),
			]);

			logger.info(
				{ templateId: id },
				"[QuickMessageRepository] Template updated",
			);

			return QuickMessageRepository.composeEntity(res);
		} catch (error) {
			logger.error(
				{ error, id, data },
				"[QuickMessageRepository] Failed to update template",
			);
			throw this.handleError(error, "update");
		}
	}

	async delete(id: string, opts: WithTx): Promise<void> {
		try {
			const deleted = await opts.tx
				.delete(tables.quickMessageTemplate)
				.where(eq(tables.quickMessageTemplate.id, id))
				.returning();

			if (deleted.length === 0) {
				throw new RepositoryError("Quick message template not found", {
					code: "NOT_FOUND",
				});
			}

			// Invalidate caches
			await Promise.all([
				this.deleteCache(id),
				this.deleteCache(QuickMessageCacheService.generateWildcardPattern()),
			]);

			logger.info(
				{ templateId: id },
				"[QuickMessageRepository] Template deleted",
			);
		} catch (error) {
			logger.error(
				{ error, id },
				"[QuickMessageRepository] Failed to delete template",
			);
			throw this.handleError(error, "delete");
		}
	}
}
