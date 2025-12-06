import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/data/repositories/driver_quiz_repository.dart';

class DriverQuizState {
  const DriverQuizState({
    this.state = CubitState.initial,
    this.message,
    this.error,
    this.attempt,
    this.currentQuestionIndex,
    this.selectedAnswerId,
    this.answeredQuestions,
    this.result,
  });

  final CubitState state;
  final String? message;
  final BaseError? error;
  final QuizAttempt? attempt;
  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String> answeredQuestions;
  final QuizResult? result;

  DriverQuizState copyWith({
    CubitState? state,
    String? message,
    BaseError? error,
    QuizAttempt? attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    QuizResult? result,
  }) {
    return DriverQuizState(
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
      attempt: attempt ?? this.attempt,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      result: result ?? this.result,
    );
  }

  DriverQuizState toInitial() => DriverQuizState();

  DriverQuizState toLoading() => copyWith(state: CubitState.loading);

  DriverQuizState toSuccess({
    String? message,
    QuizAttempt? attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    QuizResult? result,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    attempt: attempt ?? this.attempt,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
    answeredQuestions: answeredQuestions ?? this.answeredQuestions,
    result: result ?? this.result,
  );

  DriverQuizState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}

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
      emit(DriverQuizState().toFailure(e));
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
      emit(DriverQuizState().toFailure(e));
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
      emit(DriverQuizState().toFailure(e));
    }
  }

  Future<void> getLatestAttempt() async {
    try {
      emit(DriverQuizState().toLoading());

      final res = await _quizRepository.getLatestAttempt();

      emit(DriverQuizState().toSuccess(message: res.message, result: res.data));
    } on BaseError catch (e, st) {
      logger.e('Failed to get latest attempt', error: e, stackTrace: st);
      emit(DriverQuizState().toFailure(e));
    }
  }

  void selectAnswer(String optionId) {
    emit(DriverQuizState().toSuccess(selectedAnswerId: optionId));
  }

  void reset() {
    emit(DriverQuizState());
  }

  // Getters
  QuizQuestion? get currentQuestion {
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
