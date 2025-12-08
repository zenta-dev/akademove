import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:api_client/api_client.dart';

// class DriverQuizCubit extends BaseCubit<DriverQuizState> {
//   DriverQuizCubit({required DriverQuizRepository quizRepository})
//     : _quizRepository = quizRepository,
//       super(DriverQuizState());

//   final DriverQuizRepository _quizRepository;

//   Future<void> startQuiz({List<String>? questionIds, String? category}) async {
//     try {
//       emit(state.toLoading());

//       StartDriverQuizCategoryEnum? categoryEnum;

//       for (final cat in StartDriverQuizCategoryEnum.values) {
//         if (cat.name == category) {
//           categoryEnum = cat;
//           break;
//         }
//       }

//       final request = StartDriverQuiz(
//         questionIds: questionIds,
//         category: categoryEnum,
//       );

//       final res = await _quizRepository.startQuiz(request);

//       emit(
//         state.toSuccess(
//           message: res.message,
//           attempt: res.data,
//           currentQuestionIndex: 0,
//           selectedAnswerId: null,
//           answeredQuestions: <String>{},
//         ),
//       );
//     } on BaseError catch (e, st) {
//       logger.e('Failed to start quiz', error: e, stackTrace: st);
//       emit(state.toFailure(e));
//     }
//   }

//   Future<void> submitAnswer() async {
//     try {
//       final attempt = state.attempt;
//       final currentIndex = state.currentQuestionIndex;
//       final selectedAnswerId = state.selectedAnswerId;

//       if (attempt == null || currentIndex == null || selectedAnswerId == null) {
//         emit(
//           state.toFailure(
//             ServiceError('Please select an answer before submitting'),
//           ),
//         );
//         return;
//       }

//       final question = attempt.questions[currentIndex];

//       emit(state.toLoading());

//       final request = SubmitDriverQuizAnswer(
//         attemptId: attempt.attemptId,
//         questionId: question.id,
//         selectedOptionId: selectedAnswerId,
//       );

//       final res = await _quizRepository.submitAnswer(request);

//       final newAnsweredQuestions = Set<String>.from(state.answeredQuestions)
//         ..add(question.id);

//       emit(
//         state.toSuccess(
//           message: res.message,
//           answeredQuestions: newAnsweredQuestions,
//           answerFeedbackObj: res.data, // Store feedback for UI display
//         ),
//       );
//     } on BaseError catch (e, st) {
//       logger.e('Failed to submit answer', error: e, stackTrace: st);
//       emit(state.toFailure(e));
//     }
//   }

//   Future<void> nextQuestion() async {
//     final attempt = state.attempt;
//     final currentIndex = state.currentQuestionIndex;

//     if (attempt != null &&
//         currentIndex != null &&
//         currentIndex < attempt.questions.length - 1) {
//       emit(
//         state.toSuccess(
//           currentQuestionIndex: currentIndex + 1,
//           selectedAnswerId: null,
//         ),
//       );
//     }
//   }

//   Future<void> previousQuestion() async {
//     final currentIndex = state.currentQuestionIndex;

//     if (currentIndex != null && currentIndex > 0) {
//       emit(
//         state.toSuccess(
//           currentQuestionIndex: currentIndex - 1,
//           selectedAnswerId: null,
//         ),
//       );
//     }
//   }

//   /// Jump to a specific question by index
//   Future<void> jumpToQuestion(int index) async {
//     final attempt = state.attempt;

//     if (attempt != null && index >= 0 && index < attempt.questions.length) {
//       emit(
//         state.toSuccess(currentQuestionIndex: index, selectedAnswerId: null),
//       );
//     }
//   }

//   Future<void> completeQuiz() async {
//     try {
//       final attempt = state.attempt;
//       if (attempt == null) {
//         return;
//       }

//       emit(state.toLoading());

//       final request = CompleteDriverQuiz(attemptId: attempt.attemptId);

//       final res = await _quizRepository.completeQuiz(request);

//       // Clear cache after completion

//       emit(
//         state.toSuccess(
//           message: res.message,
//           result: res.data,
//           attempt: null, // Clear attempt after completion
//         ),
//       );
//     } on BaseError catch (e, st) {
//       logger.e('Failed to complete quiz', error: e, stackTrace: st);
//       emit(state.toFailure(e));
//     }
//   }

//   Future<void> getLatestAttempt() async {
//     try {
//       emit(state.toLoading());

