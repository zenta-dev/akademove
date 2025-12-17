import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

/// Repository for managing merchant menu categories
/// Uses the generated API client for type-safe API calls
class MerchantMenuCategoryRepository extends BaseRepository {
  MerchantMenuCategoryRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Get list of menu categories for a merchant
  Future<BaseResponse<List<MerchantMenuCategory>>> list({
    required String merchantId,
    int? page,
    int? limit,
    String? query,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCategoryList(
        merchantId: merchantId,
        page: page,
        limit: limit,
        query: query,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Menu categories not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get a single menu category by ID
  Future<BaseResponse<MerchantMenuCategory>> get({
    required String merchantId,
    required String categoryId,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCategoryGet(
        merchantId: merchantId,
        id: categoryId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Menu category not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Create a new menu category
  Future<BaseResponse<MerchantMenuCategory>> create({
    required String merchantId,
    required String name,
    String? description,
    int? sortOrder,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCategoryCreate(
        merchantId: merchantId,
        merchantMenuCategoryCreateRequest: MerchantMenuCategoryCreateRequest(
          name: name,
          description: description,
          sortOrder: sortOrder,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to create menu category',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Update an existing menu category
  Future<BaseResponse<MerchantMenuCategory>> update({
    required String merchantId,
    required String categoryId,
    String? name,
    String? description,
    int? sortOrder,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCategoryUpdate(
        merchantId: merchantId,
        id: categoryId,
        merchantMenuCategoryUpdateRequest: MerchantMenuCategoryUpdateRequest(
          name: name,
          description: description,
          sortOrder: sortOrder,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update menu category',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Delete a menu category
  Future<BaseResponse<void>> remove({
    required String merchantId,
    required String categoryId,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantMenuCategoryRemove(
        merchantId: merchantId,
        id: categoryId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to delete menu category',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: null);
    });
  }
}
