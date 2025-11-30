import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserMartCubit extends BaseCubit<UserMartState> {
  UserMartCubit({required MerchantRepository merchantRepository})
    : _merchantRepository = merchantRepository,
      super(UserMartState());

  final MerchantRepository _merchantRepository;

  /// Load mart home screen data (best sellers + recent orders)
  Future<void> loadMartHome() async {
    try {
      emit(state.toLoading());

      // TODO: Implement best sellers API call when backend is ready
      // For now, just load with empty data
      final bestSellers = <MerchantMenu>[];
      final recentOrders = <Order>[];

      emit(
        state.toSuccess(
          bestSellers: bestSellers,
          recentOrders: recentOrders,
          message: 'Mart home loaded successfully',
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserMartCubit] - loadMartHome Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Load merchants by category (ATK, Printing, Food)
  Future<void> loadCategoryMerchants({required String category}) async {
    try {
      emit(state.toLoading());

      // TODO: Call merchant API with category filter when backend is ready
      // For now, use getPopulars
      final res = await _merchantRepository.getPopulars();

      emit(
        state.toSuccess(
          selectedCategory: category,
          categoryMerchants: res.data,
          message: res.message,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[UserMartCubit] - loadCategoryMerchants Error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Reset to initial state
  void reset() => emit(UserMartState());
}
