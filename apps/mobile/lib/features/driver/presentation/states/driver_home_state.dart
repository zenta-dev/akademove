part of '_export.dart';

/// State for [DriverHomeCubit].
///
/// This state contains WebSocket-related data and order state for the home screen.
/// For driver profile data and stats, use [DriverProfileState] from [DriverProfileCubit].
class DriverHomeState extends Equatable {
  const DriverHomeState({this.currentOrder, this.incomingOrder});

  /// Current active order being handled by the driver.
  final Order? currentOrder;

  /// Incoming order offer from WebSocket.
  final Order? incomingOrder;

  @override
  List<Object?> get props => [currentOrder, incomingOrder];

  @override
  bool get stringify => true;

  DriverHomeState copyWith({Order? currentOrder, Order? incomingOrder}) {
    return DriverHomeState(
      currentOrder: currentOrder ?? this.currentOrder,
      incomingOrder: incomingOrder ?? this.incomingOrder,
    );
  }
}
