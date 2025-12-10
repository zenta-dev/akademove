part of '_export.dart';

class UserMerchantDetailState extends Equatable {
  const UserMerchantDetailState({
    this.merchant = const OperationResult.idle(),
    this.menuByCategory = const OperationResult.idle(),
    this.warningToast,
  });

  /// Merchant profile data
  final OperationResult<Merchant> merchant;

  /// Menu items grouped by category
  /// Example: { "Drinks": [...], "Snacks": [...], "Meals": [...] }
  final OperationResult<Map<String, List<MerchantMenu>>> menuByCategory;

  /// Warning message for stock decreases
  final String? warningToast;

  bool get isEmpty =>
      menuByCategory.value == null || menuByCategory.value!.isEmpty;

  @override
  List<Object?> get props => [merchant, menuByCategory, warningToast];

  UserMerchantDetailState copyWith({
    OperationResult<Merchant>? merchant,
    OperationResult<Map<String, List<MerchantMenu>>>? menuByCategory,
    String? warningToast,
  }) {
    return UserMerchantDetailState(
      merchant: merchant ?? this.merchant,
      menuByCategory: menuByCategory ?? this.menuByCategory,
      warningToast: warningToast ?? this.warningToast,
    );
  }

  @override
  bool get stringify => true;
}
