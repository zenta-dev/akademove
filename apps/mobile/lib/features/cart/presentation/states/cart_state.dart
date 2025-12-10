part of '_export.dart';

class CartState extends Equatable {
  const CartState({
    this.cart = const OperationResult.idle(),
    this.addItemResult = const OperationResult.idle(),
    this.updateQuantityResult = const OperationResult.idle(),
    this.removeItemResult = const OperationResult.idle(),
    this.clearCartResult = const OperationResult.idle(),
    this.replaceCartResult = const OperationResult.idle(),
    this.pendingItem,
    this.pendingMerchantName,
    this.showMerchantConflict = false,
  });

  /// Current cart (loaded from storage)
  final OperationResult<Cart?> cart;

  /// Add item operation result
  final OperationResult<Cart> addItemResult;

  /// Update quantity operation result
  final OperationResult<Cart?> updateQuantityResult;

  /// Remove item operation result
  final OperationResult<Cart?> removeItemResult;

  /// Clear cart operation result
  final OperationResult<bool> clearCartResult;

  /// Replace cart operation result (when merchant conflict resolved)
  final OperationResult<Cart> replaceCartResult;

  /// Pending item to add (when merchant conflict detected)
  final CartItem? pendingItem;

  /// Pending merchant name (when merchant conflict detected)
  final String? pendingMerchantName;

  /// Whether to show merchant conflict dialog
  final bool showMerchantConflict;

  /// Get the current cart data from any successful operation
  Cart? get currentCart {
    // Return from the most recently successful operation
    if (replaceCartResult.isSuccess && replaceCartResult.value != null) {
      return replaceCartResult.value;
    }
    if (addItemResult.isSuccess && addItemResult.value != null) {
      return addItemResult.value;
    }
    if (updateQuantityResult.isSuccess && updateQuantityResult.value != null) {
      return updateQuantityResult.value;
    }
    if (removeItemResult.isSuccess) {
      return removeItemResult.value;
    }
    if (clearCartResult.isSuccess) {
      return null;
    }
    return cart.value;
  }

  /// Computed: total number of items in cart
  int get totalItems => currentCart?.totalItems ?? 0;

  /// Computed: cart subtotal
  double get subtotal => (currentCart?.subtotal ?? 0).toDouble();

  /// Computed: is cart empty
  bool get isEmpty =>
      currentCart == null || (currentCart?.items.isEmpty ?? true);

  /// Computed: has merchant conflict
  bool get hasMerchantConflict => showMerchantConflict && pendingItem != null;

  /// Computed: any operation is loading
  bool get isLoading =>
      cart.isLoading ||
      addItemResult.isLoading ||
      updateQuantityResult.isLoading ||
      removeItemResult.isLoading ||
      clearCartResult.isLoading ||
      replaceCartResult.isLoading;

  @override
  List<Object?> get props => [
    cart,
    addItemResult,
    updateQuantityResult,
    removeItemResult,
    clearCartResult,
    replaceCartResult,
    pendingItem,
    pendingMerchantName,
    showMerchantConflict,
  ];

  CartState copyWith({
    OperationResult<Cart?>? cart,
    OperationResult<Cart>? addItemResult,
    OperationResult<Cart?>? updateQuantityResult,
    OperationResult<Cart?>? removeItemResult,
    OperationResult<bool>? clearCartResult,
    OperationResult<Cart>? replaceCartResult,
    CartItem? pendingItem,
    String? pendingMerchantName,
    bool? showMerchantConflict,
    bool clearPending = false,
  }) {
    return CartState(
      cart: cart ?? this.cart,
      addItemResult: addItemResult ?? this.addItemResult,
      updateQuantityResult: updateQuantityResult ?? this.updateQuantityResult,
      removeItemResult: removeItemResult ?? this.removeItemResult,
      clearCartResult: clearCartResult ?? this.clearCartResult,
      replaceCartResult: replaceCartResult ?? this.replaceCartResult,
      pendingItem: clearPending ? null : (pendingItem ?? this.pendingItem),
      pendingMerchantName: clearPending
          ? null
          : (pendingMerchantName ?? this.pendingMerchantName),
      showMerchantConflict: clearPending
          ? false
          : (showMerchantConflict ?? this.showMerchantConflict),
    );
  }

  @override
  bool get stringify => true;
}
