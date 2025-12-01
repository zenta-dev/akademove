part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class EmergencyState extends BaseState2 with EmergencyStateMappable {
  EmergencyState({
    this.triggered,
    this.list = const [],
    super.state,
    super.message,
    super.error,
  });

  /// Currently triggered emergency (if any)
  final Emergency? triggered;

  /// List of emergencies for the current order
  final List<Emergency> list;

  @override
  EmergencyState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  EmergencyState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  EmergencyState toSuccess({
    Emergency? triggered,
    List<Emergency>? list,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    triggered: triggered ?? this.triggered,
    list: list ?? this.list,
    message: message,
    error: null,
  );

  @override
  EmergencyState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
