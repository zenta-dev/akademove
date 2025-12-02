part of '_export.dart';

class DeliveryDetails {
  const DeliveryDetails({
    required this.description,
    required this.weight,
    this.specialInstructions,
    this.itemPhotos = const [],
  });

  final String description;
  final double weight; // in kg
  final String? specialInstructions;
  final List<File> itemPhotos; // Max 3 photos
}

class DeliveryEstimateResult {
  const DeliveryEstimateResult({
    required this.summary,
    required this.pickup,
    required this.dropoff,
    required this.details,
  });

  final OrderSummary summary;
  final Place pickup;
  final Place dropoff;
  final DeliveryDetails details;
}

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserDeliveryState extends BaseState2 with UserDeliveryStateMappable {
  UserDeliveryState({
    this.nearbyDrivers = const [],
    this.pickup,
    this.dropoff,
    this.details,
    this.estimate,
    this.nearbyPlaces = const PageTokenPaginationResult<List<Place>>(data: []),
    this.searchPlaces = const PageTokenPaginationResult<List<Place>>(data: []),
    super.state,
    super.message,
    super.error,
  });

  final Place? pickup;
  final Place? dropoff;
  final DeliveryDetails? details;
  final DeliveryEstimateResult? estimate;
  final PageTokenPaginationResult<List<Place>> nearbyPlaces;
  final PageTokenPaginationResult<List<Place>> searchPlaces;
  final List<Driver> nearbyDrivers;

  @override
  UserDeliveryState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserDeliveryState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserDeliveryState toSuccess({
    Place? pickup,
    Place? dropoff,
    DeliveryDetails? details,
    DeliveryEstimateResult? estimate,
    PageTokenPaginationResult<List<Place>>? nearbyPlaces,
    PageTokenPaginationResult<List<Place>>? searchPlaces,
    List<Driver>? nearbyDrivers,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    pickup: pickup ?? this.pickup,
    dropoff: dropoff ?? this.dropoff,
    details: details ?? this.details,
    estimate: estimate ?? this.estimate,
    nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
    searchPlaces: searchPlaces ?? this.searchPlaces,
    nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
    message: message,
    error: null,
  );

  @override
  UserDeliveryState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
