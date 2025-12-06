class DriverQuizState {
  const DriverQuizState({
    this.state = 'initial',
    this.message,
    this.error,
    this.attempt,
    this.currentQuestionIndex,
    this.selectedAnswerId,
    this.answeredQuestions = const <String>{},
    this.result,
  });

  final String state;
  final String? message;
  final String? error;
  final dynamic attempt;
  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String> answeredQuestions;
  final dynamic result;

  DriverQuizState copyWith({
    String? state,
    String? message,
    String? error,
    dynamic attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    dynamic result,
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

  DriverQuizState toLoading() => copyWith(state: 'loading');

  DriverQuizState toSuccess({
    String? message,
    dynamic attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    dynamic result,
  }) => copyWith(
    state: 'success',
    message: message,
    attempt: attempt ?? this.attempt,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
    answeredQuestions: answeredQuestions ?? this.answeredQuestions,
    result: result ?? this.result,
  );

  DriverQuizState toFailure(String error, {String? message}) =>
      copyWith(state: 'failure', error: error, message: message ?? error);
}
