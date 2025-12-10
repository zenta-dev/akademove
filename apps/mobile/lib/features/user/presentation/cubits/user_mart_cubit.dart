import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserMartCubit extends BaseCubit<UserMartState> {
  UserMartCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(const UserMartState());

  final MerchantRepository _merchantRepository;

  /// Load mart home screen data (best sellers + recent orders)
  Future<void>
  loadMartHome() async => await taskManager.execute('UMC-lMH', () async {
    try {
      emit(
        state.copyWith(
          bestSellers: const OperationResult.loading(),
          // recentOrders: const OperationResult.loading(), // Optional: load separately or together
        ),
      );

      // Load best sellers from API
      final bestSellersRes = await _merchantRepository.getBestSellers(
        limit: 20,
      );

      // Convert best seller items to BestSellerItem (menu + merchant name)
      final bestSellers = bestSellersRes.data.map((item) {
        final menu = item.menu;
        return BestSellerItem(
          menu: MerchantMenu(
            id: menu.id,
            merchantId: menu.merchantId,
            name: menu.name,
            image: menu.image,
            category: menu.category,
            price: menu.price,
            stock: menu.stock.toInt(),
            createdAt: menu.createdAt ?? DateTime.now(),
            updatedAt: menu.updatedAt ?? DateTime.now(),
          ),
          merchantName: item.merchant.name,
        );
      }).toList();

      // Recent orders would come from order repository
      // For now, we don't have a specific API endpoint for user's recent mart orders
      final recentOrders = <Order>[];

      emit(
        state.copyWith(
          bestSellers: OperationResult.success(
            bestSellers,
            message: bestSellersRes.message,
          ),
          recentOrders: OperationResult.success(recentOrders),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserMartCubit] - loadMartHome Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(bestSellers: OperationResult.failed(e)));
    }
  });

  /// Load merchants by category (ATK, Printing, Food)
  /// Uses backend category filtering to show merchants with matching categories
  Future<void> loadCategoryMerchants({required String category}) async =>
      await taskManager.execute('UMC-lCM-$category', () async {
        try {
          emit(
            state.copyWith(
              categoryMerchants: const OperationResult.loading(),
              selectedCategory: category,
            ),
          );

          // Use list() with category filter
          final res = await _merchantRepository.list(
            category: category,
            limit: 50, // Get reasonable number of merchants per category
          );

          emit(
            state.copyWith(
              selectedCategory: category,
              categoryMerchants: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[UserMartCubit] - loadCategoryMerchants Error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(categoryMerchants: OperationResult.failed(e)));
        }
      });

  /// Reset to initial state
  void reset() => emit(const UserMartState());
}
