part of '_export.dart';

/// State for [DriverHomeCubit].
///
/// This state contains WebSocket-related data and order state for the home screen.
/// For driver profile data and stats, use [DriverProfileState] from [DriverProfileCubit].
class DriverHomeState extends Equatable {
  const DriverHomeState({
    this.currentOrder,
    this.incomingOrder,
    this.currentLocation,
  });

  /// Current active order being handled by the driver.
  final Order? currentOrder;

  /// Incoming order offer from WebSocket.
  final Order? incomingOrder;

  /// Current GPS location of the driver (updated in real-time when online).
  final Coordinate? currentLocation;

  @override
  List<Object?> get props => [currentOrder, incomingOrder, currentLocation];

  @override
  bool get stringify => true;

  DriverHomeState copyWith({
    Order? currentOrder,
    Order? incomingOrder,
    Coordinate? currentLocation,
  }) {
    return DriverHomeState(
      currentOrder: currentOrder ?? this.currentOrder,
      incomingOrder: incomingOrder ?? this.incomingOrder,
      currentLocation: currentLocation ?? this.currentLocation,
    );
  }
}
