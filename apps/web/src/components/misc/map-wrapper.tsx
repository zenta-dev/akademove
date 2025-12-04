/// <reference types="google.maps" />

import type { Location } from "@repo/schema/position";
import {
	APIProvider,
	Map as MapView,
	Marker,
	useMap,
	useMapsLibrary,
} from "@vis.gl/react-google-maps";
import { useTheme } from "next-themes";
import { useCallback, useEffect, useRef, useState } from "react";
import { Input } from "@/components/ui/input";

export const MapWrapper = ({
	value,
	onLocationChange,
}: {
	value?: Location;
	onLocationChange?: (location: Location) => void;
}) => {
	const inputRef = useRef<HTMLInputElement>(null);
	const { theme } = useTheme();

	return (
		<APIProvider apiKey={import.meta.env.VITE_GOOGLE_MAPS_API_KEY}>
			<div className="space-y-4">
				<Input
					ref={inputRef}
					type="text"
					placeholder="Search for a place..."
					className="w-full"
				/>
				<MapView
					mapId="merchant-map"
					style={{
						height: "50vh",
						width: "100%",
						borderRadius: 10,
						overflow: "hidden",
					}}
					defaultCenter={value ?? { lat: 0, lng: 0 }}
					defaultZoom={14}
					gestureHandling="greedy"
					disableDefaultUI={false}
					colorScheme={theme === "dark" ? "DARK" : "FOLLOW_SYSTEM"}
				>
					<MapLogic
						inputRef={inputRef}
						value={value}
						onLocationChange={onLocationChange}
					/>
				</MapView>
			</div>
		</APIProvider>
	);
};

const MapLogic = ({
	inputRef,
	value,
	onLocationChange,
}: {
	inputRef: React.RefObject<HTMLInputElement | null>;
	value?: Location;
	onLocationChange?: (location: Location) => void;
}) => {
	const map = useMap();
	const placesLib = useMapsLibrary("places");
	const [markerPosition, setMarkerPosition] = useState<Location | null>(null);
	const autocompleteRef = useRef<google.maps.places.Autocomplete | null>(null);
	const geolocationInitialized = useRef(false);

	const updateLocation = useCallback(
		(loc: Location) => {
			setMarkerPosition(loc);
			onLocationChange?.(loc);
		},
		[onLocationChange],
	);

	useEffect(() => {
		if (!map || geolocationInitialized.current) return;
		geolocationInitialized.current = true;

		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(
				(pos) => {
					const loc = { lat: pos.coords.latitude, lng: pos.coords.longitude };
					updateLocation(loc);
					map.setCenter(loc);
					map.setZoom(15);
				},
				(err) => {
					console.error("Geolocation error:", err);
					const defaultLoc = value ?? { lat: -6.2088, lng: 106.8456 }; // Jakarta fallback
					updateLocation(defaultLoc);
					map.setCenter(defaultLoc);
				},
				{ enableHighAccuracy: true, timeout: 10000, maximumAge: 0 },
			);
		}
	}, [map, updateLocation, value]);

	useEffect(() => {
		if (!map || !placesLib || !inputRef.current || autocompleteRef.current)
			return;

		const autocomplete = new placesLib.Autocomplete(inputRef.current, {
			fields: ["geometry", "name", "formatted_address"],
		});

		autocomplete.addListener("place_changed", () => {
			const place = autocomplete.getPlace();
			if (place.geometry?.location) {
				const loc = {
					lat: place.geometry.location.lat(),
					lng: place.geometry.location.lng(),
				};
				updateLocation(loc);
				map.panTo(loc);
				map.setZoom(17);
			}
		});

		autocompleteRef.current = autocomplete;

		return () => {
			if (autocompleteRef.current) {
				google.maps.event.clearInstanceListeners(autocompleteRef.current);
			}
		};
	}, [map, placesLib, inputRef, updateLocation]);

	const handleMarkerDrag = useCallback(
		(e: google.maps.MapMouseEvent) => {
			if (e.latLng) {
				updateLocation({ lat: e.latLng.lat(), lng: e.latLng.lng() });
			}
		},
		[updateLocation],
	);

	const handleMapClick = useCallback(
		(e: google.maps.MapMouseEvent) => {
			if (e.latLng) {
				updateLocation({ lat: e.latLng.lat(), lng: e.latLng.lng() });
			}
		},
		[updateLocation],
	);

	useEffect(() => {
		if (!map) return;
		const listener = map.addListener("click", handleMapClick);
		return () => listener.remove();
	}, [map, handleMapClick]);

	return markerPosition ? (
		<Marker position={markerPosition} draggable onDragEnd={handleMarkerDrag} />
	) : null;
};
