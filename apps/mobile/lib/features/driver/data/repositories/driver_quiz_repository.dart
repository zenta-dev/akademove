import 'package:akademove/core/_export.dart';
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

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.question,
    required this.type,
    required this.category,
    required this.points,
    required this.displayOrder,
    required this.options,
  });

  final String id;
  final String question;
  final String type;
  final String category;
  final int points;
  final int displayOrder;
  final List<QuizOption> options;
}

class QuizOption {
  const QuizOption({required this.id, required this.text});

  final String id;
  final String text;
}

class QuizAttempt {
  const QuizAttempt({
    required this.attemptId,
    required this.questions,
    required this.totalQuestions,
    required this.totalPoints,
    required this.passingScore,
  });

  final String attemptId;
  final List<QuizQuestion> questions;
  final int totalQuestions;
  final int totalPoints;
  final int passingScore;
}

class QuizAnswer {
  const QuizAnswer({
    required this.questionId,
    required this.selectedOptionId,
    required this.isCorrect,
    required this.pointsEarned,
    required this.answeredAt,
  });

  final String questionId;
  final String selectedOptionId;
  final bool isCorrect;
  final int pointsEarned;
  final DateTime answeredAt;
}

class QuizResult {
  const QuizResult({
    required this.attemptId,
    required this.status,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage,
    required this.passed,
    required this.earnedPoints,
    required this.totalPoints,
    required this.completedAt,
  });

  final String attemptId;
  final String status;
  final int totalQuestions;
  final int correctAnswers;
  final double scorePercentage;
  final bool passed;
  final int earnedPoints;
  final int totalPoints;
  final DateTime? completedAt;
}

class DriverQuizRepository extends BaseRepository {
  const DriverQuizRepository({required ApiClient apiClient})
    : _apiClient = apiClient;

  // ignore: unused_field - Will be used when API is implemented
  final ApiClient _apiClient;

  Future<BaseResponse<QuizAttempt>> startQuiz(
    StartDriverQuizRequest request,
  ) async {
    return guard(() async {
      // TODO: Implement when API client is generated
      // final res = await _apiClient.getDriverQuizAnswerApi().startQuiz(
      //   questionIds: request.questionIds,
      //   category: request.category,
      // );

      // Mock response for now
      final mockQuestions = [
        QuizQuestion(
          id: '1',
          question:
              'What should you do if a passenger asks you to exceed the speed limit?',
          type: 'MULTIPLE_CHOICE',
          category: 'SAFETY',
          points: 10,
          displayOrder: 1,
          options: [
            QuizOption(
              id: 'a',
              text: 'Follow their request to maintain good rating',
            ),
            QuizOption(
              id: 'b',
              text: 'Politely refuse and explain safety regulations',
            ),
            QuizOption(
              id: 'c',
              text: 'Ask for additional payment for speeding',
            ),
            QuizOption(id: 'd', text: 'Ignore their request'),
          ],
        ),
        QuizQuestion(
          id: '2',
          question:
              'How should you handle a situation where you get lost during navigation?',
          type: 'MULTIPLE_CHOICE',
          category: 'NAVIGATION',
          points: 10,
          displayOrder: 2,
          options: [
            QuizOption(id: 'a', text: 'Keep driving until you find the way'),
            QuizOption(
              id: 'b',
              text: 'Pull over safely and use GPS or ask for directions',
            ),
            QuizOption(id: 'c', text: 'Ask the passenger for directions'),
            QuizOption(id: 'd', text: 'Cancel the trip'),
          ],
        ),
      ];

      final mockAttempt = QuizAttempt(
        attemptId: 'mock-attempt-${DateTime.now().millisecondsSinceEpoch}',
        questions: mockQuestions,
        totalQuestions: mockQuestions.length,
        totalPoints: mockQuestions.fold(0, (sum, q) => sum + q.points),
        passingScore: 70,
      );

      return SuccessResponse(
        message: 'Quiz started successfully',
        data: mockAttempt,
      );
    });
  }

  Future<BaseResponse<Map<String, dynamic>>> submitAnswer(
    SubmitDriverQuizAnswerRequest request,
  ) async {
    return guard(() async {
      // TODO: Implement when API client is generated
      // final res = await _apiClient.getDriverQuizAnswerApi().submitAnswer(
      //   attemptId: request.attemptId,
      //   questionId: request.questionId,
      //   selectedOptionId: request.selectedOptionId,
      // );

      // Mock response
      final isCorrect =
          request.selectedOptionId == 'b'; // Mock: option 'b' is correct
      final responseData = {
        'isCorrect': isCorrect,
        'pointsEarned': isCorrect ? 10 : 0,
        'correctOptionId': isCorrect ? request.selectedOptionId : 'b',
        'explanation': isCorrect
            ? 'Correct! Safety should always be the priority.'
            : 'Incorrect. Never compromise safety for ratings.',
      };

      return SuccessResponse(
        message: 'Answer submitted successfully',
        data: responseData,
      );
    });
  }

  Future<BaseResponse<QuizResult>> completeQuiz(
    CompleteDriverQuizRequest request,
  ) async {
    return guard(() async {
      // TODO: Implement when API client is generated
      // final res = await _apiClient.getDriverQuizAnswerApi().completeQuiz(
      //   attemptId: request.attemptId,
      // );

      // Mock response - assume 80% pass rate
      final mockResult = QuizResult(
        attemptId: request.attemptId,
        status: 'COMPLETED',
        totalQuestions: 2,
        correctAnswers: 2,
        scorePercentage: 80.0,
        passed: true,
        earnedPoints: 20,
        totalPoints: 20,
        completedAt: DateTime.now(),
      );

      return SuccessResponse(
        message: 'Quiz completed successfully',
        data: mockResult,
      );
    });
  }

  Future<BaseResponse<QuizResult?>> getLatestAttempt() async {
    return guard(() async {
      // TODO: Implement when API client is generated
      // final res = await _apiClient.getDriverQuizAnswerApi().getMyLatestAttempt();

      // Mock response - no previous attempt
      return SuccessResponse(
        message: 'Latest quiz attempt retrieved successfully',
        data: null,
      );
    });
  }
}
