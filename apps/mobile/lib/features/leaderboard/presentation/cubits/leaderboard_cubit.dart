import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class LeaderboardCubit extends BaseCubit<LeaderboardState> {
  LeaderboardCubit({
    required LeaderboardRepository leaderboardRepository,
    required BadgeRepository badgeRepository,
  }) : _leaderboardRepository = leaderboardRepository,
       _badgeRepository = badgeRepository,
       super(LeaderboardState());

  final LeaderboardRepository _leaderboardRepository;
  final BadgeRepository _badgeRepository;

  /// Initialize the leaderboard feature by loading all data
  Future<void> init() async {
    try {
      emit(state.toLoading());

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
        state.toSuccess(
          message: 'Loaded successfully',
          leaderboards: leaderboardsRes.data,
          badges: badgesRes.data,
          userBadges: userBadgesRes.data,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e(
        '[LeaderboardCubit] - init error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  }

  /// Load leaderboards with optional filters
  Future<void> loadLeaderboards({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadLeaderboards', () async {
    try {
      emit(state.toLoading());

      final res = await _leaderboardRepository.list(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(state.toSuccess(message: res.message, leaderboards: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[LeaderboardCubit] - loadLeaderboards error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  /// Load all available badges
  Future<void> loadBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadBadges', () async {
    try {
      emit(state.toLoading());

      final res = await _badgeRepository.listBadges(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(state.toSuccess(message: res.message, badges: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[LeaderboardCubit] - loadBadges error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  /// Load current user's earned badges
  Future<void> loadUserBadges({
    int? limit,
    String? cursor,
    PaginationOrder? order,
  }) async => await taskManager.execute('LC-loadUserBadges', () async {
    try {
      emit(state.toLoading());

      final res = await _badgeRepository.listUserBadges(
        limit: limit,
        cursor: cursor,
        order: order,
      );

      emit(state.toSuccess(message: res.message, userBadges: res.data));
    } on BaseError catch (e, st) {
      logger.e(
        '[LeaderboardCubit] - loadUserBadges error: ${e.message}',
        error: e,
        stackTrace: st,
      );
      emit(state.toFailure(e));
    }
  });

  /// Load current user's rankings across all categories
  Future<void> loadMyRankings({required String userId, int? limit}) async =>
      await taskManager.execute('LC-loadMyRankings', () async {
        try {
          emit(state.toLoading());

          final res = await _leaderboardRepository.getMyRankings(
            userId: userId,
            limit: limit,
          );

          emit(state.toSuccess(message: res.message, myRankings: res.data));
        } on BaseError catch (e, st) {
          logger.e(
            '[LeaderboardCubit] - loadMyRankings error: ${e.message}',
            error: e,
            stackTrace: st,
          );
          emit(state.toFailure(e));
        }
      });

  /// Refresh all leaderboard data
  Future<void> refresh() async {
    await init();
  }
}
