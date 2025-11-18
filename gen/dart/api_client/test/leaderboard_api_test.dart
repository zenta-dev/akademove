import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for LeaderboardApi
void main() {
  final instance = ApiClient().getLeaderboardApi();

  group(LeaderboardApi, () {
    //Future<LeaderboardGet200Response> leaderboardGet(String id) async
    test('test leaderboardGet', () async {
      // TODO
    });

    //Future<LeaderboardList200Response> leaderboardList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode }) async
    test('test leaderboardList', () async {
      // TODO
    });
  });
}
