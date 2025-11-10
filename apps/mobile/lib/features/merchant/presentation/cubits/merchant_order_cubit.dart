import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class MerchantOrderCubit extends BaseCubit<MerchantOrderState> {
  MerchantOrderCubit({
    required OrderRepository orderRepository,
  }) : _orderRepository = orderRepository,
       super(const MerchantOrderState());
  final OrderRepository _orderRepository;

  Future<void> init() async {}

  Future<void> getMine({required List<OrderStatus> statuses}) async {
    try {
      emit(state.toLoading());

      final res = await _orderRepository.list(
        ListOrderQuery(statuses: statuses),
      );

      final mergedList = {
        for (final item in state.list) item.id: item,
        for (final item in res.data) item.id: item,
      }.values.toList();

      emit(state.toSuccess(list: mergedList, message: res.message));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  void reset() => emit(const MerchantOrderState());
}
