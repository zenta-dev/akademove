import type {
	AccountDeletion,
	InsertAccountDeletion,
	UpdateAccountDeletion,
} from "@repo/schema/account-deletion";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import { nullsToUndefined } from "@repo/shared";
import { and, count, desc, eq, ilike, or } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ORPCContext,
	PartialWithTx,
	UnifiedListResult,
} from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import type { DatabaseService } from "@/core/services/db";
import { tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { log } from "@/utils";

export class AccountDeletionRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("accountDeletion", kv, db);
	}

	static composeEntity(
		item: typeof tables.accountDeletion.$inferSelect,
	): AccountDeletion {
		return nullsToUndefined(item);
	}

	async list(
		query?: UnifiedPaginationQuery & {
			status?: "PENDING" | "REVIEWING" | "APPROVED" | "REJECTED" | "COMPLETED";
			search?: string;
		},
		opts?: PartialWithTx,
	): Promise<UnifiedListResult<AccountDeletion>> {
		try {
			const { limit = 10, cursor, page = 1, status, search } = query ?? {};

			// Build WHERE clause
			const conditions = [];
			if (status) {
				conditions.push(eq(tables.accountDeletion.status, status));
			}
			if (search) {
				conditions.push(
					or(
						ilike(tables.accountDeletion.fullName, `%${search}%`),
						ilike(tables.accountDeletion.email, `%${search}%`),
						ilike(tables.accountDeletion.phone, `%${search}%`),
					),
				);
			}
			const where = conditions.length > 0 ? and(...conditions) : undefined;

			const [items, [totalResult]] = await Promise.all([
				(opts?.tx ?? this.db).query.accountDeletion.findMany({
					where,
					limit,
					offset: cursor ? undefined : (page - 1) * limit,
					orderBy: [desc(tables.accountDeletion.createdAt)],
					with: {
						user: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
						reviewedBy: {
							columns: {
								id: true,
								name: true,
								email: true,
							},
						},
					},
				}),
				(opts?.tx ?? this.db)
					.select({ count: count(tables.accountDeletion.id) })
					.from(tables.accountDeletion)
					.where(where),
			]);

			const total = totalResult?.count ?? 0;
			const totalPages = Math.ceil(total / limit);

			return {
				rows: items.map((item) =>
					AccountDeletionRepository.composeEntity(item),
				),
				pagination: {
					totalPages,
				},
			};
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(id: string, opts?: PartialWithTx): Promise<AccountDeletion> {
		try {
			const fallback = async () => {
				const res = await (opts?.tx ?? this.db).query.accountDeletion.findFirst(
					{
						where: (f, op) => op.eq(f.id, id),
						with: {
							user: {
								columns: {
									id: true,
									name: true,
									email: true,
								},
							},
							reviewedBy: {
								columns: {
									id: true,
									name: true,
									email: true,
								},
							},
						},
					},
				);
				if (!res) {
					throw new RepositoryError("Account deletion request not found", {
						code: "NOT_FOUND",
					});
				}
				const composed = AccountDeletionRepository.composeEntity(res);
				await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
				return composed;
			};
			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(
		data: InsertAccountDeletion,
		opts?: PartialWithTx,
	): Promise<AccountDeletion> {
		try {
			const id = v7();
			const [accountDeletion] = await (opts?.tx ?? this.db)
				.insert(tables.accountDeletion)
				.values({
					id,
					...data,
				})
				.returning();

			if (!accountDeletion) {
				throw new RepositoryError("Failed to create account deletion request", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const composed = AccountDeletionRepository.composeEntity(accountDeletion);
			await this.setCache(id, composed, { expirationTtl: CACHE_TTLS["1h"] });
			log.info(
				{ accountDeletionId: id, email: data.email },
				"[AccountDeletionRepository] Account deletion request created",
			);

			return composed;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		data: UpdateAccountDeletion,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<AccountDeletion> {
		try {
			// Get existing for audit
			const existing = context
				? await (opts?.tx ?? this.db).query.accountDeletion.findFirst({
						where: (f, op) => op.eq(f.id, id),
					})
				: undefined;

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.accountDeletion)
				.set(data)
				.where(eq(tables.accountDeletion.id, id))
				.returning();

			if (!updated) {
				throw new RepositoryError("Account deletion request not found", {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);

			// Audit log
			if (context?.user && existing) {
				await AuditService.logChange(
					{
						tableName: "account_deletion",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: updated,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: "Updated account deletion request",
						},
					},
					context,
					opts,
				);
			}

			log.info(
				{ accountDeletionId: id },
				"[AccountDeletionRepository] Account deletion request updated",
			);

			return AccountDeletionRepository.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async delete(id: string, opts?: PartialWithTx): Promise<boolean> {
		try {
			const result = await (opts?.tx ?? this.db)
				.delete(tables.accountDeletion)
				.where(eq(tables.accountDeletion.id, id))
				.returning();

			if (result.length === 0) {
				throw new RepositoryError("Account deletion request not found", {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);
			log.info(
				{ accountDeletionId: id },
				"[AccountDeletionRepository] Account deletion request deleted",
			);

			return true;
		} catch (error) {
			throw this.handleError(error, "delete");
		}
	}

	async review(
		id: string,
		data: {
			status: "REVIEWING" | "APPROVED" | "REJECTED" | "COMPLETED";
			reviewNotes?: string;
			reviewedById: string;
		},
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<AccountDeletion> {
		try {
			// Get existing for audit
			const existing = context
				? await (opts?.tx ?? this.db).query.accountDeletion.findFirst({
						where: (f, op) => op.eq(f.id, id),
					})
				: undefined;

			const updateData: UpdateAccountDeletion = {
				status: data.status,
				reviewNotes: data.reviewNotes,
				reviewedById: data.reviewedById,
				reviewedAt: new Date(),
			};

			// Set completedAt if status is COMPLETED
			if (data.status === "COMPLETED") {
				updateData.completedAt = new Date();
			}

			const [updated] = await (opts?.tx ?? this.db)
				.update(tables.accountDeletion)
				.set(updateData)
				.where(eq(tables.accountDeletion.id, id))
				.returning();

			if (!updated) {
				throw new RepositoryError("Account deletion request not found", {
					code: "NOT_FOUND",
				});
			}

			await this.deleteCache(id);

			// Audit log
			if (context?.user && existing) {
				await AuditService.logChange(
					{
						tableName: "account_deletion",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: updated,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: `Reviewed with status: ${data.status}`,
						},
					},
					context,
					opts,
				);
			}

			log.info(
				{ accountDeletionId: id, reviewedById: data.reviewedById },
				"[AccountDeletionRepository] Account deletion request reviewed and audited",
			);

			return AccountDeletionRepository.composeEntity(updated);
		} catch (error) {
			throw this.handleError(error, "review");
		}
	}
}
