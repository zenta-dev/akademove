part of '_export.dart';

class DriverListHistoryState extends Equatable {
  const DriverListHistoryState({
    this.fetchHistoryResult = const OperationResult.idle(),
    this.paginationResult,
  });

  final OperationResult<List<Order>> fetchHistoryResult;

  final PaginationResult? paginationResult;

  @override
  List<Object?> get props => [fetchHistoryResult, paginationResult];

  @override
  bool get stringify => true;

  DriverListHistoryState copyWith({
    OperationResult<List<Order>>? fetchHistoryResult,
    PaginationResult? paginationResult,
  }) {
    return DriverListHistoryState(
      fetchHistoryResult: fetchHistoryResult ?? this.fetchHistoryResult,
      paginationResult: paginationResult ?? this.paginationResult,
    );
  }
}
