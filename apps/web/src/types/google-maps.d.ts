// Google Maps API type declarations for polyline functionality
declare global {
	interface Window {
		google: typeof google;
	}
}

declare namespace google.maps {
	interface DirectionsService {
		route(
			request: DirectionsRequest,
			callback: (
				result: DirectionsResult | null,
				status: DirectionsStatus,
			) => void,
		): void;
	}

	interface DirectionsRequest {
		origin: LatLng | LatLngLiteral;
		destination: LatLng | LatLngLiteral;
		travelMode: TravelMode;
		provideRouteAlternatives?: boolean;
		avoidTolls?: boolean;
		avoidHighways?: boolean;
		avoidFerries?: boolean;
	}

	interface DirectionsResult {
		routes: DirectionsRoute[];
		geocoded_waypoints?: DirectionsGeocodedWaypoint[];
		request: DirectionsRequest;
		status: DirectionsStatus;
	}

	interface DirectionsRoute {
		bounds: LatLngBounds;
		copyrights: string;
		legs: DirectionsLeg[];
		overview_path: LatLng[];
		overview_polyline: string;
		warnings: DirectionsWarning[];
		waypoint_order: number[];
		fare?: TransitFare;
	}

	interface DirectionsLeg {
		start_address: string;
		end_address: string;
		start_location: LatLng;
		end_location: LatLng;
		start_place_id?: string;
		end_place_id?: string;
		steps: DirectionsStep[];
		transit?: TransitDetails;
		distance?: Distance;
		duration?: Duration;
		duration_in_traffic?: Duration;
		arrival_time?: Date;
		departure_time?: Date;
	}

	interface DirectionsStep {
		instructions: string;
		distance?: Distance;
		duration?: Duration;
		start_location: LatLng;
		end_location: LatLng;
		start_place_id?: string;
		end_place_id?: string;
		transit?: TransitDetails;
		travel_mode: TravelMode;
		path?: LatLng[];
	}

	interface Polyline {
		(opts?: PolylineOptions): Polyline;
		setMap(map: Map | null): void;
	}

	interface PolylineOptions {
		path: LatLng[] | MVCArray<LatLng>;
		geodesic?: boolean;
		strokeColor?: string;
		strokeOpacity?: number;
		strokeWeight?: number;
		map?: Map | null;
	}

	interface LatLngBounds {
		extend(point: LatLng | LatLngLiteral): void;
	}

	interface LatLng {
		lat(): number;
		lng(): number;
	}

	interface LatLngLiteral {
		lat: number;
		lng: number;
	}

	enum TravelMode {
		DRIVING = "DRIVING",
		WALKING = "WALKING",
		BICYCLING = "BICYCLING",
		TRANSIT = "TRANSIT",
	}

	enum DirectionsStatus {
		OK = "OK",
		NOT_FOUND = "NOT_FOUND",
		ZERO_RESULTS = "ZERO_RESULTS",
		MAX_WAYPOINTS_EXCEEDED = "MAX_WAYPOINTS_EXCEEDED",
		INVALID_REQUEST = "INVALID_REQUEST",
		OVER_QUERY_LIMIT = "OVER_QUERY_LIMIT",
		REQUEST_DENIED = "REQUEST_DENIED",
		UNKNOWN_ERROR = "UNKNOWN_ERROR",
	}

	interface Distance {
		text: string;
		value: number;
	}

	interface Duration {
		text: string;
		value: number;
	}

	interface TransitDetails {
		arrival_stop: TransitStop;
		departure_stop: TransitStop;
		headsign: string;
		headway: number;
		line: TransitLine;
		num_stops: number;
		transit_mode: TransitMode;
	}

	interface TransitFare {
		currency: string;
		value: number;
		text: string;
	}

	interface TransitStop {
		location: LatLng;
		name: string;
	}

	interface TransitLine {
		agencies: TransitAgency[];
		color: string;
		name: string;
		short_name: string;
		text_color: string;
		url: string;
		vehicle: TransitVehicle;
	}

	interface TransitAgency {
		name: string;
		phone: string;
		url: string;
	}

	enum TransitMode {
		BUS = "BUS",
		RAIL = "RAIL",
		SUBWAY = "SUBWAY",
		TRAM = "TRAM",
		FERRY = "FERRY",
	}

	interface TransitVehicle {
		icon?: string;
		local_icon?: string;
		name: string;
		type: TransitVehicleType;
	}

	enum TransitVehicleType {
		BUS = "BUS",
		CABLE_CAR = "CABLE_CAR",
		COMMUTER_TRAIN = "COMMUTER_TRAIN",
		FERRY = "FERRY",
		FUNICULAR = "FUNICULAR",
		GONDOLA_LIFT = "GONDOLA_LIFT",
		HEAVY_RAIL = "HEAVY_RAIL",
		HIGH_SPEED_TRAIN = "HIGH_SPEED_TRAIN",
		INTERCITY_BUS = "INTERCITY_BUS",
		METRO_RAIL = "METRO_RAIL",
		MONORAIL = "MONORAIL",
		OTHER = "OTHER",
		RAIL = "RAIL",
		SHARE_TAXI = "SHARE_TAXI",
		SUBWAY = "SUBWAY",
		TRAM = "TRAM",
		TROLLEYBUS = "TROLLEYBUS",
	}

	interface DirectionsWarning {
		driver?: string;
		highway?: string;
		toll?: string;
		ferry?: string;
		bridge?: string;
		indoor?: string;
		toll_road?: string;
		speed_limit?: string;
		weight_limit?: string;
		height_limit?: string;
		width_limit?: string;
		dirt_road?: string;
	}

	interface DirectionsGeocodedWaypoint {
		place_id: string;
		geocoder_status: GeocoderStatus;
		types: string[];
		partial_match?: boolean;
	}

	enum GeocoderStatus {
		OK = "OK",
		ZERO_RESULTS = "ZERO_RESULTS",
		INVALID_REQUEST = "INVALID_REQUEST",
		OVER_QUERY_LIMIT = "OVER_QUERY_LIMIT",
		REQUEST_DENIED = "REQUEST_DENIED",
		UNKNOWN_ERROR = "UNKNOWN_ERROR",
	}

	interface MVCArray<T> {
		getArray(): T[];
	}
}
