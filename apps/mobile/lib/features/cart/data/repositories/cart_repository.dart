import 'dart:async';
import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

/// Repository for managing shopping cart with server-side persistence
/// Supports both server sync and local optimistic updates
class CartRepository extends BaseRepository {
  CartRepository({
    required KeyValueService keyValueService,
    required ApiClient apiClient,
  }) : _keyValueService = keyValueService,
       _apiClient = apiClient;

  final KeyValueService _keyValueService;
  final ApiClient _apiClient;

  /// Lock to serialize cart write operations and prevent race conditions
  Future<void>? _cartLock;

  /// Executes a cart operation with serialization to prevent race conditions.
  /// All write operations are queued and executed sequentially.
  Future<T> _withCartLock<T>(Future<T> Function() operation) async {
    // Wait for any pending operation to complete
    while (_cartLock != null) {
      await _cartLock;
    }

    final completer = Completer<void>();
    _cartLock = completer.future;

    try {
      return await operation();
    } finally {
      _cartLock = null;
      completer.complete();
    }
  }

  /// Get current cart from server
  Future<Cart?> getCart() async {
    return guard(() async {
      final response = await _apiClient.getCartApi().cartGet();
      if (response.data == null) {
        throw const RepositoryError(
          'Failed to get cart',
          code: ErrorCode.internalServerError,
        );
      }

      final cartResponse = response.data!.data;
      return cartResponse.cart;
    });
  }

  /// Get cart from local storage (for optimistic updates)
  Future<Cart?> getLocalCart() async {
    return guard(() async {
      final cartJson = await _keyValueService.get<String>(KeyValueKeys.cart);
      if (cartJson == null || cartJson.isEmpty) return null;

      final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
      return Cart.fromJson(cartMap);
    });
  }

  /// Save cart to local storage (for optimistic updates)
  /// This method is fire-and-forget safe - errors are logged but not thrown
  Future<void> persistCart(Cart cart) async {
    return _withCartLock(() async {
      try {
        final cartJson = jsonEncode(cart.toJson());
        await _keyValueService.set(KeyValueKeys.cart, cartJson);
      } catch (e) {
        // Log but don't throw - this is for background persistence
        logger.e('[CartRepository] persistCart failed', error: e);
      }
    });
  }

  /// Clear cart from local storage (for optimistic updates)
  /// This method is fire-and-forget safe - errors are logged but not thrown
  Future<void> persistClearCart() async {
    return _withCartLock(() async {
      try {
        await _keyValueService.remove(KeyValueKeys.cart);
      } catch (e) {
        logger.e('[CartRepository] persistClearCart failed', error: e);
      }
    });
  }

  /// Add item to cart via server API
  /// Validates single-merchant constraint
  Future<BaseResponse<Cart>> addItem({
    required MerchantMenu menu,
    required String merchantName,
    int quantity = 1,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
    bool replaceIfConflict = false,
  }) async {
    return _withCartLock(() async {
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

          if (response.data == null) {
            throw const RepositoryError(
              'Failed to add item to cart',
              code: ErrorCode.internalServerError,
            );
          }

          final cartResponse = response.data!.data;
          final cart = cartResponse.cart;

          if (cart == null) {
            throw const RepositoryError(
              'Failed to add item to cart',
              code: ErrorCode.internalServerError,
            );
          }

          // Update local storage for offline support
          await persistCart(cart);

          return SuccessResponse(message: 'Item added to cart', data: cart);
        } on DioException catch (e) {
          // Check for conflict error (409)
          if (e.response?.statusCode == 409) {
            throw const RepositoryError(
              'Cart contains items from another merchant',
              code: ErrorCode.conflict,
            );
          }
          rethrow;
        }
      });
    });
  }

  /// Update item quantity by delta via server API
  /// Use positive delta to increase quantity, negative to decrease
  /// Removes item if resulting quantity <= 0
  Future<BaseResponse<Cart?>> updateItemQuantityByDelta({
    required String menuId,
    required int delta,
  }) async {
    return _withCartLock(() async {
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

        final cartResponse = response.data!.data;
        final cart = cartResponse.cart;

        // Update local storage
        if (cart != null) {
          await persistCart(cart);
        } else {
          await persistClearCart();
        }

        return SuccessResponse(message: 'Cart updated', data: cart);
      });
    });
  }

  /// Remove item from cart via server API
  Future<BaseResponse<Cart?>> removeItem(String menuId) async {
    return _withCartLock(() async {
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

        final cartResponse = response.data!.data;
        final cart = cartResponse.cart;

        // Update local storage
        if (cart != null) {
          await persistCart(cart);
        } else {
          await persistClearCart();
        }

        return SuccessResponse(message: 'Item removed from cart', data: cart);
      });
    });
  }

  /// Clear entire cart via server API
  Future<void> clearCart() async {
    return _withCartLock(() async {
      return guard(() async {
        await _apiClient.getCartApi().cartClear();
        await persistClearCart();
      });
    });
  }

  /// Replace cart with new merchant items via server API
  /// Used when user confirms merchant replacement
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

  /// Convert cart to OrderItem list for API
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

  /// Sync local cart with server (call on app startup/resume)
  /// Returns the server cart, replacing any local-only data
  Future<Cart?> syncWithServer() async {
    return guard(() async {
      try {
        final serverCart = await getCart();

        // Update local storage with server data
        if (serverCart != null) {
          await persistCart(serverCart);
        } else {
          await persistClearCart();
        }

        return serverCart;
      } catch (e) {
        // If server sync fails, fall back to local cart
        logger.w(
          '[CartRepository] Server sync failed, using local cart',
          error: e,
        );
        return getLocalCart();
      }
    });
  }
}
