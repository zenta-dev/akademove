part of '_export.dart';

class DriverListHistoryState extends Equatable {
  const DriverListHistoryState({
    this.fetchHistoryResult = const OperationResult.idle(),
    this.orders = const [],
    this.paginationResult,
  });

  final OperationResult<List<Order>> fetchHistoryResult;

  final List<Order> orders;
  final PaginationResult? paginationResult;

  @override
  List<Object?> get props => [fetchHistoryResult, orders, paginationResult];

  @override
  bool get stringify => true;

  DriverListHistoryState copyWith({
    OperationResult<List<Order>>? fetchHistoryResult,
    List<Order>? orders,
    PaginationResult? paginationResult,
  }) {
    return DriverListHistoryState(
      fetchHistoryResult: fetchHistoryResult ?? this.fetchHistoryResult,
      orders: orders ?? this.orders,
      paginationResult: paginationResult ?? this.paginationResult,
    );
  }
}
