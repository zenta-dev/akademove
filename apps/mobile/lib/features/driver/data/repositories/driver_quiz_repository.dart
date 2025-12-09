import 'package:akademove/core/_export.dart';
import 'package:api_client/api_client.dart';

class DriverQuizRepository extends BaseRepository {
  DriverQuizRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;

  /// Start a new quiz attempt
  Future<BaseResponse<DriverQuizAttempt>> startQuiz(
    StartDriverQuiz request,
  ) async {
    return guard(() async {
      // Call API to start quiz
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerStartQuiz(startDriverQuiz: request);

      if (response.data == null) {
        throw RepositoryError(
          'Failed to start quiz: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data;
      if (data == null) {
        throw RepositoryError(
          'Failed to start quiz: empty data',
          code: ErrorCode.unknown,
        );
      }

      final apiData = data.data;

      return SuccessResponse(message: data.message, data: apiData);
    });
  }

  /// Submit an answer to a question
  Future<BaseResponse<SubmitDriverQuizAnswerResponse>> submitAnswer(
    SubmitDriverQuizAnswer request,
  ) async {
    return guard(() async {
      // Call API to submit answer
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerSubmitAnswer(submitDriverQuizAnswer: request);

      if (response.data == null) {
        throw RepositoryError(
          'Failed to submit answer: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data;

      if (data == null) {
        throw RepositoryError(
          'Failed to submit answer: empty response',
          code: ErrorCode.unknown,
        );
      }

      return SuccessResponse(message: data.message, data: data.data);
    });
  }

  /// Complete the quiz attempt
  Future<BaseResponse<DriverQuizResult>> completeQuiz(
    CompleteDriverQuiz request,
  ) async {
    return guard(() async {
      // Call API to complete quiz
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerCompleteQuiz(completeDriverQuiz: request);

      if (response.data == null) {
        throw RepositoryError(
          'Failed to complete quiz: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data!;
      final resultData = data.data;

      return SuccessResponse(message: data.message, data: resultData);
    });
  }

  /// Get the latest quiz attempt status
  Future<BaseResponse<DriverQuizAnswer?>> getLatestAttempt() async {
    return guard(() async {
      try {
        // Try to fetch latest from server
        final response = await _apiClient
            .getDriverQuizAnswerApi()
            .driverQuizAnswerGetMyLatestAttempt();

        if (response.data != null) {
          final resultData = response.data!.data;

          return SuccessResponse(
            message:
                response.data?.message ??
                'Latest quiz attempt retrieved successfully',
            data: resultData,
          );
        }

        return SuccessResponse(message: 'No quiz attempt found', data: null);
      } catch (e) {
        // Server call failed, return null
        logger.w('Failed to fetch from server: $e');
        rethrow;
      }
    });
  }
}
