import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for MerchantApi
void main() {
  final instance = ApiClient().getMerchantApi();

  group(MerchantApi, () {
    //Future<MerchantGetMine200ResponseBody> merchantGet(String id) async
    test('test merchantGet', () async {
      // TODO
    });

    //Future<MerchantGetMine200Response> merchantGetMine() async
    test('test merchantGetMine', () async {
      // TODO
    });

    //Future<MerchantPopulars200Response> merchantList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test merchantList', () async {
      // TODO
    });

    //Future<MerchantMenuCreate200Response> merchantMenuCreate(String merchantId, String name, num price, int stock, { String category, MultipartFile image }) async
    test('test merchantMenuCreate', () async {
      // TODO
    });

    //Future<MerchantMenuCreate200Response> merchantMenuGet(String merchantId, String id) async
    test('test merchantMenuGet', () async {
      // TODO
    });

    //Future<MerchantMenuList200Response> merchantMenuList(String merchantId, { String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test merchantMenuList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> merchantMenuRemove(String merchantId, String id) async
    test('test merchantMenuRemove', () async {
      // TODO
    });

    //Future<MerchantMenuCreate200Response> merchantMenuUpdate(String merchantId, String id, { String name, String category, num price, int stock, MultipartFile image }) async
    test('test merchantMenuUpdate', () async {
      // TODO
    });

    //Future<MerchantPopulars200Response> merchantPopulars({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test merchantPopulars', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> merchantRemove(String id) async
    test('test merchantRemove', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantUpdate(String id, String phoneCountryCode, int phoneNumber, num locationX, num locationY, String bankProvider, num bankNumber, { String name, String email, String address, MultipartFile document, MultipartFile image }) async
    test('test merchantUpdate', () async {
      // TODO
    });
  });
}
