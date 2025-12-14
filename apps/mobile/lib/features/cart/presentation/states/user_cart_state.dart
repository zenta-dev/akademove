part of '_export.dart';

class UserCartState extends Equatable {
  const UserCartState({
    this.cart = const OperationResult.idle(),
    this.addItemResult = const OperationResult.idle(),
    this.updateQuantityResult = const OperationResult.idle(),
    this.removeItemResult = const OperationResult.idle(),
    this.clearCartResult = const OperationResult.idle(),
    this.replaceCartResult = const OperationResult.idle(),
    this.placeFoodOrderResult = const OperationResult.idle(),
    this.uploadAttachmentResult = const OperationResult.idle(),
    this.pendingItem,
    this.pendingMerchantName,
    this.pendingMerchantLocation,
    this.pendingMerchantCategory,
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

  /// Place food order operation result
  final OperationResult<PlaceOrderResponse> placeFoodOrderResult;

  /// Upload attachment operation result
  final OperationResult<String> uploadAttachmentResult;

  /// Pending item to add (when merchant conflict detected)
  final CartItem? pendingItem;

  /// Pending merchant name (when merchant conflict detected)
  final String? pendingMerchantName;

  /// Pending merchant location (when merchant conflict detected)
  final Coordinate? pendingMerchantLocation;

  /// Pending merchant category (when merchant conflict detected)
  final MerchantCategory? pendingMerchantCategory;

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

  /// Computed: is this a printing merchant (requires attachment)
  bool get isPrintingMerchant => currentCart?.isPrintingMerchant ?? false;

  /// Computed: has attachment
  bool get hasAttachment => currentCart?.attachmentUrl != null;

  @override
  List<Object?> get props => [
    cart,
    addItemResult,
    updateQuantityResult,
    removeItemResult,
    clearCartResult,
    replaceCartResult,
    placeFoodOrderResult,
    uploadAttachmentResult,
    pendingItem,
    pendingMerchantName,
    pendingMerchantLocation,
    pendingMerchantCategory,
    showMerchantConflict,
  ];

  UserCartState copyWith({
    OperationResult<Cart?>? cart,
    OperationResult<Cart>? addItemResult,
    OperationResult<Cart?>? updateQuantityResult,
    OperationResult<Cart?>? removeItemResult,
    OperationResult<bool>? clearCartResult,
    OperationResult<Cart>? replaceCartResult,
    OperationResult<PlaceOrderResponse>? placeFoodOrderResult,
    OperationResult<String>? uploadAttachmentResult,
    CartItem? pendingItem,
    String? pendingMerchantName,
    Coordinate? pendingMerchantLocation,
    MerchantCategory? pendingMerchantCategory,
    bool? showMerchantConflict,
    bool clearPending = false,
  }) {
    return UserCartState(
      cart: cart ?? this.cart,
      addItemResult: addItemResult ?? this.addItemResult,
      updateQuantityResult: updateQuantityResult ?? this.updateQuantityResult,
      removeItemResult: removeItemResult ?? this.removeItemResult,
      clearCartResult: clearCartResult ?? this.clearCartResult,
      replaceCartResult: replaceCartResult ?? this.replaceCartResult,
      placeFoodOrderResult: placeFoodOrderResult ?? this.placeFoodOrderResult,
      uploadAttachmentResult:
          uploadAttachmentResult ?? this.uploadAttachmentResult,
      pendingItem: clearPending ? null : (pendingItem ?? this.pendingItem),
      pendingMerchantName: clearPending
          ? null
          : (pendingMerchantName ?? this.pendingMerchantName),
      pendingMerchantLocation: clearPending
          ? null
          : (pendingMerchantLocation ?? this.pendingMerchantLocation),
      pendingMerchantCategory: clearPending
          ? null
          : (pendingMerchantCategory ?? this.pendingMerchantCategory),
      showMerchantConflict: clearPending
          ? false
          : (showMerchantConflict ?? this.showMerchantConflict),
    );
  }

  @override
  bool get stringify => true;
}
