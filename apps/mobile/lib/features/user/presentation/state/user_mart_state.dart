part of '_export.dart';

/// Wrapper class to hold menu + merchant name for best sellers
@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class BestSellerItem with BestSellerItemMappable {
  const BestSellerItem({required this.menu, required this.merchantName});

  final MerchantMenu menu;
  final String merchantName;
}

class UserMartState extends Equatable {
  const UserMartState({
    this.categories = const ['ATK', 'Printing', 'Food'],
    this.bestSellers = const OperationResult.idle(),
    this.recentOrders = const OperationResult.idle(),
    this.categoryMerchants = const OperationResult.idle(),
    this.selectedCategory,
  });

  final List<String> categories;
  final OperationResult<List<BestSellerItem>> bestSellers;
  final OperationResult<List<Order>> recentOrders;
  final OperationResult<List<Merchant>> categoryMerchants;
  final String? selectedCategory;

  @override
  List<Object?> get props => [
    categories,
    bestSellers,
    recentOrders,
    categoryMerchants,
    selectedCategory,
  ];

  UserMartState copyWith({
    List<String>? categories,
    OperationResult<List<BestSellerItem>>? bestSellers,
    OperationResult<List<Order>>? recentOrders,
    OperationResult<List<Merchant>>? categoryMerchants,
    String? selectedCategory,
  }) {
    return UserMartState(
      categories: categories ?? this.categories,
      bestSellers: bestSellers ?? this.bestSellers,
      recentOrders: recentOrders ?? this.recentOrders,
      categoryMerchants: categoryMerchants ?? this.categoryMerchants,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }

  @override
  bool get stringify => true;
}
