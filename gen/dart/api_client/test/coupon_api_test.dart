import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for CouponApi
void main() {
  final instance = ApiClient().getCouponApi();

  group(CouponApi, () {
    //Future<CouponCreate200Response> couponActivate(String id, { Object body }) async
    test('test couponActivate', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponCreate(InsertCoupon insertCoupon) async
    test('test couponCreate', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponDeactivate(String id, { Object body }) async
    test('test couponDeactivate', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponGet(String id) async
    test('test couponGet', () async {
      // TODO
    });

    // Get all available coupons for browsing (active and within validity period)
    //
    //Future<CouponList200Response> couponGetAvailableCoupons({ OrderType serviceType }) async
    test('test couponGetAvailableCoupons', () async {
      // TODO
    });

    //Future<CouponGetEligibleCoupons200Response> couponGetEligibleCoupons(CouponGetEligibleCouponsRequest couponGetEligibleCouponsRequest) async
    test('test couponGetEligibleCoupons', () async {
      // TODO
    });

    //Future<CouponList200Response> couponList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test couponList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> couponRemove(String id) async
    test('test couponRemove', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponUpdate(String id, UpdateCoupon updateCoupon) async
    test('test couponUpdate', () async {
      // TODO
    });

    //Future<CouponValidate200Response> couponValidate(CouponValidateRequest couponValidateRequest) async
    test('test couponValidate', () async {
      // TODO
    });
  });
}
