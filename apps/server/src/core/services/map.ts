import type { Coordinate } from "@repo/schema/position";
import { log } from "@/utils";
import { MapError } from "../error";

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export interface Place {
	id: string;
	name: string;
	address?: string;
	lat: number;
	lng: number;
	types?: string[];
	rating?: number;
	distance?: number;
}

export interface PageTokenPaginationResult<T> {
	data: T;
	token?: string;
}

export interface RouteInfo {
	distanceMeters: number;
	durationSeconds: number;
}

export interface MapService {
	nearbyLocation(
		coordinate: Coordinate,
		options?: {
			radius?: number;
			type?: string;
			limit?: number;
			nextPageToken?: string;
		},
	): Promise<PageTokenPaginationResult<Place[]>>;

	searchPlace(
		query: string,
		options?: {
			limit?: number;
			nextPageToken?: string;
			coordinate?: Coordinate;
		},
	): Promise<PageTokenPaginationResult<Place[]>>;

	getRouteDistance(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<RouteInfo>;

	getRoutePolyline(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<Coordinate[]>;
}

// ---------------------------------------------------------------------------
// Places API (New) Response Types
// ---------------------------------------------------------------------------

interface PlacesSearchResponse {
	places?: Array<{
		id: string;
		displayName?: { text: string };
		formattedAddress?: string;
		location: {
			latitude: number;
			longitude: number;
		};
		types?: string[];
		rating?: number;
	}>;
	nextPageToken?: string;
}

// ---------------------------------------------------------------------------
// Routes API v2 Response Types
// ---------------------------------------------------------------------------

interface RoutesComputeResponse {
	routes: Array<{
		distanceMeters: number;
		duration: string;
		polyline: {
			encodedPolyline: string;
		};
		legs: Array<{
			distanceMeters: number;
			duration: string;
		}>;
	}>;
}

interface RouteMatrixResponse {
	routeMatrix: Array<{
		distanceMeters?: number;
		duration?: string;
		status?: { code: number };
	}>;
}

// ---------------------------------------------------------------------------
// Google Maps Service Implementation
// ---------------------------------------------------------------------------

export class GoogleMapService implements MapService {
	readonly #apiKey: string;
	readonly #timeout = 10000;

	constructor(apiKey: string) {
		if (!apiKey) throw new MapError("Google Maps API key is required");
		this.#apiKey = apiKey;
	}

	// ---------------------------------------------------------------------------
	// Nearby Search (Places API New)
	// ---------------------------------------------------------------------------

	async nearbyLocation(
		coordinate: Coordinate,
		options: {
			radius?: number;
			type?: string;
			limit?: number;
			nextPageToken?: string;
		} = {},
	): Promise<PageTokenPaginationResult<Place[]>> {
		const { radius = 1000, type = "point_of_interest", limit = 10 } = options;

		const body = {
			includedTypes: [type],
			maxResultCount: limit,
			locationRestriction: {
				circle: {
					center: {
						latitude: coordinate.y,
						longitude: coordinate.x,
					},
					radius,
				},
			},
		};

		const data = await this.#fetchPlaces<PlacesSearchResponse>(
			"https://places.googleapis.com/v1/places:searchNearby",
			body,
		);

		const places = (data.places || []).map((item) => ({
			id: item.id,
			name: item.displayName?.text || "",
			address: item.formattedAddress,
			lat: item.location.latitude,
			lng: item.location.longitude,
			types: item.types,
			rating: item.rating,
			distance: this.#haversine(coordinate, {
				x: item.location.longitude,
				y: item.location.latitude,
			}),
		}));

