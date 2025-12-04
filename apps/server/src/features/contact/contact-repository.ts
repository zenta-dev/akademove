import { m } from "@repo/i18n";
import type {
	Contact,
	InsertContact,
	UpdateContact,
} from "@repo/schema/contact";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { count, desc, eq } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { PartialWithTx, UnifiedListResult } from "@/core/interface";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { log } from "@/utils";
import { ContactResponseService, ContactSearchService } from "./services";

export class ContactRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("contact", kv, db);
	}

	static composeEntity(item: typeof tables.contact.$inferSelect): Contact {
		return nullsToUndefined(item);
	}

	async list(
		query?: UnifiedPaginationQuery & {
			status?: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
			search?: string;
		},
		opts?: PartialWithTx,
	): Promise<UnifiedListResult<Contact>> {
		try {
			const { limit = 10, cursor, page = 1, status, search } = query ?? {};

			// Use service to build WHERE clause
			const where = ContactSearchService.buildWhereClause({ status, search });

			const [items, [totalResult]] = await Promise.all([
				(opts?.tx ?? this.db).query.contact.findMany({
					where,
					limit,
					offset: cursor ? undefined : (page - 1) * limit,
					orderBy: [desc(tables.contact.createdAt)],
					with: {
						user: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
						respondedBy: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
					},
				}),
				(opts?.tx ?? this.db)
					.select({ count: count(tables.contact.id) })
					.from(tables.contact)
					.where(where),
			]);

			const total = totalResult?.count ?? 0;
			const totalPages = Math.ceil(total / limit);

			return {
				rows: items.map((item) => ContactRepository.composeEntity(item)),
				pagination: {
					totalPages,
				},
			};
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<Contact> {
		try {
			const fallback = async () => {
				const res = await (opts?.tx ?? this.db).query.contact.findFirst({
					where: (f, op) => op.eq(f.id, id),
					with: {
						user: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
						respondedBy: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
					},
				});
				if (!res) {
					throw new RepositoryError(m.error_contact_not_found(), {
						code: "NOT_FOUND",
					});
				}
				const composed = ContactRepository.composeEntity(res);
				await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
				return composed;
			};
			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(data: InsertContact, opts?: PartialWithTx): Promise<Contact> {
		try {
			const id = v7();
			const [contact] = await (opts?.tx ?? this.db)
				.insert(tables.contact)
				.values({
					id,
					...data,
				})
				.returning();

			if (!contact) {
				throw new RepositoryError(m.error_failed_create_contact(), {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const composed = ContactRepository.composeEntity(contact);
			await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
			log.info(
				{ contactId: id, userId: data.userId },
				"[ContactRepository] Contact created",
			);

			return composed;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		data: UpdateContact,
		opts?: PartialWithTx,
	): Promise<Contact> {
		try {
			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.contact)
				.set(data)
				.where(eq(tables.contact.id, id))
				.returning();

			if (!updated) {
				throw new RepositoryError(m.error_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);
			log.info({ contactId: id }, "[ContactRepository] Contact updated");

			return ContactRepository.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async delete(id: string, opts?: PartialWithTx): Promise<boolean> {
		try {
			const result = await (opts?.tx ?? this.db)
				.delete(tables.contact)
				.where(eq(tables.contact.id, id))
				.returning();

			if (result.length === 0) {
				throw new RepositoryError(m.error_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);
			log.info({ contactId: id }, "[ContactRepository] Contact deleted");

			return true;
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}

	async respond(
		id: string,
		data: {
			response: string;
			status: "PENDING" | "REVIEWING" | "RESOLVED" | "CLOSED";
			respondedById: string;
		},
		opts?: PartialWithTx,
	): Promise<Contact> {
		try {
			const responseData = ContactResponseService.prepareResponseData(
				data.response,
				data.status,
				data.respondedById,
			);

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.contact)
				.set(responseData)
				.where(eq(tables.contact.id, id))
				.returning();

			if (!updated) {
				throw new RepositoryError(m.error_contact_not_found(), {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);
			log.info(
				{ contactId: id, respondedById: data.respondedById },
				"[ContactRepository] Contact responded",
			);

			return ContactRepository.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "respond");
		}
	}
}
