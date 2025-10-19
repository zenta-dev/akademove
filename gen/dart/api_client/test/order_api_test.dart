import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for OrderApi
void main() {
  final instance = ApiClient().getOrderApi();

  group(OrderApi, () {
    //Future<OrderCreate200Response> orderCreate(InsertOrderRequest insertOrderRequest) async
    test('test orderCreate', () async {
      // TODO
    });

    //Future<OrderCreate200Response> orderGet(String id) async
    test('test orderGet', () async {
      // TODO
    });

    //Future<OrderList200Response> orderList({ String cursor, Object limit, Object page, String query, String sortBy, String order, Object statuses }) async
    test('test orderList', () async {
      // TODO
    });

    //Future<OrderCreate200Response> orderUpdate(String id, UpdateOrderRequest updateOrderRequest) async
    test('test orderUpdate', () async {
      // TODO
    });
  });
}
