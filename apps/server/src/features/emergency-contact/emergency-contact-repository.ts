import { m } from "@repo/i18n";
import {
	type EmergencyContact,
	EmergencyContactKeySchema,
	type InsertEmergencyContact,
	type UpdateEmergencyContact,
} from "@repo/schema/emergency-contact";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { count, eq, ilike, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
	WithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { EmergencyContactDatabase } from "@/core/tables/emergency-contact";
import { logger } from "@/utils/logger";

export class EmergencyContactRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("emergencyContact", kv, db);
	}

	static composeEntity(item: EmergencyContactDatabase): EmergencyContact {
		return {
			...item,
			description: item.description ?? undefined,
			createdById: item.createdById ?? undefined,
			updatedById: item.updatedById ?? undefined,
		};
	}

	async #getFromDB(
		id: string,
		opts?: PartialWithTx,
	): Promise<EmergencyContact | undefined> {
		const result = await (opts?.tx ?? this.db).query.emergencyContact.findFirst(
			{
				where: (f, op) => op.eq(f.id, id),
			},
		);
		return result
			? EmergencyContactRepository.composeEntity(result)
			: undefined;
	}

	async #getQueryCount(query: string, opts?: PartialWithTx): Promise<number> {
		try {
			const [dbResult] = await (opts?.tx ?? this.db)
				.select({ count: count(tables.emergencyContact.id) })
				.from(tables.emergencyContact)
				.where(ilike(tables.emergencyContact.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			logger.error(
				{ query, error },
				"[EmergencyContactRepository] Failed to get query count",
			);
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery & { isActive?: boolean },
		opts?: PartialWithTx,
	): Promise<ListResult<EmergencyContact>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "desc",
			} = query ?? {};

			const orderBy = (
				f: typeof tables.emergencyContact._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = EmergencyContactKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.createdAt;
					return op[order](field);
				}
				return op[order](f.priority);
			};

			const clauses: SQL[] = [];

			if (search)
				clauses.push(ilike(tables.emergencyContact.name, `%${search}%`));

			if (typeof query?.isActive === "boolean") {
				clauses.push(eq(tables.emergencyContact.isActive, query.isActive));
			}

			if (cursor) {
				const result = await (
					opts?.tx ?? this.db
				).query.emergencyContact.findMany({
					where: (_f, op) =>
						clauses.length > 0 ? op.and(...clauses) : undefined,
					orderBy,
					limit: limit + 1,
				});

				const rows = result.map(EmergencyContactRepository.composeEntity);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await (
					opts?.tx ?? this.db
				).query.emergencyContact.findMany({
					where: (_f, op) =>
						clauses.length > 0 ? op.and(...clauses) : undefined,
					orderBy,
					offset,
					limit,
				});

				const rows = result.map(EmergencyContactRepository.composeEntity);

				const totalCount = search
					? await this.#getQueryCount(search, opts)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await (
				opts?.tx ?? this.db
			).query.emergencyContact.findMany({
				where: (_f, op) =>
					clauses.length > 0 ? op.and(...clauses) : undefined,
				orderBy,
				limit,
			});
			const rows = result.map(EmergencyContactRepository.composeEntity);
			return { rows };
		} catch (error) {
			logger.error(
				{ error },
				"[EmergencyContactRepository] Failed to list emergency contacts",
			);
			return { rows: [] };
		}
	}

	async listActive(opts?: PartialWithTx): Promise<EmergencyContact[]> {
		try {
			const cacheKey = "active_contacts";
			const fallback = async () => {
				const result = await (
					opts?.tx ?? this.db
				).query.emergencyContact.findMany({
					where: (f, op) => op.eq(f.isActive, true),
					orderBy: (f, op) => op.asc(f.priority),
				});
				const contacts = result.map(EmergencyContactRepository.composeEntity);
				await this.setCache(cacheKey, contacts, {
					expirationTtl: CACHE_TTLS["5m"],
				});
				return contacts;
			};
			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			logger.error(
				{ error },
				"[EmergencyContactRepository] Failed to list active emergency contacts",
			);
			return [];
		}
	}

	/**
	 * Get primary (highest priority) active emergency contact for WhatsApp redirect
	 */
	async getPrimary(opts?: PartialWithTx): Promise<EmergencyContact | null> {
		try {
			const cacheKey = "primary_contact";
			const fallback = async () => {
				const result = await (
					opts?.tx ?? this.db
				).query.emergencyContact.findFirst({
					where: (f, op) => op.eq(f.isActive, true),
					orderBy: (f, op) => op.asc(f.priority),
				});
				const contact = result
					? EmergencyContactRepository.composeEntity(result)
					: null;
				await this.setCache(cacheKey, contact, {
					expirationTtl: CACHE_TTLS["5m"],
				});
				return contact;
			};
			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			logger.error(
				{ error },
				"[EmergencyContactRepository] Failed to get primary emergency contact",
			);
			return null;
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<EmergencyContact> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id, opts);
				if (!res) {
					throw new RepositoryError(m.error_emergency_contact_not_found(), {
						code: "NOT_FOUND",
					});
				}
				await this.setCache(id, res, { expirationTtl: CACHE_TTLS["1h"] });
				return res;
			};
			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async createContact(
		item: InsertEmergencyContact,
		userId: string,
		opts: WithTx,
	): Promise<EmergencyContact> {
		try {
			const values: Record<string, unknown> = {
				id: v7(),
				name: item.name,
				phone: item.phone,
				description: item.description,
				isActive: item.isActive ?? true,
				priority: item.priority ?? 0,
				createdById: userId,
				updatedById: userId,
			};

			const [operation] = await (opts.tx ?? this.db)
				.insert(tables.emergencyContact)
				.values(values as never)
				.returning();

			if (!operation) {
				throw new RepositoryError(m.error_failed_create_emergency_contact(), {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const result = EmergencyContactRepository.composeEntity(operation);

			logger.info(
				{ emergencyContactId: result.id, userId },
				"[EmergencyContactRepository] Emergency contact created",
			);

			// Invalidate caches
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["1h"],
			});
			await this.deleteCache("count");
			await this.deleteCache("active_contacts");
			await this.deleteCache("primary_contact");

			return result;
		} catch (error) {
			logger.error(
				{ item, error },
				"[EmergencyContactRepository] Failed to create emergency contact",
			);
			throw this.handleError(error, "create");
		}
	}

	async updateContact(
		id: string,
		item: UpdateEmergencyContact,
		userId: string,
		opts: WithTx,
	): Promise<EmergencyContact> {
		try {
			const updateData: Record<string, unknown> = {
				...item,
				updatedById: userId,
			};

			const [operation] = await (opts.tx ?? this.db)
				.update(tables.emergencyContact)
				.set(updateData)
				.where(eq(tables.emergencyContact.id, id))
				.returning();

			if (!operation) {
				throw new RepositoryError(m.error_emergency_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const result = EmergencyContactRepository.composeEntity(operation);

			logger.info(
				{ emergencyContactId: id, updates: item, userId },
				"[EmergencyContactRepository] Emergency contact updated",
			);

			// Invalidate caches
			await this.deleteCache(id);
			await this.deleteCache("active_contacts");
			await this.deleteCache("primary_contact");

			return result;
		} catch (error) {
			logger.error(
				{ id, item, error },
				"[EmergencyContactRepository] Failed to update emergency contact",
			);
			throw this.handleError(error, "update");
		}
	}

	async deleteContact(id: string, opts: WithTx): Promise<{ ok: boolean }> {
		try {
			const result = await (opts.tx ?? this.db)
				.delete(tables.emergencyContact)
				.where(eq(tables.emergencyContact.id, id))
				.returning();

			if (!result || result.length === 0) {
				throw new RepositoryError(m.error_emergency_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			logger.info(
				{ emergencyContactId: id },
				"[EmergencyContactRepository] Emergency contact deleted",
			);

			// Invalidate caches
			await this.deleteCache(id);
			await this.deleteCache("count");
			await this.deleteCache("active_contacts");
			await this.deleteCache("primary_contact");

			return { ok: true };
		} catch (error) {
			logger.error(
				{ id, error },
				"[EmergencyContactRepository] Failed to delete emergency contact",
			);
			throw this.handleError(error, "delete");
		}
	}

	async toggleActive(
		id: string,
		userId: string,
		opts: WithTx,
	): Promise<EmergencyContact> {
		try {
			// Get current contact
			const current = await this.get(id, opts);

			// Toggle active status
			const [operation] = await (opts.tx ?? this.db)
				.update(tables.emergencyContact)
				.set({
					isActive: !current.isActive,
					updatedById: userId,
				})
				.where(eq(tables.emergencyContact.id, id))
				.returning();

			if (!operation) {
				throw new RepositoryError(m.error_emergency_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const result = EmergencyContactRepository.composeEntity(operation);

			logger.info(
				{ emergencyContactId: id, isActive: result.isActive, userId },
				"[EmergencyContactRepository] Emergency contact toggled",
			);

			// Invalidate caches
			await this.deleteCache(id);
			await this.deleteCache("active_contacts");
			await this.deleteCache("primary_contact");

			return result;
		} catch (error) {
			logger.error(
				{ id, error },
				"[EmergencyContactRepository] Failed to toggle emergency contact",
			);
			throw this.handleError(error, "toggle active");
		}
	}
}
