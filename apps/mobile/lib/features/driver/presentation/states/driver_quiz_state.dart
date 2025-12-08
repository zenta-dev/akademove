// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '_export.dart';

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
    final currentIndex = currentQuestionIndex ?? 0;

    if (attempt == null) {
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
