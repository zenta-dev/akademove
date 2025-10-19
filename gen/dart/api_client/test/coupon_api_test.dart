import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for CouponApi
void main() {
  final instance = ApiClient().getCouponApi();

  group(CouponApi, () {
    //Future<CouponCreate200Response> couponCreate(InsertCouponRequest insertCouponRequest) async
    test('test couponCreate', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponGet(String id) async
    test('test couponGet', () async {
      // TODO
    });

    //Future<CouponList200Response> couponList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test couponList', () async {
      // TODO
    });

    //Future<DriverRemove200Response> couponRemove(String id) async
    test('test couponRemove', () async {
      // TODO
    });

    //Future<CouponCreate200Response> couponUpdate(String id, UpdateCouponRequest updateCouponRequest) async
    test('test couponUpdate', () async {
      // TODO
    });
  });
}
