import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for DriverApi
void main() {
  final instance = ApiClient().getDriverApi();

  group(DriverApi, () {
    //Future<DriverGetMine200ResponseBody> driverGet(String id) async
    test('test driverGet', () async {
      // TODO
    });

    //Future<DriverGetMine200Response> driverGetMine() async
    test('test driverGetMine', () async {
      // TODO
    });

    //Future<DriverList200Response> driverList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test driverList', () async {
      // TODO
    });

    //Future<DriverRemove200Response> driverRemove(String id) async
    test('test driverRemove', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdate(String id, { num studentId, String licensePlate, MultipartFile studentCard, MultipartFile driverLicense, MultipartFile vehicleCertificate, DriverUpdateRequestBank bank }) async
    test('test driverUpdate', () async {
      // TODO
    });
  });
}
