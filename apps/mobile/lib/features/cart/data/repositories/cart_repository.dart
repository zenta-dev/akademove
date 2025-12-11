import 'dart:convert';

import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart' as models;
import 'package:api_client/api_client.dart' hide Cart, CartItem;

/// Repository for managing shopping cart with single-merchant constraint
class CartRepository extends BaseRepository {
  CartRepository({required KeyValueService keyValueService})
    : _keyValueService = keyValueService;

  final KeyValueService _keyValueService;

  /// Get current cart from storage
  Future<models.Cart?> getCart() async {
    return guard(() async {
      final cartJson = await _keyValueService.get<String>(KeyValueKeys.cart);
      if (cartJson == null || cartJson.isEmpty) return null;

      final cartMap = jsonDecode(cartJson) as Map<String, dynamic>;
      return models.Cart.fromJson(cartMap);
    });
  }

  /// Save cart to storage
  Future<void> _saveCart(models.Cart cart) async {
    return guard(() async {
      final cartJson = jsonEncode(cart.toJson());
      await _keyValueService.set(KeyValueKeys.cart, cartJson);
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
  }) async {
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
        );
      }

      await _saveCart(updatedCart);
      return SuccessResponse(message: 'Item added to cart', data: updatedCart);
    });
  }

  /// Update item quantity in cart
  Future<BaseResponse<models.Cart?>> updateItemQuantity({
    required String menuId,
    required int quantity,
  }) async {
    return guard(() async {
      final currentCart = await getCart();
      if (currentCart == null) {
        throw const RepositoryError('Cart is empty', code: ErrorCode.notFound);
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

      if (quantity <= 0) {
        // Remove item if quantity is 0 or less
        updatedItems.removeAt(itemIndex);
      } else {
        // Update quantity
        updatedItems[itemIndex] = updatedItems[itemIndex].copyWith(
          quantity: quantity,
        );
      }

      // If cart is empty after update, clear it
      if (updatedItems.isEmpty) {
        await clearCart();
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
      );

      await _saveCart(updatedCart);
      return SuccessResponse(message: 'Cart updated', data: updatedCart);
    });
  }

  /// Remove item from cart
  Future<BaseResponse<models.Cart?>> removeItem(String menuId) async {
    return guard(() async {
      final currentCart = await getCart();
      if (currentCart == null) {
        throw const RepositoryError('Cart is empty', code: ErrorCode.notFound);
      }

      final updatedItems = currentCart.items
          .where((item) => item.menuId != menuId)
          .toList();

      if (updatedItems.isEmpty) {
        await clearCart();
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
      );

      await _saveCart(updatedCart);
      return SuccessResponse(
        message: 'Item removed from cart',
        data: updatedCart,
      );
    });
  }

  /// Clear entire cart
  Future<void> clearCart() async {
    return guard(() async {
      await _keyValueService.remove(KeyValueKeys.cart);
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
  }) async {
    await clearCart();
    return addItem(
      menu: menu,
      merchantName: merchantName,
      quantity: quantity,
      notes: notes,
      merchantLocation: merchantLocation,
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
}
