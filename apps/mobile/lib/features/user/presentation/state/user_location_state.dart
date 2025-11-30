part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserLocationState extends BaseState2 with UserLocationStateMappable {
  UserLocationState({
    this.coordinate,
    this.placemark,
    super.state,
    super.message,
    super.error,
  });

  final Coordinate? coordinate;
  final Placemark? placemark;

  @override
  UserLocationState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserLocationState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserLocationState toSuccess({
    Coordinate? coordinate,
    Placemark? placemark,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    coordinate: coordinate ?? this.coordinate,
    placemark: placemark ?? this.placemark,
    message: message,
    error: null,
  );

  @override
  UserLocationState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
