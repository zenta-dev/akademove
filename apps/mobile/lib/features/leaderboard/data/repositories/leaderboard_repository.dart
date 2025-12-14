import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

// Re-export API client types for convenience
export 'package:api_client/api_client.dart'
    show LeaderboardCategory, LeaderboardPeriod, LeaderboardWithDriver;

class LeaderboardRepository extends BaseRepository {
  const LeaderboardRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Get leaderboard list with pagination and filtering
  ///
  /// Supports filtering by:
  /// - category: RATING, VOLUME, EARNINGS, STREAK, ON-TIME, COMPLETION-RATE
  /// - period: DAILY, WEEKLY, MONTHLY, QUARTERLY, YEARLY, ALL-TIME
  /// - includeDriver: Include driver profile info (name, image, rating)
  Future<BaseResponse<List<LeaderboardWithDriver>>> list({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
    bool includeDriver = true,
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardList(
        category: category,
        period: period,
        includeDriver: includeDriver,
        limit: limit,
        cursor: cursor,
        order: order?.name,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch leaderboard',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get single leaderboard entry by ID
  Future<BaseResponse<LeaderboardWithDriver>> get(
    String id, {
    bool includeDriver = true,
  }) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardGet(
        id: id,
        includeDriver: includeDriver,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Leaderboard entry not found',
            code: ErrorCode.notFound,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Get current user's leaderboard rankings
  ///
  /// Returns the user's rankings across specified category/period
  /// or all categories/periods if not specified.
  Future<BaseResponse<List<LeaderboardWithDriver>>> getMyRankings({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
  }) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardMe(
        category: category,
        period: period,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch rankings',
            code: ErrorCode.unknown,
          ));

      return SuccessResponse(message: data.message, data: data.data);
    });
  }
}
