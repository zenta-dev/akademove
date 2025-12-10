import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for PaymentApi
void main() {
  final instance = ApiClient().getPaymentApi();

  group(PaymentApi, () {
    // Validate a bank account using Midtrans Iris API. Returns account holder name if valid.
    //
    //Future<BankValidateAccount200Response> bankValidateAccount(BankValidationRequest bankValidationRequest) async
    test('test bankValidateAccount', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> paymentWebhookMidtrans(Map<String, Object> requestBody) async
    test('test paymentWebhookMidtrans', () async {
      // TODO
    });

    // Midtrans Iris Payout Webhook
    //
    // Webhook endpoint for Midtrans Iris payout/disbursement status updates
    //
    //Future<BadgeRemove200Response> paymentWebhookMidtransPayout(Map<String, Object> requestBody) async
    test('test paymentWebhookMidtransPayout', () async {
      // TODO
    });
  });
}
