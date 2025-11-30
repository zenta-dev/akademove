part of '_export.dart';

class EstimateOrderResult {
  const EstimateOrderResult({
    required this.summary,
    required this.pickup,
    required this.dropoff,
  });

  final OrderSummary summary;
  final Place pickup;
  final Place dropoff;
}

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserRideState extends BaseState2 with UserRideStateMappable {
  UserRideState({
    this.nearbyDrivers = const [],
    this.nearbyPlaces = const PageTokenPaginationResult<List<Place>>(data: []),
    this.searchPlaces = const PageTokenPaginationResult<List<Place>>(data: []),
    this.mapController,
    super.state,
    super.message,
    super.error,
  });

  final List<Driver> nearbyDrivers;
  final PageTokenPaginationResult<List<Place>> nearbyPlaces;
  final PageTokenPaginationResult<List<Place>> searchPlaces;
  final GoogleMapController? mapController;

  @override
  UserRideState toInitial() => copyWith(
    state: CubitState.initial,
    message: null,
    error: null,
  );

  @override
  UserRideState toLoading() => copyWith(
    state: CubitState.loading,
    message: null,
    error: null,
  );

  @override
  UserRideState toSuccess({
    List<Driver>? nearbyDrivers,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
    nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
    searchPlaces: searchPlaces ?? this.searchPlaces,
    message: message,
    error: null,
  );

  @override
  UserRideState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message,
  );

  UserRideState setMapController(GoogleMapController con) =>
      copyWith(mapController: con);
}
