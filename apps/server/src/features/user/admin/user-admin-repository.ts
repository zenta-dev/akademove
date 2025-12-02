import { randomBytes } from "node:crypto";
import type { UnifiedPaginationQuery } from "@repo/schema/pagination";
import {
	type AdminUpdateUser,
	type InsertUser,
	type User,
	UserKeySchema,
} from "@repo/schema/user";
import { count, eq, gt, ilike, ne, type SQL } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import { S3StorageService, type StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import { UserBadgeRepository } from "@/features/badge/user/user-badge-repository";
import { log } from "@/utils";

const BUCKET = "user";

export class UserAdminRepository extends BaseRepository {
	#storage: StorageService;
	#pw?: typeof import("@/utils/password").PasswordManager.prototype;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		pw?: typeof import("@/utils/password").PasswordManager.prototype,
	) {
		super("user", kv, db);
		this.#storage = storage;
		this.#pw = pw;
	}

	static async composeEntity(
		user: UserDatabase & {
			userBadges: DetailedUserBadgeDatabase[];
		},
		storage: StorageService,
		options?: { expiresIn?: number },
	): Promise<User> {
		let image: string | undefined;
		if (user.image) {
			image = await storage.getPresignedUrl({
				bucket: BUCKET,
				key: user.image,
				expiresIn: options?.expiresIn,
			});
		}
		return {
			...user,
			image,
			banReason: user.banReason ?? undefined,
			banExpires: user.banExpires ?? undefined,
			gender: user.gender ?? undefined,
			userBadges: user.userBadges.map((e) =>
				UserBadgeRepository.composeEntity(e, storage),
			),
		};
	}

	async #getFromDB(id: string): Promise<User | undefined> {
		const result = await this.db.query.user.findFirst({
			with: { userBadges: { with: { badge: true } } },
			where: (f, op) => op.eq(f.id, id),
		});
		return result
			? UserAdminRepository.composeEntity(result, this.#storage, {
					expiresIn: S3StorageService.ONE_DAY_PRESIGNED_URL_EXPIRY,
				})
			: undefined;
	}

	async #getQueryCount(query: string): Promise<number> {
		try {
			const [dbResult] = await this.db
				.select({ count: count(tables.user.id) })
				.from(tables.user)
				.where(ilike(tables.user.name, `%${query}%`));

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(
		query?: UnifiedPaginationQuery & { requesterId: string },
	): Promise<ListResult<User>> {
		try {
			const orderBy = (
				f: typeof tables.user._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = UserKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
				requesterId,
			} = query ?? {};

			const clauses: SQL[] = [];
			if (requesterId) clauses.push(ne(tables.user.id, requesterId));

			if (cursor) {
				clauses.push(gt(tables.user.updatedAt, new Date(cursor)));

				const result = await this.db.query.user.findMany({
					with: { userBadges: { with: { badge: true } } },
					where: (_f, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						UserAdminRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				if (search) clauses.push(ilike(tables.user.name, `%${search}%`));

				const result = await this.db.query.user.findMany({
					with: { userBadges: { with: { badge: true } } },
					where: (_f, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = await Promise.all(
					result.map((r) =>
						UserAdminRepository.composeEntity(r, this.#storage),
					),
				);

				const totalCount = search
					? await this.#getQueryCount(search)
					: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.user.findMany({
				with: { userBadges: { with: { badge: true } } },
				where: (_f, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = await Promise.all(
				result.map((r) => UserAdminRepository.composeEntity(r, this.#storage)),
			);
			return { rows };
		} catch (error) {
			throw this.handleError(error, "list");
		}
	}

	async get(id: string): Promise<User> {
		try {
			const fallback = async () => {
				const res = await this.#getFromDB(id);
				if (!res) throw new RepositoryError("Failed to get driver from DB");
				await this.setCache(id, res);
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async create(item: InsertUser): Promise<User & { password: string }> {
		try {
			// Check if user already exists
			const existingUser = await this.db.query.user.findFirst({
				columns: { email: true, phone: true },
				where: (f, op) =>
					op.or(op.eq(f.email, item.email), op.eq(f.phone, item.phone)),
			});

			if (existingUser) {
				throw new RepositoryError("Email or phone already registered", {
					code: "CONFLICT",
				});
			}

			const userId = this.#generateId();

			// Create user with role, no image for admin-created users
			const [user] = await this.db
				.insert(tables.user)
				.values({
					id: userId,
					name: item.name,
					email: item.email,
					phone: item.phone,
					role: item.role,
					gender: item.gender,
					image: null,
					emailVerified: false,
					banned: false,
					banReason: null,
					banExpires: null,
				})
				.returning();

			// Create account with hashed password
			if (!this.#pw) {
				throw new RepositoryError("Password manager not available", {
					code: "INTERNAL_SERVER_ERROR",
				});
			}
			const hashedPassword = this.#pw.hash(item.password);

			await this.db.insert(tables.account).values({
				id: this.#generateId(),
				accountId: this.#generateId(),
				userId: user.id,
				providerId: "credentials",
				password: hashedPassword,
			});

			// Create wallet
			await this.db.insert(tables.wallet).values({
				id: v7(),
				userId: user.id,
				balance: "0",
			});

			const composedUser = await UserAdminRepository.composeEntity(
				{ ...user, userBadges: [] },
				this.#storage,
			);

			log.info(
				{ userId: user.id, email: user.email, role: user.role },
				"[UserAdminRepository] User created successfully",
			);

			return { ...composedUser, password: item.password };
		} catch (error) {
			log.error({ error }, "[UserAdminRepository] Failed to create user");
			throw this.handleError(error, "create");
		}
	}

	#generateId(): string {
		return randomBytes(32).toString("hex");
	}

	async update(
		id: string,
		item: AdminUpdateUser,
		opts: PartialWithTx,
		_header: Headers,
	): Promise<User> {
		try {
			const existing = await this.#getFromDB(id);
			if (!existing) {
				throw new RepositoryError(`User with id "${id}" not found`, {
					code: "NOT_FOUND",
				});
			}

			return await (opts.tx ?? this.db).transaction(async (tx) => {
				let updatedUser = existing;

				// Handle role updates
				if ("role" in item) {
					const [updated] = await tx
						.update(tables.user)
						.set({ role: item.role })
						.where(eq(tables.user.id, id))
						.returning();

					if (!updated) {
						throw new RepositoryError("Failed to update user role", {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					const refreshed = await tx.query.user.findFirst({
						with: { userBadges: { with: { badge: true } } },
						where: (f, op) => op.eq(f.id, id),
					});
					if (!refreshed) {
						throw new RepositoryError("Failed to fetch updated user");
					}
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed,
						this.#storage,
					);

					log.info(
						{ userId: id, newRole: item.role },
						"[UserAdminRepository] User role updated",
					);
				}

				// Handle password updates
				if ("newPassword" in item) {
					if (!this.#pw) {
						throw new RepositoryError("Password manager not available", {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					// Get account to verify old password
					const account = await tx.query.account.findFirst({
						where: (f, op) =>
							op.and(op.eq(f.userId, id), op.eq(f.providerId, "credentials")),
					});

					if (!account) {
						throw new RepositoryError("User account not found", {
							code: "NOT_FOUND",
						});
					}

					// Verify old password
					const isValid = this.#pw.verify(
						account.password ?? "",
						item.oldPassword,
					);
					if (!isValid) {
						throw new RepositoryError("Invalid old password", {
							code: "UNAUTHORIZED",
						});
					}

					// Hash and update new password
					const hashedPassword = this.#pw.hash(item.newPassword);
					await tx
						.update(tables.account)
						.set({ password: hashedPassword })
						.where(eq(tables.account.id, account.id));

					log.info(
						{ userId: id },
						"[UserAdminRepository] User password updated",
					);
				}

				// Handle ban
				if ("banReason" in item) {
					const banExpires = item.banExpiresIn
						? new Date(Date.now() + item.banExpiresIn)
						: null;

					const [updated] = await tx
						.update(tables.user)
						.set({
							banned: true,
							banReason: item.banReason,
							banExpires,
						})
						.where(eq(tables.user.id, id))
						.returning();

					if (!updated) {
						throw new RepositoryError("Failed to ban user", {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					const refreshed = await tx.query.user.findFirst({
						with: { userBadges: { with: { badge: true } } },
						where: (f, op) => op.eq(f.id, id),
					});
					if (!refreshed) {
						throw new RepositoryError("Failed to fetch updated user");
					}
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed,
						this.#storage,
					);

					log.info(
						{ userId: id, banReason: item.banReason },
						"[UserAdminRepository] User banned",
					);
				}

				// Handle unban
				if ("id" in item && Object.keys(item).length === 1) {
					// UnbanUserSchema only has 'id' field
					const [updated] = await tx
						.update(tables.user)
						.set({
							banned: false,
							banReason: null,
							banExpires: null,
						})
						.where(eq(tables.user.id, id))
						.returning();

					if (!updated) {
						throw new RepositoryError("Failed to unban user", {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					const refreshed = await tx.query.user.findFirst({
						with: { userBadges: { with: { badge: true } } },
						where: (f, op) => op.eq(f.id, id),
					});
					if (!refreshed) {
						throw new RepositoryError("Failed to fetch updated user");
					}
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed,
						this.#storage,
					);

					log.info({ userId: id }, "[UserAdminRepository] User unbanned");
				}

				// Invalidate cache
				await this.deleteCache(id);

				return updatedUser;
			});
		} catch (error) {
			log.error(
				{ error, userId: id },
				"[UserAdminRepository] Failed to update user",
			);
			throw this.handleError(error, "update");
		}
	}

	async remove(id: string): Promise<void> {
		try {
			const result = await this.db
				.delete(tables.user)
				.where(eq(tables.user.id, id))
				.returning({ id: tables.user.id });

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}

	async getDashboardStats(): Promise<{
		totalUsers: number;
		totalDrivers: number;
		totalMerchants: number;
		activeOrders: number;
		totalOrders: number;
		completedOrders: number;
		cancelledOrders: number;
		totalRevenue: number;
		todayRevenue: number;
		todayOrders: number;
		onlineDrivers: number;
	}> {
		try {
			const cacheKey = "dashboard-stats";
			const fallback = async () => {
				const today = new Date();
				today.setHours(0, 0, 0, 0);

				const result = await this.db.execute<{
					total_users: number;
					total_drivers: number;
					total_merchants: number;
					active_orders: number;
					total_orders: number;
					completed_orders: number;
					cancelled_orders: number;
					total_revenue: string;
					today_revenue: string;
					today_orders: number;
					online_drivers: number;
				}>(/* sql */ `
					SELECT
						(SELECT COUNT(*)::int FROM am_users WHERE role = 'USER') AS total_users,
						(SELECT COUNT(*)::int FROM am_drivers) AS total_drivers,
						(SELECT COUNT(*)::int FROM am_merchants) AS total_merchants,
						(SELECT COUNT(*)::int FROM am_orders WHERE status NOT IN ('COMPLETED', 'CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM')) AS active_orders,
						(SELECT COUNT(*)::int FROM am_orders) AS total_orders,
						(SELECT COUNT(*)::int FROM am_orders WHERE status = 'COMPLETED') AS completed_orders,
						(SELECT COUNT(*)::int FROM am_orders WHERE status IN ('CANCELLED_BY_USER', 'CANCELLED_BY_DRIVER', 'CANCELLED_BY_SYSTEM')) AS cancelled_orders,
						(SELECT COALESCE(SUM(total_price), 0)::text FROM am_orders WHERE status = 'COMPLETED') AS total_revenue,
						(SELECT COALESCE(SUM(total_price), 0)::text FROM am_orders WHERE status = 'COMPLETED' AND created_at >= '${today.toISOString()}') AS today_revenue,
						(SELECT COUNT(*)::int FROM am_orders WHERE created_at >= '${today.toISOString()}') AS today_orders,
						(SELECT COUNT(*)::int FROM am_drivers WHERE is_online = true) AS online_drivers
				`);

				const row = result[0];
				if (!row) {
					throw new RepositoryError("Failed to get dashboard stats", {
						code: "NOT_FOUND",
					});
				}

				const stats = {
					totalUsers: row.total_users,
					totalDrivers: row.total_drivers,
					totalMerchants: row.total_merchants,
					activeOrders: row.active_orders,
					totalOrders: row.total_orders,
					completedOrders: row.completed_orders,
					cancelledOrders: row.cancelled_orders,
					totalRevenue: Number.parseFloat(row.total_revenue),
					todayRevenue: Number.parseFloat(row.today_revenue),
					todayOrders: row.today_orders,
					onlineDrivers: row.online_drivers,
				};

				// Cache for 5 minutes
				await this.setCache(cacheKey, stats, {
					expirationTtl: 300,
				});

				return stats;
			};

			return await this.getCache(cacheKey, { fallback });
		} catch (error) {
			log.error(
				{ error },
				"[UserAdminRepository] Failed to get dashboard stats",
			);
			throw this.handleError(error, "get dashboard stats");
		}
	}
}
