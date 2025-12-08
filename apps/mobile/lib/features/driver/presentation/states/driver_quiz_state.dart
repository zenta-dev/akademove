// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  final DriverQuizAttempt? attempt;
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
  DriverQuizAnswer? get answerFeedback {
    if (_answerFeedback == null) return null;
    return DriverQuizAnswer.fromJson(_answerFeedback!);
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
    DriverQuizAttempt? attempt,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
    Object? result,
    DriverQuizAnswer? answerFeedbackObj,
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

class DriverQuizState2 extends Equatable {
  const DriverQuizState2({
    this.attempt = const OperationResult.idle(),
    this.answerFeedback = const OperationResult.idle(),
    this.result = const OperationResult.idle(),
    this.answer = const OperationResult.idle(),
    this.currentQuestionIndex,
    this.selectedAnswerId,
    this.answeredQuestions,
  });

  final OperationResult<DriverQuizAttempt> attempt;
  final OperationResult<SubmitDriverQuizAnswerResponse> answerFeedback;
  final OperationResult<DriverQuizResult> result;
  final OperationResult<DriverQuizAnswer?> answer;

  final int? currentQuestionIndex;
  final String? selectedAnswerId;
  final Set<String>? answeredQuestions;

  @override
  List<Object> get props {
    return [
      attempt,
      answerFeedback,
      ?currentQuestionIndex,
      ?selectedAnswerId,
      ?answeredQuestions,
    ];
  }

  @override
  bool get stringify => true;

  DriverQuizState2 copyWith({
    OperationResult<DriverQuizAttempt>? attempt,
    OperationResult<SubmitDriverQuizAnswerResponse>? answerFeedback,
    OperationResult<DriverQuizResult>? result,
    OperationResult<DriverQuizAnswer?>? answer,
    int? currentQuestionIndex,
    String? selectedAnswerId,
    Set<String>? answeredQuestions,
  }) {
    return DriverQuizState2(
      attempt: attempt ?? this.attempt,
      answerFeedback: answerFeedback ?? this.answerFeedback,
      result: result ?? this.result,
      answer: answer ?? this.answer,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswerId: selectedAnswerId ?? this.selectedAnswerId,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
    );
  }

  DriverMinQuizQuestion? get currentQuestion {
    final attempt = this.attempt.data?.value;
    final currentIndex = currentQuestionIndex;

    if (attempt == null || currentIndex == null) {
      return null;
    }

    if (currentIndex >= attempt.questions.length) {
      return null;
    }

    return attempt.questions[currentIndex];
  }

  bool get isLastQuestion {
    final attempt = this.attempt.data?.value;
    final currentIndex = currentQuestionIndex;

    if (attempt == null || currentIndex == null) {
      return false;
    }

    return currentIndex >= attempt.questions.length - 1;
  }

  bool get allQuestionsAnswered {
    final attempt = this.attempt.data?.value;
    final answeredQuestions = this.answeredQuestions ?? {};

    if (attempt == null) {
      return false;
    }

    return answeredQuestions.length == attempt.questions.length;
  }

  bool get isCurrentQuestionAnswered {
    final currentQuestion = this.currentQuestion;
    final answeredQuestions = this.answeredQuestions ?? {};

    if (currentQuestion == null) {
      return false;
    }

    return answeredQuestions.contains(currentQuestion.id);
  }

  double get progress {
    final attempt = this.attempt.data?.value;
    final currentIndex = currentQuestionIndex;

    if (attempt == null || currentIndex == null || attempt.questions.isEmpty) {
      return 0.0;
    }

    return (currentIndex + 1) / attempt.questions.length;
  }
}
