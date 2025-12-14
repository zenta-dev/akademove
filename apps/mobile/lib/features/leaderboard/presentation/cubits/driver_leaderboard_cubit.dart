import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverLeaderboardCubit extends BaseCubit<DriverLeaderboardState> {
  DriverLeaderboardCubit({
    required LeaderboardRepository leaderboardRepository,
    required BadgeRepository badgeRepository,
  }) : _leaderboardRepository = leaderboardRepository,
       _badgeRepository = badgeRepository,
       super(const DriverLeaderboardState());

  final LeaderboardRepository _leaderboardRepository;
  final BadgeRepository _badgeRepository;

  /// Initialize the leaderboard feature by loading all data
  Future<void> init() async {
    try {
      emit(
        state.copyWith(
          leaderboards: const OperationResult.loading(),
          leaderboardEntries: const OperationResult.loading(),
          badges: const OperationResult.loading(),
          userBadges: const OperationResult.loading(),
        ),
      );

      // Load all data in parallel
      final results = await Future.wait([
        _leaderboardRepository.list(limit: 10),
        _badgeRepository.listBadges(),
        _badgeRepository.listUserBadges(),
      ]);

      final leaderboardsRes = results[0] as BaseResponse<List<Leaderboard>>;
      final badgesRes = results[1] as BaseResponse<List<Badge>>;
      final userBadgesRes = results[2] as BaseResponse<List<UserBadge>>;

      // Convert API leaderboards to LeaderboardEntry models
      final entries = _convertToEntries(leaderboardsRes.data);

      emit(
        state.copyWith(
          leaderboards: OperationResult.success(leaderboardsRes.data),
          leaderboardEntries: OperationResult.success(entries),
          badges: OperationResult.success(badgesRes.data),
          userBadges: OperationResult.success(userBadgesRes.data),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverLeaderboardCubit] - init error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          leaderboards: OperationResult.failed(e),
          leaderboardEntries: OperationResult.failed(e),
          badges: OperationResult.failed(e),
          userBadges: OperationResult.failed(e),
        ),
      );
    }
  }

  /// Convert API Leaderboard models to UI-friendly LeaderboardEntry models.
  ///
  /// Note: Currently uses placeholder data for driver names and ratings
  /// since the API doesn't provide these fields. This should be updated
  /// when the backend adds driver info to the leaderboard response.
  List<LeaderboardEntry> _convertToEntries(List<Leaderboard>? leaderboards) {
    if (leaderboards == null || leaderboards.isEmpty) return [];

    // Sort by rank and take top 10
    final sorted = [...leaderboards]..sort((a, b) => a.rank.compareTo(b.rank));
    final top10 = sorted.take(10).toList();

    return top10.map((lb) {
      // TODO: Replace with actual driver data from API when available
      // For now, use placeholder data based on user ID
      final driverName = _getDriverName(lb.userId, lb.rank);
      final driverRating = _getDriverRating(lb.rank);
      final rankChange = _getRankChange(lb.rank);

      return LeaderboardEntry(
        id: lb.id,
        userId: lb.userId,
        driverName: driverName,
        driverRating: driverRating,
        rank: lb.rank,
        score: lb.score,
        rankChange: rankChange,
      );
    }).toList();
  }

  /// Generate a display name for the driver.
  /// TODO: Replace with actual driver name from API
  String _getDriverName(String userId, int rank) {
    // Use first 8 chars of userId as a fallback display name
    final shortId = userId.length > 8 ? userId.substring(0, 8) : userId;
    return 'Driver $shortId';
  }

  /// Generate a rating for the driver.
  /// TODO: Replace with actual driver rating from API
  double _getDriverRating(int rank) {
    // Higher ranked drivers tend to have higher ratings
    // This is just placeholder logic
    return 5.0 - (rank * 0.05).clamp(0.0, 1.5);
  }

  /// Generate a rank change indicator.
  /// TODO: Replace with actual rank change from API
  int _getRankChange(int rank) {
    // Placeholder: assume no change for now
    // The API should provide previous rank for comparison
    return 0;
  }

  /// Load leaderboards with optional filters
  Future<void> loadLeaderboards({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadLeaderboards', () async {
    try {
      emit(
        state.copyWith(
          leaderboards: const OperationResult.loading(),
          leaderboardEntries: const OperationResult.loading(),
        ),
      );

      final res = await _leaderboardRepository.list(
        limit: limit ?? 10,
        cursor: cursor,
        order: order,
      );

      final entries = _convertToEntries(res.data);

      emit(
        state.copyWith(
          leaderboards: OperationResult.success(res.data, message: res.message),
          leaderboardEntries: OperationResult.success(
            entries,
            message: res.message,
          ),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverLeaderboardCubit] - loadLeaderboards error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          leaderboards: OperationResult.failed(e),
          leaderboardEntries: OperationResult.failed(e),
        ),
      );
    }
  });

  /// Load all available badges
  Future<void> loadBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadBadges', () async {
    try {
      emit(state.copyWith(badges: const OperationResult.loading()));

      final res = await _badgeRepository.listBadges(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(
        state.copyWith(
          badges: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverLeaderboardCubit] - loadBadges error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(badges: OperationResult.failed(e)));
    }
  });

  /// Load current user's earned badges
  Future<void> loadUserBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadUserBadges', () async {
    try {
      emit(state.copyWith(userBadges: const OperationResult.loading()));

      final res = await _badgeRepository.listUserBadges(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(
        state.copyWith(
          userBadges: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverLeaderboardCubit] - loadUserBadges error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(userBadges: OperationResult.failed(e)));
    }
  });

  /// Load current user's rankings across all categories
  Future<void> loadMyRankings({required String userId, int? limit}) async =>
      await taskManager.execute('LC-loadMyRankings', () async {
        try {
          emit(state.copyWith(myRankings: const OperationResult.loading()));

          final res = await _leaderboardRepository.getMyRankings(
            userId: userId,
            limit: limit,
          );

          emit(
            state.copyWith(
              myRankings: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e(
            '[DriverLeaderboardCubit] - loadMyRankings error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.copyWith(myRankings: OperationResult.failed(e)));
        }
      });

  /// Refresh all leaderboard data
  Future<void> refresh() async {
    await init();
  }
}
