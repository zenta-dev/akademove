import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for FraudApi
void main() {
  final instance = ApiClient().getFraudApi();

  group(FraudApi, () {
    //Future<FraudGetEvent200Response> fraudGetEvent(String id) async
    test('test fraudGetEvent', () async {
      // TODO
    });

    //Future<FraudGetStats200Response> fraudGetStats({ DateTime startDate, DateTime endDate, int trendDays }) async
    test('test fraudGetStats', () async {
      // TODO
    });

    //Future<FraudListEvents200Response> fraudGetUserEvents(String userId, { int page, int limit }) async
    test('test fraudGetUserEvents', () async {
      // TODO
    });

    //Future<FraudGetUserProfile200Response> fraudGetUserProfile(String userId) async
    test('test fraudGetUserProfile', () async {
      // TODO
    });

    //Future<FraudListEvents200Response> fraudListEvents({ Object page, Object limit, FraudStatus status, FraudSeverity severity, FraudEventType eventType, String userId, String driverId, DateTime startDate, DateTime endDate, String sortBy, String order }) async
    test('test fraudListEvents', () async {
      // TODO
    });

    //Future<FraudListHighRiskUsers200Response> fraudListHighRiskUsers({ int page, int limit }) async
    test('test fraudListHighRiskUsers', () async {
      // TODO
    });

    //Future<FraudGetEvent200Response> fraudReviewEvent(String id, ReviewFraudEvent reviewFraudEvent) async
    test('test fraudReviewEvent', () async {
      // TODO
    });
  });
}
