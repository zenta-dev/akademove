import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dio/dio.dart';

class GetDriverNearbyQuery {
  const GetDriverNearbyQuery({
    required this.x,
    required this.y,
    required this.radiusKm,
    required this.limit,
    required this.gender,
  });

  final double x;
  final double y;
  final int radiusKm;
  final int limit;
  final UserGender? gender;
}

class DriverRepository extends BaseRepository {
  const DriverRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  Future<BaseResponse<List<Driver>>> getDriverNearby(GetDriverNearbyQuery req) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverNearby(
        x: req.x,
        y: req.y,
        radiusKm: req.radiusKm,
        limit: req.limit,
        gender: req.gender,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Drivers not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Driver>> getMine() {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverGetMine();
      final data =
          res.data ??
          (throw const RepositoryError(
            'Driver profile not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.body.message, data: data.body.data);
    });
  }

  Future<BaseResponse<Driver>> get(String id) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverGet(id: id);
      final data =
          res.data ??
          (throw const RepositoryError(
            'Driver not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Driver>> updateOnlineStatus({
    required String driverId,
    required bool isOnline,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverUpdateOnlineStatus(
        id: driverId,
        driverUpdateOnlineStatusRequest: DriverUpdateOnlineStatusRequest(
          isOnline: isOnline,
        ),
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update online status',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Driver>> updateLocation({
    required String driverId,
    required CoordinateWithMeta location,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverUpdateLocation(
        id: driverId,
        coordinateWithMeta: location,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update location',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<Driver>> update({
    required String driverId,
    num? studentId,
    String? licensePlate,
    MultipartFile? studentCard,
    MultipartFile? driverLicense,
    MultipartFile? vehicleCertificate,
    Bank? bank,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverUpdate(
        id: driverId,
        studentId: studentId,
        licensePlate: licensePlate,
        studentCard: studentCard,
        driverLicense: driverLicense,
        vehicleCertificate: vehicleCertificate,
        bankProvider: bank?.provider.value,
        bankNumber: bank?.number,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update driver profile',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  // Schedule Management
  Future<BaseResponse<List<DriverSchedule>>> listSchedules(String driverId) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverScheduleList(
        driverId: driverId,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to retrieve schedules',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<DriverSchedule>> createSchedule({
    required String driverId,
    required DriverScheduleCreateRequest request,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverScheduleCreate(
        driverId: driverId,
        driverScheduleCreateRequest: request,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to create schedule',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<DriverSchedule>> getSchedule({
    required String driverId,
    required String scheduleId,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverScheduleGet(
        driverId: driverId,
        id: scheduleId,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Schedule not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<DriverSchedule>> updateSchedule({
    required String driverId,
    required String scheduleId,
    required DriverScheduleUpdateRequest request,
  }) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverScheduleUpdate(
        driverId: driverId,
        id: scheduleId,
        driverScheduleUpdateRequest: request,
      );
      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to update schedule',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  Future<BaseResponse<bool>> removeSchedule({
    required String driverId,
    required String scheduleId,
  }) {
    return guard(() async {
      await _apiClient.getDriverApi().driverScheduleRemove(
        driverId: driverId,
        id: scheduleId,
      );

      return SuccessResponse(
        message: 'Schedule removed successfully',
        data: true,
      );
    });
  }

  // Approval Review
  Future<BaseResponse<DriverGetReview200ResponseData>> getApprovalReview(
    String driverId,
  ) {
    return guard(() async {
      final res = await _apiClient.getDriverApi().driverGetReview(id: driverId);
      final data =
          res.data ??
          (throw const RepositoryError(
            'Approval review not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