		return { data: places, token: data.nextPageToken };
	}

	// ---------------------------------------------------------------------------
	// Text Search (Places API New)
	// ---------------------------------------------------------------------------

	async searchPlace(
		query: string,
		options: {
			limit?: number;
			nextPageToken?: string;
			coordinate?: Coordinate;
		} = {},
	): Promise<PageTokenPaginationResult<Place[]>> {
		const { limit = 10, coordinate } = options;

		const body: Record<string, unknown> = {
			textQuery: query,
			maxResultCount: limit,
		};

		if (coordinate) {
			body.locationBias = {
				circle: {
					center: {
						latitude: coordinate.y,
						longitude: coordinate.x,
					},
					radius: 5000,
				},
			};
		}

		const data = await this.#fetchPlaces<PlacesSearchResponse>(
			"https://places.googleapis.com/v1/places:searchText",
			body,
		);

		const places = (data.places || []).map((item) => {
			const place: Place = {
				id: item.id,
				name: item.displayName?.text || "",
				address: item.formattedAddress,
				lat: item.location.latitude,
				lng: item.location.longitude,
				types: item.types,
				rating: item.rating,
			};

			if (coordinate) {
				place.distance = this.#haversine(coordinate, {
					x: place.lng,
					y: place.lat,
				});
			}

			return place;
		});

		return { data: places, token: data.nextPageToken };
	}

	// ---------------------------------------------------------------------------
	// Route Distance (Routes API v2 - ComputeRouteMatrix)
	// ---------------------------------------------------------------------------

	async getRouteDistance(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<RouteInfo> {
		const body = {
			origins: [
				{
					waypoint: {
						location: {
							latLng: {
								latitude: origin.y,
								longitude: origin.x,
							},
						},
					},
				},
			],
			destinations: [
				{
					waypoint: {
						location: {
							latLng: {
								latitude: destination.y,
								longitude: destination.x,
							},
						},
					},
				},
			],
			travelMode: "TWO_WHEELER",
			routingPreference: "TRAFFIC_AWARE_OPTIMAL",
		};

		const data = await this.#fetchRoutes<RouteMatrixResponse>(
			"https://routes.googleapis.com/distanceMatrix/v2:computeRouteMatrix",
			body,
			"routes.distanceMeters,routes.duration",
		);

		const element = data.routeMatrix?.[0];
		if (
			element?.distanceMeters &&
			element.duration &&
			element.status?.code === 0
		) {
			return {
				distanceMeters: element.distanceMeters,
				durationSeconds: this.#parseDuration(element.duration),
			};
		}

		// Fallback to straight-line distance
		return {
			distanceMeters: this.#haversine(origin, destination),
			durationSeconds: 0,
		};
	}

	// ---------------------------------------------------------------------------
	// Route Polyline (Routes API v2 - ComputeRoutes)
	// ---------------------------------------------------------------------------

	async getRoutePolyline(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<Coordinate[]> {
		const body = {
			origin: {
				location: {
					latLng: {
						latitude: origin.y,
						longitude: origin.x,
					},
				},
			},
			destination: {
				location: {
					latLng: {
						latitude: destination.y,
						longitude: destination.x,
					},
				},
			},
			travelMode: "TWO_WHEELER",
			routingPreference: "TRAFFIC_AWARE_OPTIMAL",
			polylineEncoding: "ENCODED_POLYLINE",
		};

		const data = await this.#fetchRoutes<RoutesComputeResponse>(
			"https://routes.googleapis.com/directions/v2:computeRoutes",
			body,
			"routes.distanceMeters,routes.duration,routes.polyline.encodedPolyline",
		);

		if (!data.routes?.length) return [];

		const route = data.routes[0];
		log.info(`Route: ${route.distanceMeters}m, ${route.duration}`);

		return this.#decodePolyline(route.polyline.encodedPolyline);
	}

	// ---------------------------------------------------------------------------
	// Private HTTP Methods
	// ---------------------------------------------------------------------------

	async #fetchPlaces<T>(
		url: string,
		body: Record<string, unknown>,
	): Promise<T> {
		return this.#post<T>(url, body, {
			"X-Goog-Api-Key": this.#apiKey,
			"X-Goog-FieldMask": "*",
		});
	}

	async #fetchRoutes<T>(
		url: string,
		body: Record<string, unknown>,
		fieldMask: string,
	): Promise<T> {
		return this.#post<T>(url, body, {
			"X-Goog-Api-Key": this.#apiKey,
			"X-Goog-FieldMask": fieldMask,
		});
	}

	async #post<T>(
		url: string,
		body: Record<string, unknown>,
		headers: Record<string, string>,
	): Promise<T> {
		const controller = new AbortController();
		const timeoutId = setTimeout(() => controller.abort(), this.#timeout);

		try {
			const response = await fetch(url, {
				method: "POST",
				headers: {
					"Content-Type": "application/json",
					...headers,
				},
				body: JSON.stringify(body),
				signal: controller.signal,
			});

			if (!response.ok) {
				const error = (await response.json().catch(() => ({}))) as {
					error: { message?: string };
				};
				throw new MapError(
					error.error?.message || `HTTP error: ${response.status}`,
				);
			}

			return await response.json();
		} catch (error) {
			if (error instanceof MapError) throw error;
			log.error(`[MapService] ${error}`);
			throw new MapError(`Failed to fetch: ${error}`);
		} finally {
			clearTimeout(timeoutId);
		}
	}

	// ---------------------------------------------------------------------------
	// Private Utility Methods
	// ---------------------------------------------------------------------------

	#parseDuration(duration: string): number {
		// Parse duration string like "123s" to seconds
		return Number.parseInt(duration.replace("s", ""), 10) || 0;
	}

	#haversine(from: Coordinate, to: Coordinate): number {
		const R = 6371000;
		const toRad = (d: number) => (d * Math.PI) / 180;
		const dLat = toRad(to.y - from.y);
		const dLon = toRad(to.x - from.x);
		const a =
			Math.sin(dLat / 2) ** 2 +
			Math.cos(toRad(from.y)) * Math.cos(toRad(to.y)) * Math.sin(dLon / 2) ** 2;
		return R * 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	}

	#decodePolyline(encoded: string): Coordinate[] {
		const coords: Coordinate[] = [];
		let index = 0;
		let lat = 0;
		let lng = 0;

		while (index < encoded.length) {
			let shift = 0;
			let result = 0;
			let byte: number;

			do {
				byte = encoded.charCodeAt(index++) - 63;
				result |= (byte & 0x1f) << shift;
				shift += 5;
			} while (byte >= 0x20);

			lat += result & 1 ? ~(result >> 1) : result >> 1;

			shift = 0;
			result = 0;

			do {
				byte = encoded.charCodeAt(index++) - 63;
				result |= (byte & 0x1f) << shift;
				shift += 5;
			} while (byte >= 0x20);

			lng += result & 1 ? ~(result >> 1) : result >> 1;

			coords.push({ x: lng / 1e5, y: lat / 1e5 });
		}

		return coords;
	}
}
