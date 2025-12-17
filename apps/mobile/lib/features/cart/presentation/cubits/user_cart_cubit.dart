import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:akademove/features/order/data/repositories/order_repository.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;

class UserCartCubit extends BaseCubit<UserCartState> {
  UserCartCubit({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
  }) : _cartRepository = cartRepository,
       _orderRepository = orderRepository,
       super(const UserCartState());

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;

  /// Load cart from server on init (syncs with server)
  Future<void> loadCart() async => await taskManager.execute('CC-lC', () async {
    try {
      emit(state.copyWith(cart: const OperationResult.loading()));

      final cart = await _cartRepository.syncWithServer();
      emit(
        state.copyWith(
          cart: OperationResult.success(cart, message: 'Cart loaded'),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserCartCubit] - loadCart Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(cart: OperationResult.failed(e)));
    }
  });

  /// Sync cart with server (call on app startup/resume)
  Future<void> syncWithServer() async =>
      await taskManager.execute('CC-sWS', () async {
        try {
          final cart = await _cartRepository.syncWithServer();
          emit(
            state.copyWith(
              cart: OperationResult.success(cart, message: 'Cart synced'),
            ),
          );
        } on BaseError catch (e, st) {
          logger.w(
            '[UserCartCubit] - syncWithServer Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          // Don't emit error state on sync failure - keep existing cart
        }
      });

  /// Add item to cart
  /// If different merchant detected, shows conflict dialog instead of adding
  Future<void> addItem({
    required MerchantMenu menu,
    required String merchantName,
    required int quantity,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
  }) async => await taskManager.execute('CC-aI-${menu.id}', () async {
    try {
      // Don't emit loading for add operations to keep UI responsive
      final result = await _cartRepository.addItem(
        menu: menu,
        merchantName: merchantName,
        quantity: quantity,
        notes: notes,
        merchantLocation: merchantLocation,
        merchantCategory: merchantCategory,
      );

      result.when(
        success: (cart, message) {
          emit(
            state.copyWith(
              addItemResult: OperationResult.success(cart, message: message),
              cart: OperationResult.success(cart),
              // Reset stale operation results
              updateQuantityResult: const OperationResult.idle(),
              removeItemResult: const OperationResult.idle(),
              replaceCartResult: const OperationResult.idle(),
            ),
          );
        },
        failed: (code, message) {
          // Check if it's a merchant conflict error
          if (code == ErrorCode.conflict) {
            // Extract pending item for conflict dialog
            final item = CartItem(
              menuId: menu.id,
              merchantId: menu.merchantId,
              merchantName: merchantName,
              menuName: menu.name,
              menuImage: menu.image,
              unitPrice: menu.price,
              quantity: quantity,
              stock: menu.stock,
              notes: notes,
            );

            // Show merchant conflict dialog
            emit(
              state.copyWith(
                pendingItem: item,
                pendingMerchantName: merchantName,
                pendingMerchantLocation: merchantLocation,
                pendingMerchantCategory: merchantCategory,
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
        '[UserCartCubit] - addItem Error: ${e.message}',
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
          final pendingMerchantLocation = state.pendingMerchantLocation;
          final pendingMerchantCategory = state.pendingMerchantCategory;

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
            soldStock: 0, // Not tracked in cart context
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          final result = await _cartRepository.replaceCart(
            menu: menu,
            merchantName: pendingMerchantName,
            quantity: pendingItem.quantity,
            notes: pendingItem.notes,
            merchantLocation: pendingMerchantLocation,
            merchantCategory: pendingMerchantCategory,
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
                  // Reset stale operation results
                  addItemResult: const OperationResult.idle(),
                  updateQuantityResult: const OperationResult.idle(),
                  removeItemResult: const OperationResult.idle(),
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
            '[UserCartCubit] - confirmReplaceCart Error: ${e.message}',
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

  /// Update item quantity by delta (positive to increment, negative to decrement)
  /// Removes item if resulting quantity <= 0
  ///
  /// Uses optimistic updates for instant UI feedback:
  /// 1. Validates stock availability for increments
  /// 2. Immediately computes and emits new cart state
  /// 3. Syncs with server in background (non-blocking)
  void updateQuantity({required String menuId, required int delta}) {
    final currentCart = state.currentCart;
    if (currentCart == null) {
      emit(
        state.copyWith(
          updateQuantityResult: OperationResult.failed(
            const RepositoryError('Cart is empty', code: ErrorCode.notFound),
          ),
        ),
      );
      return;
    }

    final itemIndex = currentCart.items.indexWhere(
      (item) => item.menuId == menuId,
    );

    if (itemIndex < 0) {
      emit(
        state.copyWith(
          updateQuantityResult: OperationResult.failed(
            const RepositoryError(
              'Item not found in cart',
              code: ErrorCode.notFound,
            ),
          ),
        ),
      );
      return;
    }

    // Compute new cart state optimistically
    final updatedItems = List<CartItem>.from(currentCart.items);
    final currentItem = updatedItems[itemIndex];
    final newQuantity = currentItem.quantity + delta;

    // Validate stock for increments (delta > 0)
    // Use effectiveStock extension to handle null stock
    if (delta > 0 && newQuantity > currentItem.effectiveStock) {
      // Cannot exceed available stock - silently ignore or emit same state
      // The UI will show the item as "at max stock"
      return;
    }

    Cart? updatedCart;

    if (newQuantity <= 0) {
      // Remove item
      updatedItems.removeAt(itemIndex);

      if (updatedItems.isEmpty) {
        // Cart becomes empty
        updatedCart = null;
      } else {
        // Recalculate totals
        final totalItems = updatedItems.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );
        final subtotal = updatedItems.fold<num>(
          0,
          (sum, item) => sum + (item.unitPrice * item.quantity),
        );

        updatedCart = currentCart.copyWith(
          items: updatedItems,
          totalItems: totalItems,
          subtotal: subtotal,
          lastUpdated: DateTime.now(),
        );
      }
    } else {
      // Update quantity
      updatedItems[itemIndex] = currentItem.copyWith(quantity: newQuantity);

      // Recalculate totals
      final totalItems = updatedItems.fold<int>(
        0,
        (sum, item) => sum + item.quantity,
      );
      final subtotal = updatedItems.fold<num>(
        0,
        (sum, item) => sum + (item.unitPrice * item.quantity),
      );

      updatedCart = currentCart.copyWith(
        items: updatedItems,
        totalItems: totalItems,
        subtotal: subtotal,
        lastUpdated: DateTime.now(),
      );
    }

    // Emit optimistic state immediately (non-blocking)
    // Reset other operation results to ensure cart field is the source of truth
    emit(
      state.copyWith(
        updateQuantityResult: OperationResult.success(
          updatedCart,
          message: 'Cart updated',
        ),
        cart: OperationResult.success(updatedCart),
        // Reset stale operation results to prevent them from interfering
        addItemResult: const OperationResult.idle(),
        removeItemResult: const OperationResult.idle(),
        replaceCartResult: const OperationResult.idle(),
      ),
    );

    // Sync with server in background (fire-and-forget)
    // This persists locally and syncs with server
    _syncQuantityUpdateToServer(menuId: menuId, delta: delta);
  }

  /// Background sync of quantity update to server
  /// Fire-and-forget - errors are logged but don't affect UI
  Future<void> _syncQuantityUpdateToServer({
    required String menuId,
    required int delta,
  }) async {
    try {
      await _cartRepository.updateItemQuantityByDelta(
        menuId: menuId,
        delta: delta,
      );
    } catch (e, st) {
      // Log but don't propagate - optimistic update already shown
      logger.w(
        '[UserCartCubit] - Server sync failed for quantity update',
        error: e,
        stackTrace: st,
      );
    }
  }

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
              // Reset stale operation results
              addItemResult: const OperationResult.idle(),
              updateQuantityResult: const OperationResult.idle(),
              replaceCartResult: const OperationResult.idle(),
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
        '[UserCartCubit] - removeItem Error: ${e.message}',
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
            // Reset stale operation results
            addItemResult: const OperationResult.idle(),
            updateQuantityResult: const OperationResult.idle(),
            removeItemResult: const OperationResult.idle(),
            replaceCartResult: const OperationResult.idle(),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserCartCubit] - clearCart Error: ${e.message}',
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
      logger.w('[UserCartCubit] - getOrderItems failed: ${e.message}');
      return [];
    }
  }

  /// Place a food order from the current cart
  Future<PlaceOrderResponse?> placeFoodOrder({
    required Coordinate pickupLocation,
    required Coordinate dropoffLocation,
    required PaymentMethod paymentMethod,
    PaymentProvider paymentProvider = PaymentProvider.MANUAL,
    String? couponCode,
    String? attachmentUrl,
  }) async => await taskManager.execute('CC-pFO', () async {
    try {
      emit(
        state.copyWith(placeFoodOrderResult: const OperationResult.loading()),
      );

      // Get order items from cart
      final orderItems = await _cartRepository.convertToOrderItems();
      if (orderItems.isEmpty) {
        throw const RepositoryError(
          'Cart is empty',
          code: ErrorCode.badRequest,
        );
      }

      // Create place order request
      final placeOrderRequest = PlaceOrder(
        type: OrderType.FOOD,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        items: orderItems,
        attachmentUrl: attachmentUrl,
        couponCode: couponCode,
        payment: PlaceOrderPayment(
          method: paymentMethod,
          provider: paymentProvider,
        ),
      );

      // Call API via repository
      final response = await _orderRepository.placeOrder(placeOrderRequest);

      // Clear cart on success
      await _cartRepository.clearCart();

      emit(
        state.copyWith(
          placeFoodOrderResult: OperationResult.success(
            response.data,
            message: response.message,
          ),
          cart: OperationResult.success(null),
        ),
      );

      return response.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserCartCubit] - placeFoodOrder Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(placeFoodOrderResult: OperationResult.failed(e)));
      return null;
    }
  });

  /// Reset to initial state
  void reset() => emit(const UserCartState());
}
