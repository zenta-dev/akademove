import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class TriggerEmergencyQuery {
  const TriggerEmergencyQuery({
    required this.orderId,
    required this.userId,
    required this.type,
    required this.description,
    this.location,
    this.contactedAuthorities,
  });

  final String orderId;
  final String userId;
  final EmergencyType type;
  final String description;
  final EmergencyLocation? location;
  final List<String>? contactedAuthorities;
}

class EmergencyRepository extends BaseRepository {
  EmergencyRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Trigger emergency during active trip
  Future<BaseResponse<Emergency>> trigger(TriggerEmergencyQuery query) {
    return guard(() async {
      final insertEmergency = InsertEmergency(
        orderId: query.orderId,
        userId: query.userId,
        type: query.type,
        status: EmergencyStatus.REPORTED,
        description: query.description,
        location: query.location,
        contactedAuthorities: query.contactedAuthorities,
      );

      final res = await _apiClient.getEmergencyApi().emergencyTrigger(
        insertEmergency: insertEmergency,
      );

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        if (data == null) {
          throw const RepositoryError(
            'No data received from emergency trigger',
            code: ErrorCode.internalServerError,
          );
        }
        return SuccessResponse(message: data.message ?? '', data: data.data);
      }

      throw const RepositoryError(
        'Failed to trigger emergency',
        code: ErrorCode.internalServerError,
      );
    });
  }

  /// List emergencies for an order
  Future<BaseResponse<List<Emergency>>> listByOrder(String orderId) {
    return guard(() async {
      final res = await _apiClient.getEmergencyApi().emergencyListByOrder(
        orderId: orderId,
      );

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        if (data == null) {
          throw const RepositoryError(
            'No data received from emergency list',
            code: ErrorCode.internalServerError,
          );
        }
        return SuccessResponse(message: data.message ?? '', data: data.data);
      }

      throw const RepositoryError(
        'Failed to list emergencies',
        code: ErrorCode.internalServerError,
      );
    });
  }

  /// Get single emergency details
  Future<BaseResponse<Emergency>> get(String id) {
    return guard(() async {
      final res = await _apiClient.getEmergencyApi().emergencyGet(id: id);

      if (res.statusCode == 200 && res.data != null) {
        final data = res.data;
        if (data == null) {
          throw const RepositoryError(
            'No data received from emergency get',
            code: ErrorCode.internalServerError,
          );
        }
        return SuccessResponse(message: data.message ?? '', data: data.data);
      }

      throw const RepositoryError(
        'Failed to get emergency',
        code: ErrorCode.internalServerError,
      );
    });
  }
}
