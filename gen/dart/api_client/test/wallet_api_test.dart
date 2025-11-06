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

    //Future<WalletTopUp200Response> walletPay(PayRequest payRequest) async
    test('test walletPay', () async {
      // TODO
    });

    //Future<WalletTopUp200Response> walletTopUp(TopUpRequest topUpRequest) async
    test('test walletTopUp', () async {
      // TODO
    });

    //Future<WalletTransactions200Response> walletTransactions() async
    test('test walletTransactions', () async {
      // TODO
    });

    //Future<WalletTopUp200Response> walletTransfer(TransferRequest transferRequest) async
    test('test walletTransfer', () async {
      // TODO
    });

    //Future<DriverRemove200Response> walletWebhookMidtrans(Object body) async
    test('test walletWebhookMidtrans', () async {
      // TODO
    });
  });
}
