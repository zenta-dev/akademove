/**
 * Location type matching Emergency schema
 */
type Location = {
	latitude: number;
	longitude: number;
};

/**
 * Service responsible for emergency location management
 *
 * Handles:
 * - Conversion between Location objects and PostGIS POINT format
 * - Geographic coordinate validation
 * - Location formatting for database storage
 *
 * @example
 * ```typescript
 * // Convert location to PostGIS format for database storage
 * const pointString = EmergencyLocationService.toPostGISPoint({
 *   latitude: -6.200000,
 *   longitude: 106.816666
 * });
 * // Returns: "POINT(106.816666 -6.200000)"
 *
 * // Parse PostGIS point back to Location object
 * const location = EmergencyLocationService.fromPostGISPoint(point);
 * // Returns: { latitude: -6.200000, longitude: 106.816666 }
 * ```
 */
export class EmergencyLocationService {
	/**
	 * Converts Location object to PostGIS POINT string
	 *
	 * Format: POINT(longitude latitude)
	 * Note: PostGIS uses (lon, lat) order, not (lat, lon)
	 *
	 * @param location - Location with latitude and longitude
	 * @returns PostGIS POINT string
	 */
	static toPostGISPoint(location: Location): string {
		return `POINT(${location.longitude} ${location.latitude})`;
	}

	/**
	 * Converts Location object to PostGIS POINT string (nullable)
	 *
	 * @param location - Optional location
	 * @returns PostGIS POINT string or undefined
	 */
	static toPostGISPointOrUndefined(
		location: Location | undefined,
	): string | undefined {
		if (!location) return undefined;
		return EmergencyLocationService.toPostGISPoint(location);
	}

	/**
	 * Parses PostGIS POINT to Location object
	 *
	 * @param point - PostGIS point with x (longitude) and y (latitude)
	 * @returns Location object
	 */
	static fromPostGISPoint(point: { x: number; y: number }): Location {
		return {
			latitude: point.y,
			longitude: point.x,
		};
	}

	/**
	 * Parses PostGIS POINT to Location object (nullable)
	 *
	 * @param point - Optional PostGIS point
	 * @returns Location object or undefined
	 */
	static fromPostGISPointOrUndefined(
		point: { x: number; y: number } | null | undefined,
	): Location | undefined {
		if (!point) return undefined;
		return EmergencyLocationService.fromPostGISPoint(point);
	}

	/**
	 * Validates if location coordinates are within valid ranges
	 *
	 * - Latitude: -90 to 90
	 * - Longitude: -180 to 180
	 *
	 * @param location - Location to validate
	 * @returns true if valid
	 */
	static isValidLocation(location: Location): boolean {
		const { latitude, longitude } = location;
		return (
			latitude >= -90 && latitude <= 90 && longitude >= -180 && longitude <= 180
		);
	}

	/**
	 * Validates location and throws if invalid
	 *
	 * @param location - Location to validate
	 * @throws Error if location is invalid
	 */
	static validateLocation(location: Location): void {
		if (!EmergencyLocationService.isValidLocation(location)) {
			throw new Error(
				`Invalid location coordinates: lat=${location.latitude}, lon=${location.longitude}`,
			);
		}
	}
}
