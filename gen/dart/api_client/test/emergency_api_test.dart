import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for EmergencyApi
void main() {
  final instance = ApiClient().getEmergencyApi();

  group(EmergencyApi, () {
    //Future<EmergencyContactGetPrimary200Response> emergencyContactCreate(InsertEmergencyContact insertEmergencyContact) async
    test('test emergencyContactCreate', () async {
      // TODO
    });

    //Future<BannerDelete200Response> emergencyContactDelete(String id) async
    test('test emergencyContactDelete', () async {
      // TODO
    });

    //Future<EmergencyContactGetPrimary200Response> emergencyContactGet(String id) async
    test('test emergencyContactGet', () async {
      // TODO
    });

    //Future<EmergencyContactGetPrimary200Response> emergencyContactGetPrimary() async
    test('test emergencyContactGetPrimary', () async {
      // TODO
    });

    //Future<EmergencyContactListActive200Response> emergencyContactList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, bool isActive }) async
    test('test emergencyContactList', () async {
      // TODO
    });

    //Future<EmergencyContactListActive200Response> emergencyContactListActive() async
    test('test emergencyContactListActive', () async {
      // TODO
    });

    //Future<EmergencyContactGetPrimary200Response> emergencyContactToggleActive(String id, { Object body }) async
    test('test emergencyContactToggleActive', () async {
      // TODO
    });

    //Future<EmergencyContactGetPrimary200Response> emergencyContactUpdate(String id, UpdateEmergencyContact updateEmergencyContact) async
    test('test emergencyContactUpdate', () async {
      // TODO
    });

    //Future<EmergencyGet200Response> emergencyGet(String id) async
    test('test emergencyGet', () async {
      // TODO
    });

    //Future<EmergencyListByOrder200Response> emergencyListByOrder(String orderId) async
    test('test emergencyListByOrder', () async {
      // TODO
    });

    //Future<EmergencyLog200Response> emergencyLog(LogEmergency logEmergency) async
    test('test emergencyLog', () async {
      // TODO
    });

    //Future<EmergencyTrigger200Response> emergencyTrigger(InsertEmergency insertEmergency) async
    test('test emergencyTrigger', () async {
      // TODO
    });

    //Future<EmergencyGet200Response> emergencyUpdateStatus(String id, EmergencyUpdateStatusRequest emergencyUpdateStatusRequest) async
    test('test emergencyUpdateStatus', () async {
      // TODO
    });
  });
}
