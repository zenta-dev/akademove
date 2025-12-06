import { m } from "@repo/i18n";
import type { UserListQuery } from "@repo/schema/pagination";
import type { AdminUpdateUser, InviteUser, User } from "@repo/schema/user";
import {
	eq,
	gt,
	gte,
	ilike,
	inArray,
	lte,
	ne,
	or,
	type SQL,
} from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { RepositoryError } from "@/core/error";
import type { ListResult, ORPCContext, PartialWithTx } from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { MailService } from "@/core/services/mail";
import { S3StorageService, type StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import { UserBadgeRepository } from "@/features/badge/user/user-badge-repository";
import {
	DashboardStatsService,
	PasswordChangeService,
	UserBanService,
	UserIdService,
	UserListQueryService,
	UserRefreshService,
	UserSearchService,
} from "@/features/user/services";
import { log } from "@/utils";
import type { PasswordManager } from "@/utils/password";

const BUCKET = "user";

export class UserAdminRepository extends BaseRepository {
	#storage: StorageService;
	#mailService: MailService;
	#pw: PasswordManager;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
		mailService: MailService,
		pw: PasswordManager,
	) {
		super("user", kv, db);
		this.#storage = storage;
		this.#mailService = mailService;
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
			phone: user.phone ?? undefined,
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
		// Delegate to UserSearchService
		return UserSearchService.getQueryCount(this.db, query);
	}

	async list(
		query?: UserListQuery & { requesterId: string },
	): Promise<ListResult<User>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy = "createdAt",
				order = "asc",
				requesterId,
				filters,
			} = query ?? {};

			// Use service to generate order by clause
			const orderBy = UserListQueryService.generateOrderBy(sortBy, order);

			// Build where clauses
			const clauses: SQL[] = [];
			if (requesterId) clauses.push(ne(tables.user.id, requesterId));

			// Add search clause if provided (delegate to service)
			if (search) {
				const determine = or(
					ilike(tables.user.name, `%${search}%`),
					ilike(tables.user.email, `%${search}%`),
				);
				if (determine) clauses.push(determine);
			}

			// Add filter clauses
			if (filters) {
				// Role filter
				if (filters.roles && filters.roles.length > 0) {
					clauses.push(inArray(tables.user.role, filters.roles));
				}

				// Gender filter
				if (filters.genders && filters.genders.length > 0) {
					clauses.push(inArray(tables.user.gender, filters.genders));
				}

				// Email verified filter
				if (filters.emailVerified !== undefined) {
					clauses.push(eq(tables.user.emailVerified, filters.emailVerified));
				}

				// Banned filter
				if (filters.banned !== undefined) {
					clauses.push(eq(tables.user.banned, filters.banned));
				}

				// Date range filter
				if (filters.startDate) {
					clauses.push(gte(tables.user.createdAt, filters.startDate));
				}
				if (filters.endDate) {
					clauses.push(lte(tables.user.createdAt, filters.endDate));
				}
			}
			// Cursor-based pagination
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

			// Page-based pagination
			if (page) {
				const offset = UserListQueryService.calculateOffset(page, limit);

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

				const totalPages = UserListQueryService.calculateTotalPages(
					totalCount,
					limit,
				);

				return { rows, totalPages };
			}

			// Simple listing
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
				if (!res) throw new RepositoryError(m.error_failed_get_driver());
				await this.setCache(id, res);
				return res;
			};
			const result = await this.getCache(id, { fallback });
			return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	generateRandomPassword(): string {
		const randomPassword = Math.random().toString(36).slice(-8);
		return randomPassword;
	}

	async create(item: InviteUser): Promise<User & { password: string }> {
		try {
			// Check if user already exists

			const whereClauses: SQL[] = [];
			if (item.email) {
				whereClauses.push(eq(tables.user.email, item.email));
			}
			if (item.phone) {
				whereClauses.push(eq(tables.user.phone, item.phone));
			}

			const existingUser = await this.db.query.user.findFirst({
				columns: { email: true, phone: true },
				where: (_f, op) => op.or(...whereClauses),
			});

			if (existingUser) {
				throw new RepositoryError(m.error_email_or_phone_already_registered(), {
					code: "CONFLICT",
				});
			}

			const userId = UserIdService.generate();

			// Create user with role, no image for admin-created users
			const user = await this.db
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
				.returning()
				.then((r) => r[0]);

			// Create account with hashed password
			if (!this.#pw) {
				throw new RepositoryError(m.error_password_manager_not_available(), {
					code: "INTERNAL_SERVER_ERROR",
				});
			}

			const password = this.generateRandomPassword();
			const hashedPassword = this.#pw.hash(password);

			const [composedUser] = await Promise.all([
				await UserAdminRepository.composeEntity(
					{ ...user, userBadges: [] },
					this.#storage,
				),
				await this.db.insert(tables.account).values({
					id: UserIdService.generate(),
					accountId: UserIdService.generate(),
					userId: user.id,
					providerId: "credentials",
					password: hashedPassword,
				}),
				await this.db.insert(tables.wallet).values({
					id: v7(),
					userId: user.id,
					balance: "0",
				}),
				await this.#mailService.sendInvitation({
					to: user.email,
					email: user.email,
					password,
					role: user.role,
				}),
			]);

			log.info(
				{ userId: user.id, email: user.email, role: user.role },
				m.server_user_created(),
			);

			return { ...composedUser, password };
		} catch (error) {
			log.error({ error }, "[UserAdminRepository] Failed to create user");
			throw this.handleError(error, "create");
		}
	}

	async update(
		id: string,
		item: AdminUpdateUser,
		opts: PartialWithTx,
		_header: Headers,
		context?: ORPCContext,
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
						throw new RepositoryError(m.error_failed_update_user_role(), {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					// Use UserRefreshService to refresh and compose user
					const refreshed = await UserRefreshService.refreshUser(tx, id);
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed as Parameters<
							typeof UserAdminRepository.composeEntity
						>[0],
						this.#storage,
					);

					// Audit log: role change
					if (context?.user) {
						await AuditService.logChange(
							{
								tableName: "user",
								recordId: id,
								operation: "UPDATE",
								oldData: { role: existing.role },
								newData: { role: item.role },
								updatedById: context.user.id,
								metadata: AuditService.extractMetadata(context),
							},
							context,
							{ tx },
						);
					}

					log.info(
						{ userId: id, newRole: item.role },
						"[UserAdminRepository] User role updated",
					);
				}

				// Handle password updates
				if ("newPassword" in item) {
					if (!this.#pw) {
						throw new RepositoryError(
							m.error_password_manager_not_available(),
							{
								code: "INTERNAL_SERVER_ERROR",
							},
						);
					}

					// Get account to verify old password
					const account = await tx.query.account.findFirst({
						where: (f, op) =>
							op.and(op.eq(f.userId, id), op.eq(f.providerId, "credentials")),
					});

					if (!account) {
						throw new RepositoryError(m.error_user_account_not_found(), {
							code: "NOT_FOUND",
						});
					}

					// Hash new password using service
					const hashedPassword = PasswordChangeService.hashPassword(
						this.#pw,
						item.newPassword,
					);
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
					const banData = UserBanService.createBanData(
						item.banReason,
						item.banExpiresIn,
					);

					const [updated] = await tx
						.update(tables.user)
						.set(banData)
						.where(eq(tables.user.id, id))
						.returning();

					if (!updated) {
						throw new RepositoryError(m.error_failed_ban_user(), {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					// Use UserRefreshService to refresh and compose user
					const refreshed = await UserRefreshService.refreshUser(tx, id);
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed as Parameters<
							typeof UserAdminRepository.composeEntity
						>[0],
						this.#storage,
					);

					// Audit log: user ban
					if (context?.user) {
						await AuditService.logChange(
							{
								tableName: "user",
								recordId: id,
								operation: "UPDATE",
								oldData: {
									banned: existing.banned,
									banReason: existing.banReason,
									banExpires: existing.banExpires,
								},
								newData: banData,
								updatedById: context.user.id,
								metadata: {
									...AuditService.extractMetadata(context),
									reason: item.banReason,
								},
							},
							context,
							{ tx },
						);
					}

					log.info(
						{ userId: id, banReason: item.banReason },
						"[UserAdminRepository] User banned",
					);
				}

				// Handle unban
				if (UserBanService.isUnbanOperation(item)) {
					// UnbanUserSchema only has 'id' field
					const unbanData = UserBanService.createUnbanData();

					const [updated] = await tx
						.update(tables.user)
						.set(unbanData)
						.where(eq(tables.user.id, id))
						.returning();

					if (!updated) {
						throw new RepositoryError(m.error_failed_unban_user(), {
							code: "INTERNAL_SERVER_ERROR",
						});
					}

					// Use UserRefreshService to refresh and compose user
					const refreshed = await UserRefreshService.refreshUser(tx, id);
					updatedUser = await UserAdminRepository.composeEntity(
						refreshed as Parameters<
							typeof UserAdminRepository.composeEntity
						>[0],
						this.#storage,
					);

					// Audit log: user unban
					if (context?.user) {
						await AuditService.logChange(
							{
								tableName: "user",
								recordId: id,
								operation: "UPDATE",
								oldData: {
									banned: existing.banned,
									banReason: existing.banReason,
									banExpires: existing.banExpires,
								},
								newData: unbanData,
								updatedById: context.user.id,
								metadata: {
									...AuditService.extractMetadata(context),
									reason: "User unbanned by admin",
								},
							},
							context,
							{ tx },
						);
					}

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

	async getDashboardStats(options?: {
		startDate?: Date;
		endDate?: Date;
		period?: "today" | "week" | "month" | "year";
	}): Promise<{
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
		revenueByDay: Array<{
			date: string;
			revenue: number;
			orders: number;
		}>;
		ordersByDay: Array<{
			date: string;
			total: number;
			completed: number;
			cancelled: number;
		}>;
		ordersByType: Array<{
			type: string;
			orders: number;
			revenue: number;
		}>;
		topDrivers: Array<{
			id: string;
			name: string;
			earnings: number;
			orders: number;
			rating: number;
		}>;
		topMerchants: Array<{
			id: string;
			name: string;
			revenue: number;
			orders: number;
			rating: number;
		}>;
		highCancellationDrivers: Array<{
			id: string;
			name: string;
			totalOrders: number;
			cancelledOrders: number;
			cancellationRate: number;
		}>;
	}> {
		try {
			// Use service to calculate date range
			const { startDate, endDate } =
				DashboardStatsService.calculateDateRange(options);
			const cacheKey = DashboardStatsService.getCacheKey(startDate, endDate);

			const fallback = async () => {
				const today = DashboardStatsService.getTodayMidnight();

				// Execute all queries in parallel using service-generated SQL
				const [
					basicStatsResult,
					revenueByDayResult,
					ordersByDayResult,
					ordersByTypeResult,
					topDriversResult,
					topMerchantsResult,
					highCancellationResult,
				] = await Promise.all([
					this.db.execute(DashboardStatsService.getBasicStatsSQL(today)),
					this.db.execute(
						DashboardStatsService.getRevenueByDaySQL(startDate, endDate),
					),
					this.db.execute(
						DashboardStatsService.getOrdersByDaySQL(startDate, endDate),
					),
					this.db.execute(
						DashboardStatsService.getOrdersByTypeSQL(startDate, endDate),
					),
					this.db.execute(
						DashboardStatsService.getTopDriversSQL(startDate, endDate),
					),
					this.db.execute(
						DashboardStatsService.getTopMerchantsSQL(startDate, endDate),
					),
					this.db.execute(
						DashboardStatsService.getHighCancellationSQL(startDate, endDate),
					),
				]);

				const basicStats = basicStatsResult[0];
				if (!basicStats) {
					throw new RepositoryError(m.error_failed_get_dashboard_stats(), {
						code: "NOT_FOUND",
					});
				}

				// Log raw database results for debugging
				log.info(
					{
						basicStats,
						revenueByDayCount: revenueByDayResult.length,
						ordersByDayCount: ordersByDayResult.length,
						ordersByTypeCount: ordersByTypeResult.length,
						topDriversCount: topDriversResult.length,
						topMerchantsCount: topMerchantsResult.length,
						highCancellationCount: highCancellationResult.length,
					},
					"[UserAdminRepository] Raw dashboard stats from database",
				);

				// Use service to compose the final stats object
				const stats = DashboardStatsService.composeDashboardStats({
					basicStats: basicStats as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["basicStats"],
					revenueByDay: revenueByDayResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["revenueByDay"],
					ordersByDay: ordersByDayResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["ordersByDay"],
					ordersByType: ordersByTypeResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["ordersByType"],
					topDrivers: topDriversResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["topDrivers"],
					topMerchants: topMerchantsResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["topMerchants"],
					highCancellation: highCancellationResult as unknown as Parameters<
						typeof DashboardStatsService.composeDashboardStats
					>[0]["highCancellation"],
				});

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
