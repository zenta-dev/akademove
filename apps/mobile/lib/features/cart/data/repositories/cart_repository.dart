import 'dart:async';
import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart' as models;
import 'package:api_client/api_client.dart' hide Cart, CartItem;

/// Repository for managing shopping cart with single-merchant constraint
class CartRepository extends BaseRepository {
  CartRepository({required KeyValueService keyValueService})
    : _keyValueService = keyValueService;

  final KeyValueService _keyValueService;

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

  /// Get current cart from storage
  Future<models.Cart?> getCart() async {
    return guard(() async {
      final cartJson = await _keyValueService.get<String>(KeyValueKeys.cart);
      if (cartJson == null || cartJson.isEmpty) return null;

      final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
      return models.Cart.fromJson(cartMap);
    });
  }

  /// Save cart to storage (internal, used within locked operations)
  Future<void> _saveCart(models.Cart cart) async {
    return guard(() async {
      final cartJson = jsonEncode(cart.toJson());
      await _keyValueService.set(KeyValueKeys.cart, cartJson);
    });
  }

  /// Save cart to storage (public, for optimistic updates)
  /// This method is fire-and-forget safe - errors are logged but not thrown
  Future<void> persistCart(models.Cart cart) async {
    return _withCartLock(() async {
      try {
        final cartJson = jsonEncode(cart.toJson());
        await _keyValueService.set(KeyValueKeys.cart, cartJson);
      } catch (e) {
        // Log but don't throw - this is for background persistence
        // The UI already has the optimistic state
        logger.e('[CartRepository] persistCart failed', error: e);
      }
    });
  }

  /// Clear cart from storage (public, for optimistic updates)
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

  /// Clear entire cart (internal, not locked - used within locked operations)
  Future<void> _clearCartInternal() async {
    return guard(() async {
      await _keyValueService.remove(KeyValueKeys.cart);
    });
  }

  /// Add item to cart (or update quantity if exists)
  /// Validates single-merchant constraint
  Future<BaseResponse<models.Cart>> addItem({
    required MerchantMenu menu,
    required String merchantName,
    int quantity = 1,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
  }) async {
    return _withCartLock(() async {
      return guard(() async {
        final currentCart = await getCart();

        // Create new cart item
        final newItem = models.CartItem(
          menuId: menu.id,
          merchantId: menu.merchantId,
          merchantName: merchantName,
          menuName: menu.name,
          menuImage: menu.image,
          unitPrice: menu.price,
          quantity: quantity,
          notes: notes,
        );

        models.Cart updatedCart;

        if (currentCart == null || currentCart.items.isEmpty) {
          // Create new cart
          updatedCart = models.Cart(
            merchantId: newItem.merchantId,
            merchantName: newItem.merchantName,
            items: [newItem],
            totalItems: quantity,
            subtotal: menu.price * quantity,
            lastUpdated: DateTime.now(),
            merchantLocation: merchantLocation,
            merchantCategory: merchantCategory,
          );
        } else {
          // Check merchant conflict
          if (currentCart.merchantId != menu.merchantId) {
            throw RepositoryError(
              'Cart contains items from ${currentCart.merchantName}. '
              'Please clear cart before adding items from ${newItem.merchantName}.',
              code: ErrorCode.conflict,
            );
          }

          // Update existing cart
          final existingIndex = currentCart.items.indexWhere(
            (item) => item.menuId == newItem.menuId,
          );

          List<models.CartItem> updatedItems;
          if (existingIndex >= 0) {
            // Update existing item quantity
            updatedItems = List<models.CartItem>.from(currentCart.items);
            final existing = updatedItems[existingIndex];
            updatedItems[existingIndex] = existing.copyWith(
              quantity: existing.quantity + quantity,
              notes: notes ?? existing.notes,
            );
          } else {
            // Add new item
            updatedItems = [...currentCart.items, newItem];
          }

          // Recalculate totals
          final totalItems = updatedItems.fold<int>(
            0,
            (sum, item) => sum + item.quantity,
          );
          final subtotal = updatedItems.fold<num>(
            0,
            (sum, item) => sum + (item.unitPrice * item.quantity),
          );

          updatedCart = models.Cart(
            merchantId: currentCart.merchantId,
            merchantName: currentCart.merchantName,
            items: updatedItems,
            totalItems: totalItems,
            subtotal: subtotal,
            lastUpdated: DateTime.now(),
            merchantLocation: merchantLocation ?? currentCart.merchantLocation,
            merchantCategory: merchantCategory ?? currentCart.merchantCategory,
          );
        }

        await _saveCart(updatedCart);
        return SuccessResponse(
          message: 'Item added to cart',
          data: updatedCart,
        );
      });
    });
  }

