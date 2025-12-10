import { m } from "@repo/i18n";
import type { Coordinate } from "@repo/schema";
import {
	type Driver,
	DriverKeySchema,
	type DriverQuizStatus,
	type DriverStatus,
	type InsertDriver,
	type UpdateDriver,
} from "@repo/schema/driver";
import { nullsToUndefined } from "@repo/shared";
import {
	and,
	count,
	eq,
	gt,
	gte,
	ilike,
	inArray,
	lte,
	type SQL,
} from "drizzle-orm";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { ListResult, OrderByOperation, WithTx } from "@/core/interface";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type { StorageService } from "@/core/services/storage";
import type { UserDatabase } from "@/core/tables/auth";
import type { DetailedUserBadgeDatabase } from "@/core/tables/badge";
import type { DriverDatabase } from "@/core/tables/driver";
import { UserAdminRepository } from "@/features/user/admin/user-admin-repository";
import { log } from "@/utils";
import {
	DriverDocumentService,
	DriverLocationService,
	DriverStatsService,
	DriverVerificationService,
} from "../services";
import type { DriverListQuery, NearbyQuery } from "./driver-main-spec";

export class DriverMainRepository extends BaseRepository {
	readonly #storage: StorageService;
	readonly #locationService: DriverLocationService;
	readonly #verificationService: DriverVerificationService;

	constructor(
		db: DatabaseService,
		kv: KeyValueService,
		storage: StorageService,
	) {
		super("driver", kv, db);
		this.#storage = storage;
		this.#locationService = new DriverLocationService(db);
		this.#verificationService = new DriverVerificationService(db, storage);
	}

	static async composeEntity(
		item: DriverDatabase & {
			user: UserDatabase & {
				userBadges: DetailedUserBadgeDatabase[];
			};
		},
		storage: StorageService,
	): Promise<
		Driver & {
			studentCardId: string;
			driverLicenseId: string;
			vehicleCertificateId: string;
		}
	> {
		const [studentCard, driverLicense, vehicleCertificate, user] =
			await Promise.all([
				storage.getPresignedUrl({
					bucket: DriverDocumentService.BUCKET,
					key: item.studentCard,
				}),
				storage.getPresignedUrl({
					bucket: DriverDocumentService.BUCKET,
					key: item.driverLicense,
				}),
				storage.getPresignedUrl({
					bucket: DriverDocumentService.BUCKET,
					key: item.vehicleCertificate,
				}),
				UserAdminRepository.composeEntity(item.user, storage),
			]);

		return nullsToUndefined({
			...item,
			user: nullsToUndefined(user),
			studentCardId: item.studentCard,
			driverLicenseId: item.driverLicense,
			vehicleCertificateId: item.vehicleCertificate,
			studentCard,
			driverLicense,
			vehicleCertificate,
		});
	}

