// ignore_for_file: public_member_api_docs, sort_constructors_first

part of '_export.dart';

class UserMapState extends Equatable {
  const UserMapState({
    this.routeCoordinates = const OperationResult.idle(),
    this.routeInfo = const OperationResult.idle(),
    this.markers = const {},
    this.polylines = const {},
  });

  final OperationResult<List<Coordinate>> routeCoordinates;
  final OperationResult<DistanceWithDuration?> routeInfo;

  final Set<Marker> markers;
  final Set<Polyline> polylines;

  @override
  bool get stringify => true;

  UserMapState copyWith({
    OperationResult<List<Coordinate>>? routeCoordinates,
    OperationResult<DistanceWithDuration?>? routeInfo,
    Set<Marker>? markers,
    Set<Polyline>? polylines,
  }) {
    return UserMapState(
      routeCoordinates: routeCoordinates ?? this.routeCoordinates,
      routeInfo: routeInfo ?? this.routeInfo,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
    );
  }

  @override
  List<Object> get props => [routeCoordinates, routeInfo, markers, polylines];
}
