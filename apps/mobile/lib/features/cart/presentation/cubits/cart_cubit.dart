import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart' as models;
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;

class CartCubit extends BaseCubit<CartState> {
  CartCubit({required CartRepository cartRepository})
    : _cartRepository = cartRepository,
      super(const CartState());

  final CartRepository _cartRepository;

  /// Load cart from storage on init
  Future<void> loadCart() async => await taskManager.execute('CC-lC', () async {
    try {
      emit(state.copyWith(cart: const OperationResult.loading()));

      final cart = await _cartRepository.getCart();
      emit(
        state.copyWith(
          cart: OperationResult.success(cart, message: 'Cart loaded'),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - loadCart Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(cart: OperationResult.failed(e)));
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
          emit(
            state.copyWith(
              addItemResult: OperationResult.success(cart, message: message),
              cart: OperationResult.success(cart),
            ),
          );
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
              state.copyWith(
                pendingItem: item,
                pendingMerchantName: merchantName,
                showMerchantConflict: true,
              ),
            );
          } else {
            final error = RepositoryError(message, code: code);
            emit(state.copyWith(addItemResult: OperationResult.failed(error)));
          }
        },
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - addItem Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(addItemResult: OperationResult.failed(e)));
    }
  });

  /// User confirms replacing cart with new merchant item
  Future<void> confirmReplaceCart() async =>
      await taskManager.execute('CC-cRC', () async {
        try {
          final pendingItem = state.pendingItem;
          final pendingMerchantName = state.pendingMerchantName;

          if (pendingItem == null || pendingMerchantName == null) {
            emit(state.copyWith(clearPending: true));
            return;
          }

          emit(
            state.copyWith(replaceCartResult: const OperationResult.loading()),
          );

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
              emit(
                state.copyWith(
                  replaceCartResult: OperationResult.success(
                    cart,
                    message: message,
                  ),
                  cart: OperationResult.success(cart),
                  clearPending: true,
                ),
              );
            },
            failed: (code, message) {
              final error = RepositoryError(message, code: code);
              emit(
                state.copyWith(
                  replaceCartResult: OperationResult.failed(error),
                  clearPending: true,
                ),
              );
            },
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[CartCubit] - confirmReplaceCart Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(
            state.copyWith(
              replaceCartResult: OperationResult.failed(e),
              clearPending: true,
            ),
          );
        }
      });

  /// User cancels cart replacement
  void cancelReplaceCart() {
    emit(state.copyWith(clearPending: true));
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
          emit(
            state.copyWith(
              updateQuantityResult: OperationResult.success(
                cart,
                message: message,
              ),
              cart: OperationResult.success(cart),
            ),
          );
        },
        failed: (code, message) {
          final error = RepositoryError(message, code: code);
          emit(
            state.copyWith(updateQuantityResult: OperationResult.failed(error)),
          );
        },
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - updateQuantity Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(updateQuantityResult: OperationResult.failed(e)));
    }
  });

  /// Remove item from cart
  Future<void> removeItem(
    String menuId,
  ) async => await taskManager.execute('CC-rI-$menuId', () async {
    try {
      final result = await _cartRepository.removeItem(menuId);

      result.when(
        success: (cart, message) {
          emit(
            state.copyWith(
              removeItemResult: OperationResult.success(cart, message: message),
              cart: OperationResult.success(cart),
            ),
          );
        },
        failed: (code, message) {
          final error = RepositoryError(message, code: code);
          emit(state.copyWith(removeItemResult: OperationResult.failed(error)));
        },
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[CartCubit] - removeItem Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(removeItemResult: OperationResult.failed(e)));
    }
  });

  /// Clear entire cart
  Future<void> clearCart() async => await taskManager.execute(
    'CC-cC',
    () async {
      try {
        emit(state.copyWith(clearCartResult: const OperationResult.loading()));

        await _cartRepository.clearCart();
        emit(
          state.copyWith(
            clearCartResult: OperationResult.success(
              true,
              message: 'Cart cleared',
            ),
            cart: OperationResult.success(null),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[CartCubit] - clearCart Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(clearCartResult: OperationResult.failed(e)));
      }
    },
  );

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
  void reset() => emit(const CartState());
}
