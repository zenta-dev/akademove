part of '_export.dart';

@MappableClass(
  generateMethods:
      GenerateMethods.stringify | GenerateMethods.equals | GenerateMethods.copy,
)
class DriverQuizState extends BaseState2 with DriverQuizStateMappable {
  DriverQuizState({
    super.state,
    super.message,
    super.error,
    this.attempt,
    this.currentQuestionIndex,
    this.selectedAnswerId,
    this.answeredQuestions = const <String>{},
    this.result,
  });

  final QuizAttempt? attempt;
  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String> answeredQuestions;
  final QuizResult? result;

  @override
  DriverQuizState toInitial() => DriverQuizState();

  @override
  DriverQuizState toLoading() => copyWith(state: CubitState.loading);

  @override
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

  @override
  DriverQuizState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
