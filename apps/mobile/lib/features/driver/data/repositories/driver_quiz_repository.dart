import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/models/quiz_persistence_model.dart';
import 'package:api_client/api_client.dart';

class StartDriverQuizRequest {
  const StartDriverQuizRequest({this.questionIds, this.category});

  final List<String>? questionIds;
  final String? category;
}

class SubmitDriverQuizAnswerRequest {
  const SubmitDriverQuizAnswerRequest({
    required this.attemptId,
    required this.questionId,
    required this.selectedOptionId,
  });

  final String attemptId;
  final String questionId;
  final String selectedOptionId;
}

class CompleteDriverQuizRequest {
  const CompleteDriverQuizRequest({required this.attemptId});

  final String attemptId;
}
  
/// Driver Quiz Repository
/// Handles quiz operations with local persistence and real API integration
class DriverQuizRepository extends BaseRepository {
  DriverQuizRepository({
    required ApiClient apiClient,
    required KeyValueService keyValueService,
  }) : _apiClient = apiClient,
       _keyValueService = keyValueService;

  final ApiClient _apiClient;
  final KeyValueService _keyValueService;

  /// Get persisted quiz attempt from local storage
  Future<QuizAttemptPersistence?> _getPersistedAttempt() async {
    try {
      final json = await _keyValueService.get<String>(KeyValueKeys.quizAttempt);
      if (json == null || json.isEmpty) return null;
      return QuizAttemptPersistence.fromJsonString(json);
    } catch (e) {
      logger.w('Failed to get persisted quiz attempt: $e');
      return null;
    }
  }

  /// Save quiz attempt to local storage
  Future<void> _savePersistedAttempt(QuizAttemptPersistence attempt) async {
    try {
      await _keyValueService.set(
        KeyValueKeys.quizAttempt,
        attempt.toJsonString(),
      );
    } catch (e) {
      logger.e('Failed to save persisted quiz attempt: $e');
    }
  }

  /// Clear persisted quiz attempt
  Future<void> _clearPersistedAttempt() async {
    try {
      await _keyValueService.remove(KeyValueKeys.quizAttempt);
    } catch (e) {
      logger.e('Failed to clear persisted quiz attempt: $e');
    }
  }

  /// Convert API question to local model
  QuizQuestion _mapApiQuestion(
    DriverQuizQuestionGetQuizQuestions200ResponseDataInner apiQuestion) {

    return QuizQuestion(
      id: apiQuestion.id,
      question: apiQuestion.question,
      type: apiQuestion.type,
      category: apiQuestion.category,
      points: apiQuestion.points.toInt(),
      displayOrder: apiQuestion.displayOrder.toInt(),
      options: List<dynamic>.from(apiQuestion['options'] as List)
          .map(
            (opt) => QuizOption(
              id: opt['id'] as String,
              text: opt['text'] as String,
            ),
          )
          .toList(),
    );
  }

