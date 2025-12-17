import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for CartApi
void main() {
  final instance = ApiClient().getCartApi();

  group(CartApi, () {
    //Future<CartGet200Response> cartAddItem(AddToCartRequest addToCartRequest) async
    test('test cartAddItem', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> cartClear() async
    test('test cartClear', () async {
      // TODO
    });

    //Future<CartGet200Response> cartGet() async
    test('test cartGet', () async {
      // TODO
    });

    //Future<CartGet200Response> cartRemoveItem(String menuId) async
    test('test cartRemoveItem', () async {
      // TODO
    });

    //Future<CartGet200Response> cartUpdateItem(UpdateCartItemRequest updateCartItemRequest) async
    test('test cartUpdateItem', () async {
      // TODO
    });
  });
}
