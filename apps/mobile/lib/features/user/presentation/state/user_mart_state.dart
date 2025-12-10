// ignore_for_file: public_member_api_docs, sort_constructors_first

part of '_export.dart';

class BestSellerItem extends Equatable {
  const BestSellerItem({required this.menu, required this.merchantName});

  final MerchantMenu menu;
  final String merchantName;

  @override
  List<Object> get props => [menu, merchantName];

  @override
  bool get stringify => true;

  BestSellerItem copyWith({MerchantMenu? menu, String? merchantName}) {
    return BestSellerItem(
      menu: menu ?? this.menu,
      merchantName: merchantName ?? this.merchantName,
    );
  }
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
