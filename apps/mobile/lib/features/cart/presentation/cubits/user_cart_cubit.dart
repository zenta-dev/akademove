import "package:akademove/core/_export.dart";
import "package:akademove/features/cart/data/_export.dart";
import "package:akademove/features/cart/presentation/states/_export.dart";
import "package:akademove/features/order/data/repositories/order_repository.dart";
import "package:api_client/api_client.dart" hide Cart, CartItem;

class UserCartCubit extends BaseCubit<UserCartState> {
  UserCartCubit({
    required CartRepository cartRepository,
    required OrderRepository orderRepository,
  }) : _cartRepository = cartRepository,
       _orderRepository = orderRepository,
       super(const UserCartState());

  final CartRepository _cartRepository;
  final OrderRepository _orderRepository;

  Future<void> loadCart() async {
    emit(state.copyWith(isLoading: true, clearError: true));
    try {
      final cart = await _cartRepository.getCart();
      emit(state.copyWith(cart: cart, isLoading: false));
    } on BaseError catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    }
  }

  Future<void> addItem({
    required MerchantMenu menu,
    required String merchantName,
    required int quantity,
    String? notes,
    Coordinate? merchantLocation,
    MerchantCategory? merchantCategory,
  }) async {
    try {
      final result = await _cartRepository.addItem(
        menu: menu,
        merchantName: merchantName,
        quantity: quantity,
        notes: notes,
        merchantLocation: merchantLocation,
        merchantCategory: merchantCategory,
      );
      emit(state.copyWith(cart: result.data, clearError: true));
    } on RepositoryError catch (e) {
      if (e.code == ErrorCode.conflict) {
        final pendingItem = CartItem(
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
        emit(
          state.copyWith(
            pendingItem: pendingItem,
            pendingMerchantName: merchantName,
            pendingMerchantLocation: merchantLocation,
            pendingMerchantCategory: merchantCategory,
            showMerchantConflict: true,
          ),
        );
      } else {
        emit(state.copyWith(error: e.message));
      }
    } on BaseError catch (e) {
      emit(state.copyWith(error: e.message));
    }
  }

  Future<void> updateQuantity({
    required String menuId,
    required int delta,
  }) async {
    try {
      final result = await _cartRepository.updateItemQuantityByDelta(
        menuId: menuId,
        delta: delta,
      );
      emit(state.copyWith(cart: result.data, clearError: true));
    } on BaseError catch (e) {
      emit(state.copyWith(error: e.message));
    }
  }

  Future<void> removeItem(String menuId) async {
    try {
      final result = await _cartRepository.removeItem(menuId);
      emit(state.copyWith(cart: result.data, clearError: true));
    } on BaseError catch (e) {
      emit(state.copyWith(error: e.message));
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartRepository.clearCart();
      emit(state.copyWith(clearCart: true, clearError: true));
    } on BaseError catch (e) {
      emit(state.copyWith(error: e.message));
    }
  }

  Future<void> confirmReplaceCart() async {
    final pending = state.pendingItem;
    final merchantName = state.pendingMerchantName;

    if (pending == null || merchantName == null) {
      emit(state.copyWith(clearPending: true));
      return;
    }

    try {
      final menu = MerchantMenu(
        id: pending.menuId,
        merchantId: pending.merchantId,
        name: pending.menuName,
        image: pending.menuImage,
        price: pending.unitPrice,
        stock: pending.stock ?? 999,
        soldStock: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final result = await _cartRepository.replaceCart(
        menu: menu,
        merchantName: merchantName,
        quantity: pending.quantity,
        notes: pending.notes,
        merchantLocation: state.pendingMerchantLocation,
        merchantCategory: state.pendingMerchantCategory,
      );
      emit(
        state.copyWith(cart: result.data, clearPending: true, clearError: true),
      );
    } on BaseError catch (e) {
      emit(state.copyWith(error: e.message, clearPending: true));
    }
  }

  void cancelReplaceCart() {
    emit(state.copyWith(clearPending: true));
  }

  Future<PlaceOrderResponse?> placeFoodOrder({
    required Coordinate pickupLocation,
    required Coordinate dropoffLocation,
    required PaymentMethod paymentMethod,
    PaymentProvider paymentProvider = PaymentProvider.MANUAL,
    String? couponCode,
    String? attachmentUrl,
  }) async {
    emit(state.copyWith(isLoading: true, clearError: true));

    try {
      final orderItems = await _cartRepository.convertToOrderItems();
      if (orderItems.isEmpty) {
        throw const RepositoryError(
          "Cart is empty",
          code: ErrorCode.badRequest,
        );
      }

      final request = PlaceOrder(
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

      final response = await _orderRepository.placeOrder(request);
      await _cartRepository.clearCart();
      emit(state.copyWith(clearCart: true, isLoading: false));
      return response.data;
    } on BaseError catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
      return null;
    }
  }

  void reset() {
    emit(const UserCartState());
  }
}
