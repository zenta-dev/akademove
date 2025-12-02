import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart' as models;
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;

class CartCubit extends BaseCubit<CartState> {
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(CartState());

  final CartRepository _cartRepository;

  /// Load cart from storage on init
  Future<void> loadCart() async => await taskManager.execute('CC-lC', () async {
    try {
      emit(state.toLoading());

      final cart = await _cartRepository.getCart();
      emit(state.toSuccess(cart: cart, message: 'Cart loaded'));
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - loadCart Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e, message: e.message));
    }
  });

  /// Add item to cart
  /// If different merchant detected, shows conflict dialog instead of adding
  Future<void> addItem({
    required MerchantMenu menu,
    required String merchantName,
    required int quantity,
    String? notes,
  }) async => await taskManager.execute('CC-aI-${menu.id}', () async {
    try {
      // Don't emit loading for add operations to keep UI responsive
      final result = await _cartRepository.addItem(
        menu: menu,
        merchantName: merchantName,
        quantity: quantity,
        notes: notes,
      );

      result.when(
        success: (cart, message) {
          emit(state.toSuccess(cart: cart, message: message));
        },
        failed: (code, message) {
          // Check if it's a merchant conflict error
          if (code == ErrorCode.conflict) {
            // Extract pending item for conflict dialog
            final item = models.CartItem(
              menuId: menu.id,
              merchantId: menu.merchantId,
              merchantName: merchantName,
              menuName: menu.name,
              menuImage: menu.image,
              unitPrice: menu.price,
              quantity: quantity,
              notes: notes,
            );

            // Show merchant conflict dialog
            emit(
              state.toMerchantConflict(
                pendingItem: item,
                pendingMerchantName: merchantName,
              ),
            );
          } else {
            final error = RepositoryError(message, code: code);
            emit(state.toFailure(error, message: message));
          }
        },
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - addItem Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e, message: e.message));
    }
  });

  /// User confirms replacing cart with new merchant item
  Future<void> confirmReplaceCart() async =>
      await taskManager.execute('CC-cRC', () async {
        try {
          final pendingItem = state.pendingItem;
          final pendingMerchantName = state.pendingMerchantName;

          if (pendingItem == null || pendingMerchantName == null) {
            emit(state.clearConflict());
            return;
          }

          emit(state.toLoading());

          // Need to convert back to MerchantMenu for replaceCart
          final menu = MerchantMenu(
            id: pendingItem.menuId,
            merchantId: pendingItem.merchantId,
            name: pendingItem.menuName,
            image: pendingItem.menuImage,
            price: pendingItem.unitPrice,
            stock: 999, // Stock not validated here (checked at checkout)
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          final result = await _cartRepository.replaceCart(
            menu: menu,
            merchantName: pendingMerchantName,
            quantity: pendingItem.quantity,
            notes: pendingItem.notes,
          );

          result.when(
            success: (cart, message) {
              emit(state.toSuccess(cart: cart, message: message));
            },
            failed: (code, message) {
              final error = RepositoryError(message, code: code);
              emit(state.toFailure(error, message: message));
            },
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[CartCubit] - confirmReplaceCart Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e, message: e.message));
        }
      });

  /// User cancels cart replacement
  void cancelReplaceCart() {
    emit(state.clearConflict());
  }

  /// Update item quantity (or remove if quantity <= 0)
  Future<void> updateQuantity({
    required String menuId,
    required int quantity,
  }) async => await taskManager.execute('CC-uQ-$menuId', () async {
    try {
      final result = await _cartRepository.updateItemQuantity(
        menuId: menuId,
        quantity: quantity,
      );

      result.when(
        success: (cart, message) {
          emit(state.toSuccess(cart: cart, message: message));
        },
        failed: (code, message) {
          final error = RepositoryError(message, code: code);
          emit(state.toFailure(error, message: message));
        },
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - updateQuantity Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e, message: e.message));
    }
  });

  /// Remove item from cart
  Future<void> removeItem(String menuId) async =>
      await taskManager.execute('CC-rI-$menuId', () async {
        try {
          final result = await _cartRepository.removeItem(menuId);

          result.when(
            success: (cart, message) {
              emit(state.toSuccess(cart: cart, message: message));
            },
            failed: (code, message) {
              final error = RepositoryError(message, code: code);
              emit(state.toFailure(error, message: message));
            },
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[CartCubit] - removeItem Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e, message: e.message));
        }
      });

  /// Clear entire cart
  Future<void> clearCart() async =>
      await taskManager.execute('CC-cC', () async {
        try {
          emit(state.toLoading());

          await _cartRepository.clearCart();
          emit(state.toSuccess(cart: null, message: 'Cart cleared'));
        } on BaseError catch (e, st) {
          logger.e(
            '[CartCubit] - clearCart Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e, message: e.message));
        }
      });

  /// Get order items for API submission
  /// Returns empty list if cart is empty
  Future<List<OrderItem>> getOrderItems() async {
    try {
      return await _cartRepository.convertToOrderItems();
    } on BaseError catch (e) {
      logger.w('[CartCubit] - getOrderItems failed: ${e.message}');
      return [];
    }
  }

  /// Reset to initial state
  void reset() => emit(CartState());
}
