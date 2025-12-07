part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserMerchantDetailState extends BaseState2 {
  UserMerchantDetailState({
    this.merchant,
    this.menuByCategory,
    this.warningToast,
    super.state,
    super.message,
    super.error,
  });

  /// Merchant profile data
  final Merchant? merchant;

  /// Menu items grouped by category
  /// Example: { "Drinks": [...], "Snacks": [...], "Meals": [...] }
  final Map<String, List<MerchantMenu>>? menuByCategory;

  /// Warning message for stock decreases
  final String? warningToast;

  bool get isEmpty => menuByCategory?.isEmpty ?? true;

  UserMerchantDetailState copyWith({
    CubitState? state,
    Merchant? merchant,
    Map<String, List<MerchantMenu>>? menuByCategory,
    String? message,
    BaseError? error,
    String? warningToast,
  }) {
    return UserMerchantDetailState(
      state: state ?? this.state,
      merchant: merchant ?? this.merchant,
      menuByCategory: menuByCategory ?? this.menuByCategory,
      message: message ?? this.message,
      error: error ?? this.error,
      warningToast: warningToast ?? this.warningToast,
    );
  }

  @override
  UserMerchantDetailState toInitial() => copyWith(
    state: CubitState.initial,
    merchant: null,
    menuByCategory: null,
    message: null,
    error: null,
    warningToast: null,
  );

  @override
  UserMerchantDetailState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserMerchantDetailState toSuccess({
    Merchant? merchant,
    Map<String, List<MerchantMenu>>? menuByCategory,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    merchant: merchant ?? this.merchant,
    menuByCategory: menuByCategory ?? this.menuByCategory,
    message: message,
    error: null,
    warningToast: null,
  );

  @override
  UserMerchantDetailState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);

  /// Reset to initial state
  UserMerchantDetailState reset() => toInitial();
}
