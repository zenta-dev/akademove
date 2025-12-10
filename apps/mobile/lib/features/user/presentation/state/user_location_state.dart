part of '_export.dart';

class UserLocationState extends Equatable {
  const UserLocationState({
    this.location = const OperationResult.idle(),
    this.markers = const {},
    this.polylines = const {},
  });

  final OperationResult<(Coordinate, Placemark?)> location;

  /// Markers for displaying on map (pickup, dropoff, drivers, etc.)
  final Set<Marker> markers;

  /// Polylines for displaying routes on map
  final Set<Polyline> polylines;

  Coordinate? get coordinate => location.value?.$1;
  Placemark? get placemark => location.value?.$2;

  /// Returns true if location data is available
  bool get hasLocation => coordinate != null;

  /// Returns true if location is currently being fetched
  bool get isLoading => location.isLoading;

  /// Returns true if location fetch failed
  bool get hasError => location.isFailure;

  /// Returns true if there are markers or polylines to display
  bool get hasMapData => markers.isNotEmpty || polylines.isNotEmpty;

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
