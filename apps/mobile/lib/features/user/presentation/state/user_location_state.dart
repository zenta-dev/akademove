part of '_export.dart';

class UserLocationState extends Equatable {
  const UserLocationState({this.location = const OperationResult.idle()});

  final OperationResult<(Coordinate, Placemark?)> location;

  Coordinate? get coordinate => location.value?.$1;
  Placemark? get placemark => location.value?.$2;

  @override
  List<Object> get props => [location];

  UserLocationState copyWith({
    OperationResult<(Coordinate, Placemark?)>? location,
  }) {
    return UserLocationState(location: location ?? this.location);
  }

  @override
  bool get stringify => true;
}
