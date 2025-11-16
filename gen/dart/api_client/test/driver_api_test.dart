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

    //Future<DriverList200Response> driverNearby(num x, num y, num radiusKm, num limit, { UserGender gender }) async
    test('test driverNearby', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> driverRemove(String id) async
    test('test driverRemove', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleCreate(String driverId, InsertDriverScheduleRequest insertDriverScheduleRequest) async
    test('test driverScheduleCreate', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleGet(String driverId, String id) async
    test('test driverScheduleGet', () async {
      // TODO
    });

    //Future<DriverScheduleList200Response> driverScheduleList(String driverId, { String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test driverScheduleList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> driverScheduleRemove(String driverId, String id) async
    test('test driverScheduleRemove', () async {
      // TODO
    });

    //Future<DriverScheduleCreate200Response> driverScheduleUpdate(String driverId, String id, UpdateDriverScheduleRequest updateDriverScheduleRequest) async
    test('test driverScheduleUpdate', () async {
      // TODO
    });

    //Future<DriverGetMine200ResponseBody> driverUpdate(String id, { num studentId, String licensePlate, MultipartFile studentCard, MultipartFile driverLicense, MultipartFile vehicleCertificate, DriverUpdateRequestBank bank, bool isTakingOrder, DriverUpdateRequestCurrentLocation currentLocation }) async
    test('test driverUpdate', () async {
      // TODO
    });
  });
}
