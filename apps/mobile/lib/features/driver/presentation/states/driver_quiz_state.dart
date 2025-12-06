part of '_export.dart';

part of '_export.dart';

class DriverQuizState {
  DriverQuizState({
    this.state = CubitState.initial,
    this.message,
    this.error,
    this.attempt,
    this.currentQuestionIndex,
    this.selectedAnswerId,
    this.answeredQuestions = const <String>{},
    this.result,
  });

  final CubitState state;
  final String? message;
  final BaseError? error;
  final QuizAttempt? attempt;
  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String> answeredQuestions = const <String>{};
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
