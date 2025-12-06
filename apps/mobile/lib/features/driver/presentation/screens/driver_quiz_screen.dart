import 'package:akademove/features/driver/data/repositories/driver_quiz_repository.dart';
import 'package:akademove/features/driver/presentation/cubits/driver_quiz_cubit_simple.dart';
import 'package:akademove/features/driver/presentation/states/driver_quiz_state_simple.dart';
import 'package:akademove/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Knowledge Quiz'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<DriverQuizCubit, DriverQuizState>(
        bloc: _quizCubit,
        builder: (context, state) {
          if (state.state == 'loading') {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.state == 'failure') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load quiz',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _quizCubit.reset(),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          // Show quiz result if completed
          if (state.result != null) {
            final result = state.result;
            return _buildResultScreen(result);
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
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.quiz_outlined, size: 64, color: primaryColor),
          const SizedBox(height: 24),
          Text(
            'Driver Knowledge Quiz',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Complete this quiz to demonstrate your understanding of driver guidelines, safety protocols, and platform rules.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _quizCubit.startQuiz(),
              icon: const Icon(Icons.play_arrow),
              label: const Text('Start Quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
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
    final primaryColor = Theme.of(context).primaryColor;

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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: primaryColor),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
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
                  child: ElevatedButton.icon(
                    onPressed: () => _quizCubit.previousQuestion(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                ),

              // Next/Complete Button
              Expanded(
                child: _quizCubit.isLastQuestion
                    ? ElevatedButton.icon(
                        onPressed: () => _quizCubit.completeQuiz(),
                        icon: const Icon(Icons.check_circle),
                        label: const Text('Complete Quiz'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: _quizCubit.isCurrentQuestionAnswered
                            ? () => _quizCubit.nextQuestion()
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Next'),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(dynamic question, DriverQuizState state) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(question.category as String),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                (question.category as String).replaceAll('_', ' '),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Question
            Text(
              question.question as String,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            // Options
            ...(question.options as List).map((option) {
              final isSelected = state.selectedAnswerId == option.id;
              final isAnswered = state.answeredQuestions.contains(
                question.id as String,
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: isAnswered
                      ? null
                      : () => _quizCubit.selectAnswer(option.id as String),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withValues(alpha: 0.1)
                          : Colors.grey.shade100,
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.grey.shade300,
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
                                  : Colors.grey.shade300,
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
                            option.text as String,
                            style: TextStyle(
                              color: isSelected ? primaryColor : Colors.black87,
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

  Widget _buildResultScreen(dynamic result) {
    final primaryColor = Theme.of(context).primaryColor;
    final passed = result.passed as bool;
    return Padding(
      padding: const EdgeInsets.all(16),
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
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Result Message
          Text(
            passed ? 'Congratulations!' : 'Quiz Not Passed',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: passed ? Colors.green.shade700 : Colors.red.shade700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            passed
                ? 'You have successfully passed the driver knowledge quiz!'
                : 'You did not pass the quiz. Please try again.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 24),

          // Score Details
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _buildScoreRow(
                  'Score',
                  '${(result.scorePercentage as num).toInt()}%',
                ),
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

          const SizedBox(height: 32),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Dashboard'),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
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
        return Colors.grey;
    }
  }
}
