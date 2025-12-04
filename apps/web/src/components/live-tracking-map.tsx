import type { Location } from "@repo/schema/position";
import {
	AdvancedMarker,
	APIProvider,
	InfoWindow,
	Map as MapView,
	Pin,
	useAdvancedMarkerRef,
	useMap,
} from "@vis.gl/react-google-maps";
import { useTheme } from "next-themes";
import { useEffect, useState } from "react";
import { Badge } from "./ui/badge";
import { Card, CardContent } from "./ui/card";

interface LiveTrackingMapProps {
	pickup: Location;
	delivery: Location;
	driverLocation?: Location | null;
	driverName?: string;
	orderStatus?: string;
	eta?: string;
	distance?: string;
}

/**
 * Live tracking map component with real-time driver location updates
 *
 * Features:
 * - Animated driver marker
 * - Info window with driver details
 * - Auto-fit bounds to show all markers
 * - Status badges
 * - ETA and distance display
 */
export const LiveTrackingMap = ({
	pickup,
	delivery,
	driverLocation,
	driverName,
	orderStatus,
	eta,
	distance,
}: LiveTrackingMapProps) => {
	const { theme } = useTheme();

	return (
		<div className="space-y-4">
			{/* Status Card */}
			{(orderStatus || eta || distance) && (
				<Card>
					<CardContent className="flex items-center justify-between gap-4 p-4">
						{orderStatus && (
							<div className="flex items-center gap-2">
								<span className="text-muted-foreground text-sm">Status:</span>
								<Badge variant="default">{formatStatus(orderStatus)}</Badge>
							</div>
						)}
						{eta && (
							<div className="flex items-center gap-2">
								<span className="text-muted-foreground text-sm">ETA:</span>
								<span className="font-medium text-sm">{eta}</span>
							</div>
						)}
						{distance && (
							<div className="flex items-center gap-2">
								<span className="text-muted-foreground text-sm">Distance:</span>
								<span className="font-medium text-sm">{distance}</span>
							</div>
						)}
					</CardContent>
				</Card>
			)}

			{/* Map */}
			<APIProvider apiKey={import.meta.env.VITE_GOOGLE_MAPS_API_KEY}>
				<MapView
					mapId="live-tracking-map"
					style={{
						height: "500px",
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
						driverName={driverName}
					/>
				</MapView>
			</APIProvider>

			{/* Legend */}
			<div className="flex items-center justify-center gap-6 text-sm">
				<div className="flex items-center gap-2">
					<div className="h-3 w-3 rounded-full bg-green-500" />
					<span className="text-muted-foreground">Pickup</span>
				</div>
				<div className="flex items-center gap-2">
					<div className="h-3 w-3 rounded-full bg-red-500" />
					<span className="text-muted-foreground">Delivery</span>
				</div>
				{driverLocation && (
					<div className="flex items-center gap-2">
						<div className="h-3 w-3 rounded-full bg-blue-500" />
						<span className="text-muted-foreground">Driver</span>
					</div>
				)}
			</div>
		</div>
	);
};

interface MapLogicProps {
	pickup: Location;
	delivery: Location;
	driverLocation?: Location | null;
	driverName?: string;
}

const MapLogic = ({
	pickup,
	delivery,
	driverLocation,
	driverName,
}: MapLogicProps) => {
	const map = useMap();
	const [driverMarkerRef, driverMarker] = useAdvancedMarkerRef();
	const [showDriverInfo, setShowDriverInfo] = useState(false);

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

			map.fitBounds(bounds, { top: 80, right: 80, bottom: 80, left: 80 });
		} catch (error) {
			console.error("Failed to fit map bounds:", error);
		}
	}, [map, pickup, delivery, driverLocation]);

	return (
		<>
			{/* Pickup marker (green) */}
			<AdvancedMarker position={pickup} title="Pickup Location">
				<Pin
					background="#22c55e"
					glyphColor="#fff"
					borderColor="#16a34a"
					scale={1.2}
				/>
			</AdvancedMarker>

			{/* Delivery marker (red) */}
			<AdvancedMarker position={delivery} title="Delivery Location">
				<Pin
					background="#ef4444"
					glyphColor="#fff"
					borderColor="#dc2626"
					scale={1.2}
				/>
			</AdvancedMarker>

			{/* Driver marker (blue) with info window */}
			{driverLocation && (
				<>
					<AdvancedMarker
						ref={driverMarkerRef}
						position={driverLocation}
						title={driverName || "Driver"}
						onClick={() => setShowDriverInfo((prev) => !prev)}
					>
						<Pin
							background="#3b82f6"
							glyphColor="#fff"
							borderColor="#2563eb"
							scale={1.4}
						>
							<div className="flex h-8 w-8 items-center justify-center rounded-full bg-blue-500 text-white shadow-lg">
								🚗
							</div>
						</Pin>
					</AdvancedMarker>

					{showDriverInfo && driverMarker && (
						<InfoWindow
							anchor={driverMarker}
							onCloseClick={() => setShowDriverInfo(false)}
						>
							<div className="p-2">
								<p className="font-semibold text-sm">
									{driverName || "Driver"}
								</p>
								<p className="text-muted-foreground text-xs">
									En route to pickup/delivery
								</p>
							</div>
						</InfoWindow>
					)}
				</>
			)}
		</>
	);
};

const formatStatus = (status: string): string => {
	const statusMap: Record<string, string> = {
		REQUESTED: "Requested",
		MATCHING: "Finding Driver...",
		ACCEPTED: "Driver Accepted",
		PREPARING: "Preparing Order",
		READY_FOR_PICKUP: "Ready for Pickup",
		ARRIVING: "Driver Arriving",
		IN_TRIP: "On the Way",
		COMPLETED: "Completed",
		CANCELLED: "Cancelled",
	};
	return statusMap[status] || status;
};
