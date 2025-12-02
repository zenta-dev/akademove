import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';
import 'package:dart_mappable/dart_mappable.dart';

part 'leaderboard_state.mapper.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class LeaderboardState extends BaseState2 with LeaderboardStateMappable {
  LeaderboardState({
    this.leaderboards = const [],
    this.badges = const [],
    this.userBadges = const [],
    this.myRankings = const [],
    super.state,
    super.message,
    super.error,
  });

  final List<Leaderboard> leaderboards;
  final List<Badge> badges;
  final List<UserBadge> userBadges;
  final List<Leaderboard> myRankings;

  @override
  LeaderboardState toInitial() => LeaderboardState();

  @override
  LeaderboardState toLoading() => copyWith(state: CubitState.loading);

  @override
  LeaderboardState toSuccess({
    String? message,
    List<Leaderboard>? leaderboards,
    List<Badge>? badges,
    List<UserBadge>? userBadges,
    List<Leaderboard>? myRankings,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    leaderboards: leaderboards ?? this.leaderboards,
    badges: badges ?? this.badges,
    userBadges: userBadges ?? this.userBadges,
    myRankings: myRankings ?? this.myRankings,
  );

  @override
  LeaderboardState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
