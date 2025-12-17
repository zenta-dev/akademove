import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for WalletApi
void main() {
  final instance = ApiClient().getWalletApi();

  group(WalletApi, () {
    // Get driver wallet monthly summary
    //
    //Future<DriverWalletGetMonthlySummary200Response> driverWalletGetMonthlySummary(String driverId, num year, num month) async
    test('test driverWalletGetMonthlySummary', () async {
      // TODO
    });

    // Get saved bank account details from driver profile for pre-filling withdrawal forms
    //
    //Future<DriverWalletGetSavedBankAccount200Response> driverWalletGetSavedBankAccount(String driverId) async
    test('test driverWalletGetSavedBankAccount', () async {
      // TODO
    });

    // Get driver wallet transactions
    //
    //Future<DriverWalletGetTransactions200Response> driverWalletGetTransactions(String driverId, { String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test driverWalletGetTransactions', () async {
      // TODO
    });

    // Get driver wallet by driver ID
    //
    //Future<DriverWalletGetWallet200Response> driverWalletGetWallet(String driverId) async
    test('test driverWalletGetWallet', () async {
      // TODO
    });

    // Top up driver wallet
    //
    //Future<DriverWalletTopUp200Response> driverWalletTopUp(String driverId, TopUpRequest topUpRequest) async
    test('test driverWalletTopUp', () async {
      // TODO
    });

    // Transfer from driver wallet to another user
    //
    //Future<DriverWalletTransfer200Response> driverWalletTransfer(String driverId, TransferRequest transferRequest) async
    test('test driverWalletTransfer', () async {
      // TODO
    });

    // Withdraw from driver wallet to bank account
    //
    //Future<DriverWalletTopUp200Response> driverWalletWithdraw(String driverId, WithdrawRequest withdrawRequest) async
    test('test driverWalletWithdraw', () async {
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

    //Future<DriverWalletGetWallet200Response> walletGet() async
    test('test walletGet', () async {
      // TODO
    });

    // Get commission report for drivers with balance summary, chart data, and transaction history
    //
    //Future<WalletGetCommissionReport200Response> walletGetCommissionReport({ CommissionReportPeriod period, DateTime startDate, DateTime endDate }) async
    test('test walletGetCommissionReport', () async {
      // TODO
    });

    //Future<DriverWalletGetMonthlySummary200Response> walletGetMonthlySummary(num year, num month) async
    test('test walletGetMonthlySummary', () async {
      // TODO
    });

    // Get saved bank account details from driver/merchant profile for pre-filling withdrawal forms
    //
    //Future<DriverWalletGetSavedBankAccount200Response> walletGetSavedBankAccount() async
    test('test walletGetSavedBankAccount', () async {
      // TODO
    });

    //Future<DriverWalletTopUp200Response> walletPay(PayRequest payRequest) async
    test('test walletPay', () async {
      // TODO
    });

    //Future<DriverWalletTopUp200Response> walletTopUp(TopUpRequest topUpRequest) async
    test('test walletTopUp', () async {
      // TODO
    });

    //Future<DriverWalletTransfer200Response> walletTransfer(TransferRequest transferRequest) async
    test('test walletTransfer', () async {
      // TODO
    });

    //Future<DriverWalletTopUp200Response> walletWithdraw(WithdrawRequest withdrawRequest) async
    test('test walletWithdraw', () async {
      // TODO
    });
  });
}
