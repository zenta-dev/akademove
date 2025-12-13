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
          badges: const OperationResult.loading(),
          userBadges: const OperationResult.loading(),
        ),
      );

      // Load all data in parallel
      final results = await Future.wait([
        _leaderboardRepository.list(),
        _badgeRepository.listBadges(),
        _badgeRepository.listUserBadges(),
      ]);

      final leaderboardsRes = results[0] as BaseResponse<List<Leaderboard>>;
      final badgesRes = results[1] as BaseResponse<List<Badge>>;
      final userBadgesRes = results[2] as BaseResponse<List<UserBadge>>;

      emit(
        state.copyWith(
          leaderboards: OperationResult.success(leaderboardsRes.data),
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
          badges: OperationResult.failed(e),
          userBadges: OperationResult.failed(e),
        ),
      );
    }
  }

  /// Load leaderboards with optional filters
  Future<void> loadLeaderboards({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadLeaderboards', () async {
    try {
      emit(state.copyWith(leaderboards: const OperationResult.loading()));

      final res = await _leaderboardRepository.list(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(
        state.copyWith(
          leaderboards: OperationResult.success(res.data, message: res.message),
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[DriverLeaderboardCubit] - loadLeaderboards error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.copyWith(leaderboards: OperationResult.failed(e)));
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
