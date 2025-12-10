part of '_export.dart';

class UserRideState extends Equatable {
  const UserRideState({
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

  UserRideState copyWith({
    OperationResult<List<Driver>>? nearbyDrivers,
    OperationResult<PageTokenPaginationResult<List<Place>>>? nearbyPlaces,
    OperationResult<PageTokenPaginationResult<List<Place>>>? searchPlaces,
    GoogleMapController? mapController,
  }) {
    return UserRideState(
      nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      searchPlaces: searchPlaces ?? this.searchPlaces,
      mapController: mapController ?? this.mapController,
    );
  }

  @override
  bool get stringify => true;
}