  /// Update item quantity in cart by delta (increment/decrement)
  /// Use positive delta to increase quantity, negative to decrease
  /// Removes item if resulting quantity <= 0
  Future<BaseResponse<models.Cart?>> updateItemQuantityByDelta({
    required String menuId,
    required int delta,
  }) async {
    return _withCartLock(() async {
      return guard(() async {
        final currentCart = await getCart();
        if (currentCart == null) {
          throw const RepositoryError(
            'Cart is empty',
            code: ErrorCode.notFound,
          );
        }

        final itemIndex = currentCart.items.indexWhere(
          (item) => item.menuId == menuId,
        );

        if (itemIndex < 0) {
          throw const RepositoryError(
            'Item not found in cart',
            code: ErrorCode.notFound,
          );
        }

        final updatedItems = List<models.CartItem>.from(currentCart.items);
        final currentItem = updatedItems[itemIndex];
        final newQuantity = currentItem.quantity + delta;

        if (newQuantity <= 0) {
          // Remove item if quantity is 0 or less
          updatedItems.removeAt(itemIndex);
        } else {
          // Update quantity
          updatedItems[itemIndex] = currentItem.copyWith(quantity: newQuantity);
        }

        // If cart is empty after update, clear it
        if (updatedItems.isEmpty) {
          await _clearCartInternal();
          return const SuccessResponse(message: 'Cart cleared', data: null);
        }

        // Recalculate totals
        final totalItems = updatedItems.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        final subtotal = updatedItems.fold<num>(
          0,
          (sum, item) => sum + (item.unitPrice * item.quantity),
        );

        final updatedCart = models.Cart(
          merchantId: currentCart.merchantId,
          merchantName: currentCart.merchantName,
          items: updatedItems,
          totalItems: totalItems,
          subtotal: subtotal,
          lastUpdated: DateTime.now(),
          merchantLocation: currentCart.merchantLocation,
          merchantCategory: currentCart.merchantCategory,
          attachmentUrl: currentCart.attachmentUrl,
        );

        await _saveCart(updatedCart);
        return SuccessResponse(message: 'Cart updated', data: updatedCart);
      });
    });
  }

  /// Remove item from cart
  Future<BaseResponse<models.Cart?>> removeItem(String menuId) async {
    return _withCartLock(() async {
      return guard(() async {
        final currentCart = await getCart();
        if (currentCart == null) {
          throw const RepositoryError(
            'Cart is empty',
            code: ErrorCode.notFound,
          );
        }

        final updatedItems = currentCart.items
            .where((item) => item.menuId != menuId)
            .toList();

        if (updatedItems.isEmpty) {
          await _clearCartInternal();
          return const SuccessResponse(message: 'Cart cleared', data: null);
        }

        // Recalculate totals
        final totalItems = updatedItems.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        final subtotal = updatedItems.fold<num>(
          0,
          (sum, item) => sum + (item.unitPrice * item.quantity),
        );

        final updatedCart = models.Cart(
          merchantId: currentCart.merchantId,
          merchantName: currentCart.merchantName,
          items: updatedItems,
          totalItems: totalItems,
          subtotal: subtotal,
          lastUpdated: DateTime.now(),
          merchantLocation: currentCart.merchantLocation,
          merchantCategory: currentCart.merchantCategory,
          attachmentUrl: currentCart.attachmentUrl,
        );

        await _saveCart(updatedCart);
        return SuccessResponse(
          message: 'Item removed from cart',
          data: updatedCart,
        );
      });
    });
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    return _withCartLock(() async {
      return _clearCartInternal();
    });
  }

  /// Replace cart with new merchant items
  /// Used when user confirms merchant replacement
  Future<BaseResponse<models.Cart>> replaceCart({
    required MerchantMenu menu,
    required String merchantName,
    int quantity = 1,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
  }) async {
    return _withCartLock(() async {
      await _clearCartInternal();
      return guard(() async {
        // Create new cart item
        final newItem = models.CartItem(
          menuId: menu.id,
          merchantId: menu.merchantId,
          merchantName: merchantName,
          menuName: menu.name,
          menuImage: menu.image,
          unitPrice: menu.price,
          quantity: quantity,
          notes: notes,
        );

        final updatedCart = models.Cart(
          merchantId: newItem.merchantId,
          merchantName: newItem.merchantName,
          items: [newItem],
          totalItems: quantity,
          subtotal: menu.price * quantity,
          lastUpdated: DateTime.now(),
          merchantLocation: merchantLocation,
          merchantCategory: merchantCategory,
        );

        await _saveCart(updatedCart);
        return SuccessResponse(message: 'Cart replaced', data: updatedCart);
      });
    });
  }

  /// Update attachment URL in cart (for Printing merchants)
  Future<BaseResponse<models.Cart>> updateAttachment(
    String? attachmentUrl,
  ) async {
    return _withCartLock(() async {
      return guard(() async {
        final currentCart = await getCart();
        if (currentCart == null) {
          throw const RepositoryError(
            'Cart is empty',
            code: ErrorCode.notFound,
          );
        }

        final updatedCart = currentCart.copyWith(
          attachmentUrl: attachmentUrl,
          clearAttachment: attachmentUrl == null,
          lastUpdated: DateTime.now(),
        );

        await _saveCart(updatedCart);
        return SuccessResponse(
          message: attachmentUrl != null
              ? 'Attachment added'
              : 'Attachment removed',
          data: updatedCart,
        );
      });
    });
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
}
