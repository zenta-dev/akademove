import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/driver/presentation/cubits/driver_quiz_cubit_simple.dart';
import 'package:akademove/features/driver/presentation/states/driver_quiz_state_simple.dart';

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
    _quizCubit = DriverQuizCubit(
      quizRepository: sl(),
    );
    
    // Check for existing attempt
    _quizCubit.getLatestAttempt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Driver Knowledge Quiz',
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<DriverQuizCubit, DriverQuizState>(
        bloc: _quizCubit,
        builder: (context, state) {
          if (state.state == 'loading') {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.state == 'failure') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.quiz_outlined,
            size: 64,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(height: 24),
          Text(
            'Driver Knowledge Quiz',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
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
              label: 'Start Quiz',
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
    final currentQuestion = state.currentQuestionIndex;
    final progress = state.progress;

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
                    'Question ${currentQuestion + 1} of ${attempt.questions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    '${(progress * 100).toInt()}%',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),

        // Question Card
        Expanded(
          child: currentQuestion != null
              ? _buildQuestionCard(currentQuestion, state)
              : const Center(
                  child: Text('No question available'),
                ),
        ),

        // Navigation Buttons
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous Button
              if (currentQuestion > 0)
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _quizCubit.previousQuestion(),
                    icon: const Icon(Icons.arrow_back),
                    label: 'Previous',
                  ),
                ),

              // Next/Complete Button
              Expanded(
                child: state.isLastQuestion
                    ? ElevatedButton.icon(
                        onPressed: () => _quizCubit.completeQuiz(),
                        icon: const Icon(Icons.check_circle),
                        label: 'Complete Quiz',
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: state.isCurrentQuestionAnswered
                            ? () => _quizCubit.nextQuestion()
                            : null,
                        icon: const Icon(Icons.arrow_forward),
                        label: 'Next',
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(dynamic question, DriverQuizState state) {
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
            Text(
              question.question,
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const SizedBox(height: 16),

            // Options
            ...question.options.map((option) {
              final isSelected = state.selectedAnswerId == option.id;
              final isAnswered = state.answeredQuestions.contains(question.id);

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: isAnswered ? null : () => _quizCubit.selectAnswer(option.id),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isSelected
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.grey.shade100,
                      border: Border.all(
                        color: isSelected
                            ? Theme.of(context).primaryColor
                            : Colors.grey.shade300,
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
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Colors.white,
                            border: Border.all(
                              color: isSelected
                                    ? Theme.of(context).primaryColor
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
                            option.text,
                            style: TextStyle(
                              color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen(dynamic result) {
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
              color: result.passed ? Colors.green.shade100 : Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              result.passed ? Icons.check_circle : Icons.cancel,
              size: 64,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 24),

          // Result Message
          Text(
            result.passed ? 'Congratulations!' : 'Quiz Not Passed',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: result.passed ? Colors.green.shade700 : Colors.red.shade700,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            result.passed
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
                _buildScoreRow('Score', '${result.scorePercentage.toInt()}%'),
                const SizedBox(height: 8),
                _buildScoreRow('Correct Answers', '${result.correctAnswers}/${result.totalQuestions}'),
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
              label: 'Back to Dashboard',
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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