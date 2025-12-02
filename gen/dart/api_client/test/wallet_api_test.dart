import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for walletApi
void main() {
  final instance = ApiClient().getwalletApi();

  group(walletApi, () {
    //Future<walletGet200Response> walletGet() async
    test('test walletGet', () async {
      // TODO
    });

    //Future<walletGetMonthlySummary200Response> walletGetMonthlySummary(num year, num month) async
    test('test walletGetMonthlySummary', () async {
      // TODO
    });

    //Future<walletTopUp200Response> walletPay(PayRequest payRequest) async
    test('test walletPay', () async {
      // TODO
    });

    //Future<walletTopUp200Response> walletTopUp(TopUpRequest topUpRequest) async
    test('test walletTopUp', () async {
      // TODO
    });

    //Future<walletTopUp200Response> walletTransfer(TransferRequest transferRequest) async
    test('test walletTransfer', () async {
      // TODO
    });
  });
}
