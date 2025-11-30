import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

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
            'Merchant not found',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
