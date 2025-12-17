import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

/// Simple cart repository - server is the source of truth
class CartRepository extends BaseRepository {
  CartRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<Cart?> getCart() async {
    return guard(() async {
      final response = await _apiClient.getCartApi().cartGet();
      if (response.data == null) {
        throw const RepositoryError(
          'Failed to get cart',
          code: ErrorCode.internalServerError,
        );
      }
      return response.data!.data.cart;
    });
  }

  Future<BaseResponse<Cart>> addItem({
    required MerchantMenu menu,
    required String merchantName,
    int quantity = 1,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
    bool replaceIfConflict = false,
  }) async {
    return guard(() async {
      try {
        final response = await _apiClient.getCartApi().cartAddItem(
          addToCartRequest: AddToCartRequest(
            menuId: menu.id,
            quantity: quantity,
            notes: notes,
            replaceIfConflict: replaceIfConflict,
          ),
        );

        if (response.data?.data.cart == null) {
          throw const RepositoryError(
            'Failed to add item to cart',
            code: ErrorCode.internalServerError,
          );
        }

        return SuccessResponse(
          message: 'Item added to cart',
          data: response.data!.data.cart!,
        );
      } on DioException catch (e) {
        if (e.response?.statusCode == 409) {
          throw const RepositoryError(
            'Cart contains items from another merchant',
            code: ErrorCode.conflict,
          );
        }
        rethrow;
      }
    });
  }

  Future<BaseResponse<Cart?>> updateItemQuantityByDelta({
    required String menuId,
    required int delta,
  }) async {
    return guard(() async {
      final response = await _apiClient.getCartApi().cartUpdateItem(
        updateCartItemRequest: UpdateCartItemRequest(
          menuId: menuId,
          delta: delta,
        ),
      );

      if (response.data == null) {
        throw const RepositoryError(
          'Failed to update cart',
          code: ErrorCode.internalServerError,
        );
      }

      return SuccessResponse(
        message: 'Cart updated',
        data: response.data!.data.cart,
      );
    });
  }

  Future<BaseResponse<Cart?>> removeItem(String menuId) async {
    return guard(() async {
      final response = await _apiClient.getCartApi().cartRemoveItem(
        menuId: menuId,
      );

      if (response.data == null) {
        throw const RepositoryError(
          'Failed to remove item from cart',
          code: ErrorCode.internalServerError,
        );
      }

      return SuccessResponse(
        message: 'Item removed from cart',
        data: response.data!.data.cart,
      );
    });
  }

  Future<void> clearCart() async {
    return guard(() async {
      await _apiClient.getCartApi().cartClear();
    });
  }

  Future<BaseResponse<Cart>> replaceCart({
    required MerchantMenu menu,
    required String merchantName,
    int quantity = 1,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
  }) async {
    return addItem(
      menu: menu,
      merchantName: merchantName,
      quantity: quantity,
      notes: notes,
      merchantLocation: merchantLocation,
      merchantCategory: merchantCategory,
      replaceIfConflict: true,
    );
  }

  Future<List<OrderItem>> convertToOrderItems() async {
    return guard(() async {
      final cart = await getCart();
      if (cart == null || cart.items.isEmpty) {
        throw const RepositoryError(
          'Cart is empty',
          code: ErrorCode.badRequest,
        );
      }

      return cart.items.map((cartItem) {
        return OrderItem(
          quantity: cartItem.quantity,
          item: OrderItemItem(
            id: cartItem.menuId,
            merchantId: cart.merchantId,
            name: cartItem.menuName,
            price: cartItem.unitPrice,
            image: cartItem.menuImage,
          ),
        );
      }).toList();
    });
  }
}
