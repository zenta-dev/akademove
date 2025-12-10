import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class ListCouponQuery extends UnifiedQuery {
  const ListCouponQuery({
    super.limit,
    super.page,
    super.cursor,
    super.query,
    super.sortBy,
    super.orderBy,
  });
}

/// Result from getEligibleCoupons API
class EligibleCouponsResult {
  const EligibleCouponsResult({
    required this.coupons,
    this.bestCoupon,
    required this.bestDiscountAmount,
  });

  final List<Coupon> coupons;
  final Coupon? bestCoupon;
  final num bestDiscountAmount;
}

/// Result from validateCoupon API
class CouponValidationResult {
  const CouponValidationResult({
    required this.valid,
    this.coupon,
    required this.discountAmount,
    required this.finalAmount,
    this.reason,
  });

  final bool valid;
  final Coupon? coupon;
  final num discountAmount;
  final num finalAmount;
  final String? reason;
}

class CouponRepository extends BaseRepository {
  CouponRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<Coupon>>> list(ListCouponQuery query) {
    return guard(() async {
      final res = await _apiClient.getCouponApi().couponList(
        cursor: query.cursor?.trim(),
        limit: query.limit,
        page: query.page,
        query: query.query?.trim(),
        sortBy: query.sortBy?.trim(),
        order: query.orderBy,
        mode: PaginationMode.cursor,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Coupons not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  /// Get all eligible coupons for an order with auto-selected best coupon
  /// Returns ALL eligible coupons without any limit
  Future<BaseResponse<EligibleCouponsResult>> getEligibleCoupons({
    required OrderType serviceType,
    required num totalAmount,
    String? merchantId,
  }) {
    return guard(() async {
      final res = await _apiClient.getCouponApi().couponGetEligibleCoupons(
        couponGetEligibleCouponsRequest: CouponGetEligibleCouponsRequest(
          serviceType: serviceType,
          totalAmount: totalAmount,
          merchantId: merchantId,
        ),
      );

      final responseData =
          res.data ??
          (throw const RepositoryError(
            'Response data not found',
            code: ErrorCode.notFound,
          ));

      final data = responseData.data;

      return SuccessResponse(
        message: responseData.message ?? '',
        data: EligibleCouponsResult(
          coupons: data.coupons,
          bestCoupon: data.bestCoupon,
          bestDiscountAmount: data.bestDiscountAmount,
        ),
      );
    });
  }

  /// Validate a specific coupon code
  Future<BaseResponse<CouponValidationResult>> validateCoupon({
    required String code,
    required num orderAmount,
    OrderType? serviceType,
    String? merchantId,
  }) {
    return guard(() async {
      final res = await _apiClient.getCouponApi().couponValidate(
        couponValidateRequest: CouponValidateRequest(
          code: code,
          orderAmount: orderAmount,
          serviceType: serviceType,
          merchantId: merchantId,
        ),
      );

      final responseData =
          res.data ??
          (throw const RepositoryError(
            'Response data not found',
            code: ErrorCode.notFound,
          ));

      final data = responseData.data;

      return SuccessResponse(
        message: responseData.message ?? '',
        data: CouponValidationResult(
          valid: data.valid,
          coupon: data.coupon,
          discountAmount: data.discountAmount,
          finalAmount: data.finalAmount,
          reason: data.reason,
        ),
      );
    });
  }
}
