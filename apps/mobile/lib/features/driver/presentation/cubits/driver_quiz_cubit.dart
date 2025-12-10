import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

class DriverQuizCubit2 extends BaseCubit<DriverQuizState2> {
  DriverQuizCubit2({required this.quizRepository})
    : super(const DriverQuizState2());

  final DriverQuizRepository quizRepository;

  void reset() => emit(const DriverQuizState2());

  Future<void> startQuiz({List<String>? questionIds, String? category}) async =>
      taskManager.execute('DQC2-SQ1', () async {
        try {
          emit(state.copyWith(attempt: const OperationResult.loading()));

          StartDriverQuizCategoryEnum? categoryEnum;

          for (final cat in StartDriverQuizCategoryEnum.values) {
            if (cat.name == category) {
              categoryEnum = cat;
              break;
            }
          }
          final res = await quizRepository.startQuiz(
            StartDriverQuiz(questionIds: questionIds, category: categoryEnum),
          );

          emit(
            state.copyWith(
              attempt: OperationResult.success(res.data),
              currentQuestionIndex: 0,
              selectedAnswerId: null,
              answeredQuestions: <String>{},
              result: const OperationResult.idle(),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to start quiz', error: e, stackTrace: st);
          emit(
            state.copyWith(
              attempt: OperationResult.failed(e),
              currentQuestionIndex: null,
              selectedAnswerId: null,
              answeredQuestions: null,
            ),
          );
        }
      });

  Future<void> submitAnswer() async =>
      await taskManager.execute('DQC2-SA1', () async {
        try {
          final attempt = state.attempt.value;
          final currentIndex = state.currentQuestionIndex;
          final selectedAnswerId = state.selectedAnswerId;

          if (attempt == null ||
              currentIndex == null ||
              selectedAnswerId == null) {
            emit(
              state.copyWith(
                answerFeedback: OperationResult.failed(
                  ServiceError('Please select an answer before submitting'),
                ),
              ),
            );
            return;
          }

          final question = attempt.questions[currentIndex];
          final questionId = question.id ?? '';

          final res = await quizRepository.submitAnswer(
            SubmitDriverQuizAnswer(
              attemptId: attempt.attemptId,
              questionId: questionId,
              selectedOptionId: selectedAnswerId,
            ),
          );

          final newAnsweredQuestions = Set<String>.from(
            state.answeredQuestions ?? {},
          )..add(questionId);

          emit(
            state.copyWith(
              answeredQuestions: newAnsweredQuestions,
              answerFeedback: OperationResult.success(
                res.data,
                message: res.message,
              ),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to start quiz', error: e, stackTrace: st);
          emit(
            state.copyWith(
              answerFeedback: OperationResult.failed(e),
              currentQuestionIndex: null,
              selectedAnswerId: null,
              answeredQuestions: null,
            ),
          );
        }
      });

  Future<void> getLatestAttempt() async =>
      await taskManager.execute('DQC2-GLA1', () async {
        try {
          emit(state.copyWith(result: const OperationResult.loading()));

          final res = await quizRepository.getLatestAttempt();

          emit(
            state.copyWith(
              answer: OperationResult.success(res.data, message: res.message),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to get latest attempt', error: e, stackTrace: st);
          emit(state.copyWith(answer: OperationResult.failed(e)));
        }
      });

  Future<void> completeQuiz() async =>
      await taskManager.execute('DQC2-CQ1', () async {
        try {
          final attempt = state.attempt.value;
          if (attempt == null) {
            return;
          }

          emit(state.copyWith(attempt: const OperationResult.loading()));

          final res = await quizRepository.completeQuiz(
            CompleteDriverQuiz(attemptId: attempt.attemptId),
          );

          emit(
            state.copyWith(
              result: OperationResult.success(res.data, message: res.message),
              attempt: const OperationResult.idle(),
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to complete quiz', error: e, stackTrace: st);
          emit(state.copyWith(attempt: OperationResult.failed(e)));
        }
      });

  Future<void> nextQuestion() async {
    final attempt = state.attempt.value;
    final currentIndex = state.currentQuestionIndex ?? 0;

    if (attempt != null && currentIndex < attempt.questions.length - 1) {
      emit(
        state.copyWith(
          currentQuestionIndex: currentIndex + 1,
          selectedAnswerId: null,
          answerFeedback: const OperationResult.idle(),
        ),
      );
    }
  }

  Future<void> previousQuestion() async {
    final currentIndex = state.currentQuestionIndex;

    if (currentIndex != null && currentIndex > 0) {
      emit(
        state.copyWith(
          currentQuestionIndex: currentIndex - 1,
          selectedAnswerId: null,
          answerFeedback: const OperationResult.idle(),
        ),
      );
    }
  }

  Future<void> jumpToQuestion(int index) async {
    final attempt = state.attempt.value;

    if (attempt != null && index >= 0 && index < attempt.questions.length) {
      emit(
        state.copyWith(
          currentQuestionIndex: index,
          selectedAnswerId: null,
          answerFeedback: const OperationResult.idle(),
        ),
      );
    }
  }

  void selectAnswer(String optionId) {
    emit(state.copyWith(selectedAnswerId: optionId));
  }
}
