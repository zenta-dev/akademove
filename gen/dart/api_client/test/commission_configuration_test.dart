import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

// tests for CommissionConfiguration
void main() {
  final CommissionConfiguration? instance = /* CommissionConfiguration(...) */ null;
  // TODO add properties to the entity

  group(CommissionConfiguration, () {
    // Platform commission rate for RIDE orders (0-1, e.g., 0.15 for 15%)
    // num rideCommissionRate
    test('to test the property `rideCommissionRate`', () async {
      // TODO
    });

    // Platform commission rate for DELIVERY orders (0-1, e.g., 0.15 for 15%)
    // num deliveryCommissionRate
    test('to test the property `deliveryCommissionRate`', () async {
      // TODO
    });

    // Platform commission rate for FOOD orders (0-1, e.g., 0.20 for 20%)
    // num foodCommissionRate
    test('to test the property `foodCommissionRate`', () async {
      // TODO
    });

    // Merchant commission rate on food orders (0-1, e.g., 0.10 for 10%)
    // num merchantCommissionRate
    test('to test the property `merchantCommissionRate`', () async {
      // TODO
    });
  });
}
