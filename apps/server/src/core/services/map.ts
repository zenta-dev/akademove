import type { Coordinate } from "@repo/schema/common";
import { log } from "@/utils";
import { MapError } from "../error";

export interface MapService {
	getRouteDistance(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<{ distanceMeters: number; durationSeconds: number }>;
}
interface GoogleMapsLeg {
	distance: { text: string; value: number };
	duration: { text: string; value: number };
}

interface GoogleMapsRoute {
	legs: GoogleMapsLeg[];
}

interface GoogleMapsResponse {
	status: string;
	routes: GoogleMapsRoute[];
	error_message?: string;
}

export class GoogleMapService implements MapService {
	#apiKey: string;

	constructor(apiKey: string) {
		if (!apiKey) throw new Error("Google Maps API key is required");
		this.#apiKey = apiKey;
	}

	async getRouteDistance(
		origin: Coordinate,
		destination: Coordinate,
	): Promise<{ distanceMeters: number; durationSeconds: number }> {
		try {
			const originStr = `${origin.y},${origin.x}`; // lat,lng
			const destStr = `${destination.y},${destination.x}`;

			const url = new URL(
				"https://maps.googleapis.com/maps/api/directions/json",
			);
			url.searchParams.set("origin", originStr);
			url.searchParams.set("destination", destStr);
			url.searchParams.set("mode", "driving");
			url.searchParams.set("key", this.#apiKey);

			const response = await fetch(url.toString(), { method: "GET" });

			if (!response.ok) {
				throw new MapError(`Google Maps API HTTP error: ${response.status}`);
			}

			const data: GoogleMapsResponse = await response.json();

			if (data.status !== "OK" || !data.routes?.length) {
				const message = data.error_message ?? data.status;
				throw new MapError(`Google Maps API error: ${message}`);
			}

			const leg = data.routes[0].legs[0];
			return {
				distanceMeters: leg.distance.value,
				durationSeconds: leg.duration.value,
			};
		} catch (error) {
			log.error(`[MapService] Error => ${error}`);
			throw error;
		}
	}
}
