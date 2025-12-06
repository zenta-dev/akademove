import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/driver_quiz_repository.dart';
import 'package:akademove/features/driver/presentation/states/driver_quiz_state_simple.dart';

class DriverQuizCubit extends BaseCubit<DriverQuizState> {
  DriverQuizCubit({required DriverQuizRepository quizRepository})
    : _quizRepository = quizRepository,
      super(DriverQuizState());

  final DriverQuizRepository _quizRepository;

  Future<void> startQuiz({List<String>? questionIds, String? category}) async {
    try {
      emit(DriverQuizState().toLoading());

      final request = StartDriverQuizRequest(
        questionIds: questionIds,
        category: category,
      );

      final res = await _quizRepository.startQuiz(request);

      emit(
        DriverQuizState().toSuccess(
          message: res.message,
          attempt: res.data,
          currentQuestionIndex: 0,
          selectedAnswerId: null,
          answeredQuestions: <String>{},
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('Failed to start quiz', error: e, stackTrace: st);
      emit(DriverQuizState().toFailure(e.message));
    }
  }

  Future<void> submitAnswer() async {
    try {
      final attempt = state.attempt;
      final currentIndex = state.currentQuestionIndex;
      final selectedAnswerId = state.selectedAnswerId;

      if (attempt == null || currentIndex == null || selectedAnswerId == null) {
        return;
      }

      final question = attempt.questions[currentIndex!];

      emit(DriverQuizState().toLoading());

      final request = SubmitDriverQuizAnswerRequest(
        attemptId: attempt.attemptId,
        questionId: question.id,
        selectedOptionId: selectedAnswerId,
      );

      final res = await _quizRepository.submitAnswer(request);

      final newAnsweredQuestions = Set<String>.from(
        state.answeredQuestions ?? {},
      )..add(question.id);

      emit(
        DriverQuizState().toSuccess(
          message: res.message,
          answeredQuestions: newAnsweredQuestions,
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('Failed to submit answer', error: e, stackTrace: st);
      emit(DriverQuizState().toFailure(e.message));
    }
  }

  Future<void> nextQuestion() async {
    final attempt = state.attempt;
    final currentIndex = state.currentQuestionIndex;

    if (attempt != null &&
        currentIndex != null &&
        currentIndex! < attempt.questions.length - 1) {
      emit(
        DriverQuizState().toSuccess(
          currentQuestionIndex: currentIndex! + 1,
          selectedAnswerId: null,
        ),
      );
    }
  }

  Future<void> previousQuestion() async {
    final currentIndex = state.currentQuestionIndex;

    if (currentIndex != null && currentIndex! > 0) {
      emit(
        DriverQuizState().toSuccess(
          currentQuestionIndex: currentIndex! - 1,
          selectedAnswerId: null,
        ),
      );
    }
  }

  Future<void> completeQuiz() async {
    try {
      final attempt = state.attempt;
      if (attempt == null) {
        return;
      }

      emit(DriverQuizState().toLoading());

      final request = CompleteDriverQuizRequest(attemptId: attempt.attemptId);

      final res = await _quizRepository.completeQuiz(request);

      emit(
        DriverQuizState().toSuccess(
          message: res.message,
          result: res.data,
          attempt: null, // Clear attempt after completion
        ),
      );
    } on BaseError catch (e, st) {
      logger.e('Failed to complete quiz', error: e, stackTrace: st);
      emit(DriverQuizState().toFailure(e.message));
    }
  }

  Future<void> getLatestAttempt() async {
    try {
      emit(DriverQuizState().toLoading());

      final res = await _quizRepository.getLatestAttempt();

      emit(DriverQuizState().toSuccess(message: res.message, result: res.data));
    } on BaseError catch (e, st) {
      logger.e('Failed to get latest attempt', error: e, stackTrace: st);
      emit(DriverQuizState().toFailure(e.message));
    }
  }

  void selectAnswer(String optionId) {
    emit(DriverQuizState().toSuccess(selectedAnswerId: optionId));
  }

  void reset() {
    emit(DriverQuizState());
  }

  // Getters
  dynamic get currentQuestion {
    final attempt = state.attempt;
    final currentIndex = state.currentQuestionIndex;

    if (attempt == null || currentIndex == null) {
      return null;
    }

    if (currentIndex! >= attempt.questions.length) {
      return null;
    }

    return attempt.questions[currentIndex!];
  }

  bool get isLastQuestion {
    final attempt = state.attempt;
    final currentIndex = state.currentQuestionIndex;

    if (attempt == null || currentIndex == null) {
      return false;
    }

    return currentIndex! >= attempt.questions.length - 1;
  }

  bool get allQuestionsAnswered {
    final attempt = state.attempt;
    final answeredQuestions = state.answeredQuestions;

    if (attempt == null || answeredQuestions == null) {
      return false;
    }

    return answeredQuestions.length == attempt.questions.length;
  }

  bool get isCurrentQuestionAnswered {
    final currentQuestion = this.currentQuestion;
    final answeredQuestions = state.answeredQuestions;

    if (currentQuestion == null || answeredQuestions == null) {
      return false;
    }

    return answeredQuestions.contains(currentQuestion!.id);
  }

  double get progress {
    final attempt = state.attempt;
    final currentIndex = state.currentQuestionIndex;

    if (attempt == null || currentIndex == null || attempt.questions.isEmpty) {
      return 0.0;
    }

    return (currentIndex! + 1) / attempt.questions.length;
  }
}
