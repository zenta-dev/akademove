import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for PaymentApi
void main() {
  final instance = ApiClient().getPaymentApi();

  group(PaymentApi, () {
    //Future<DriverRemove200Response> paymentWebhookMidtrans(Object body) async
    test('test paymentWebhookMidtrans', () async {
      // TODO
    });
  });
}
