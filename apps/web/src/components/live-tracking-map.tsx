import { m } from "@repo/i18n";
import type { Location } from "@repo/schema/position";
import {
	AdvancedMarker,
	APIProvider,
	InfoWindow,
	Map as MapView,
	Pin,
	useAdvancedMarkerRef,
	useMap,
	useMapsLibrary,
} from "@vis.gl/react-google-maps";
import { useTheme } from "next-themes";
import { useEffect, useMemo, useRef, useState } from "react";
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
								<span className="text-muted-foreground text-sm">
									{m.tracking_status()}
								</span>
								<Badge variant="default">{formatStatus(orderStatus)}</Badge>
							</div>
						)}
						{eta && (
							<div className="flex items-center gap-2">
								<span className="text-muted-foreground text-sm">
									{m.tracking_eta()}
								</span>
								<span className="font-medium text-sm">{eta}</span>
							</div>
						)}
						{distance && (
							<div className="flex items-center gap-2">
								<span className="text-muted-foreground text-sm">
									{m.tracking_distance()}
								</span>
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
						orderStatus={orderStatus}
					/>
				</MapView>
			</APIProvider>

			{/* Legend */}
			<div className="flex flex-wrap items-center justify-center gap-6 text-sm">
				<div className="flex items-center gap-2">
					<div className="h-3 w-3 rounded-full bg-green-500" />
					<span className="text-muted-foreground">{m.tracking_pickup()}</span>
				</div>
				<div className="flex items-center gap-2">
					<div className="h-3 w-3 rounded-full bg-red-500" />
					<span className="text-muted-foreground">{m.tracking_delivery()}</span>
				</div>
				{driverLocation && (
					<div className="flex items-center gap-2">
						<div className="h-3 w-3 rounded-full bg-blue-500" />
						<span className="text-muted-foreground">{m.tracking_driver()}</span>
					</div>
				)}
				<div className="flex items-center gap-2">
					<div className="h-0.5 w-6 bg-blue-500" />
					<span className="text-muted-foreground">{m.tracking_route()}</span>
				</div>
			</div>
		</div>
	);
};

interface MapLogicProps {
	pickup: Location;
	delivery: Location;
	driverLocation?: Location | null;
	driverName?: string;
	orderStatus?: string;
}

