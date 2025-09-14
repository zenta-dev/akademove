import 'package:test/test.dart';
import 'package:akademove_api/akademove_api.dart';

/// tests for OrderApi
void main() {
  final instance = AkademoveApi().getOrderApi();

  group(OrderApi, () {
    //Future<CreateOrderSuccessResponse> createOrder({ CreateOrderRequest createOrderRequest }) async
    test('test createOrder', () async {
      // TODO
    });

    //Future<DeleteOrderSuccessResponse> deleteOrder(String id) async
    test('test deleteOrder', () async {
      // TODO
    });

    //Future<GetAllOrderSuccessResponse> getAllOrder(int page, int limit, { String cursor }) async
    test('test getAllOrder', () async {
      // TODO
    });

    //Future<GetOrderByIdSuccessResponse> getOrderById(String id, bool fromCache) async
    test('test getOrderById', () async {
      // TODO
    });

    //Future<UpdateOrderSuccessResponse> updateOrder(String id, { UpdateOrderRequest updateOrderRequest }) async
    test('test updateOrder', () async {
      // TODO
    });
  });
}
