part of '_export.dart';

// class DeliveryDetails {
//   const DeliveryDetails({
//     required this.description,
//     required this.weight,
//     this.specialInstructions,
//     this.itemPhotos = const [],
//   });

//   final String description;
//   final double weight; // in kg
//   final String? specialInstructions;
//   final List<File> itemPhotos; // Max 3 photos
// }

// class DeliveryEstimateResult {
//   const DeliveryEstimateResult({
//     required this.summary,
//     required this.pickup,
//     required this.dropoff,
//     required this.details,
//   });

//   final OrderSummary summary;
//   final Place pickup;
//   final Place dropoff;
//   final DeliveryDetails details;
// }

class UserDeliveryState extends Equatable {
  const UserDeliveryState({
    this.nearbyDrivers = const OperationResult.idle(),
    // this.pickup,
    // this.dropoff,
    // this.details,
    // this.estimate = const OperationResult.idle(),
    this.nearbyPlaces = const OperationResult.idle(),
    this.searchPlaces = const OperationResult.idle(),
  });

  // final Place? pickup;
  // final Place? dropoff;
  // final DeliveryDetails? details;
  // final OperationResult<DeliveryEstimateResult> estimate;
  final OperationResult<PageTokenPaginationResult<List<Place>>> nearbyPlaces;
  final OperationResult<PageTokenPaginationResult<List<Place>>> searchPlaces;
  final OperationResult<List<Driver>> nearbyDrivers;

  @override
  List<Object?> get props => [
    nearbyDrivers,
    // pickup,
    // dropoff,
    // details,
    // estimate,
    nearbyPlaces,
    searchPlaces,
  ];

  UserDeliveryState copyWith({
    Place? pickup,
    Place? dropoff,
    // DeliveryDetails? details,
    // OperationResult<DeliveryEstimateResult>? estimate,
    OperationResult<PageTokenPaginationResult<List<Place>>>? nearbyPlaces,
    OperationResult<PageTokenPaginationResult<List<Place>>>? searchPlaces,
    OperationResult<List<Driver>>? nearbyDrivers,
  }) {
    return UserDeliveryState(
      // pickup: pickup ?? this.pickup,
      // dropoff: dropoff ?? this.dropoff,
      // details: details ?? this.details,
      // estimate: estimate ?? this.estimate,
      nearbyPlaces: nearbyPlaces ?? this.nearbyPlaces,
      searchPlaces: searchPlaces ?? this.searchPlaces,
      nearbyDrivers: nearbyDrivers ?? this.nearbyDrivers,
    );
  }

  @override
  bool get stringify => true;
}
