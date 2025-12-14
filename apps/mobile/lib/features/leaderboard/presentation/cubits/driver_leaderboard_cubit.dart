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
  Future<void> init({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
  }) async {
    try {
      final effectiveCategory = category ?? LeaderboardCategory.RATING;
      final effectivePeriod = period ?? LeaderboardPeriod.WEEKLY;

      emit(
        state.copyWith(
          leaderboards: const OperationResult.loading(),
          leaderboardEntries: const OperationResult.loading(),
          badges: const OperationResult.loading(),
          userBadges: const OperationResult.loading(),
          selectedCategory: effectiveCategory,
          selectedPeriod: effectivePeriod,
        ),
      );

      // Load all data in parallel
      final results = await Future.wait([
        _leaderboardRepository.list(
          category: effectiveCategory,
          period: effectivePeriod,
          includeDriver: true,
          limit: 10,
        ),
        _badgeRepository.listBadges(),
        _badgeRepository.listUserBadges(),
      ]);

      final leaderboardsRes =
          results[0] as BaseResponse<List<LeaderboardWithDriver>>;
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

  /// Convert API LeaderboardWithDriver models to UI-friendly LeaderboardEntry.
  ///
  /// Uses the driver data directly from API response.
  List<LeaderboardEntry> _convertToEntries(
    List<LeaderboardWithDriver>? leaderboards,
  ) {
    if (leaderboards == null || leaderboards.isEmpty) return [];

    // Sort by rank and take top 10
    final sorted = [...leaderboards]..sort((a, b) => a.rank.compareTo(b.rank));
    final top10 = sorted.take(10).toList();

    return top10.map(LeaderboardEntry.fromApi).toList();
  }

  /// Change the selected category and reload data
  Future<void> selectCategory(LeaderboardCategory category) async {
    if (state.selectedCategory == category) return;
    await init(category: category, period: state.selectedPeriod);
  }

  /// Change the selected period and reload data
  Future<void> selectPeriod(LeaderboardPeriod period) async {
    if (state.selectedPeriod == period) return;
    await init(category: state.selectedCategory, period: period);
  }

  /// Load leaderboards with optional filters
  Future<void> loadLeaderboards({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
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
        category: category ?? state.selectedCategory,
        period: period ?? state.selectedPeriod,
        includeDriver: true,
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
          selectedCategory: category ?? state.selectedCategory,
          selectedPeriod: period ?? state.selectedPeriod,
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
  Future<void> loadMyRankings({
    LeaderboardCategory? category,
    LeaderboardPeriod? period,
  }) async => await taskManager.execute('LC-loadMyRankings', () async {
    try {
      emit(state.copyWith(myRankings: const OperationResult.loading()));

      final res = await _leaderboardRepository.getMyRankings(
        category: category,
        period: period,
      );

      emit(
        state.copyWith(
          myRankings: OperationResult.success(res.data, message: res.message),
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
    await init(category: state.selectedCategory, period: state.selectedPeriod);
  }
}
