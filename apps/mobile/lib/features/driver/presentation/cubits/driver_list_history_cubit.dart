import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverListHistoryCubit extends BaseCubit<DriverListHistoryState> {
  DriverListHistoryCubit({required OrderRepository orderRepository})
    : _orderRepository = orderRepository,
      super(DriverListHistoryState());

  final OrderRepository _orderRepository;

  Future<void> getOrders({required ListOrderQuery query}) async =>
      await taskManager.execute('DHC-lO1', () async {
        try {
          emit(state.toLoading());

          final orderRes = await _orderRepository.list(query);

          emit(
            state.toSuccess(
              orders: orderRes.data,
              message: orderRes.message,
              paginationResult: orderRes.paginationResult,
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverHistoryCubit] - Error loading orders: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  Future<void> loadMoreOrders({required List<OrderStatus> statuses}) async =>
      await taskManager.execute(
        'DHC-lO2-${state.paginationResult?.nextCursor}',
        () async {
          try {
            if (!(state.paginationResult?.hasMore ?? false) ||
                state.isLoading) {
              return;
            }
            emit(state.toLoading());

            final orderRes = await _orderRepository.list(
              ListOrderQuery(
                limit: 20,
                cursor: state.paginationResult?.nextCursor,
                statuses: statuses,
              ),
            );

            final updatedOrders = [...?state.orders, ...orderRes.data];

            emit(
              state.toSuccess(
                orders: updatedOrders,
                message: orderRes.message,
                paginationResult: orderRes.paginationResult,
              ),
            );
          } on BaseError catch (e, st) {
            logger.e(
              '[DriverHistoryCubit] - Error loading more orders: ${e.message}',
              error: e,
              stackTrace: st,
            );
            emit(state.toFailure(e));
          }
        },
      );
}