	async #getFromDB(
		id: string,
		opts?: WithTx,
	): Promise<
		| (Driver & {
				studentCardId: string;
				driverLicenseId: string;
				vehicleCertificateId: string;
		  })
		| undefined
	> {
		const tx = opts?.tx ?? this.db;

		const result = await tx.query.driver.findFirst({
			with: {
				user: {
					with: { userBadges: { with: { badge: true } } },
				},
			},
			where: (f, op) => op.eq(f.id, id),
		});

		return result
			? await DriverMainRepository.composeEntity(result, this.#storage)
			: undefined;
	}

	async #getQueryCount(
		query: string,
		filters?: {
			statuses?: DriverStatus[];
			isOnline?: boolean;
			minRating?: number;
			maxRating?: number;
		},
	): Promise<number> {
		try {
			const clauses: SQL[] = [];

			if (query) {
				clauses.push(ilike(tables.user.name, `%${query}%`));
			}
			if (filters?.statuses && filters.statuses.length > 0) {
				clauses.push(inArray(tables.driver.status, filters.statuses));
			}
			if (filters?.isOnline !== undefined) {
				clauses.push(eq(tables.driver.isOnline, filters.isOnline));
			}
			if (filters?.minRating !== undefined) {
				clauses.push(gte(tables.driver.rating, filters.minRating));
			}
			if (filters?.maxRating !== undefined) {
				clauses.push(lte(tables.driver.rating, filters.maxRating));
			}

			const [dbResult] = await this.db
				.select({ count: count(tables.driver.id) })
				.from(tables.driver)
				.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(clauses.length > 0 ? and(...clauses) : undefined);

			return dbResult?.count ?? 0;
		} catch (error) {
			log.error({ query, filters, error }, "Failed to get query count");
			return 0;
		}
	}

	async list(query?: DriverListQuery): Promise<ListResult<Driver>> {
		try {
			const {
				cursor,
				page,
				limit = 10,
				query: search,
				sortBy,
				order = "asc",
				statuses,
				isOnline,
				minRating,
				maxRating,
			} = query ?? {};

			const orderBy = (
				f: typeof tables.driver._.columns,
				op: OrderByOperation,
			) => {
				if (sortBy) {
					const parsed = DriverKeySchema.safeParse(sortBy);
					const field = parsed.success ? f[parsed.data] : f.id;
					return op[order](field);
				}
				return op[order](f.id);
			};

			const clauses: SQL[] = [];

			if (search) clauses.push(ilike(tables.user.name, `%${search}%`));

			// Add filter clauses
			if (statuses && statuses.length > 0) {
				clauses.push(inArray(tables.driver.status, statuses));
			}
			if (isOnline !== undefined) {
				clauses.push(eq(tables.driver.isOnline, isOnline));
			}
			if (minRating !== undefined) {
				clauses.push(gte(tables.driver.rating, minRating));
			}
			if (maxRating !== undefined) {
				clauses.push(lte(tables.driver.rating, maxRating));
			}

			if (cursor) {
				clauses.push(gt(tables.driver.updatedAt, new Date(cursor)));

				const result = await this.db.query.driver.findMany({
					with: {
						user: {
							with: { userBadges: { with: { badge: true } } },
						},
					},
					where: (_, op) => op.and(...clauses),
					orderBy,
					limit: limit + 1,
				});

				const rows = await Promise.all(
					result.map((r) =>
						DriverMainRepository.composeEntity(r, this.#storage),
					),
				);
				return { rows };
			}

			if (page) {
				const offset = (page - 1) * limit;

				const result = await this.db.query.driver.findMany({
					with: {
						user: {
							with: { userBadges: { with: { badge: true } } },
						},
					},
					where: (_, op) => op.and(...clauses),
					orderBy,
					offset,
					limit,
				});

				const rows = await Promise.all(
					result.map((r) =>
						DriverMainRepository.composeEntity(r, this.#storage),
					),
				);

				const hasFilters =
					(statuses && statuses.length > 0) ||
					isOnline !== undefined ||
					minRating !== undefined ||
					maxRating !== undefined;

				const totalCount =
					search || hasFilters
						? await this.#getQueryCount(search ?? "", {
								statuses,
								isOnline,
								minRating,
								maxRating,
							})
						: await this.getTotalRow();

				const totalPages = Math.ceil(totalCount / limit);

				return { rows, totalPages };
			}

			const result = await this.db.query.driver.findMany({
				with: { user: { with: { userBadges: { with: { badge: true } } } } },
				where: (_, op) => op.and(...clauses),
				orderBy,
				limit,
			});
			const rows = await Promise.all(
				result.map((r) => DriverMainRepository.composeEntity(r, this.#storage)),
			);
			return { rows };
		} catch (error) {
			this.handleError(error, "list");
			return { rows: [] };
		}
	}

	async nearby(query: NearbyQuery): Promise<Driver[]> {
		try {
			const { x, y, limit = 20, radiusKm = 10, gender } = query;

			// Delegate to DriverLocationService
			return await this.#locationService.findNearby(
				{ lat: y, lng: x, radiusKm, limit, gender },
				{
					composeEntity: async (driver) =>
						await DriverMainRepository.composeEntity(driver, this.#storage),
				},
			);
		} catch (error) {
			throw this.handleError(error, "nearby");
		}
	}

	async get(id: string): Promise<Driver> {
		try {
			const res = await this.#getFromDB(id);
			if (!res) throw new RepositoryError(m.error_failed_get_driver());
			await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
			return res;
			// const fallback = async () => {
			// 	const res = await this.#getFromDB(id);
			// 	if (!res) throw new RepositoryError(m.error_failed_get_driver());
			// 	await this.setCache(id, res, { expirationTtl: CACHE_TTLS["24h"] });
			// 	return res;
			// };
			// const result = await this.getCache(id, { fallback });
			// return result;
		} catch (error) {
			throw this.handleError(error, "get by id");
		}
	}

	async getByUserId(userId: string): Promise<Driver> {
		try {
			const result = await this.db.query.driver.findFirst({
				with: { user: { with: { userBadges: { with: { badge: true } } } } },
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (!result) throw new RepositoryError(m.error_failed_get_merchant());

			return await DriverMainRepository.composeEntity(result, this.#storage);
		} catch (error) {
			throw this.handleError(error, "get by user id");
		}
	}

	async create(
		item: InsertDriver & { userId: string },
		opts?: WithTx,
	): Promise<Driver> {
		try {
			// Fetch user
			const user = await (opts?.tx ?? this.db).query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, item.userId),
			});

			if (!user)
				throw new RepositoryError(m.error_user_not_found(), {
					code: "NOT_FOUND",
				});

			// Validate uniqueness and upload documents (delegated to service)
			const fileKeys =
				await this.#verificationService.validateAndUploadDocuments(
					{
						studentId: item.studentId,
						licensePlate: item.licensePlate,
						studentCard: item.studentCard,
						driverLicense: item.driverLicense,
						vehicleCertificate: item.vehicleCertificate,
					},
					opts,
				);

			// Insert driver record
			const operation = await (opts?.tx ?? this.db)
				.insert(tables.driver)
				.values({
					...item,
					id: fileKeys.id,
					studentCard: fileKeys.studentCard,
					driverLicense: fileKeys.driverLicense,
					vehicleCertificate: fileKeys.vehicleCertificate,
				})
				.returning()
				.then((r) => r[0]);

			const result = await DriverMainRepository.composeEntity(
				{ ...operation, user },
				this.#storage,
			);
			await this.setCache(result.id, result, {
				expirationTtl: CACHE_TTLS["24h"],
			});
			return result;
		} catch (error) {
			throw this.handleError(error, "create");
		}
	}

	async update(id: string, item: UpdateDriver, opts?: WithTx): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;

			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(`Driver with id "${id}" not found`);

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});
			if (!user) throw new RepositoryError(m.error_user_not_found());

			// Upload updated documents (if provided) - delegated to service
			if (item.studentCard || item.driverLicense || item.vehicleCertificate) {
				await this.#verificationService.updateDocuments(id, {
					studentCard: item.studentCard,
					driverLicense: item.driverLicense,
					vehicleCertificate: item.vehicleCertificate,
				});
			}

			// Update driver record
			const operation = await tx
				.update(tables.driver)
				.set({
					...item,
					lastLocationUpdate:
						item.currentLocation !== undefined ? new Date() : undefined,
					studentCard: existing.studentCardId,
					driverLicense: existing.driverLicenseId,
					vehicleCertificate: existing.vehicleCertificateId,
					createdAt: new Date(existing.createdAt),
				})
				.where(eq(tables.driver.id, id))
				.returning()
				.then((r) => r[0]);

			const result = await DriverMainRepository.composeEntity(
				{ ...operation, user },
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update");
		}
	}

	async updateLocation(
		id: string,
		coord: Coordinate,
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing)
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			const [updated] = await tx
				.update(tables.driver)
				.set({ currentLocation: coord, lastLocationUpdate: new Date() })
				.where(eq(tables.driver.id, id))
				.returning();
			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});
			if (!user) throw new RepositoryError(m.error_user_not_found());
			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);
			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update location");
		}
	}

	async updateOnlineStatus(
		id: string,
		isOnline: boolean,
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const [updated, user] = await Promise.all([
				tx
					.update(tables.driver)
					.set({
						isOnline,
						...(isOnline
							? {}
							: { currentLocation: null, lastLocationUpdate: null }),
					})
					.where(eq(tables.driver.id, id))
					.returning()
					.then((r) => r[0]),
				tx.query.user.findFirst({
					with: { userBadges: { with: { badge: true } } },
					where: (f, op) => op.eq(f.id, existing.userId),
				}),
			]);

			if (!user) throw new RepositoryError(m.error_user_not_found());
			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update online status");
		}
	}

	async updateTakingOrderStatus(
		id: string,
		isTakingOrder: boolean,
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const [updated, user] = await Promise.all([
				tx
					.update(tables.driver)
					.set({ isTakingOrder })
					.where(eq(tables.driver.id, id))
					.returning()
					.then((r) => r[0]),
				tx.query.user.findFirst({
					with: { userBadges: { with: { badge: true } } },
					where: (f, op) => op.eq(f.id, existing.userId),
				}),
			]);

			if (!user) throw new RepositoryError(m.error_user_not_found());
			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.setCache(id, result, { expirationTtl: CACHE_TTLS["24h"] });
			return result;
		} catch (error) {
			throw this.handleError(error, "update online status");
		}
	}

	async remove(id: string, opts?: WithTx): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;
			const find = await this.#getFromDB(id, opts);
			if (!find)
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});

			// Delete driver record and documents in parallel
			const [result] = await Promise.all([
				tx
					.delete(tables.driver)
					.where(eq(tables.driver.id, id))
					.returning({ id: tables.driver.id }),
				// Delete documents - delegated to service
				this.#verificationService.deleteDocuments({
					studentCard: find.studentCardId,
					driverLicense: find.driverLicenseId,
					vehicleCertificate: find.vehicleCertificateId,
				}),
			]);

			if (result.length > 0) {
				await this.deleteCache(id);
			}
		} catch (error) {
			throw this.handleError(error, "remove");
		}
	}

	/**
	 * Get comprehensive analytics for a driver
	 * Includes earnings, performance metrics, and time-series data
	 *
	 * @param driverId - Driver ID
	 * @param query - Optional query parameters for filtering by period
	 * @returns Analytics data with earnings breakdown and performance metrics
	 */
	async getAnalytics(
		driverId: string,
		query?: {
			period?: "today" | "week" | "month" | "year";
			startDate?: Date;
			endDate?: Date;
		},
	): Promise<{
		// Earnings metrics
		totalEarnings: number;
		totalCommission: number;
		netEarnings: number;

		// Order metrics
		totalOrders: number;
		completedOrders: number;
		cancelledOrders: number;
		completionRate: number;

		// Performance metrics
		averageRating: number;

		// Breakdown by service type
		earningsByType: Array<{
			type: "RIDE" | "DELIVERY" | "FOOD";
			orders: number;
			earnings: number;
			commission: number;
		}>;

		// Time-series data for charts
		earningsByDay: Array<{
			date: string;
			earnings: number;
			orders: number;
			commission: number;
		}>;

		// Top earning days
		topEarningDays: Array<{
			date: string;
			earnings: number;
			orders: number;
		}>;
	}> {
		try {
			// Calculate date range based on period (delegated to service)
			const { startDate, endDate } = DriverStatsService.calculateDateRange(
				query?.period,
				query?.startDate,
				query?.endDate,
			);

			// Execute queries (SQL generation delegated to service)
			const [statsResult, earningsByTypeResult, earningsByDayResult] =
				await Promise.all([
					this.db.execute<{
						total_orders: number;
						total_earnings: string;
						total_commission: string;
						completed_orders: number;
						cancelled_orders: number;
						average_rating: string;
					}>(
						DriverStatsService.getOverallStatsSQL(driverId, startDate, endDate),
					),
					this.db.execute<{
						type: "RIDE" | "DELIVERY" | "FOOD";
						orders: number;
						earnings: string;
						commission: string;
					}>(
						DriverStatsService.getEarningsByTypeSQL(
							driverId,
							startDate,
							endDate,
						),
					),
					this.db.execute<{
						date: string;
						earnings: string;
						commission: string;
						orders: number;
					}>(
						DriverStatsService.getEarningsByDaySQL(
							driverId,
							startDate,
							endDate,
						),
					),
				]);

			// Compose analytics result (delegated to service)
			return DriverStatsService.composeDriverStats(
				statsResult[0],
				earningsByTypeResult,
				earningsByDayResult,
			);
		} catch (error) {
			throw this.handleError(error, "get analytics");
		}
	}

	async approve(id: string, opts?: WithTx): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (existing.status !== "PENDING") {
				throw new RepositoryError(
					"Driver must be in PENDING status to be approved",
					{ code: "BAD_REQUEST" },
				);
			}

			// Check if driver has passed the quiz
			if (existing.quizStatus !== "PASSED") {
				throw new RepositoryError(
					"Driver must pass the quiz before approval. Current quiz status: " +
						existing.quizStatus,
					{ code: "BAD_REQUEST" },
				);
			}

			const [updated] = await tx
				.update(tables.driver)
				.set({ status: "APPROVED" })
				.where(eq(tables.driver.id, id))
				.returning();

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});

			if (!user) throw new RepositoryError(m.error_user_not_found());

			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.deleteCache(id);
			log.info({ driverId: id }, "[DriverMainRepository] Driver approved");

			return result;
		} catch (error) {
			throw this.handleError(error, "approve");
		}
	}

	async reject(id: string, reason: string, opts?: WithTx): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (existing.status !== "PENDING") {
				throw new RepositoryError(
					"Driver must be in PENDING status to be rejected",
					{ code: "BAD_REQUEST" },
				);
			}

			const [updated] = await tx
				.update(tables.driver)
				.set({ status: "REJECTED" })
				.where(eq(tables.driver.id, id))
				.returning();

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});

			if (!user) throw new RepositoryError(m.error_user_not_found());

			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.deleteCache(id);
			log.info(
				{ driverId: id, reason },
				"[DriverMainRepository] Driver rejected",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "reject");
		}
	}

	async suspend(
		id: string,
		reason: string,
		suspendUntil?: Date,
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (existing.status !== "ACTIVE" && existing.status !== "APPROVED") {
				throw new RepositoryError(
					"Driver must be ACTIVE or APPROVED to be suspended",
					{ code: "BAD_REQUEST" },
				);
			}

			const [updated] = await tx
				.update(tables.driver)
				.set({ status: "SUSPENDED" })
				.where(eq(tables.driver.id, id))
				.returning();

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});

			if (!user) throw new RepositoryError(m.error_user_not_found());

			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.deleteCache(id);
			log.info(
				{ driverId: id, reason, suspendUntil },
				"[DriverMainRepository] Driver suspended",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "suspend");
		}
	}

	async activate(id: string, opts?: WithTx): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;
			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			if (
				existing.status !== "APPROVED" &&
				existing.status !== "INACTIVE" &&
				existing.status !== "SUSPENDED"
			) {
				throw new RepositoryError(
					"Driver must be APPROVED, INACTIVE, or SUSPENDED to be activated",
					{ code: "BAD_REQUEST" },
				);
			}

			const [updated] = await tx
				.update(tables.driver)
				.set({ status: "ACTIVE" })
				.where(eq(tables.driver.id, id))
				.returning();

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});

			if (!user) throw new RepositoryError(m.error_user_not_found());

			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.deleteCache(id);
			log.info({ driverId: id }, "[DriverMainRepository] Driver activated");

			return result;
		} catch (error) {
			throw this.handleError(error, "activate");
		}
	}

	/**
	 * Update driver's quiz status after completing a quiz attempt
	 */
	async updateQuizStatus(
		id: string,
		data: {
			quizStatus: DriverQuizStatus;
			quizAttemptId: string;
			quizScore: number;
			quizCompletedAt: Date;
		},
		opts?: WithTx,
	): Promise<Driver> {
		try {
			const tx = opts?.tx ?? this.db;

			const existing = await this.#getFromDB(id, opts);
			if (!existing) {
				throw new RepositoryError(m.error_driver_not_found(), {
					code: "NOT_FOUND",
				});
			}

			const [updated] = await tx
				.update(tables.driver)
				.set({
					quizStatus: data.quizStatus,
					quizAttemptId: data.quizAttemptId,
					quizScore: data.quizScore,
					quizCompletedAt: data.quizCompletedAt,
				})
				.where(eq(tables.driver.id, id))
				.returning();

			const user = await tx.query.user.findFirst({
				with: { userBadges: { with: { badge: true } } },
				where: (f, op) => op.eq(f.id, existing.userId),
			});

			if (!user) throw new RepositoryError(m.error_user_not_found());

			const result = await DriverMainRepository.composeEntity(
				{ ...updated, user },
				this.#storage,
			);

			await this.deleteCache(id);
			log.info(
				{
					driverId: id,
					quizStatus: data.quizStatus,
					quizScore: data.quizScore,
				},
				"[DriverMainRepository] Driver quiz status updated",
			);

			return result;
		} catch (error) {
			throw this.handleError(error, "updateQuizStatus");
		}
	}
}
