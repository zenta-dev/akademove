/**
 * OrderMatchingService - Handles driver matching logic for orders
 *
 * SOLID Principles:
 * - SRP: Single responsibility for driver matching
 * - OCP: Open for extension with new matching strategies
 * - DIP: Depends on database interface, not concrete implementation
 */

import type { Driver } from "@repo/schema/driver";
import type { GenderPreference, OrderType } from "@repo/schema/order";
import type { UserGender } from "@repo/schema/user";
import { and, eq, isNull, lt, or, sql } from "drizzle-orm";
import { BUSINESS_CONSTANTS, ERROR_MESSAGES } from "@/core/constants";
import { RepositoryError } from "@/core/error";
import type { DatabaseService, DatabaseTransaction } from "@/core/services/db";
import { tables } from "@/core/services/db";
import { log } from "@/utils";

export interface MatchingCriteria {
	pickupLocation: { x: number; y: number };
	orderType: OrderType;
	genderPreference?: GenderPreference;
	userGender?: UserGender;
	radiusKm?: number;
}

export interface MatchedDriver {
	driver: Partial<Driver>;
	distance: number;
}

/**
 * OrderMatchingService
 *
 * Responsibilities:
 * - Find available drivers within radius
 * - Apply gender preference filters
 * - Apply rating-based prioritization
 * - Check driver schedule availability
 */
export class OrderMatchingService {
	constructor(private readonly db: DatabaseService) {}

	/**
	 * Find the best available driver for an order
	 *
	 * Algorithm:
	 * 1. Query drivers within radius using PostGIS
	 * 2. Filter by online status and availability
	 * 3. Apply gender preference if requested
	 * 4. Sort by rating (highest first)
	 * 5. Return top match
	 *
	 * @param criteria - Matching criteria
	 * @param opts - Transaction options
	 * @returns Matched driver or null if none available
	 */
	async findBestDriver(
		criteria: MatchingCriteria,
		opts?: { tx?: DatabaseTransaction },
	): Promise<MatchedDriver | null> {
		try {
			const radiusKm =
				criteria.radiusKm ?? BUSINESS_CONSTANTS.DRIVER_MATCHING_RADIUS_KM;
			const radiusMeters = radiusKm * 1000;

			log.debug(
				{ criteria, radiusKm },
				"[OrderMatchingService] Finding best driver",
			);

			const db = opts?.tx ?? this.db;

			// Build query with PostGIS spatial filtering
			const drivers = await db
				.select({
					id: tables.driver.id,
					userId: tables.driver.userId,
					rating: tables.driver.rating,
					currentLocation: tables.driver.currentLocation,
					isTakingOrder: tables.driver.isTakingOrder,
					isOnline: tables.driver.isOnline,
					gender: tables.user.gender,
					distance: sql<number>`ST_Distance(
						${tables.driver.currentLocation}::geography,
						ST_SetSRID(ST_MakePoint(${criteria.pickupLocation.x}, ${criteria.pickupLocation.y}), 4326)::geography
					)`.as("distance"),
				})
				.from(tables.driver)
				.leftJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(
					and(
						// Driver must be online and not taking another order
						eq(tables.driver.isOnline, true),
						eq(tables.driver.isTakingOrder, false),
						eq(tables.driver.status, "ACTIVE"),
						// Driver must be within radius
						sql`ST_DWithin(
							${tables.driver.currentLocation}::geography,
							ST_SetSRID(ST_MakePoint(${criteria.pickupLocation.x}, ${criteria.pickupLocation.y}), 4326)::geography,
							${radiusMeters}
						)`,
						// Gender preference filter
						this.#buildGenderFilter(criteria),
						// Check cancellation count (not exceeded daily limit)
						or(
							isNull(tables.driver.lastCancellationDate),
							lt(
								tables.driver.cancellationCount,
								BUSINESS_CONSTANTS.DRIVER_MAX_CANCELLATIONS_PER_DAY,
							),
							// Reset count if last cancellation was yesterday
							sql`DATE(${tables.driver.lastCancellationDate}) < CURRENT_DATE`,
						),
					),
				)
				.orderBy(
					// Prioritize by rating (higher is better)
					sql`${tables.driver.rating} DESC`,
					// Then by distance (closer is better)
					sql`distance ASC`,
				)
				.limit(1);

			if (drivers.length === 0) {
				log.warn(
					{ criteria, radiusKm },
					"[OrderMatchingService] No drivers found",
				);
				return null;
			}

			const matchedDriver = drivers[0];
			const distanceKm = Number((matchedDriver.distance / 1000).toFixed(2));

			log.info(
				{
					driverId: matchedDriver.id,
					distanceKm,
					rating: matchedDriver.rating,
				},
				"[OrderMatchingService] Driver matched",
			);

			return {
				driver: matchedDriver as unknown as Partial<Driver>,
				distance: distanceKm,
			};
		} catch (error) {
			log.error({ error, criteria }, "[OrderMatchingService] Matching failed");
			throw new RepositoryError(ERROR_MESSAGES.DRIVER_NOT_AVAILABLE, {
				code: "NOT_FOUND",
			});
		}
	}

	/**
	 * Find multiple available drivers for broadcasting
	 *
	 * @param criteria - Matching criteria
	 * @param limit - Maximum number of drivers to return
	 * @param opts - Transaction options
	 * @returns List of matched drivers
	 */
	async findAvailableDrivers(
		criteria: MatchingCriteria,
		limit = 10,
		opts?: { tx?: DatabaseTransaction },
	): Promise<MatchedDriver[]> {
		try {
			const radiusKm =
				criteria.radiusKm ?? BUSINESS_CONSTANTS.DRIVER_MATCHING_RADIUS_KM;
			const radiusMeters = radiusKm * 1000;

			const db = opts?.tx ?? this.db;

			const drivers = await db
				.select({
					id: tables.driver.id,
					userId: tables.driver.userId,
					rating: tables.driver.rating,
					currentLocation: tables.driver.currentLocation,
					gender: tables.user.gender,
					distance: sql<number>`ST_Distance(
						${tables.driver.currentLocation}::geography,
						ST_SetSRID(ST_MakePoint(${criteria.pickupLocation.x}, ${criteria.pickupLocation.y}), 4326)::geography
					)`.as("distance"),
				})
				.from(tables.driver)
				.leftJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(
					and(
						eq(tables.driver.isOnline, true),
						eq(tables.driver.isTakingOrder, false),
						eq(tables.driver.status, "ACTIVE"),
						sql`ST_DWithin(
							${tables.driver.currentLocation}::geography,
							ST_SetSRID(ST_MakePoint(${criteria.pickupLocation.x}, ${criteria.pickupLocation.y}), 4326)::geography,
							${radiusMeters}
						)`,
						this.#buildGenderFilter(criteria),
					),
				)
				.orderBy(sql`${tables.driver.rating} DESC`, sql`distance ASC`)
				.limit(limit);

			return drivers.map((d) => ({
				driver: d as unknown as Partial<Driver>,
				distance: Number((d.distance / 1000).toFixed(2)),
			}));
		} catch (error) {
			log.error({ error, criteria }, "[OrderMatchingService] Search failed");
			throw new RepositoryError("Failed to find available drivers", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Build gender filter SQL based on criteria
	 */
	#buildGenderFilter(criteria: MatchingCriteria) {
		if (
			!criteria.genderPreference ||
			criteria.genderPreference === "ANY" ||
			!criteria.userGender
		) {
			// No filter needed
			return sql`1=1`;
		}

		// "SAME" preference - filter for matching gender
		return eq(tables.user.gender, criteria.userGender);
	}
}
