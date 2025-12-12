import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverListHistoryCubit extends BaseCubit<DriverListHistoryState> {
  DriverListHistoryCubit({required OrderRepository orderRepository})
    : _orderRepository = orderRepository,
      super(const DriverListHistoryState());

  final OrderRepository _orderRepository;

  Future<void> getOrders({required ListOrderQuery query}) async =>
      await taskManager.execute('DHC-lO1', () async {
        try {
          emit(
            state.copyWith(fetchHistoryResult: const OperationResult.loading()),
          );

          final orderRes = await _orderRepository.list(query);

          emit(
            state.copyWith(
              fetchHistoryResult: OperationResult.success(orderRes.data),
              paginationResult: orderRes.paginationResult,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHistoryCubit] - Error loading orders: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(fetchHistoryResult: OperationResult.failed(e)));
        }
      });

  Future<void> loadMoreOrders({
    required List<OrderStatus> statuses,
    OrderType? type,
  }) async => await taskManager.execute(
    'DHC-lO2-${state.paginationResult?.nextCursor}',
    () async {
      try {
        if (!(state.paginationResult?.hasMore ?? false) ||
            state.fetchHistoryResult.isLoading) {
          return;
        }
        emit(
          state.copyWith(fetchHistoryResult: const OperationResult.loading()),
        );

        final orderRes = await _orderRepository.list(
          ListOrderQuery(
            limit: 20,
            cursor: state.paginationResult?.nextCursor,
            statuses: statuses,
            type: type,
          ),
        );

        final updatedOrders = [
          ...?state.fetchHistoryResult.value,
          ...orderRes.data,
        ];

        emit(
          state.copyWith(
            fetchHistoryResult: OperationResult.success(updatedOrders),
            paginationResult: orderRes.paginationResult,
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[DriverHistoryCubit] - Error loading more orders: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(fetchHistoryResult: OperationResult.failed(e)));
      }
    },
  );
}
