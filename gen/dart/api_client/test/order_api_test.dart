import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for OrderApi
void main() {
  final instance = ApiClient().getOrderApi();

  group(OrderApi, () {
    //Future<OrderEstimate200Response> orderEstimate(num dropoffLocationX, num dropoffLocationY, num pickupLocationX, num pickupLocationY, OrderType type, { String notePickup, String noteDropoff, List<OrderItem> items, UserGender gender, List<num> discountIds, num weight }) async
    test('test orderEstimate', () async {
      // TODO
    });

    //Future<OrderGet200Response> orderGet(String id) async
    test('test orderGet', () async {
      // TODO
    });

    //Future<OrderList200Response> orderList({ String cursor, Object limit, Object page, String query, String sortBy, String order, Object statuses }) async
    test('test orderList', () async {
      // TODO
    });

    //Future<OrderPlaceOrder200Response> orderPlaceOrder(PlaceOrder placeOrder) async
    test('test orderPlaceOrder', () async {
      // TODO
    });

    //Future<OrderGet200Response> orderUpdate(String id, UpdateOrder updateOrder) async
    test('test orderUpdate', () async {
      // TODO
    });
  });
}
