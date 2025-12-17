part of '_export.dart';

class UserCartState extends Equatable {
  const UserCartState({
    this.cart,
    this.isLoading = false,
    this.error,
    this.pendingItem,
    this.pendingMerchantName,
    this.pendingMerchantLocation,
    this.pendingMerchantCategory,
    this.showMerchantConflict = false,
  });

  final Cart? cart;
  final bool isLoading;
  final String? error;

  /// Pending item to add (when merchant conflict detected)
  final CartItem? pendingItem;
  final String? pendingMerchantName;
  final Coordinate? pendingMerchantLocation;
  final MerchantCategory? pendingMerchantCategory;
  final bool showMerchantConflict;

  /// Computed properties
  int get totalItems => cart?.totalItems ?? 0;
  double get subtotal => (cart?.subtotal ?? 0).toDouble();
  bool get isEmpty => cart == null || cart!.items.isEmpty;
  bool get hasMerchantConflict => showMerchantConflict && pendingItem != null;
  bool get isPrintingMerchant => cart?.isPrintingMerchant ?? false;

  @override
  List<Object?> get props => [
    cart,
    isLoading,
    error,
    pendingItem,
    pendingMerchantName,
    pendingMerchantLocation,
    pendingMerchantCategory,
    showMerchantConflict,
  ];

  UserCartState copyWith({
    Cart? cart,
    bool? isLoading,
    String? error,
    CartItem? pendingItem,
    String? pendingMerchantName,
    Coordinate? pendingMerchantLocation,
    MerchantCategory? pendingMerchantCategory,
    bool? showMerchantConflict,
    bool clearError = false,
    bool clearCart = false,
    bool clearPending = false,
  }) {
    return UserCartState(
      cart: clearCart ? null : (cart ?? this.cart),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
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
}
