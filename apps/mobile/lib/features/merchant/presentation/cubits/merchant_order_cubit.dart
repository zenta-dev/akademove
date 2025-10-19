import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class MerchantOrderCubit extends BaseCubit<MerchantOrderState> {
  MerchantOrderCubit(this._orderRepository) : super(const MerchantOrderState());
  final OrderRepository _orderRepository;

  @override
  Future<void> init() async {}

  Future<void> getMine({required List<OrderStatusEnum> statuses}) async {
    try {
      logger.d('Statuses $statuses');
      emit(state.toLoading());
      await delay(const Duration(seconds: 4));
      final dummy = List.generate(
        5,
        (int i) => Order(
          id: 'id-$i',
          userId: 'userId-$i',
          type: OrderTypeEnum.food,
          status: OrderStatusEnum.requested,
          pickupLocation: Location(lat: 0, lng: 0),
          dropoffLocation: Location(lat: 0, lng: 0),
          distanceKm: 1,
          basePrice: 2000 * i,
          totalPrice: 5000 * i,
          requestedAt: DateTime(2020),
          createdAt: DateTime(2020),
          updatedAt: DateTime(2020),
        ),
      );
      emit(state.toSuccess(list: dummy));
    } on BaseError catch (e, st) {
      logger.e(
        '[MerchantOrderCubit] - Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  @override
  void reset() => emit(const MerchantOrderState());
}
