part of '_export.dart';

class UserLocationState extends Equatable {
  const UserLocationState({
    this.location = const OperationResult.idle(),
    this.markers = const {},
    this.polylines = const {},
  });

  /// Current location with optional placemark
  final OperationResult<(Coordinate, Placemark?)> location;

  final Set<Marker> markers;
  final Set<Polyline> polylines;

  /// Convenience getter for coordinate
  Coordinate? get coordinate => location.value?.$1;

  /// Convenience getter for placemark
  Placemark? get placemark => location.value?.$2;

  @override
  List<Object> get props => [location, markers, polylines];

  UserLocationState copyWith({
    OperationResult<(Coordinate, Placemark?)>? location,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
  }) {
    return UserLocationState(
      location: location ?? this.location,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  bool get stringify => true;
}
