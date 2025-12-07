part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverListHistoryState extends BaseState2
    with DriverListHistoryStateMappable {
  DriverListHistoryState({
    super.state,
    super.message,
    super.error,
    this.orders,
    this.paginationResult,
  });

  final List<Order>? orders;
  final PaginationResult? paginationResult;

  @override
  DriverListHistoryState toInitial() => DriverListHistoryState();

  @override
  DriverListHistoryState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverListHistoryState toSuccess({
    String? message,
    List<Order>? orders,
    PaginationResult? paginationResult,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    orders: orders ?? this.orders,
    paginationResult: paginationResult ?? this.paginationResult,
  );

  @override
  DriverListHistoryState toFailure(BaseError error, {String? message}) =>
      copyWith(
        state: CubitState.failure,
        error: error,
        message: message ?? error.message,
      );
}
