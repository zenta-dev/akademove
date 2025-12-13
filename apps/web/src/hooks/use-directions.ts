import type { Location } from "@repo/schema/position";
import { useMapsLibrary } from "@vis.gl/react-google-maps";
import { useEffect, useState } from "react";

interface DirectionsResult {
	routes: google.maps.DirectionsRoute[];
	loading: boolean;
	error: string | null;
}

interface UseDirectionsOptions {
	origin: Location | null;
	destination: Location | null;
	enabled?: boolean;
}

/**
 * Hook to fetch directions between two locations using Google Directions API
 *
 * @param options - The origin and destination locations
 * @returns DirectionsResult with routes, loading state, and error
 */
export function useDirections({
	origin,
	destination,
	enabled = true,
}: UseDirectionsOptions): DirectionsResult {
	const routesLibrary = useMapsLibrary("routes");
	const [directionsService, setDirectionsService] =
		useState<google.maps.DirectionsService | null>(null);
	const [routes, setRoutes] = useState<google.maps.DirectionsRoute[]>([]);
	const [loading, setLoading] = useState(false);
	const [error, setError] = useState<string | null>(null);

	// Initialize DirectionsService when library is loaded
	useEffect(() => {
		if (!routesLibrary) return;
		setDirectionsService(new routesLibrary.DirectionsService());
	}, [routesLibrary]);

	// Fetch directions when origin/destination change
	useEffect(() => {
		if (!directionsService || !origin || !destination || !enabled) {
			return;
		}

		setLoading(true);
		setError(null);

		directionsService
			.route({
				origin: { lat: origin.lat, lng: origin.lng },
				destination: { lat: destination.lat, lng: destination.lng },
				travelMode: google.maps.TravelMode.DRIVING,
				provideRouteAlternatives: false,
			})
			.then((response) => {
				setRoutes(response.routes);
				setLoading(false);
			})
			.catch((err) => {
				console.error("Directions request failed:", err);
				setError(err.message || "Failed to fetch directions");
				setRoutes([]);
				setLoading(false);
			});
	}, [directionsService, origin, destination, enabled]);

	return { routes, loading, error };
}

/**
 * Hook to render a polyline on the map from DirectionsRoute
 * Returns the path coordinates that can be used with google.maps.Polyline
 */
export function useRoutePolyline(route: google.maps.DirectionsRoute | null): {
	path: google.maps.LatLng[];
	bounds: google.maps.LatLngBounds | null;
} {
	const [path, setPath] = useState<google.maps.LatLng[]>([]);
	const [bounds, setBounds] = useState<google.maps.LatLngBounds | null>(null);

	useEffect(() => {
		if (!route || !route.legs || route.legs.length === 0) {
			setPath([]);
			setBounds(null);
			return;
		}

		// Extract path from all legs
		const allPoints: google.maps.LatLng[] = [];
		for (const leg of route.legs) {
			for (const step of leg.steps) {
				if (step.path) {
					allPoints.push(...step.path);
				}
			}
		}

		setPath(allPoints);
		setBounds(route.bounds || null);
	}, [route]);

	return { path, bounds };
}

/**
 * Simple hook to get route coordinates as an array of {lat, lng} objects
 * Useful for rendering with Polyline component
 */
export function useRouteCoordinates(
	origin: Location | null,
	destination: Location | null,
	enabled = true,
): {
	coordinates: Array<{ lat: number; lng: number }>;
	loading: boolean;
	error: string | null;
} {
	const { routes, loading, error } = useDirections({
		origin,
		destination,
		enabled,
	});

	const [coordinates, setCoordinates] = useState<
		Array<{ lat: number; lng: number }>
	>([]);

	useEffect(() => {
		if (routes.length === 0 || !routes[0]?.overview_path) {
			setCoordinates([]);
			return;
		}

		const path = routes[0].overview_path;
		const coords = path.map((point) => ({
			lat: point.lat(),
			lng: point.lng(),
		}));
		setCoordinates(coords);
	}, [routes]);

	return { coordinates, loading, error };
}
