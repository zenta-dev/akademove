import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class MerchantMenuCategoryState extends Equatable {
  const MerchantMenuCategoryState({
    this.categories = const OperationResult.idle(),
    this.category = const OperationResult.idle(),
  });

  final OperationResult<List<MerchantMenuCategory>> categories;
  final OperationResult<MerchantMenuCategory> category;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [categories, category];

  MerchantMenuCategoryState copyWith({
    OperationResult<List<MerchantMenuCategory>>? categories,
    OperationResult<MerchantMenuCategory>? category,
  }) {
    return MerchantMenuCategoryState(
      categories: categories ?? this.categories,
      category: category ?? this.category,
    );
  }
}
