import 'package:test/test.dart';
import 'package:api_client/api_client.dart';


/// tests for ScheduleApi
void main() {
  final instance = ApiClient().getScheduleApi();

  group(ScheduleApi, () {
    //Future<CreateScheduleSuccessResponse> createSchedule({ CreateScheduleRequest createScheduleRequest }) async
    test('test createSchedule', () async {
      // TODO
    });

    //Future<DeleteScheduleSuccessResponse> deleteSchedule(String id) async
    test('test deleteSchedule', () async {
      // TODO
    });

    //Future<GetAllScheduleSuccessResponse> getAllSchedule(int page, int limit, { String cursor }) async
    test('test getAllSchedule', () async {
      // TODO
    });

    //Future<GetScheduleByIdSuccessResponse> getScheduleById(String id, bool fromCache) async
    test('test getScheduleById', () async {
      // TODO
    });

    //Future<UpdateScheduleSuccessResponse> updateSchedule(String id, { UpdateScheduleRequest updateScheduleRequest }) async
    test('test updateSchedule', () async {
      // TODO
    });

  });
}