  /// Start a new quiz attempt
  Future<BaseResponse<QuizAttempt>> startQuiz(
    StartDriverQuizRequest request,
  ) async {
    return guard(() async {
      // Call API to start quiz
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerStartQuiz(
            startDriverQuiz: StartDriverQuiz(
              questionIds: request.questionIds,
              // category is optional and passed as null to use server default
            ),
          );

      if (response.data == null) {
        throw RepositoryError(
          'Failed to start quiz: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data!;
      final apiData = data.data;

      final attempt = QuizAttempt(
        attemptId: apiData.attemptId,
        questions: (apiData.questions).map(_mapApiQuestion).toList(),
        totalQuestions: apiData.totalQuestions.toInt(),
        totalPoints: apiData.totalPoints.toInt(),
        passingScore: apiData.passingScore.toInt(),
      );

      // Persist attempt locally
      await _savePersistedAttempt(
        QuizAttemptPersistence(
          attemptId: attempt.attemptId,
          status: 'IN_PROGRESS',
          currentQuestionIndex: 0,
          selectedAnswers: {},
          answeredQuestions: {},
          totalQuestions: attempt.totalQuestions,
          lastSyncTime: DateTime.now().toIso8601String(),
        ),
      );

      return SuccessResponse(message: data.message, data: attempt);
    });
  }

  /// Submit an answer to a question
  Future<BaseResponse<Map<String, dynamic>>> submitAnswer(
    SubmitDriverQuizAnswerRequest request,
  ) async {
    return guard(() async {
      // Call API to submit answer
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerSubmitAnswer(
            submitDriverQuizAnswer: SubmitDriverQuizAnswer(
              attemptId: request.attemptId,
              questionId: request.questionId,
              selectedOptionId: request.selectedOptionId,
            ),
          );

      if (response.data == null) {
        throw RepositoryError(
          'Failed to submit answer: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data!;
      final responseData = {
        'isCorrect': data.data.isCorrect,
        'pointsEarned': data.data.pointsEarned.toInt(),
        'correctOptionId': data.data.correctOptionId,
        'explanation': data.data.explanation,
      };

      // Update persisted attempt with selected answer
      final persisted = await _getPersistedAttempt();
      if (persisted != null && persisted.attemptId == request.attemptId) {
        final updatedAnswers = {...persisted.selectedAnswers};
        updatedAnswers[request.questionId] = request.selectedOptionId;

        final updatedQuestions = {...persisted.answeredQuestions};
        updatedQuestions.add(request.questionId);

        await _savePersistedAttempt(
          persisted.copyWith(
            selectedAnswers: updatedAnswers,
            answeredQuestions: updatedQuestions,
            lastSyncTime: DateTime.now().toIso8601String(),
          ),
        );
      }

      return SuccessResponse(message: data.message, data: responseData);
    });
  }

  /// Complete the quiz attempt
  Future<BaseResponse<QuizResult>> completeQuiz(
    CompleteDriverQuizRequest request,
  ) async {
    return guard(() async {
      // Call API to complete quiz
      final response = await _apiClient
          .getDriverQuizAnswerApi()
          .driverQuizAnswerCompleteQuiz(
            completeDriverQuiz: CompleteDriverQuiz(
              attemptId: request.attemptId,
            ),
          );

      if (response.data == null) {
        throw RepositoryError(
          'Failed to complete quiz: empty response',
          code: ErrorCode.unknown,
        );
      }

      final data = response.data!;
      final resultData = data.data;

      final result = QuizResult(
        attemptId: resultData.attemptId,
        status: resultData.status.value,
        totalQuestions: resultData.totalQuestions,
        correctAnswers: resultData.correctAnswers,
        scorePercentage: (resultData.scorePercentage).toDouble(),
        passed: (resultData.scorePercentage >= 70),
        earnedPoints: resultData.earnedPoints,
        totalPoints: resultData.totalPoints,
        completedAt: resultData.completedAt,
      );

      // Update persisted attempt with completion status
      final persisted = await _getPersistedAttempt();
      if (persisted != null && persisted.attemptId == request.attemptId) {
        await _savePersistedAttempt(
          persisted.copyWith(
            status: result.status,
            lastSyncTime: DateTime.now().toIso8601String(),
          ),
        );
      }

      return SuccessResponse(message: data.message, data: result);
    });
  }

  /// Get the latest quiz attempt status
  Future<BaseResponse<QuizResult?>> getLatestAttempt() async {
    return guard(() async {
      try {
        // Try to fetch latest from server
        final response = await _apiClient
            .getDriverQuizAnswerApi()
            .driverQuizAnswerGetMyLatestAttempt();

        if (response.data != null) {
          final resultData = response.data!.data;

          // Calculate if passed (score >= 70)
          final scorePercentage = resultData.totalPoints > 0
              ? (resultData.earnedPoints / resultData.totalPoints) * 100
              : 0.0;

          final result = QuizResult(
            attemptId: resultData.id,
            status: resultData.status.value,
            totalQuestions: resultData.totalQuestions,
            correctAnswers: resultData.correctAnswers,
            scorePercentage: scorePercentage,
            passed: scorePercentage >= 70,
            earnedPoints: resultData.earnedPoints,
            totalPoints: resultData.totalPoints,
            completedAt: resultData.completedAt,
          );

          // Update persisted attempt with server state
          final persisted = await _getPersistedAttempt();
          if (persisted != null) {
            await _savePersistedAttempt(
              persisted.copyWith(
                status: result.status,
                lastSyncTime: DateTime.now().toIso8601String(),
              ),
            );
          }

          return SuccessResponse(
            message:
                response.data?.message ??
                'Latest quiz attempt retrieved successfully',
            data: result,
          );
        }

        return SuccessResponse(message: 'No quiz attempt found', data: null);
      } catch (e) {
        // Server call failed, try to return persisted state
        logger.w('Failed to fetch from server, checking cache: $e');
        final persisted = await _getPersistedAttempt();
        if (persisted != null && persisted.status != 'IN_PROGRESS') {
          // We have a completed attempt cached, but can't get full result
          return SuccessResponse(
            message: 'Latest quiz attempt retrieved successfully (cached)',
            data: null,
          );
        }
        rethrow;
      }
    });
  }

  /// Clear quiz attempt cache (after successful completion/submission)
  Future<void> clearQuizCache() async {
    return guard(() async {
      await _clearPersistedAttempt();
    });
  }
}