//       final res = await _quizRepository.getLatestAttempt();

//       emit(state.toSuccess(message: res.message, result: res.data));
//     } on BaseError catch (e, st) {
//       logger.e('Failed to get latest attempt', error: e, stackTrace: st);
//       emit(state.toFailure(e));
//     }
//   }

//   void selectAnswer(String optionId) {
//     emit(state.toSuccess(selectedAnswerId: optionId));
//   }

//   void reset() {
//     emit(state.toInitial());
//   }

//   // Getters
//   DriverMinQuizQuestion? get currentQuestion {
//     final attempt = state.attempt;
//     final currentIndex = state.currentQuestionIndex;

//     if (attempt == null || currentIndex == null) {
//       return null;
//     }

//     if (currentIndex >= attempt.questions.length) {
//       return null;
//     }

//     return attempt.questions[currentIndex];
//   }

//   bool get isLastQuestion {
//     final attempt = state.attempt;
//     final currentIndex = state.currentQuestionIndex;

//     if (attempt == null || currentIndex == null) {
//       return false;
//     }

//     return currentIndex >= attempt.questions.length - 1;
//   }

//   bool get allQuestionsAnswered {
//     final attempt = state.attempt;
//     final answeredQuestions = state.answeredQuestions;

//     if (attempt == null) {
//       return false;
//     }

//     return answeredQuestions.length == attempt.questions.length;
//   }

//   bool get isCurrentQuestionAnswered {
//     final currentQuestion = this.currentQuestion;
//     final answeredQuestions = state.answeredQuestions;

//     if (currentQuestion == null) {
//       return false;
//     }

//     return answeredQuestions.contains(currentQuestion.id);
//   }

//   double get progress {
//     final attempt = state.attempt;
//     final currentIndex = state.currentQuestionIndex;

//     if (attempt == null || currentIndex == null || attempt.questions.isEmpty) {
//       return 0.0;
//     }

//     return (currentIndex + 1) / attempt.questions.length;
//   }

//   /// Check for persisted quiz state on app restart
//   /// Restores the quiz to the last known state if available
//   Future<void> checkPersistedState() async {
//     try {
//       // Try to get latest attempt from server
//       final res = await _quizRepository.getLatestAttempt();

//       if (res.data != null) {
//         // Quiz attempt exists, show result screen
//         emit(state.toSuccess(result: res.data, message: 'Quiz status loaded'));
//       } else {
//         // No quiz attempt found
//         emit(state.toSuccess(message: 'No quiz attempt found'));
//       }
//     } on BaseError catch (e, st) {
//       logger.e('Failed to check persisted state', error: e, stackTrace: st);
//       emit(state.toFailure(e));
//     }
//   }
// }

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
            ),
          );
        } on BaseError catch (e, st) {
          logger.e('Failed to start quiz', error: e, stackTrace: st);
          emit(
            state.copyWith(
              attempt: OperationResult.failed(e),
              currentQuestionIndex: 0,
              selectedAnswerId: null,
              answeredQuestions: <String>{},
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
                attempt: OperationResult.failed(
                  ServiceError('Please select an answer before submitting'),
                ),
              ),
            );
            return;
          }

          final question = attempt.questions[currentIndex];

          final res = await quizRepository.submitAnswer(
            SubmitDriverQuizAnswer(
              attemptId: attempt.attemptId,
              questionId: question.id,
              selectedOptionId: selectedAnswerId,
            ),
          );

          final newAnsweredQuestions = Set<String>.from(
            state.answeredQuestions ?? {},
          )..add(question.id);

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
              attempt: OperationResult.failed(e),
              currentQuestionIndex: 0,
              selectedAnswerId: null,
              answeredQuestions: <String>{},
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
    final currentIndex = state.currentQuestionIndex;

    if (attempt != null &&
        currentIndex != null &&
        currentIndex < attempt.questions.length - 1) {
      emit(
        state.copyWith(
          currentQuestionIndex: currentIndex + 1,
          selectedAnswerId: null,
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
        ),
      );
    }
  }

  Future<void> jumpToQuestion(int index) async {
    final attempt = state.attempt.value;

    if (attempt != null && index >= 0 && index < attempt.questions.length) {
      emit(state.copyWith(currentQuestionIndex: index, selectedAnswerId: null));
    }
  }

  void selectAnswer(String optionId) =>
      emit(state.copyWith(selectedAnswerId: optionId));
}
