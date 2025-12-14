import 'package:akademove/core/_export.dart';
import 'package:akademove/features/leaderboard/data/models/leaderboard_entry.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class DriverLeaderboardState extends Equatable {
  const DriverLeaderboardState({
    this.leaderboards = const OperationResult.idle(),
    this.leaderboardEntries = const OperationResult.idle(),
    this.badges = const OperationResult.idle(),
    this.userBadges = const OperationResult.idle(),
    this.myRankings = const OperationResult.idle(),
    this.selectedCategory = LeaderboardCategory.RATING,
    this.selectedPeriod = LeaderboardPeriod.WEEKLY,
  });

  /// Raw leaderboard data from API (now with driver info)
  final OperationResult<List<LeaderboardWithDriver>> leaderboards;

  /// Processed leaderboard entries with driver info for UI display
  final OperationResult<List<LeaderboardEntry>> leaderboardEntries;

  final OperationResult<List<Badge>> badges;
  final OperationResult<List<UserBadge>> userBadges;
  final OperationResult<List<LeaderboardWithDriver>> myRankings;

  /// Currently selected leaderboard category filter
  final LeaderboardCategory selectedCategory;

  /// Currently selected leaderboard period filter
  final LeaderboardPeriod selectedPeriod;

  /// Get top 3 drivers for podium display
  List<LeaderboardEntry> get topThree {
    final entries = leaderboardEntries.value ?? [];
    return entries.where((e) => e.rank <= 3).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));
  }

  /// Get drivers ranked 4-10 for list display
  List<LeaderboardEntry> get otherRankings {
    final entries = leaderboardEntries.value ?? [];
    return entries.where((e) => e.rank >= 4 && e.rank <= 10).toList()
      ..sort((a, b) => a.rank.compareTo(b.rank));
  }

  @override
  List<Object> get props => [
    leaderboards,
    leaderboardEntries,
    badges,
    userBadges,
    myRankings,
    selectedCategory,
    selectedPeriod,
  ];

  DriverLeaderboardState copyWith({
    OperationResult<List<LeaderboardWithDriver>>? leaderboards,
    OperationResult<List<LeaderboardEntry>>? leaderboardEntries,
    OperationResult<List<Badge>>? badges,
    OperationResult<List<UserBadge>>? userBadges,
    OperationResult<List<LeaderboardWithDriver>>? myRankings,
    LeaderboardCategory? selectedCategory,
    LeaderboardPeriod? selectedPeriod,
  }) {
    return DriverLeaderboardState(
      leaderboards: leaderboards ?? this.leaderboards,
      leaderboardEntries: leaderboardEntries ?? this.leaderboardEntries,
      badges: badges ?? this.badges,
      userBadges: userBadges ?? this.userBadges,
      myRankings: myRankings ?? this.myRankings,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  bool get stringify => true;
}
