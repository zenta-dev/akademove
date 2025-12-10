import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class BadgeRepository extends BaseRepository {
  const BadgeRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Get all badges
  Future<BaseResponse<List<Badge>>> listBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) {
    return guard(() async {
      final res = await _apiClient.getBadgeApi().badgeList(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      final data = res.data;
      if (data == null) {
        throw const RepositoryError(
          'Failed to fetch badges',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  /// Get user's earned badges
  Future<BaseResponse<List<UserBadge>>> listUserBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) {
    return guard(() async {
      final res = await _apiClient.getBadgeApi().badgeUserList(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      final data = res.data;
      if (data == null) {
        throw const RepositoryError(
          'Failed to fetch user badges',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(message: data.message ?? '', data: data.data);
    });
  }

  /// Get single badge by ID
  Future<BaseResponse<Badge>> getBadge(String id) {
    return guard(() async {
      final res = await _apiClient.getBadgeApi().badgeGet(id: id);

      final data = res.data;
      if (data == null) {
        throw const RepositoryError(
          'Badge not found',
          code: ErrorCode.notFound,
        );
      }

      final badge = data.data;

      return SuccessResponse(message: data.message ?? '', data: badge);
    });
  }
}
