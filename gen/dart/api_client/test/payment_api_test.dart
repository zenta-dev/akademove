import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for PaymentApi
void main() {
  final instance = ApiClient().getPaymentApi();

  group(PaymentApi, () {
    //Future<BadgeRemove200Response> paymentWebhookMidtrans(Map<String, Object> requestBody) async
    test('test paymentWebhookMidtrans', () async {
      // TODO
    });
  });
}
