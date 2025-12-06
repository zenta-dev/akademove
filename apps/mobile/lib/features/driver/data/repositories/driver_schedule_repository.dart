import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class DriverScheduleRepository extends BaseRepository {
  DriverScheduleRepository({required this.apiClient});

  final ApiClient apiClient;

  Future<BaseResponse<List<DriverSchedule>>> list({
    required String driverId,
    int? page,
    int? limit,
  }) async {
    return await guard<BaseResponse<List<DriverSchedule>>>(() async {
      final response = await apiClient.getDriverApi().driverScheduleList(
        driverId: driverId,
        page: page,
        limit: limit,
      );

      final schedules = response.data?.data ?? [];
      return SuccessResponse(
        data: schedules,
        message: 'Schedules retrieved successfully',
      );
    });
  }

  Future<BaseResponse<DriverSchedule>> get({
    required String driverId,
    required String scheduleId,
  }) async {
    return await guard<BaseResponse<DriverSchedule>>(() async {
      final response = await apiClient.getDriverApi().driverScheduleGet(
        driverId: driverId,
        id: scheduleId,
      );

      final scheduleData = response.data?.data;
      if (scheduleData == null) {
        throw Exception('Schedule not found');
      }

      return SuccessResponse(
        data: scheduleData,
        message: 'Schedule retrieved successfully',
      );
    });
  }

  Future<BaseResponse<DriverSchedule>> create({
    required String driverId,
    required DriverScheduleCreateRequest schedule,
  }) async {
    return await guard<BaseResponse<DriverSchedule>>(() async {
      final response = await apiClient.getDriverApi().driverScheduleCreate(
        driverId: driverId,
        driverScheduleCreateRequest: schedule,
      );

      final scheduleData = response.data?.data;
      if (scheduleData == null) {
        throw Exception('Failed to create schedule');
      }

      return SuccessResponse(
        data: scheduleData,
        message: 'Schedule created successfully',
      );
    });
  }

  Future<BaseResponse<DriverSchedule>> update({
    required String driverId,
    required String scheduleId,
    required DriverScheduleUpdateRequest schedule,
  }) async {
    return await guard<BaseResponse<DriverSchedule>>(() async {
      final response = await apiClient.getDriverApi().driverScheduleUpdate(
        driverId: driverId,
        id: scheduleId,
        driverScheduleUpdateRequest: schedule,
      );

      final scheduleData = response.data?.data;
      if (scheduleData == null) {
        throw Exception('Failed to update schedule');
      }

      return SuccessResponse(
        data: scheduleData,
        message: 'Schedule updated successfully',
      );
    });
  }

  Future<BaseResponse<void>> delete({
    required String driverId,
    required String scheduleId,
  }) async {
    return await guard<BaseResponse<void>>(() async {
      await apiClient.getDriverApi().driverScheduleRemove(
        driverId: driverId,
        id: scheduleId,
      );

      return const SuccessResponse(
        data: null,
        message: 'Schedule deleted successfully',
      );
    });
  }
}
