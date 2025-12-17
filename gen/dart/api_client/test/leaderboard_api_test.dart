import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for LeaderboardApi
void main() {
  final instance = ApiClient().getLeaderboardApi();

  group(LeaderboardApi, () {
    //Future<LeaderboardGet200Response> leaderboardGet(String id, { bool includeDriver }) async
    test('test leaderboardGet', () async {
      // TODO
    });

    //Future<LeaderboardList200Response> leaderboardList({ LeaderboardCategory category, LeaderboardPeriod period, int limit, String cursor, int page, String sortBy, String order, bool includeDriver }) async
    test('test leaderboardList', () async {
      // TODO
    });

    //Future<LeaderboardList200Response> leaderboardMe({ LeaderboardCategory category, LeaderboardPeriod period }) async
    test('test leaderboardMe', () async {
      // TODO
    });
  });
}
