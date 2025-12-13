part of '_export.dart';

/// Unified state for order location-related operations.
/// Used by both Ride and Delivery order flows for:
/// - Fetching nearby drivers
/// - Fetching nearby places
/// - Searching places
/// - Managing map controller
class OrderLocationState extends Equatable {
  const OrderLocationState({
    this.nearbyDrivers = const OperationResult.idle(),
    this.nearbyPlaces = const OperationResult.idle(),
    this.searchPlaces = const OperationResult.idle(),
    this.mapController,
  });

  final OperationResult<List<Driver>> nearbyDrivers;
  final OperationResult<PageTokenPaginationResult<List<Place>>> nearbyPlaces;
  final OperationResult<PageTokenPaginationResult<List<Place>>> searchPlaces;
  final GoogleMapController? mapController;

  @override
  List<Object?> get props => [
    nearbyDrivers,
    nearbyPlaces,
    searchPlaces,
    mapController,
  ];

  OrderLocationState copyWith({
    OperationResult<List<Driver>>? nearbyDrivers,
    OperationResult<PageTokenPaginationResult<List<Place>>>? nearbyPlaces,
    OperationResult<PageTokenPaginationResult<List<Place>>>? searchPlaces,
    GoogleMapController? mapController,
  }) {
    return OrderLocationState(
      nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      searchPlaces: searchPlaces ?? this.searchPlaces,
      mapController: mapController ?? this.mapController,
    );
  }

  @override
  bool get stringify => true;
}
