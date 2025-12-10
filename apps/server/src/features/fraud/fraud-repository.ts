import type {
	FraudEvent,
	FraudEventListQuery,
	FraudSignal,
	FraudStats,
	FraudStatsQuery,
	InsertFraudEvent,
	UpdateFraudEvent,
	UserFraudProfile,
} from "@repo/schema/fraud";
import { and, count, desc, eq, gte, lte, sql } from "drizzle-orm";
import { v7 } from "uuid";
import { BaseRepository } from "@/core/base";
import { CACHE_TTLS } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type {
	ListResult,
	ORPCContext,
	OrderByOperation,
	PartialWithTx,
} from "@/core/interface";
import { AuditService } from "@/core/services/audit";
import { type DatabaseService, tables } from "@/core/services/db";
import type { KeyValueService } from "@/core/services/kv";
import type {
	FraudEventDatabase,
	UserFraudProfileDatabase,
} from "@/core/tables/fraud";
import { toNumberSafe } from "@/utils";
import { logger } from "@/utils/logger";

export class FraudRepository extends BaseRepository {
	constructor(db: DatabaseService, kv: KeyValueService) {
		super("fraudEvent", kv, db);
	}

	/**
	 * Compose database row to API entity
	 */
	static composeFraudEventEntity(item: FraudEventDatabase): FraudEvent {
		return {
			...item,
			signals: item.signals as FraudSignal[],
			score: toNumberSafe(item.score),
			location: item.location
				? { lat: item.location.x, lng: item.location.y }
				: null,
			previousLocation: item.previousLocation
				? { lat: item.previousLocation.x, lng: item.previousLocation.y }
				: null,
			distanceKm: item.distanceKm ? toNumberSafe(item.distanceKm) : null,
			timeDeltaSeconds: item.timeDeltaSeconds ?? null,
			velocityKmh: item.velocityKmh ? toNumberSafe(item.velocityKmh) : null,
			userId: item.userId ?? null,
			driverId: item.driverId ?? null,
			ipAddress: item.ipAddress ?? null,
			userAgent: item.userAgent ?? null,
			handledById: item.handledById ?? null,
			resolution: item.resolution ?? null,
			actionTaken: item.actionTaken ?? null,
			resolvedAt: item.resolvedAt ?? null,
		};
	}

	static composeProfileEntity(
		item: UserFraudProfileDatabase,
	): UserFraudProfile {
		return {
			...item,
			riskScore: toNumberSafe(item.riskScore),
			knownIps: item.knownIps as string[],
			lastEventAt: item.lastEventAt ?? null,
		};
	}

