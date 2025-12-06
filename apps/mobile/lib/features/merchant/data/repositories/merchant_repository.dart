import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class MerchantRepository extends BaseRepository {
  const MerchantRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<Merchant>> getMine() {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantGetMine();

      final data =
          res.data?.body ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<List<Merchant>>> getPopulars() {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantPopulars();

      final data =
          res.data ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get list of merchants with optional category filter
  /// Used for UserMart category screens (ATK, Printing, Food, etc.)
  Future<BaseResponse<List<Merchant>>> list({
    String? category,
    String? query,
    int? page,
    int? limit,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantList(
        categories: category != null ? [category] : null,
        query: query,
        page: page,
        limit: limit,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Merchants not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get best-selling menu items across all merchants
  /// Used for mart home screen to show popular products
  Future<BaseResponse<List<MerchantBestSellers200ResponseDataInner>>>
  getBestSellers({num limit = 10, String? category}) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantBestSellers(
        limit: limit,
        category: category,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Best sellers not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // ========== MERCHANT MENU METHODS ==========

  Future<BaseResponse<List<MerchantMenu>>> getMenuList({
    required String merchantId,
    int? page,
    int? limit,
    String? query,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuList(
        merchantId: merchantId,
        page: page,
        limit: limit,
        query: query,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Menu list not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<MerchantMenu>> getMenu({
    required String merchantId,
    required String menuId,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuGet(
        merchantId: merchantId,
        id: menuId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Menu not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<MerchantMenu>> createMenu({
    required String merchantId,
    required String name,
    required num price,
    required int stock,
    String? category,
    MultipartFile? image,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCreate(
        merchantId: merchantId,
        name: name,
        price: price,
        stock: stock,
        category: category,
        image: image,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to create menu',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<MerchantMenu>> updateMenu({
    required String merchantId,
    required String menuId,
    String? name,
    num? price,
    int? stock,
    String? category,
    MultipartFile? image,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuUpdate(
        merchantId: merchantId,
        id: menuId,
        name: name,
        price: price,
        stock: stock,
        category: category,
        image: image,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update menu',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<void>> deleteMenu({
    required String merchantId,
    required String menuId,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuRemove(
        merchantId: merchantId,
        id: menuId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to delete menu',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: null);
    });
  }
}
