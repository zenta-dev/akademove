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
    Map<String, dynamic>? answerFeedback,
  }) : _answerFeedback = answerFeedback;

  final DriverQuizAnswerStartQuiz201ResponseData? attempt;
  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String> answeredQuestions;

  /// Quiz result - can be either DriverQuizResult or DriverQuizAnswer
  /// DriverQuizResult is returned from completeQuiz
  /// DriverQuizAnswer is returned from getLatestAttempt
  final Object? result;

  /// Raw answer feedback data (kept as Map for mapper compatibility)
  final Map<String, dynamic>? _answerFeedback;

  /// Get structured answer feedback from response data
  DriverQuizAnswerSubmitAnswer200ResponseData? get answerFeedback {
    if (_answerFeedback == null) return null;
    return DriverQuizAnswerSubmitAnswer200ResponseData.fromJson(
      _answerFeedback!,
    );
  }

  /// Check if result is DriverQuizResult
  bool get isCompletionResult => result is DriverQuizResult;

  /// Check if result is DriverQuizAnswer
  bool get isAttemptResult => result is DriverQuizAnswer;

  /// Get result as DriverQuizResult if available
  DriverQuizResult? get asCompletionResult =>
      result is DriverQuizResult ? result as DriverQuizResult : null;

  /// Get result as DriverQuizAnswer if available
  DriverQuizAnswer? get asAttemptResult =>
      result is DriverQuizAnswer ? result as DriverQuizAnswer : null;

  @override
  DriverQuizState toInitial() => DriverQuizState();

  @override
  DriverQuizState toLoading() => copyWith(state: CubitState.loading);

  @override
  DriverQuizState toSuccess({
    String? message,
    DriverQuizAnswerStartQuiz201ResponseData? attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    Object? result,
    DriverQuizAnswerSubmitAnswer200ResponseData? answerFeedbackObj,
  }) => copyWith(
    state: CubitState.success,
    message: message,
    attempt: attempt ?? this.attempt,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
    answeredQuestions: answeredQuestions ?? this.answeredQuestions,
    result: result ?? this.result,
    answerFeedback: answerFeedbackObj?.toJson(),
  );

  @override
  DriverQuizState toFailure(BaseError error, {String? message}) => copyWith(
    state: CubitState.failure,
    error: error,
    message: message ?? error.message,
  );
}
