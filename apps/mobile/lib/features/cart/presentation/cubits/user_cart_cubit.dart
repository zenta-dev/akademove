import 'package:akademove/core/_export.dart';
import 'package:akademove/features/cart/data/_export.dart';
import 'package:akademove/features/cart/data/models/cart_models.dart' as models;
import 'package:akademove/features/cart/presentation/states/_export.dart';
import 'package:akademove/features/order/data/repositories/order_repository.dart';
import 'package:api_client/api_client.dart' hide Cart, CartItem;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart' show MediaType;

class UserCartCubit extends BaseCubit<UserCartState> {
  UserCartCubit({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
  }) : _cartRepository = cartRepository,
       _orderRepository = orderRepository,
       super(const UserCartState());

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;

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
        '[UserCartCubit] - loadCart Error: ${e.message}',
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
  Future<void> updateQuantity({
    required String menuId,
    required int delta,
  }) async {
    // Use stable key per menuId - operations are serialized in the repository
    final taskKey = 'CC-uQ-$menuId';
    await taskManager.execute(taskKey, () async {
      try {
        final result = await _cartRepository.updateItemQuantityByDelta(
          menuId: menuId,
          delta: delta,
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
              state.copyWith(
                updateQuantityResult: OperationResult.failed(error),
              ),
            );
          },
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserCartCubit] - updateQuantity Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(updateQuantityResult: OperationResult.failed(e)));
      }
    });
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

  /// Reset to initial state
  void reset() => emit(const UserCartState());

  /// Place a food order from the current cart
  Future<PlaceOrderResponse?> placeFoodOrder({
    required Coordinate pickupLocation,
    required Coordinate dropoffLocation,
    required PaymentMethod paymentMethod,
    PaymentProvider paymentProvider = PaymentProvider.MANUAL,
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

      // Get attachment URL from cart if present
      final cart = await _cartRepository.getCart();
      final attachmentUrl = cart?.attachmentUrl;

      // Create place order request
      final placeOrderRequest = PlaceOrder(
        type: OrderType.FOOD,
        pickupLocation: pickupLocation,
        dropoffLocation: dropoffLocation,
        items: orderItems,
        attachmentUrl: attachmentUrl,
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

  /// Upload attachment file for Printing merchants
  /// Returns the uploaded URL on success
  Future<String?> uploadAttachment(
    String filePath,
  ) async => await taskManager.execute('CC-uA', () async {
    try {
      emit(
        state.copyWith(uploadAttachmentResult: const OperationResult.loading()),
      );

      // Create multipart file from path
      final file = await MultipartFile.fromFile(
        filePath,
        contentType: _getMediaType(filePath),
      );

      // Upload to server
      final response = await _orderRepository.uploadAttachment(file);

      // Update cart with attachment URL
      await _cartRepository.updateAttachment(response.data);

      // Reload cart to get updated data
      final updatedCart = await _cartRepository.getCart();

      emit(
        state.copyWith(
          uploadAttachmentResult: OperationResult.success(
            response.data,
            message: response.message,
          ),
          cart: OperationResult.success(updatedCart),
        ),
      );

      return response.data;
    } on BaseError catch (e, st) {
      logger.e(
        '[UserCartCubit] - uploadAttachment Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(uploadAttachmentResult: OperationResult.failed(e)));
      return null;
    }
  });

  /// Remove attachment from cart
  Future<void> removeAttachment() async =>
      await taskManager.execute('CC-rA', () async {
        try {
          await _cartRepository.updateAttachment(null);
          final updatedCart = await _cartRepository.getCart();
          emit(
            state.copyWith(
              uploadAttachmentResult: const OperationResult.idle(),
              cart: OperationResult.success(updatedCart),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserCartCubit] - removeAttachment Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
        }
      });

  /// Get media type from file extension
  MediaType _getMediaType(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return MediaType('application', 'pdf');
      case 'doc':
        return MediaType('application', 'msword');
      case 'docx':
        return MediaType(
          'application',
          'vnd.openxmlformats-officedocument.wordprocessingml.document',
        );
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      default:
        return MediaType('application', 'octet-stream');
    }
  }
}
