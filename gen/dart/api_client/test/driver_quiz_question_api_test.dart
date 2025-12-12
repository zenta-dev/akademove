import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for DriverQuizQuestionApi
void main() {
  final instance = ApiClient().getDriverQuizQuestionApi();

  group(DriverQuizQuestionApi, () {
    //Future<DriverQuizQuestionCreate201Response> driverQuizQuestionCreate(InsertDriverQuizQuestion insertDriverQuizQuestion) async
    test('test driverQuizQuestionCreate', () async {
      // TODO
    });

    //Future<DriverQuizQuestionCreate201Response> driverQuizQuestionGet(String id) async
    test('test driverQuizQuestionGet', () async {
      // TODO
    });

    //Future<DriverQuizQuestionGetQuizQuestions200Response> driverQuizQuestionGetQuizQuestions({ String category, int limit }) async
    test('test driverQuizQuestionGetQuizQuestions', () async {
      // TODO
    });

    //Future<DriverQuizQuestionList200Response> driverQuizQuestionList({ String cursor, Object limit, String direction, Object page, String query, String sortBy, PaginationOrder order, PaginationMode mode, DriverQuizQuestionCategory category, DriverQuizQuestionType type, bool isActive }) async
    test('test driverQuizQuestionList', () async {
      // TODO
    });

    //Future<BadgeRemove200Response> driverQuizQuestionRemove(String id) async
    test('test driverQuizQuestionRemove', () async {
      // TODO
    });

    //Future<DriverQuizQuestionCreate201Response> driverQuizQuestionUpdate(String id, UpdateDriverQuizQuestion updateDriverQuizQuestion) async
    test('test driverQuizQuestionUpdate', () async {
      // TODO
    });
  });
}
