import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class MerchantRepository extends BaseRepository {
  MerchantRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Cached merchant ID for availability operations
  String? _cachedMerchantId;

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

  Future<BaseResponse<Merchant>> getById(String merchantId) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantGet(id: merchantId);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Merchant not found',
            code: ErrorCode.notFound,
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

  /// Get merchant list with advanced filtering and search
  /// Used for user home screen merchant list with:
  /// - Search by name
  /// - Filter by active/open status
  /// - Pagination with cursor
  Future<BaseResponse<List<Merchant>>> listWithFilters({
    String? query,
    bool isActive = true,
    String? sortBy, // 'rating' for bestsellers, 'distance' for nearby
    int? limit,
    String? cursor, // Cursor-based pagination
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantList(
        query: query,
        isActive: isActive,
        sortBy: sortBy,
        limit: limit,
        cursor: cursor,
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

  // ========== MERCHANT AVAILABILITY METHODS ==========

  /// Helper to get merchant ID (cached for performance)
  Future<String> _getMerchantId() async {
    if (_cachedMerchantId != null) {
      return _cachedMerchantId!;
    }
    final res = await getMine();
    _cachedMerchantId = res.data.id;
    return _cachedMerchantId!;
  }

  /// Clear cached merchant ID (call on logout)
  void clearCache() {
    _cachedMerchantId = null;
  }

  /// Set merchant online status
  Future<BaseResponse<Merchant>> setOnlineStatus(bool isOnline) {
    return guard(() async {
      final merchantId = await _getMerchantId();

      final res = await _apiClient.getMerchantApi().merchantSetOnlineStatus(
        id: merchantId,
        driverUpdateOnlineStatusRequest: DriverUpdateOnlineStatusRequest(
          isOnline: isOnline,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update online status',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(
        message: isOnline ? 'You are now online' : 'You are now offline',
        data: data.data,
      );
    });
  }

  /// Set merchant operating status (OPEN, CLOSED, BREAK, MAINTENANCE)
  Future<BaseResponse<Merchant>> setOperatingStatus(
    MerchantSetOperatingStatusRequestOperatingStatusEnum operatingStatus,
  ) {
    return guard(() async {
      final merchantId = await _getMerchantId();

      final res = await _apiClient.getMerchantApi().merchantSetOperatingStatus(
        id: merchantId,
        merchantSetOperatingStatusRequest: MerchantSetOperatingStatusRequest(
          operatingStatus: operatingStatus,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update operating status',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(
        message: 'Store status updated to ${operatingStatus.value}',
        data: data.data,
      );
    });
  }

  /// Get merchant availability status
  Future<BaseResponse<MerchantGetAvailabilityStatus200ResponseData>>
  getAvailabilityStatus() {
    return guard(() async {
      final merchantId = await _getMerchantId();

      final res = await _apiClient
          .getMerchantApi()
          .merchantGetAvailabilityStatus(id: merchantId);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to get availability status',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // ========== MERCHANT PROFILE UPDATE METHODS ==========

  /// Update merchant profile
  Future<BaseResponse<Merchant>> update({
    required String merchantId,
    String? name,
    String? email,
    required String phoneCountryCode,
    required int phoneNumber,
    String? address,
    required num locationX,
    required num locationY,
    String? category,
    required String bankProvider,
    required num bankNumber,
    String? bankAccountName,
    MultipartFile? document,
    MultipartFile? image,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantUpdate(
        id: merchantId,
        name: name,
        email: email,
        phoneCountryCode: phoneCountryCode,
        phoneNumber: phoneNumber,
        address: address,
        locationX: locationX,
        locationY: locationY,
        category: category,
        bankProvider: bankProvider,
        bankNumber: bankNumber,
        bankAccountName: bankAccountName,
        document: document,
        image: image,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update merchant',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Setup outlet - updates merchant image and category
  /// This is a simplified update method for the outlet setup wizard
  /// It fetches current merchant data to get required fields, then updates
  Future<BaseResponse<Merchant>> setupOutlet({
    required String merchantId,
    MerchantCategory? category,
    MultipartFile? image,
  }) {
    return guard(() async {
      // First, get current merchant data to retrieve required fields
      final currentMerchant = await getMine();
      final merchant = currentMerchant.data;

      final res = await _apiClient.getMerchantApi().merchantUpdate(
        id: merchantId,
        phoneCountryCode: merchant.phone?.countryCode.value ?? '+62',
        phoneNumber: merchant.phone?.number ?? 0,
        locationX: merchant.location?.x ?? 0,
        locationY: merchant.location?.y ?? 0,
        bankProvider: merchant.bank.provider.value,
        bankNumber: merchant.bank.number.toInt(),
        bankAccountName: merchant.bank.accountName,
        category: category?.value,
        image: image,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to setup outlet',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // ========== MERCHANT OPERATING HOURS METHODS ==========

  /// Bulk upsert operating hours for a merchant
  /// Used in the outlet setup wizard (Step 2) to set weekly operating schedule
  Future<BaseResponse<List<MerchantOperatingHours>>> bulkUpsertOperatingHours({
    required String merchantId,
    required List<MerchantOperatingHoursCreateRequest> hours,
  }) {
    return guard(() async {
      final res = await _apiClient
          .getMerchantApi()
          .merchantOperatingHoursBulkUpsert(
            merchantId: merchantId,
            merchantOperatingHoursBulkUpsertRequest:
                MerchantOperatingHoursBulkUpsertRequest(hours: hours),
          );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update operating hours',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get operating hours for a merchant
  Future<BaseResponse<List<MerchantOperatingHours>>> getOperatingHours({
    required String merchantId,
  }) {
    return guard(() async {
      final res = await _apiClient.getMerchantApi().merchantOperatingHoursList(
        merchantId: merchantId,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to get operating hours',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // ========== MERCHANT ANALYTICS METHODS ==========

  /// Get merchant analytics
  Future<BaseResponse<MerchantAnalytics200ResponseData>> getAnalytics({
    String? period,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return guard(() async {
      final merchantId = await _getMerchantId();

      final res = await _apiClient.getMerchantApi().merchantAnalytics(
        id: merchantId,
        period: period,
        startDate: startDate,
        endDate: endDate,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to get analytics',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Export merchant analytics
  Future<BaseResponse<String>> exportAnalytics({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return guard(() async {
      final merchantId = await _getMerchantId();

      final res = await _apiClient
          .getMerchantApi()
          .analyticsExportMerchantAnalytics(
            merchantId: merchantId,
            startDate: startDate,
            endDate: endDate,
          );

      final data = res.data;
      if (data == null) {
        throw const RepositoryError(
          'Failed to export analytics',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(
        message: 'Analytics exported successfully',
        data: data,
      );
    });
  }
}
