import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for WalletApi
void main() {
  final instance = ApiClient().getWalletApi();

  group(WalletApi, () {
    //Future<WalletGet200Response> walletGet() async
    test('test walletGet', () async {
      // TODO
    });

    //Future<WalletGetMonthlySummary200Response> walletGetMonthlySummary(num year, num month) async
    test('test walletGetMonthlySummary', () async {
      // TODO
    });

    // Get saved bank account details from driver/merchant profile for pre-filling withdrawal forms
    //
    //Future<WalletGetSavedBankAccount200Response> walletGetSavedBankAccount() async
    test('test walletGetSavedBankAccount', () async {
      // TODO
    });

    //Future<WalletTopUp200Response> walletPay(PayRequest payRequest) async
    test('test walletPay', () async {
      // TODO
    });

    //Future<WalletTopUp200Response> walletTopUp(TopUpRequest topUpRequest) async
    test('test walletTopUp', () async {
      // TODO
    });

    //Future<WalletTransfer200Response> walletTransfer(TransferRequest transferRequest) async
    test('test walletTransfer', () async {
      // TODO
    });

    //Future<WalletTopUp200Response> walletWithdraw(WithdrawRequest withdrawRequest) async
    test('test walletWithdraw', () async {
      // TODO
    });
  });
}
