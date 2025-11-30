part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class UserMartState extends BaseState2 with UserMartStateMappable {
  UserMartState({
    this.categories = const ['ATK', 'Printing', 'Food'],
    this.bestSellers = const [],
    this.recentOrders = const [],
    this.categoryMerchants = const [],
    this.selectedCategory,
    super.state,
    super.message,
    super.error,
  });

  final List<String> categories;
  final List<MerchantMenu> bestSellers;
  final List<Order> recentOrders;
  final List<Merchant> categoryMerchants;
  final String? selectedCategory;

  @override
  UserMartState toInitial() =>
      copyWith(state: CubitState.initial, message: null, error: null);

  @override
  UserMartState toLoading() =>
      copyWith(state: CubitState.loading, message: null, error: null);

  @override
  UserMartState toSuccess({
    List<String>? categories,
    List<MerchantMenu>? bestSellers,
    List<Order>? recentOrders,
    List<Merchant>? categoryMerchants,
    String? selectedCategory,
    String? message,
  }) => copyWith(
    state: CubitState.success,
    categories: categories ?? this.categories,
    bestSellers: bestSellers ?? this.bestSellers,
    recentOrders: recentOrders ?? this.recentOrders,
    categoryMerchants: categoryMerchants ?? this.categoryMerchants,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    message: message,
    error: null,
  );

  @override
  UserMartState toFailure(BaseError error, {String? message}) =>
      copyWith(state: CubitState.failure, error: error, message: message);
}
