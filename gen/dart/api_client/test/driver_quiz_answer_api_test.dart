import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

/// tests for DriverQuizAnswerApi
void main() {
  final instance = ApiClient().getDriverQuizAnswerApi();

  group(DriverQuizAnswerApi, () {
    //Future<DriverQuizAnswerCompleteQuiz200Response> driverQuizAnswerCompleteQuiz(CompleteDriverQuiz completeDriverQuiz) async
    test('test driverQuizAnswerCompleteQuiz', () async {
      // TODO
    });

    //Future<DriverQuizAnswerGetAttempt200Response> driverQuizAnswerGetAttempt(String attemptId) async
    test('test driverQuizAnswerGetAttempt', () async {
      // TODO
    });

    //Future<DriverQuizAnswerGetAttempt200Response> driverQuizAnswerGetMyLatestAttempt() async
    test('test driverQuizAnswerGetMyLatestAttempt', () async {
      // TODO
    });

    //Future<DriverQuizAnswerCompleteQuiz200Response> driverQuizAnswerGetResult(String attemptId) async
    test('test driverQuizAnswerGetResult', () async {
      // TODO
    });

    //Future<DriverQuizAnswerList200Response> driverQuizAnswerList({ String driverId, DriverQuizAnswerStatus status, int page, int limit }) async
    test('test driverQuizAnswerList', () async {
      // TODO
    });

    //Future<DriverQuizAnswerStartQuiz201Response> driverQuizAnswerStartQuiz(StartDriverQuiz startDriverQuiz) async
    test('test driverQuizAnswerStartQuiz', () async {
      // TODO
    });

    //Future<DriverQuizAnswerSubmitAnswer200Response> driverQuizAnswerSubmitAnswer(SubmitDriverQuizAnswer submitDriverQuizAnswer) async
    test('test driverQuizAnswerSubmitAnswer', () async {
      // TODO
    });
  });
}
