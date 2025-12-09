import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for MerchantApi
void main() {
  final instance = ApiClient().getMerchantApi();

  group(MerchantApi, () {
    //Future<String> analyticsExportMerchantAnalytics(String merchantId, DateTime startDate, DateTime endDate) async
    test('test analyticsExportMerchantAnalytics', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantActivate(String id) async
    test('test merchantActivate', () async {
      // TODO
    });

    //Future<MerchantAnalytics200Response> merchantAnalytics(String id, { String period, DateTime startDate, DateTime endDate }) async
    test('test merchantAnalytics', () async {
      // TODO
    });

    //Future<MerchantBestSellers200Response> merchantBestSellers(num limit, { String category }) async
    test('test merchantBestSellers', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantDeactivate(String id, MerchantDeactivateRequest merchantDeactivateRequest) async
    test('test merchantDeactivate', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantGet(String id) async
    test('test merchantGet', () async {
      // TODO
    });

    //Future<MerchantGetAvailabilityStatus200Response> merchantGetAvailabilityStatus(String id) async
    test('test merchantGetAvailabilityStatus', () async {
      // TODO
    });

    //Future<MerchantGetMine200Response> merchantGetMine() async
    test('test merchantGetMine', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantGetReview(String id) async
    test('test merchantGetReview', () async {
      // TODO
    });

    //Future<MerchantPopulars200Response> merchantList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, Object categories, Object isActive, num minRating, num maxRating, num maxDistance, num latitude, num longitude }) async
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

    //Future<MerchantOrderAccept200Response> merchantOrderAccept(String merchantId, String id) async
    test('test merchantOrderAccept', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> merchantOrderMarkPreparing(String merchantId, String id) async
    test('test merchantOrderMarkPreparing', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> merchantOrderMarkReady(String merchantId, String id) async
    test('test merchantOrderMarkReady', () async {
      // TODO
    });

    //Future<MerchantOrderAccept200Response> merchantOrderReject(String merchantId, String id, String reason, { String note }) async
    test('test merchantOrderReject', () async {
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

    //Future<MerchantGetMine200ResponseBody> merchantSetOnlineStatus(String id, DriverUpdateOnlineStatusRequest driverUpdateOnlineStatusRequest) async
    test('test merchantSetOnlineStatus', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantSetOperatingStatus(String id, MerchantSetOperatingStatusRequest merchantSetOperatingStatusRequest) async
    test('test merchantSetOperatingStatus', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantSetOrderTakingStatus(String id, MerchantSetOrderTakingStatusRequest merchantSetOrderTakingStatusRequest) async
    test('test merchantSetOrderTakingStatus', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantSubmitApproval(String id, DriverSubmitApprovalRequest driverSubmitApprovalRequest) async
    test('test merchantSubmitApproval', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantSubmitRejection(String id, DriverSubmitRejectionRequest driverSubmitRejectionRequest) async
    test('test merchantSubmitRejection', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantUpdate(String id, String phoneCountryCode, int phoneNumber, num locationX, num locationY, String bankProvider, num bankNumber, { String name, String email, String address, String category, MultipartFile document, MultipartFile image }) async
    test('test merchantUpdate', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantUpdateDocumentStatus(String id, MerchantUpdateDocumentStatusRequest merchantUpdateDocumentStatusRequest) async
    test('test merchantUpdateDocumentStatus', () async {
      // TODO
    });
  });
}
