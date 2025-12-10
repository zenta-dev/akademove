import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:equatable/equatable.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.leaderboards = const OperationResult.idle(),
    this.badges = const OperationResult.idle(),
    this.userBadges = const OperationResult.idle(),
    this.myRankings = const OperationResult.idle(),
  });

  final OperationResult<List<Leaderboard>> leaderboards;
  final OperationResult<List<Badge>> badges;
  final OperationResult<List<UserBadge>> userBadges;
  final OperationResult<List<Leaderboard>> myRankings;

  @override
  List<Object> get props => [leaderboards, badges, userBadges, myRankings];

  LeaderboardState copyWith({
    OperationResult<List<Leaderboard>>? leaderboards,
    OperationResult<List<Badge>>? badges,
    OperationResult<List<UserBadge>>? userBadges,
    OperationResult<List<Leaderboard>>? myRankings,
  }) {
    return LeaderboardState(
      leaderboards: leaderboards ?? this.leaderboards,
      badges: badges ?? this.badges,
      userBadges: userBadges ?? this.userBadges,
      myRankings: myRankings ?? this.myRankings,
    );
  }

  @override
  bool get stringify => true;
}
