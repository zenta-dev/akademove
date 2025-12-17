import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class UserMartCubit extends BaseCubit<UserMartState> {
  UserMartCubit({
    required MerchantRepository merchantRepository,
    required LocationService locationService,
  }) : _merchantRepository = merchantRepository,
       _locationService = locationService,
       super(const UserMartState());

  final MerchantRepository _merchantRepository;
  final LocationService _locationService;

  /// Load mart home screen data (best sellers + nearby merchants)
  Future<void>
  loadMartHome() async => await taskManager.execute('UMC-lMH', () async {
    try {
      emit(
        state.copyWith(
          bestSellers: const OperationResult.loading(),
          nearbyMerchants: const OperationResult.loading(),
        ),
      );

      // Load best sellers and nearby merchants in parallel
      final results = await Future.wait([
        _merchantRepository.getBestSellers(limit: 20),
        _loadNearbyMerchantsInternal(),
      ]);

      final bestSellersRes =
          results[0]
              as BaseResponse<List<MerchantBestSellers200ResponseDataInner>>;

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
            // Best sellers use orderCount for ranking, soldStock shown when available
            soldStock: 0,
            createdAt: menu.createdAt ?? DateTime.now(),
            updatedAt: menu.updatedAt ?? DateTime.now(),
          ),
          merchantName: item.merchant.name,
        );
      }).toList();

      // Recent orders would come from order repository
      // For now, we don't have a specific API endpoint for user's recent mart orders
      final recentOrders = <Order>[];

      final nearbyRes = results[1] as BaseResponse<List<Merchant>>?;

      emit(
        state.copyWith(
          bestSellers: OperationResult.success(
            bestSellers,
            message: bestSellersRes.message,
          ),
          recentOrders: OperationResult.success(recentOrders),
          nearbyMerchants: nearbyRes != null
              ? OperationResult.success(
                  nearbyRes.data,
                  message: nearbyRes.message,
                )
              : OperationResult.success(<Merchant>[]),
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

  /// Internal method to load nearby merchants
  Future<BaseResponse<List<Merchant>>?> _loadNearbyMerchantsInternal() async {
    try {
      final location = await _locationService.getMyLocation(
        fromCache: true,
        timeout: const Duration(seconds: 10),
      );

      if (location == null) {
        logger.w(
          '[UserMartCubit] - Could not get user location for nearby merchants',
        );
        return null;
      }

      return await _merchantRepository.listNearby(
        latitude: location.y.toDouble(),
        longitude: location.x.toDouble(),
        maxDistance: 5000, // 5km radius
        limit: 10,
      );
    } catch (e, st) {
      logger.e(
        '[UserMartCubit] - loadNearbyMerchants Error: $e',
        error: e,
        stackTrace: st,
      );
      return null;
    }
  }

  /// Load nearby merchants separately (can be called to refresh)
  Future<void> loadNearbyMerchants() async => await taskManager.execute(
    'UMC-lNM',
    () async {
      try {
        emit(state.copyWith(nearbyMerchants: const OperationResult.loading()));

        final res = await _loadNearbyMerchantsInternal();

        emit(
          state.copyWith(
            nearbyMerchants: res != null
                ? OperationResult.success(res.data, message: res.message)
                : OperationResult.success(<Merchant>[]),
          ),
        );
      } on BaseError catch (e, st) {
        logger.e(
          '[UserMartCubit] - loadNearbyMerchants Error: ${e.message}',
          error: e,
          stackTrace: st,
        );
        emit(state.copyWith(nearbyMerchants: OperationResult.failed(e)));
      }
    },
  );

  /// Load merchants by category (ATK, Printing, Food)
  /// Uses backend category filtering to show merchants with matching categories
  /// Only shows approved, active, and open merchants to match server behavior
  Future<void> loadCategoryMerchants({required String category}) async =>
      await taskManager.execute('UMC-lCM-$category', () async {
        try {
          emit(
            state.copyWith(
              categoryMerchants: const OperationResult.loading(),
              selectedCategory: category,
            ),
          );

          // Use list() with category filter and status filters
          // This matches server's popular merchants filter criteria
          final res = await _merchantRepository.list(
            category: category,
            isActive: true, // Only show active merchants
            status: MerchantStatus.APPROVED, // Only show approved merchants
            operatingStatus: 'OPEN', // Only show open merchants
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