const MapLogic = ({
	pickup,
	delivery,
	driverLocation,
	driverName,
	orderStatus,
}: MapLogicProps) => {
	const map = useMap();
	const routesLibrary = useMapsLibrary("routes");
	const [driverMarkerRef, driverMarker] = useAdvancedMarkerRef();
	const [showDriverInfo, setShowDriverInfo] = useState(false);

	// Refs for polyline instances
	const activeRouteRef = useRef<google.maps.Polyline | null>(null);
	const plannedRouteRef = useRef<google.maps.Polyline | null>(null);

	// Determine which route to show based on order status
	const isDriverHeadingToPickup = useMemo(() => {
		return orderStatus === "ACCEPTED" || orderStatus === "ARRIVING";
	}, [orderStatus]);

	const isInTrip = useMemo(() => {
		return orderStatus === "IN_TRIP";
	}, [orderStatus]);

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

	// Fetch and render polylines
	useEffect(() => {
		if (!map || !routesLibrary) return;

		const directionsService = new routesLibrary.DirectionsService();

		// Cleanup function to remove polylines
		const cleanup = () => {
			if (activeRouteRef.current) {
				activeRouteRef.current.setMap(null);
				activeRouteRef.current = null;
			}
			if (plannedRouteRef.current) {
				plannedRouteRef.current.setMap(null);
				plannedRouteRef.current = null;
			}
		};

		// Clean up existing polylines before creating new ones
		cleanup();

		const fetchAndDrawRoutes = async () => {
			try {
				// If driver is heading to pickup, show driver→pickup (highlighted) and pickup→delivery (dimmed)
				if (isDriverHeadingToPickup && driverLocation) {
					// Fetch driver to pickup route
					const driverToPickupResponse = await directionsService.route({
						origin: { lat: driverLocation.lat, lng: driverLocation.lng },
						destination: { lat: pickup.lat, lng: pickup.lng },
						travelMode: google.maps.TravelMode.DRIVING,
					});

					if (driverToPickupResponse.routes[0]) {
						activeRouteRef.current = new google.maps.Polyline({
							path: driverToPickupResponse.routes[0].overview_path,
							strokeColor: "#3b82f6", // Blue - active route
							strokeOpacity: 1.0,
							strokeWeight: 5,
							map,
						});
					}

					// Fetch pickup to delivery route (dimmed)
					const pickupToDeliveryResponse = await directionsService.route({
						origin: { lat: pickup.lat, lng: pickup.lng },
						destination: { lat: delivery.lat, lng: delivery.lng },
						travelMode: google.maps.TravelMode.DRIVING,
					});

					if (pickupToDeliveryResponse.routes[0]) {
						plannedRouteRef.current = new google.maps.Polyline({
							path: pickupToDeliveryResponse.routes[0].overview_path,
							strokeColor: "#3b82f6",
							strokeOpacity: 0.4, // Dimmed
							strokeWeight: 4,
							map,
							icons: [
								{
									icon: {
										path: "M 0,-1 0,1",
										strokeOpacity: 1,
										scale: 4,
									},
									offset: "0",
									repeat: "20px",
								},
							],
						});
					}
				}
				// If in trip, show driver→delivery (highlighted)
				else if (isInTrip && driverLocation) {
					const driverToDeliveryResponse = await directionsService.route({
						origin: { lat: driverLocation.lat, lng: driverLocation.lng },
						destination: { lat: delivery.lat, lng: delivery.lng },
						travelMode: google.maps.TravelMode.DRIVING,
					});

					if (driverToDeliveryResponse.routes[0]) {
						activeRouteRef.current = new google.maps.Polyline({
							path: driverToDeliveryResponse.routes[0].overview_path,
							strokeColor: "#3b82f6",
							strokeOpacity: 1.0,
							strokeWeight: 5,
							map,
						});
					}
				}
				// Fallback: show pickup→delivery
				else {
					const pickupToDeliveryResponse = await directionsService.route({
						origin: { lat: pickup.lat, lng: pickup.lng },
						destination: { lat: delivery.lat, lng: delivery.lng },
						travelMode: google.maps.TravelMode.DRIVING,
					});

					if (pickupToDeliveryResponse.routes[0]) {
						activeRouteRef.current = new google.maps.Polyline({
							path: pickupToDeliveryResponse.routes[0].overview_path,
							strokeColor: "#3b82f6",
							strokeOpacity: 1.0,
							strokeWeight: 4,
							map,
						});
					}
				}
			} catch (error) {
				console.error("Failed to fetch directions:", error);
				// Fallback to straight lines
				if (driverLocation && (isDriverHeadingToPickup || isInTrip)) {
					const destination = isDriverHeadingToPickup ? pickup : delivery;
					activeRouteRef.current = new google.maps.Polyline({
						path: [
							{ lat: driverLocation.lat, lng: driverLocation.lng },
							{ lat: destination.lat, lng: destination.lng },
						],
						strokeColor: "#3b82f6",
						strokeOpacity: 1.0,
						strokeWeight: 4,
						map,
					});
				}
			}
		};

		fetchAndDrawRoutes();

		return cleanup;
	}, [
		map,
		routesLibrary,
		pickup,
		delivery,
		driverLocation,
		isDriverHeadingToPickup,
		isInTrip,
	]);

	return (
		<>
			{/* Pickup marker (green) */}
			<AdvancedMarker position={pickup} title={m.tracking_pickup()}>
				<Pin
					background="#22c55e"
					glyphColor="#fff"
					borderColor="#16a34a"
					scale={1.2}
				/>
			</AdvancedMarker>

			{/* Delivery marker (red) */}
			<AdvancedMarker position={delivery} title={m.tracking_delivery()}>
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
						title={driverName || m.tracking_driver()}
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
									{driverName || m.tracking_driver()}
								</p>
								<p className="text-muted-foreground text-xs">
									{m.tracking_enroute()}
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
		REQUESTED: m.tracking_status_requested(),
		MATCHING: m.tracking_status_finding(),
		ACCEPTED: m.tracking_status_accepted(),
		PREPARING: m.tracking_status_preparing(),
		READY_FOR_PICKUP: m.tracking_status_ready(),
		ARRIVING: m.tracking_status_arriving(),
		IN_TRIP: m.tracking_status_onway(),
		COMPLETED: m.tracking_status_completed(),
		CANCELLED: m.tracking_status_cancelled(),
	};
	return statusMap[status] || status;
};
