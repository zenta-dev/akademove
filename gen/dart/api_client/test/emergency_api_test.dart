import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for EmergencyApi
void main() {
  final instance = ApiClient().getEmergencyApi();

  group(EmergencyApi, () {
    //Future<EmergencyTrigger200Response> emergencyGet(String id) async
    test('test emergencyGet', () async {
      // TODO
    });

    //Future<EmergencyListByOrder200Response> emergencyListByOrder(String orderId) async
    test('test emergencyListByOrder', () async {
      // TODO
    });

    //Future<EmergencyTrigger200Response> emergencyTrigger(InsertEmergency insertEmergency) async
    test('test emergencyTrigger', () async {
      // TODO
    });

    //Future<EmergencyTrigger200Response> emergencyUpdateStatus(String id, EmergencyUpdateStatusRequest emergencyUpdateStatusRequest) async
    test('test emergencyUpdateStatus', () async {
      // TODO
    });
  });
}
