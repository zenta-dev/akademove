import type { Location } from "@repo/schema/position";
import {
	APIProvider,
	Map as MapView,
	Marker,
	useMap,
} from "@vis.gl/react-google-maps";
import { useTheme } from "next-themes";
import { useEffect } from "react";

interface OrderTrackingMapProps {
	pickup: Location;
	delivery: Location;
	driverLocation?: Location;
	orderStatus?: string;
}

/**
 * Map component for tracking order delivery progress
 *
 * Displays:
 * - Pickup location (merchant)
 * - Delivery location (customer)
 * - Current driver location (if available)
 */
export const OrderTrackingMap = ({
	pickup,
	delivery,
	driverLocation,
}: OrderTrackingMapProps) => {
	const { theme } = useTheme();

	return (
		<APIProvider apiKey={import.meta.env.VITE_GOOGLE_MAPS_API_KEY}>
			<MapView
				mapId="order-tracking-map"
				style={{
					height: "400px",
					width: "100%",
					borderRadius: 8,
					overflow: "hidden",
				}}
				defaultCenter={pickup}
				defaultZoom={14}
				gestureHandling="greedy"
				disableDefaultUI={false}
				colorScheme={theme === "dark" ? "DARK" : "FOLLOW_SYSTEM"}
			>
				<MapLogic
					pickup={pickup}
					delivery={delivery}
					driverLocation={driverLocation}
				/>
			</MapView>
		</APIProvider>
	);
};

interface MapLogicProps {
	pickup: Location;
	delivery: Location;
	driverLocation?: Location;
}

const MapLogic = ({ pickup, delivery, driverLocation }: MapLogicProps) => {
	const map = useMap();

	// Fit bounds to show all markers
	useEffect(() => {
		if (!map) return;

		try {
			const bounds = new window.google.maps.LatLngBounds();
			bounds.extend(pickup);
			bounds.extend(delivery);
			if (driverLocation) {
				bounds.extend(driverLocation);
			}

			map.fitBounds(bounds, { top: 50, right: 50, bottom: 50, left: 50 });
		} catch (error) {
			console.error("Failed to fit map bounds:", error);
		}
	}, [map, pickup, delivery, driverLocation]);

	return (
		<>
			{/* Pickup marker (merchant) - green */}
			<Marker position={pickup} title="Pickup Location" />

			{/* Delivery marker (customer) - red */}
			<Marker position={delivery} title="Delivery Location" />

			{/* Driver marker (if available) - blue */}
			{driverLocation && (
				<Marker position={driverLocation} title="Driver Location" />
			)}
		</>
	);
};
