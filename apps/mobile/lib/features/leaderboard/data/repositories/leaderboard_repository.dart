import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class LeaderboardRepository extends BaseRepository {
  const LeaderboardRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Get leaderboard list with pagination
  ///
  /// Supports filtering by:
  /// - category: RATING, VOLUME, EARNINGS, STREAK, ON-TIME
  /// - period: DAILY, WEEKLY, MONTHLY, QUARTERLY, YEARLY
  Future<BaseResponse<List<Leaderboard>>> list({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardList(
        limit: limit,
        cursor: cursor,
        order: order,
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
  Future<BaseResponse<Leaderboard>> get(String id) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardGet(id: id);

      final data =
          res.data ??
          (throw const RepositoryError(
            'Leaderboard entry not found',
            code: ErrorCode.notFound,
          ));

      final leaderboard = data.data;

      return SuccessResponse(message: data.message, data: leaderboard);
    });
  }

  /// Get current user's leaderboard position
  ///
  /// Returns leaderboard entries filtered by current user's ID
  Future<BaseResponse<List<Leaderboard>>> getMyRankings({
    required String userId,
    int? limit,
  }) {
    return guard(() async {
      final res = await _apiClient.getLeaderboardApi().leaderboardList(
        limit: limit ?? 100,
      );

      final data =
          res.data ??
          (throw const RepositoryError(
            'Failed to fetch rankings',
            code: ErrorCode.unknown,
          ));

      // Filter by current user
      final myRankings = data.data.where((lb) => lb.userId == userId).toList();

      return SuccessResponse(
        message: 'Successfully fetched your rankings',
        data: myRankings,
      );
    });
  }
}
