import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for ScheduleApi
void main() {
  final instance = ApiClient().getScheduleApi();

  group(ScheduleApi, () {
    //Future<ScheduleCreate200Response> scheduleCreate(InsertScheduleRequest insertScheduleRequest) async
    test('test scheduleCreate', () async {
      // TODO
    });

    //Future<ScheduleCreate200Response> scheduleGet(String id) async
    test('test scheduleGet', () async {
      // TODO
    });

    //Future<ScheduleList200Response> scheduleList({ String cursor, Object limit, Object page, String query, String sortBy, String order }) async
    test('test scheduleList', () async {
      // TODO
    });

    //Future<DriverRemove200Response> scheduleRemove(String id) async
    test('test scheduleRemove', () async {
      // TODO
    });

    //Future<ScheduleCreate200Response> scheduleUpdate(String id, UpdateScheduleRequest updateScheduleRequest) async
    test('test scheduleUpdate', () async {
      // TODO
    });
  });
}
