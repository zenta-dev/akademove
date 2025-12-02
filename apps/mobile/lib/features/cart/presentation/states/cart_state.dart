part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class CartState extends BaseState2 with CartStateMappable {
  CartState({
    this.cart,
    this.pendingItem,
    this.pendingMerchantName,
    this.showMerchantConflict = false,
    super.state,
    super.message,
    super.error,
  });

  /// Current cart (null if empty)
  final Cart? cart;

  /// Pending item to add (when merchant conflict detected)
  final CartItem? pendingItem;

  /// Pending merchant name (when merchant conflict detected)
  final String? pendingMerchantName;

  /// Whether to show merchant conflict dialog
  final bool showMerchantConflict;

  /// Computed: total number of items in cart
  int get totalItems => cart?.totalItems ?? 0;

  /// Computed: cart subtotal
  double get subtotal => (cart?.subtotal ?? 0).toDouble();

  /// Computed: is cart empty
  bool get isEmpty => cart == null || (cart?.items.isEmpty ?? true);

  /// Computed: has merchant conflict
  bool get hasMerchantConflict => showMerchantConflict && pendingItem != null;

  @override
  CartState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  CartState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  CartState toSuccess({
    Cart? cart,
    CartItem? pendingItem,
    String? pendingMerchantName,
    bool? showMerchantConflict,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    cart: cart,
    pendingItem: pendingItem,
    pendingMerchantName: pendingMerchantName,
    showMerchantConflict: showMerchantConflict ?? false,
    message: message,
    error: null,
  );

  @override
  CartState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);

  /// Helper: Create merchant conflict state
  CartState toMerchantConflict({
    required CartItem pendingItem,
    required String pendingMerchantName,
  }) => copyWith(
    state: CubitState.success,
    pendingItem: pendingItem,
    pendingMerchantName: pendingMerchantName,
    showMerchantConflict: true,
    error: null,
  );

  /// Helper: Clear merchant conflict
  CartState clearConflict() => copyWith(
    pendingItem: null,
    pendingMerchantName: null,
    showMerchantConflict: false,
  );
}