	/**
	 * List fraud events with filtering and pagination
	 */
	async listEvents(
		query?: FraudEventListQuery,
	): Promise<ListResult<FraudEvent>> {
		try {
			const {
				page = 1,
				limit = 20,
				status,
				severity,
				eventType,
				userId,
				driverId,
				startDate,
				endDate,
				sortBy = "detectedAt",
				order = "desc",
			} = query ?? {};

			const conditions = [];

			if (status) {
				conditions.push(eq(tables.fraudEvent.status, status));
			}
			if (severity) {
				conditions.push(eq(tables.fraudEvent.severity, severity));
			}
			if (eventType) {
				conditions.push(eq(tables.fraudEvent.eventType, eventType));
			}
			if (userId) {
				conditions.push(eq(tables.fraudEvent.userId, userId));
			}
			if (driverId) {
				conditions.push(eq(tables.fraudEvent.driverId, driverId));
			}
			if (startDate) {
				conditions.push(gte(tables.fraudEvent.detectedAt, startDate));
			}
			if (endDate) {
				conditions.push(lte(tables.fraudEvent.detectedAt, endDate));
			}

			const whereClause =
				conditions.length > 0 ? and(...conditions) : undefined;

			// Order by
			const orderBy = (
				f: typeof tables.fraudEvent._.columns,
				op: OrderByOperation,
			) => {
				const field = f[sortBy as keyof typeof f] ?? f.detectedAt;
				return op[order](field);
			};

			const offset = (page - 1) * limit;

			const result = await this.db.query.fraudEvent.findMany({
				where: whereClause,
				orderBy,
				offset,
				limit,
				with: {
					user: {
						columns: { id: true, name: true, email: true },
					},
					driver: {
						columns: { id: true, studentId: true, licensePlate: true },
					},
					handledBy: {
						columns: { id: true, name: true },
					},
				},
			});

			const rows = result.map((item) => ({
				...FraudRepository.composeFraudEventEntity(item),
				user: item.user ?? undefined,
				driver: item.driver ?? undefined,
				handledBy: item.handledBy ?? undefined,
			}));

			// Get total count
			const [countResult] = await this.db
				.select({ count: count() })
				.from(tables.fraudEvent)
				.where(whereClause);

			const totalCount = countResult?.count ?? 0;
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, totalPages };
		} catch (error) {
			this.handleError(error, "list fraud events");
			return { rows: [] };
		}
	}

	/**
	 * Get a single fraud event by ID
	 */
	async get(id: string, opts?: PartialWithTx): Promise<FraudEvent> {
		try {
			const fallback = async () => {
				const result = await (opts?.tx ?? this.db).query.fraudEvent.findFirst({
					where: (f, op) => op.eq(f.id, id),
					with: {
						user: {
							columns: { id: true, name: true, email: true },
						},
						driver: {
							columns: { id: true, studentId: true, licensePlate: true },
						},
						handledBy: {
							columns: { id: true, name: true },
						},
					},
				});

				if (!result) {
					throw new RepositoryError("Fraud event not found", {
						code: "NOT_FOUND",
					});
				}

				const entity = {
					...FraudRepository.composeFraudEventEntity(result),
					user: result.user ?? undefined,
					driver: result.driver ?? undefined,
					handledBy: result.handledBy ?? undefined,
				};

				await this.setCache(id, entity, { expirationTtl: CACHE_TTLS["1h"] });
				return entity;
			};

			return await this.getCache(id, { fallback });
		} catch (error) {
			throw this.handleError(error, "get fraud event");
		}
	}

	/**
	 * Create a new fraud event
	 */
	async create(
		item: InsertFraudEvent,
		opts?: PartialWithTx,
	): Promise<FraudEvent> {
		try {
			const id = v7();
			const tx = opts?.tx ?? this.db;

			const locationPoint = item.location
				? sql`ST_SetSRID(ST_MakePoint(${item.location.lng}, ${item.location.lat}), 4326)`
				: null;
			const previousLocationPoint = item.previousLocation
				? sql`ST_SetSRID(ST_MakePoint(${item.previousLocation.lng}, ${item.previousLocation.lat}), 4326)`
				: null;

			const [result] = await tx
				.insert(tables.fraudEvent)
				.values({
					id,
					eventType: item.eventType,
					severity: item.severity,
					status: item.status,
					userId: item.userId ?? null,
					driverId: item.driverId ?? null,
					signals: item.signals,
					score: String(item.score),
					location: locationPoint,
					previousLocation: previousLocationPoint,
					distanceKm: item.distanceKm ? String(item.distanceKm) : null,
					timeDeltaSeconds: item.timeDeltaSeconds ?? null,
					velocityKmh: item.velocityKmh ? String(item.velocityKmh) : null,
					ipAddress: item.ipAddress ?? null,
					userAgent: item.userAgent ?? null,
					handledById: item.handledById ?? null,
					resolution: item.resolution ?? null,
					actionTaken: item.actionTaken ?? null,
					detectedAt: item.detectedAt,
					resolvedAt: item.resolvedAt ?? null,
				})
				.returning();

			const entity = FraudRepository.composeFraudEventEntity(result);
			await this.setCache(id, entity, { expirationTtl: CACHE_TTLS["1h"] });

			// Update user fraud profile
			if (item.userId) {
				await this.updateUserFraudProfile(item.userId, item, opts);
			}

			logger.info(
				{ eventId: id, eventType: item.eventType, severity: item.severity },
				"[FraudRepository] Fraud event created",
			);

			return entity;
		} catch (error) {
			throw this.handleError(error, "create fraud event");
		}
	}

	/**
	 * Update a fraud event (for review/resolution)
	 */
	async update(
		id: string,
		item: UpdateFraudEvent,
		opts?: PartialWithTx,
		context?: ORPCContext,
	): Promise<FraudEvent> {
		try {
			const existing = await this.get(id, opts);

			const resolvedAt =
				item.status === "CONFIRMED" || item.status === "DISMISSED"
					? new Date()
					: null;

			const [result] = await (opts?.tx ?? this.db)
				.update(tables.fraudEvent)
				.set({
					status: item.status ?? existing.status,
					resolution: item.resolution ?? existing.resolution,
					actionTaken: item.actionTaken ?? existing.actionTaken,
					handledById: context?.user?.id ?? existing.handledById,
					resolvedAt,
				})
				.where(eq(tables.fraudEvent.id, id))
				.returning();

			const entity = FraudRepository.composeFraudEventEntity(result);
			await this.setCache(id, entity, { expirationTtl: CACHE_TTLS["1h"] });

			// Audit log
			if (context?.user) {
				await AuditService.logChange(
					{
						tableName: "fraud_event",
						recordId: id,
						operation: "UPDATE",
						oldData: existing,
						newData: entity,
						updatedById: context.user.id,
						metadata: {
							...AuditService.extractMetadata(context),
							reason: item.resolution ?? "Status updated",
						},
					},
					context,
					opts,
				);
			}

			// Update user fraud profile if confirmed
			if (item.status === "CONFIRMED" && existing.userId) {
				await this.incrementConfirmedEvents(existing.userId, opts);
			}

			logger.info(
				{ eventId: id, newStatus: item.status },
				"[FraudRepository] Fraud event updated",
			);

			return entity;
		} catch (error) {
			throw this.handleError(error, "update fraud event");
		}
	}

	/**
	 * Update or create user fraud profile
	 */
	async updateUserFraudProfile(
		userId: string,
		event: InsertFraudEvent,
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;

			// Check if profile exists
			const existing = await tx.query.userFraudProfile.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});

			const newIps = event.ipAddress
				? [
						...new Set([
							...((existing?.knownIps as string[]) ?? []),
							event.ipAddress,
						]),
					]
				: ((existing?.knownIps as string[]) ?? []);

			// Calculate new risk score (simple average of recent events)
			const recentEvents = await tx.query.fraudEvent.findMany({
				where: (f, op) =>
					op.and(
						op.eq(f.userId, userId),
						op.gte(
							f.detectedAt,
							new Date(Date.now() - 30 * 24 * 60 * 60 * 1000),
						), // last 30 days
					),
				orderBy: desc(tables.fraudEvent.detectedAt),
				limit: 10,
			});

			const totalScore =
				recentEvents.reduce(
					(sum, e) => sum + toNumberSafe(e.score),
					event.score,
				) /
				(recentEvents.length + 1);
			const isHighRisk = totalScore >= 70;

			if (existing) {
				await tx
					.update(tables.userFraudProfile)
					.set({
						totalEvents: existing.totalEvents + 1,
						riskScore: String(Math.round(totalScore * 100) / 100),
						isHighRisk,
						knownIps: newIps,
						lastEventAt: event.detectedAt,
					})
					.where(eq(tables.userFraudProfile.id, existing.id));
			} else {
				await tx.insert(tables.userFraudProfile).values({
					id: v7(),
					userId,
					totalEvents: 1,
					confirmedEvents: 0,
					riskScore: String(event.score),
					isHighRisk: event.score >= 70,
					knownIps: newIps,
					lastEventAt: event.detectedAt,
				});
			}
		} catch (error) {
			logger.error(
				{ error, userId },
				"[FraudRepository] Failed to update fraud profile",
			);
		}
	}

	/**
	 * Increment confirmed events count for a user
	 */
	private async incrementConfirmedEvents(
		userId: string,
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			await (opts?.tx ?? this.db)
				.update(tables.userFraudProfile)
				.set({
					confirmedEvents: sql`${tables.userFraudProfile.confirmedEvents} + 1`,
				})
				.where(eq(tables.userFraudProfile.userId, userId));
		} catch (error) {
			logger.error(
				{ error, userId },
				"[FraudRepository] Failed to increment confirmed events",
			);
		}
	}

	/**
	 * Get fraud statistics
	 */
	async getStats(query?: FraudStatsQuery): Promise<FraudStats> {
		try {
			const { startDate, endDate, trendDays = 30 } = query ?? {};

			const conditions = [];
			if (startDate) {
				conditions.push(gte(tables.fraudEvent.detectedAt, startDate));
			}
			if (endDate) {
				conditions.push(lte(tables.fraudEvent.detectedAt, endDate));
			}

			const whereClause =
				conditions.length > 0 ? and(...conditions) : undefined;

			// Get counts by status
			const statusCounts = await this.db
				.select({
					status: tables.fraudEvent.status,
					count: count(),
				})
				.from(tables.fraudEvent)
				.where(whereClause)
				.groupBy(tables.fraudEvent.status);

			const statusMap = Object.fromEntries(
				statusCounts.map((s) => [s.status, s.count]),
			);

			// Get counts by severity
			const severityCounts = await this.db
				.select({
					severity: tables.fraudEvent.severity,
					count: count(),
				})
				.from(tables.fraudEvent)
				.where(whereClause)
				.groupBy(tables.fraudEvent.severity);

			const eventsBySeverity = {
				LOW: 0,
				MEDIUM: 0,
				HIGH: 0,
				CRITICAL: 0,
			};
			for (const s of severityCounts) {
				eventsBySeverity[s.severity as keyof typeof eventsBySeverity] = s.count;
			}

			// Get counts by type
			const typeCounts = await this.db
				.select({
					eventType: tables.fraudEvent.eventType,
					count: count(),
				})
				.from(tables.fraudEvent)
				.where(whereClause)
				.groupBy(tables.fraudEvent.eventType);

			const eventsByType = Object.fromEntries(
				typeCounts.map((t) => [t.eventType, t.count]),
			);

			// Get high risk users count
			const [highRiskResult] = await this.db
				.select({ count: count() })
				.from(tables.userFraudProfile)
				.where(eq(tables.userFraudProfile.isHighRisk, true));

			// Get trend data (last N days)
			const trendStartDate = new Date();
			trendStartDate.setDate(trendStartDate.getDate() - trendDays);

			const trendData = await this.db
				.select({
					date: sql<string>`DATE(${tables.fraudEvent.detectedAt})`.as("date"),
					count: count(),
				})
				.from(tables.fraudEvent)
				.where(gte(tables.fraudEvent.detectedAt, trendStartDate))
				.groupBy(sql`DATE(${tables.fraudEvent.detectedAt})`)
				.orderBy(sql`DATE(${tables.fraudEvent.detectedAt})`);

			const recentTrend = trendData.map((t) => ({
				date: t.date,
				count: t.count,
			}));

			return {
				totalEvents:
					(statusMap.PENDING ?? 0) +
					(statusMap.REVIEWING ?? 0) +
					(statusMap.CONFIRMED ?? 0) +
					(statusMap.DISMISSED ?? 0),
				pendingEvents: statusMap.PENDING ?? 0,
				reviewingEvents: statusMap.REVIEWING ?? 0,
				confirmedEvents: statusMap.CONFIRMED ?? 0,
				dismissedEvents: statusMap.DISMISSED ?? 0,
				eventsBySeverity,
				eventsByType,
				highRiskUsers: highRiskResult?.count ?? 0,
				recentTrend,
			};
		} catch (error) {
			throw this.handleError(error, "get fraud stats");
		}
	}

	/**
	 * Get user fraud profile
	 */
	async getUserProfile(
		userId: string,
		opts?: PartialWithTx,
	): Promise<UserFraudProfile | null> {
		try {
			const result = await (
				opts?.tx ?? this.db
			).query.userFraudProfile.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
				with: {
					user: {
						columns: { id: true, name: true, email: true, role: true },
					},
				},
			});

			if (!result) return null;

			return {
				...FraudRepository.composeProfileEntity(result),
				user: result.user ?? undefined,
			};
		} catch (error) {
			throw this.handleError(error, "get user fraud profile");
		}
	}

	/**
	 * List high-risk users
	 */
	async listHighRiskUsers(query?: {
		page?: number;
		limit?: number;
	}): Promise<ListResult<UserFraudProfile>> {
		try {
			const { page = 1, limit = 20 } = query ?? {};
			const offset = (page - 1) * limit;

			const result = await this.db.query.userFraudProfile.findMany({
				where: eq(tables.userFraudProfile.isHighRisk, true),
				orderBy: desc(tables.userFraudProfile.riskScore),
				offset,
				limit,
				with: {
					user: {
						columns: { id: true, name: true, email: true, role: true },
					},
				},
			});

			const rows = result.map((item) => ({
				...FraudRepository.composeProfileEntity(item),
				user: item.user ?? undefined,
			}));

			const [countResult] = await this.db
				.select({ count: count() })
				.from(tables.userFraudProfile)
				.where(eq(tables.userFraudProfile.isHighRisk, true));

			const totalCount = countResult?.count ?? 0;
			const totalPages = Math.ceil(totalCount / limit);

			return { rows, totalPages };
		} catch (error) {
			this.handleError(error, "list high risk users");
			return { rows: [] };
		}
	}

	/**
	 * Check for recent registrations from an IP address
	 */
	async getRecentIpRegistrations(
		ipAddress: string,
		windowHours = 24,
	): Promise<Array<{ userId: string; registeredAt: Date }>> {
		try {
			const windowStart = new Date(Date.now() - windowHours * 60 * 60 * 1000);

			const result = await this.db.query.fraudEvent.findMany({
				where: (f, op) =>
					op.and(
						op.eq(f.ipAddress, ipAddress),
						op.gte(f.detectedAt, windowStart),
						op.eq(f.eventType, "DUPLICATE_IP_PATTERN"),
					),
				columns: { userId: true, detectedAt: true },
			});

			return result
				.filter((r) => r.userId !== null)
				.map((r) => ({
					userId: r.userId as string,
					registeredAt: r.detectedAt,
				}));
		} catch (error) {
			logger.error(
				{ error, ipAddress },
				"[FraudRepository] Failed to get IP registrations",
			);
			return [];
		}
	}

	/**
	 * Check for existing bank accounts in driver table
	 */
	async checkBankAccountExists(
		params: { bankAccountNumber: string },
		opts?: PartialWithTx,
	): Promise<Array<{ bankAccountNumber: string; userId: string }>> {
		const { bankAccountNumber } = params;
		try {
			const db = opts?.tx ?? this.db;
			// Query actual driver records for matching bank account numbers
			const drivers = await db.query.driver.findMany({
				columns: { userId: true, bank: true },
			});

			const matches: Array<{ bankAccountNumber: string; userId: string }> = [];

			for (const driver of drivers) {
				const bank = driver.bank as { number?: number } | null;
				// Compare as strings to handle numeric bank numbers
				if (
					bank?.number !== undefined &&
					String(bank.number) === bankAccountNumber
				) {
					matches.push({
						bankAccountNumber,
						userId: driver.userId,
					});
				}
			}

			return matches;
		} catch (error) {
			logger.error({ error }, "[FraudRepository] Failed to check bank account");
			return [];
		}
	}

	/**
	 * Get recent registrations from an IP address (from user table createdAt)
	 * This queries actual user registrations, not fraud events
	 */
	async getRecentRegistrationsByIp(
		params: {
			ipAddress: string;
			windowHours?: number;
		},
		opts?: PartialWithTx,
	): Promise<Array<{ userId: string; registeredAt: Date }>> {
		const { ipAddress, windowHours = 24 } = params;
		try {
			const db = opts?.tx ?? this.db;

			const windowStart = new Date(Date.now() - windowHours * 60 * 60 * 1000);

			// Query user fraud profiles that have this IP in their known IPs
			const profiles = await db.query.userFraudProfile.findMany({
				where: (f, op) => op.gte(f.createdAt, windowStart),
				columns: { userId: true, knownIps: true, createdAt: true },
			});

			const registrations: Array<{ userId: string; registeredAt: Date }> = [];

			for (const profile of profiles) {
				const knownIps = profile.knownIps as string[];
				if (knownIps.includes(ipAddress)) {
					registrations.push({
						userId: profile.userId,
						registeredAt: profile.createdAt,
					});
				}
			}

			return registrations;
		} catch (error) {
			logger.error(
				{ error, ipAddress },
				"[FraudRepository] Failed to get registrations by IP",
			);
			return [];
		}
	}

	/**
	 * Find users with similar names for duplicate detection
	 */
	async findSimilarUserNames(
		params: { name: string; threshold?: number },
		opts?: PartialWithTx,
	): Promise<Array<{ userId: string; name: string; similarity: number }>> {
		const { name, threshold = 0.8 } = params;
		try {
			const db = opts?.tx ?? this.db;
			const { DuplicateAccountService } = await import(
				"./services/duplicate-account-service"
			);

			// Get all users (limit to recent for performance)
			const users = await db.query.user.findMany({
				columns: { id: true, name: true },
				limit: 1000,
				orderBy: desc(tables.user.createdAt),
			});

			return DuplicateAccountService.findSimilarNames(
				name,
				users.map((u) => ({ userId: u.id, name: u.name })),
				threshold,
			);
		} catch (error) {
			logger.error({ error }, "[FraudRepository] Failed to find similar names");
			return [];
		}
	}

	/**
	 * Record an IP address for a user registration
	 * Creates or updates the user fraud profile with the IP
	 */
	async recordRegistrationIp(
		userId: string,
		ipAddress: string,
		opts?: PartialWithTx,
	): Promise<void> {
		try {
			const tx = opts?.tx ?? this.db;

			// Check if profile exists
			const existing = await tx.query.userFraudProfile.findFirst({
				where: (f, op) => op.eq(f.userId, userId),
			});

			if (existing) {
				const knownIps = [
					...new Set([...((existing.knownIps as string[]) ?? []), ipAddress]),
				];
				await tx
					.update(tables.userFraudProfile)
					.set({ knownIps })
					.where(eq(tables.userFraudProfile.id, existing.id));
			} else {
				await tx.insert(tables.userFraudProfile).values({
					id: v7(),
					userId,
					totalEvents: 0,
					confirmedEvents: 0,
					riskScore: "0",
					isHighRisk: false,
					knownIps: [ipAddress],
					lastEventAt: null,
				});
			}

			logger.info(
				{ userId, ipAddress },
				"[FraudRepository] Recorded registration IP",
			);
		} catch (error) {
			logger.error(
				{ error, userId, ipAddress },
				"[FraudRepository] Failed to record registration IP",
			);
		}
	}
}
