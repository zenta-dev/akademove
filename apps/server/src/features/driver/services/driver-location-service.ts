import type { Driver } from "@repo/schema/driver";
import { and, eq, isNotNull, sql } from "drizzle-orm";
import { RepositoryError } from "@/core/error";
import { type DatabaseService, tables } from "@/core/services/db";
import { logger } from "@/utils/logger";

/**
 * Service responsible for driver location tracking
 *
 * Handles:
 * - PostGIS-based nearby driver search
 * - Location update and validation
 * - Distance calculations
 *
 * @example
 * ```typescript
 * const locationService = new DriverLocationService(db);
 *
 * // Find nearby drivers
 * const drivers = await locationService.findNearby({
 *   lat: -6.2088,
 *   lng: 106.8456,
 *   radiusKm: 10,
 *   gender: "MALE"
 * });
 * ```
 */
export class DriverLocationService {
	readonly #db: DatabaseService;

	constructor(db: DatabaseService) {
		this.#db = db;
	}

	/**
	 * Finds available drivers within radius using PostGIS
	 *
	 * Filters:
	 * - isOnline = true
	 * - isTakingOrder = false
	 * - status = ACTIVE
	 * - quizStatus = PASSED
	 * - emailVerified = true
	 * - currentLocation is not null
	 * - Within radiusKm distance
	 * - Optional gender match
	 *
	 * Orders by distance (nearest first)
	 *
	 * @param query - Search parameters
	 * @param deps - Dependency functions for storage
	 * @returns Array of drivers with distance metadata
	 */
	async findNearby(
		query: {
			lat: number;
			lng: number;
			radiusKm?: number;
			limit?: number;
			gender?: "MALE" | "FEMALE";
		},
		deps: {
			composeEntity: (
				driver: typeof tables.driver.$inferSelect & {
					user: typeof tables.user.$inferSelect & {
						userBadges: never[];
					};
				},
			) => Promise<Driver>;
		},
	): Promise<Driver[]> {
		try {
			const { lat, lng, limit = 20, radiusKm = 10, gender } = query;

			// Create PostGIS point from lat/lng
			const point = sql`ST_SetSRID(ST_MakePoint(${lng}, ${lat}), 4326)::geography`;
			const distance = sql<number>`ST_Distance(${tables.driver.currentLocation}::geography, ${point})`;

			// Build where conditions
			const conditions = [
				eq(tables.driver.isOnline, true),
				eq(tables.driver.isTakingOrder, false),
				eq(tables.driver.status, "ACTIVE"), // Only active drivers can accept orders
				eq(tables.driver.quizStatus, "PASSED"), // Only drivers who passed the quiz can be matched
				eq(tables.user.emailVerified, true), // Only drivers with verified email can be matched
				isNotNull(tables.driver.currentLocation),
				sql`ST_DWithin(
					${tables.driver.currentLocation}::geography,
					${point},
					${radiusKm * 1000}
				)`,
			];

			if (gender) {
				conditions.push(eq(tables.user.gender, gender));
			}

			logger.info(
				{ lat, lng, radiusKm, limit, gender },
				"[DriverLocationService] Searching nearby drivers",
			);

			// Execute PostGIS query
			const result = await this.#db
				.select({
					driver: tables.driver,
					user: tables.user,
					distance: distance.as("distance_meters"),
				})
				.from(tables.driver)
				.innerJoin(tables.user, eq(tables.driver.userId, tables.user.id))
				.where(and(...conditions))
				.orderBy(distance)
				.limit(limit);

			logger.info(
				{ count: result.length },
				"[DriverLocationService] Found nearby drivers",
			);

			// Compose entities
			return await Promise.all(
				result.map((r) =>
					deps.composeEntity({
						...r.driver,
						user: { ...r.user, userBadges: [] },
					}),
				),
			);
		} catch (error) {
			logger.error(
				{ error, query },
				"[DriverLocationService] Failed to find nearby drivers",
			);
			throw new RepositoryError("Failed to find nearby drivers", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Updates driver's current location
	 *
	 * @param driverId - Driver ID
	 * @param lat - Latitude
	 * @param lng - Longitude
	 * @returns true if successful
	 */
	async updateLocation(
		driverId: string,
		lat: number,
		lng: number,
	): Promise<boolean> {
		try {
			if (!this.validateCoordinates(lat, lng)) {
				throw new RepositoryError("Invalid coordinates", {
					code: "BAD_REQUEST",
				});
			}

			// Create PostGIS point using raw SQL
			await this.#db.execute(sql`
				UPDATE ${tables.driver}
				SET 
					current_location = ST_SetSRID(ST_MakePoint(${lng}, ${lat}), 4326),
					last_location_update = ${new Date()}
				WHERE id = ${driverId}
			`);

			logger.info(
				{ driverId, lat, lng },
				"[DriverLocationService] Updated driver location",
			);

			return true;
		} catch (error) {
			logger.error(
				{ error, driverId, lat, lng },
				"[DriverLocationService] Failed to update location",
			);
			throw new RepositoryError("Failed to update driver location", {
				code: "INTERNAL_SERVER_ERROR",
			});
		}
	}

	/**
	 * Validates location coordinates
	 *
	 * @param lat - Latitude
	 * @param lng - Longitude
	 * @returns true if valid
	 */
	validateCoordinates(lat: number, lng: number): boolean {
		return lat >= -90 && lat <= 90 && lng >= -180 && lng <= 180;
	}
}
