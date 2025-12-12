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

    //Future<MerchantPopulars200Response> merchantList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, Object categories, Object isActive, MerchantStatus status, String operatingStatus, num minRating, num maxRating, num maxDistance, num latitude, num longitude }) async
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

    //Future<MerchantOperatingHoursList200Response> merchantOperatingHoursBulkUpsert(String merchantId, MerchantOperatingHoursBulkUpsertRequest merchantOperatingHoursBulkUpsertRequest) async
    test('test merchantOperatingHoursBulkUpsert', () async {
      // TODO
    });

    //Future<MerchantOperatingHoursCreate200Response> merchantOperatingHoursCreate(String merchantId, MerchantOperatingHoursCreateRequest merchantOperatingHoursCreateRequest) async
    test('test merchantOperatingHoursCreate', () async {
      // TODO
    });

    //Future<MerchantOperatingHoursCreate200Response> merchantOperatingHoursGet(String merchantId, String id) async
    test('test merchantOperatingHoursGet', () async {
      // TODO
    });

    //Future<MerchantOperatingHoursList200Response> merchantOperatingHoursList(String merchantId) async
    test('test merchantOperatingHoursList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> merchantOperatingHoursRemove(String merchantId, String id) async
    test('test merchantOperatingHoursRemove', () async {
      // TODO
    });

    //Future<MerchantOperatingHoursCreate200Response> merchantOperatingHoursUpdate(String merchantId, String id, MerchantOperatingHoursUpdateRequest merchantOperatingHoursUpdateRequest) async
    test('test merchantOperatingHoursUpdate', () async {
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

    //Future<MerchantGetReview200Response> merchantSubmitApproval(String id, DriverSubmitApprovalRequest driverSubmitApprovalRequest) async
    test('test merchantSubmitApproval', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantSubmitRejection(String id, DriverSubmitRejectionRequest driverSubmitRejectionRequest) async
    test('test merchantSubmitRejection', () async {
      // TODO
    });

    //Future<MerchantGetMine200ResponseBody> merchantUpdate(String id, String phoneCountryCode, int phoneNumber, num locationX, num locationY, String bankProvider, num bankNumber, { String name, String email, String address, String category, String bankAccountName, MultipartFile document, MultipartFile image }) async
    test('test merchantUpdate', () async {
      // TODO
    });

    //Future<MerchantGetReview200Response> merchantUpdateDocumentStatus(String id, MerchantUpdateDocumentStatusRequest merchantUpdateDocumentStatusRequest) async
    test('test merchantUpdateDocumentStatus', () async {
      // TODO
    });

    // Get merchant wallet monthly summary
    //
    //Future<DriverWalletGetMonthlySummary200Response> merchantWalletGetMonthlySummary(String merchantId, num year, num month) async
    test('test merchantWalletGetMonthlySummary', () async {
      // TODO
    });

    // Get saved bank account details from merchant profile for pre-filling withdrawal forms
    //
    //Future<DriverWalletGetSavedBankAccount200Response> merchantWalletGetSavedBankAccount(String merchantId) async
    test('test merchantWalletGetSavedBankAccount', () async {
      // TODO
    });

    // Get merchant wallet transactions
    //
    //Future<DriverWalletGetTransactions200Response> merchantWalletGetTransactions(String merchantId, { String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test merchantWalletGetTransactions', () async {
      // TODO
    });

    // Get merchant wallet by merchant ID
    //
    //Future<DriverWalletGetWallet200Response> merchantWalletGetWallet(String merchantId) async
    test('test merchantWalletGetWallet', () async {
      // TODO
    });

    // Top up merchant wallet
    //
    //Future<DriverWalletTopUp200Response> merchantWalletTopUp(String merchantId, TopUpRequest topUpRequest) async
    test('test merchantWalletTopUp', () async {
      // TODO
    });

    // Transfer from merchant wallet to another user
    //
    //Future<DriverWalletTransfer200Response> merchantWalletTransfer(String merchantId, TransferRequest transferRequest) async
    test('test merchantWalletTransfer', () async {
      // TODO
    });

    // Withdraw from merchant wallet to bank account
    //
    //Future<DriverWalletTopUp200Response> merchantWalletWithdraw(String merchantId, WithdrawRequest withdrawRequest) async
    test('test merchantWalletWithdraw', () async {
      // TODO
    });
  });
}
