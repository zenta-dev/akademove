import 'package:akademove/core/_export.dart';
import 'package:akademove/features/features.dart';
import 'package:akademove/locator.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverQuizScreen extends StatefulWidget {
  const DriverQuizScreen({super.key});

  @override
  State<DriverQuizScreen> createState() => _DriverQuizScreenState();
}

class _DriverQuizScreenState extends State<DriverQuizScreen> {
  late DriverQuizCubit _quizCubit;

  @override
  void initState() {
    super.initState();
    _quizCubit = DriverQuizCubit(quizRepository: sl<DriverQuizRepository>());

    // Check for existing attempt
    _quizCubit.getLatestAttempt();
  }

  @override
  void dispose() {
    _quizCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      headers: [AppBar(title: const Text('Driver Knowledge Quiz'))],
      body: BlocBuilder<DriverQuizCubit, DriverQuizState>(
        bloc: _quizCubit,
        builder: (context, state) {
          if (state.state == CubitState.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.state == CubitState.failure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  Text('Failed to load quiz').h4,
                  Text(state.error?.message ?? '').h4,
                  PrimaryButton(
                    onPressed: () => _quizCubit.reset(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // Show quiz result if completed
          if (state.result != null) {
            return _buildResultScreen(state.result);
          }

          // Show quiz questions
          if (state.attempt != null) {
            return _buildQuizScreen(state);
          }

          // Show start screen
          return _buildStartScreen();
        },
      ),
    );
  }

  Widget _buildStartScreen() {
    final primaryColor = context.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.quiz_outlined, size: 64, color: primaryColor),
            const SizedBox(height: 24),
            Text(
              'Driver Knowledge Quiz',
              style: context.typography.h2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Complete this quiz to demonstrate your understanding of driver guidelines, safety protocols, and platform rules.',
              style: context.typography.large,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Quiz Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.gray.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quiz Information',
                    style: context.typography.medium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoBullet(
                    'You will be presented with multiple-choice questions',
                  ),
                  _buildInfoBullet(
                    'Cover topics: Safety, Navigation, Customer Service, Platform Rules',
                  ),
                  _buildInfoBullet('Passing score: 70%'),
                  _buildInfoBullet(
                    'You must pass this quiz to be eligible for driver approval',
                  ),
                  _buildInfoBullet('Take your time - there is no time limit'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: IconButton(
                variance: ButtonVariance.primary,
                onPressed: () => _quizCubit.startQuiz(),
                icon: const Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '• ',
            style: context.typography.small.copyWith(
              color: Colors.gray.shade600,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: context.typography.small.copyWith(
                color: Colors.gray.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizScreen(DriverQuizState state) {
    final attempt = state.attempt;
    final currentQuestionIndex = state.currentQuestionIndex ?? 0;
    final progress = _quizCubit.progress;
    final primaryColor = context.colorScheme.primary;

    return Column(
      children: [
        // Progress Header
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${currentQuestionIndex + 1} of ${attempt?.questions.length ?? 0}',
                    style: context.typography.medium,
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: context.typography.small.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.gray.shade300,
                color: primaryColor,
              ),
            ],
          ),
        ),

        // Question Card
        Expanded(
          child: _quizCubit.currentQuestion != null
              ? _buildQuestionCard(_quizCubit.currentQuestion, state)
              : const Center(child: Text('No question available')),
        ),

        // Navigation Buttons
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous Button
              if (currentQuestionIndex > 0)
                Expanded(
                  child: IconButton(
                    variance: ButtonVariance.secondary,
                    onPressed: () => _quizCubit.previousQuestion(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),

              // Next/Complete Button
              Expanded(
                child: _quizCubit.isLastQuestion
                    ? IconButton(
                        variance: ButtonVariance.secondary,
                        onPressed: () => _quizCubit.completeQuiz(),
                        icon: const Icon(Icons.check_circle),
                      )
                    : IconButton(
                        variance: ButtonVariance.secondary,
                        onPressed: _quizCubit.isCurrentQuestionAnswered
                            ? () => _quizCubit.nextQuestion()
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                      ),
              ),
            ],
          ),
        ),

        // Question Navigation Buttons
        if (attempt != null && attempt.questions.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jump to question:',
                  style: context.typography.small.copyWith(
                    color: Colors.gray.shade600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(attempt.questions.length, (index) {
                    final isCurrentQuestion = index == currentQuestionIndex;
                    final isAnswered = state.answeredQuestions.contains(
                      attempt.questions[index].id,
                    );

                    return GestureDetector(
                      onTap: () => _quizCubit.jumpToQuestion(index),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isCurrentQuestion
                              ? primaryColor
                              : isAnswered
                              ? Colors.green.shade100
                              : Colors.transparent,
                          border: Border.all(
                            color: isCurrentQuestion
                                ? primaryColor
                                : Colors.gray.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isCurrentQuestion
                                ? Colors.white
                                : isAnswered
                                ? Colors.green.shade700
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildQuestionCard(
    DriverQuizQuestionGetQuizQuestions200ResponseDataInner? question,
    DriverQuizState state,
  ) {
    if (question == null) {
      return const Center(child: Text('No question available'));
    }
    final primaryColor = context.colorScheme.primary;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(question.category),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                question.category.replaceAll('_', ' '),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Question
            Text(question.question, style: context.typography.medium),

            const SizedBox(height: 16),

            // Answer Feedback if submitted
            if (state.answeredQuestions.contains(question.id) &&
                state.answerFeedback != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: state.answerFeedback!.isCorrect
                      ? Colors.green.shade50
                      : Colors.red.shade50,
                  border: Border.all(
                    color: state.answerFeedback!.isCorrect
                        ? Colors.green.shade200
                        : Colors.red.shade200,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      state.answerFeedback!.isCorrect
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: state.answerFeedback!.isCorrect
                          ? Colors.green.shade700
                          : Colors.red.shade700,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.answerFeedback!.isCorrect
                                ? 'Correct!'
                                : 'Incorrect',
                            style: context.typography.medium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: state.answerFeedback!.isCorrect
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                          ),
                          Text(
                            '+${state.answerFeedback!.pointsEarned.toInt()} points earned',
                            style: context.typography.small.copyWith(
                              color: state.answerFeedback!.isCorrect
                                  ? Colors.green.shade700
                                  : Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Options
            ...question.options.map((option) {
              final isSelected = state.selectedAnswerId == option.id;
              final isAnswered = state.answeredQuestions.contains(question.id);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: OutlineButton(
                  onPressed: isAnswered
                      ? null
                      : () => _quizCubit.selectAnswer(option.id),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withValues(alpha: 0.1)
                          : Colors.gray.shade100,
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.gray.shade300,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Radio Button
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected ? primaryColor : Colors.white,
                            border: Border.all(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.gray.shade300,
                              width: 2,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  size: 16,
                                )
                              : null,
                        ),
                        const SizedBox(width: 12),

                        // Option Text
                        Expanded(
                          child: Text(
                            option.text,
                            style: TextStyle(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.gray.shade800,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen(Object? result) {
    if (result == null) {
      return const Center(child: Text('No result data available'));
    }

    // Handle DriverQuizResult (from completion)
    if (result is DriverQuizResult) {
      return _buildCompletionResultScreen(result);
    }

    // Handle DriverQuizAnswer (from latest attempt)
    if (result is DriverQuizAnswer) {
      return _buildAttemptResultScreen(result);
    }

    return const Center(child: Text('Unknown result type'));
  }

  Widget _buildCompletionResultScreen(DriverQuizResult result) {
    final passed = result.passed;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: passed ? Colors.green.shade100 : Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 64,
                color: passed ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),

            const SizedBox(height: 24),

            // Result Message
            Text(
              passed ? 'Congratulations!' : 'Quiz Not Passed',
              style: context.typography.h2.copyWith(
                color: passed ? Colors.green.shade700 : Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              passed
                  ? 'You have successfully passed the driver knowledge quiz!'
                  : 'Don\'t worry, you can try again!',
              style: context.typography.large,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            // Score Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.gray.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildScoreRow('Score', '${result.scorePercentage.toInt()}%'),
                  const SizedBox(height: 8),
                  _buildScoreRow(
                    'Correct Answers',
                    '${result.correctAnswers}/${result.totalQuestions}',
                  ),
                  const SizedBox(height: 8),
                  _buildScoreRow('Points Earned', '${result.earnedPoints}'),
                  const SizedBox(height: 8),
                  _buildScoreRow('Total Points', '${result.totalPoints}'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Not Passed Alert
            if (!passed)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not Passed',
                            style: context.typography.medium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You need at least 70% to pass. Please review the material and try again.',
                            style: context.typography.small.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 32),

            // Action Button
            SizedBox(
              width: double.infinity,
              child: passed
                  ? IconButton(
                      variance: ButtonVariance.primary,
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed('/sign-in'),
                      icon: const Icon(Icons.arrow_forward),
                    )
                  : IconButton(
                      variance: ButtonVariance.secondary,
                      onPressed: () {
                        _quizCubit.reset();
                        _quizCubit.startQuiz();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttemptResultScreen(DriverQuizAnswer attempt) {
    // For DriverQuizAnswer, we can determine pass/fail based on status
    final passed =
        attempt.status == DriverQuizAnswerStatus.COMPLETED &&
        attempt.scorePercentage >= (attempt.passingScore ?? 70);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: passed ? Colors.green.shade100 : Colors.red.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 64,
                color: passed ? Colors.green.shade700 : Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 24),
            // Result Message
            Text(
              passed ? 'Congratulations!' : 'Quiz Not Passed',
              style: context.typography.h2.copyWith(
                color: passed ? Colors.green.shade700 : Colors.red.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              passed
                  ? 'You have successfully passed the driver knowledge quiz!'
                  : 'Don\'t worry, you can try again!',
              style: context.typography.large,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            // Score Details
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.gray.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  _buildScoreRow(
                    'Score',
                    '${attempt.scorePercentage.toInt()}%',
                  ),
                  const SizedBox(height: 8),
                  _buildScoreRow(
                    'Correct Answers',
                    '${attempt.correctAnswers}/${attempt.totalQuestions}',
                  ),
                  const SizedBox(height: 8),
                  _buildScoreRow('Points Earned', '${attempt.earnedPoints}'),
                  const SizedBox(height: 8),
                  _buildScoreRow('Total Points', '${attempt.totalPoints}'),
                ],
              ),
            ),
            if (!passed) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  border: Border.all(color: Colors.red.shade200),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red.shade700),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Not Passed',
                            style: context.typography.medium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'You need at least ${attempt.passingScore ?? 70}% to pass. Please review and try again.',
                            style: context.typography.small.copyWith(
                              color: Colors.red.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: passed
                  ? IconButton(
                      variance: ButtonVariance.primary,
                      onPressed: () => Navigator.of(
                        context,
                      ).pushReplacementNamed('/sign-in'),
                      icon: const Icon(Icons.arrow_forward),
                    )
                  : IconButton(
                      variance: ButtonVariance.secondary,
                      onPressed: () {
                        _quizCubit.reset();
                        _quizCubit.startQuiz();
                      },
                      icon: const Icon(Icons.refresh),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: context.typography.medium.copyWith(
            color: Colors.gray.shade600,
          ),
        ),
        Text(
          value,
          style: context.typography.small.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'SAFETY':
        return Colors.red;
      case 'NAVIGATION':
        return Colors.blue;
      case 'CUSTOMER_SERVICE':
        return Colors.purple;
      case 'PLATFORM_RULES':
        return Colors.orange;
      case 'EMERGENCY_PROCEDURES':
        return Colors.pink;
      case 'VEHICLE_MAINTENANCE':
        return Colors.teal;
      default:
        return Colors.gray;
    }
  }
}
