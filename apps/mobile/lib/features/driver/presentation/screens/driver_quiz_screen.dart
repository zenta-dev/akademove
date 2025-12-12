import 'package:akademove/app/_export.dart';
import 'package:akademove/core/_export.dart';
import 'package:akademove/features/auth/_export.dart';
import 'package:akademove/features/driver/_export.dart';
import 'package:akademove/l10n/l10n.dart';
import 'package:api_client/api_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DriverQuizScreen extends StatefulWidget {
  const DriverQuizScreen({super.key});

  @override
  State<DriverQuizScreen> createState() => _DriverQuizScreenState();
}

class _DriverQuizScreenState extends State<DriverQuizScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DriverQuizCubit2>().getLatestAttempt();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      headers: [
        DefaultAppBar(
          title: context.l10n.driver_knowledge_quiz,
          padding: EdgeInsets.all(16.r),
        ),
      ],
      child: SafeArea(
        child: RefreshTrigger(
          onRefresh: () async {
            context.read<DriverQuizCubit2>().getLatestAttempt();
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: BlocConsumer<DriverQuizCubit2, DriverQuizState2>(
                listenWhen: (previous, current) {
                  // Only trigger listener when answerFeedback changes from non-success to success
                  return !previous.answerFeedback.isSuccess &&
                      current.answerFeedback.isSuccess;
                },
                listener: (context, state) {
                  // Show toast for answer feedback
                  final feedback = state.answerFeedback.data?.value;
                  if (feedback != null) {
                    if (feedback.isCorrect) {
                      showToast(
                        context: context,
                        builder: (context, overlay) => SurfaceCard(
                          child: Basic(
                            leading: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 24.sp,
                            ),
                            title: Text(
                              'Correct! +${feedback.pointsEarned} points',
                            ),
                          ),
                        ),
                        location: ToastLocation.bottomCenter,
                      );
                    } else {
                      showToast(
                        context: context,
                        builder: (context, overlay) => SurfaceCard(
                          child: Basic(
                            leading: Icon(
                              Icons.cancel,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                            title: const Text('Incorrect answer'),
                          ),
                        ),
                        location: ToastLocation.bottomCenter,
                      );
                    }
                  }
                },
                builder: (context, state) {
                  // Check if driver has already passed the quiz
                  final authState = context.watch<AuthCubit>().state;
                  final driver = authState.driver.data?.value;

                  if (driver?.quizStatus == DriverQuizStatus.PASSED) {
                    return _buildAlreadyPassedScreen(driver);
                  }

                  if (state.attempt.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state.result.isSuccess && state.result.hasData) {
                    return _buildResultScreen(state.result.data?.value, state);
                  }

                  if (state.attempt.isSuccess && state.attempt.hasData) {
                    return _buildQuizScreen(state);
                  }

                  return _buildStartScreen(state);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAlreadyPassedScreen(Driver? driver) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check_circle, size: 48.sp, color: Colors.green),
          ),
          SizedBox(height: 24.h),
          Text(
            'Quiz Completed!',
            style: context.typography.h2.copyWith(fontSize: 24.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'You have already passed the driver knowledge quiz.',
            style: context.typography.textMuted.copyWith(fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          if (driver?.quizScore != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: context.colorScheme.muted,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Text(
                    'Quiz Score',
                    style: context.typography.small.copyWith(
                      fontSize: 14.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${driver?.quizScore?.toStringAsFixed(0)}%',
                    style: context.typography.h1.copyWith(fontSize: 32.sp),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            Builder(
              builder: (context) {
                final completedAt = driver?.quizCompletedAt;
                if (completedAt != null) {
                  return Text(
                    'Completed on: ${_formatDate(completedAt)}',
                    style: context.typography.small.copyWith(
                      fontSize: 12.sp,
                      color: context.colorScheme.mutedForeground,
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          SizedBox(height: 32.h),
          PrimaryButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Continue',
                  style: context.typography.medium.copyWith(fontSize: 16.sp),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, size: 20.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Widget _buildResultScreen(DriverQuizResult? result, DriverQuizState2 state) {
    if (result == null) {
      return const Center(child: Text('No result available'));
    }

    final passed = result.passed;

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: passed
                    ? Colors.green.withValues(alpha: 0.1)
                    : Colors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                passed ? Icons.check_circle : Icons.cancel,
                size: 48.sp,
                color: passed ? Colors.green : Colors.red,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              passed ? 'Congratulations!' : 'Quiz Not Passed',
              style: context.typography.h2.copyWith(fontSize: 24.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              passed
                  ? 'You have successfully passed the driver knowledge quiz.'
                  : "Don't worry, you can try again!",
              style: context.typography.textMuted.copyWith(fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            // Stats grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Score',
                    '${result.scorePercentage.toStringAsFixed(0)}%',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Correct Answers',
                    '${result.correctAnswers}/${result.totalQuestions}',
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Points Earned',
                    '${result.earnedPoints}',
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildStatCard(
                    'Total Points',
                    '${result.totalPoints}',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            if (!passed) ...[
              Alert.destructive(
                leading: Icon(Icons.info_outline, size: 24.sp),
                title: Text(
                  'Not Passed',
                  style: context.typography.h4.copyWith(fontSize: 16.sp),
                ),
                content: Text(
                  'You need at least 70% to pass. Please review the material and try again.',
                  style: context.typography.small.copyWith(fontSize: 14.sp),
                ),
              ),
              SizedBox(height: 24.h),
            ],
            SizedBox(
              width: double.infinity,
              child: passed
                  ? PrimaryButton(
                      onPressed: () {
                        context.pushReplacementNamed(
                          Routes.driverApproval.name,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Continue',
                            style: context.typography.medium.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(Icons.arrow_forward, size: 20.sp),
                        ],
                      ),
                    )
                  : PrimaryButton(
                      onPressed: state.attempt.isLoading
                          ? null
                          : () {
                              context.read<DriverQuizCubit2>().startQuiz();
                            },
                      enabled: !state.attempt.isLoading,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.attempt.isLoading) ...[
                            SizedBox(
                              width: 20.sp,
                              height: 20.sp,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 8.w),
                          ] else ...[
                            Icon(Icons.refresh, size: 20.sp),
                            SizedBox(width: 8.w),
                          ],
                          Text(
                            'Try Again',
                            style: context.typography.medium.copyWith(
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: context.colorScheme.muted,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          SizedBox(height: 4.h),
          Text(value, style: context.typography.h2.copyWith(fontSize: 24.sp)),
        ],
      ),
    );
  }

  Widget _buildQuizScreen(DriverQuizState2 state) {
    final currentQuestion = state.currentQuestion;
    final progress = state.progress;

    return Column(
      spacing: 8.h,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 4.w,
          children: [
            Text(
              'Question ${(state.currentQuestionIndex ?? 0) + 1} of ${state.attempt.data?.value.questions.length ?? 0}',
              style: context.typography.small.copyWith(fontSize: 16.sp),
            ),
            OutlineBadge(
              child: Text('${state.answeredQuestions?.length} answered'),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: Progress(
            progress: (progress * 100).clamp(0, 100),
            min: 0,
            max: 100,
          ),
        ),
        _buildQuestionCard(currentQuestion, state),
        SizedBox.shrink(),
        Column(
          spacing: 12.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Jump to question:',
              style: context.typography.small.copyWith(fontSize: 14.sp),
            ),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: List.generate(
                state.attempt.data?.value.questions.length ?? 0,
                (index) {
                  final isCurrentQuestion =
                      index == (state.currentQuestionIndex ?? 0);
                  final isAnswered =
                      state.answeredQuestions?.contains(
                        state.attempt.data!.value.questions[index].id,
                      ) ==
                      true;

                  // Determine button style based on state (like web)
                  // Current question: primary, Answered: secondary with green, Default: outline
                  return GestureDetector(
                    onTap: () {
                      context.read<DriverQuizCubit2>().jumpToQuestion(index);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        color: isCurrentQuestion
                            ? context.colorScheme.primary
                            : isAnswered
                            ? Colors.green.withValues(alpha: 0.15)
                            : Colors.transparent,
                        border: Border.all(
                          color: isCurrentQuestion
                              ? context.colorScheme.primary
                              : isAnswered
                              ? Colors.green
                              : context.colorScheme.border,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: context.typography.medium.copyWith(
                            fontSize: 14.sp,
                            color: isCurrentQuestion
                                ? context.colorScheme.primaryForeground
                                : isAnswered
                                ? Colors.green.shade700
                                : context.colorScheme.mutedForeground,
                            fontWeight: isCurrentQuestion || isAnswered
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionCard(
    DriverMinQuizQuestion? question,
    DriverQuizState2 state,
  ) {
    if (question == null) {
      return Center(
        child: Text(
          'No question available',
          style: context.typography.medium.copyWith(fontSize: 16.sp),
        ),
      );
    }
    return Card(
      child: Column(
        spacing: 12.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getCategoryColor(question.category),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  (question.category).replaceAll('_', ' '),
                  style: context.typography.small.copyWith(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Points: ${question.points}',
                style: context.typography.small.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          Text(
            question.question,
            style: context.typography.medium.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.left,
          ),
          SizedBox.shrink(),
          Column(
            spacing: 16.h,
            children: question.options.map((option) {
              final checkboxState = state.selectedAnswerId == option.id
                  ? CheckboxState.checked
                  : CheckboxState.unchecked;
              final isAnswered =
                  state.answeredQuestions?.contains(question.id) == true;

              return OutlineButton(
                density: ButtonDensity((v) => EdgeInsets.all(8.dg)),
                onPressed: isAnswered
                    ? null
                    : () {
                        context.read<DriverQuizCubit2>().selectAnswer(
                          option.id,
                        );
                      },
                child: Row(
                  spacing: 12.w,
                  children: [
                    Checkbox(
                      state: checkboxState,
                      onChanged: isAnswered
                          ? null
                          : (value) {
                              context.read<DriverQuizCubit2>().selectAnswer(
                                option.id,
                              );
                            },
                    ),
                    Expanded(
                      child: Text(
                        option.text,
                        style: context.typography.medium.copyWith(
                          fontSize: 14.sp,
                        ),
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          Text(
            state.isCurrentQuestionAnswered
                ? 'You have answered this question.'
                : 'Please select an answer to proceed.',
            style: context.typography.small.copyWith(
              fontSize: 12.sp,
              color: context.colorScheme.mutedForeground,
            ),
          ),
          //           if (kDebugMode) ...[
          //             Text(
          //               '''
          // [Debug] Selected Answer ID: ${state.selectedAnswerId}
          // [Debug] Current Question ID: ${question.id}
          // [Debug] Answered Questions: ${state.answeredQuestions?.join(', ')}
          // [Debug] Is Last Question: ${state.isLastQuestion}
          // [Debug] All Questions Answered: ${state.allQuestionsAnswered}
          // ''',
          //               style: context.typography.small.copyWith(
          //                 fontSize: 12.sp,
          //                 color: context.colorScheme.mutedForeground,
          //               ),
          //             ),
          //           ],
          SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Previous button
              OutlineButton(
                onPressed: (state.currentQuestionIndex ?? 0) > 0
                    ? () {
                        context.read<DriverQuizCubit2>().previousQuestion();
                      }
                    : null,
                child: Text(
                  'Previous',
                  style: context.typography.medium.copyWith(fontSize: 14.sp),
                ),
              ),
              Row(
                spacing: 8.w,
                children: [
                  // Submit Answer button - show when question NOT yet answered and answer is selected
                  if (!state.isCurrentQuestionAnswered) ...[
                    PrimaryButton(
                      onPressed:
                          state.selectedAnswerId != null &&
                              !state.answerFeedback.isLoading
                          ? () {
                              context.read<DriverQuizCubit2>().submitAnswer();
                            }
                          : null,
                      enabled:
                          state.selectedAnswerId != null &&
                          !state.answerFeedback.isLoading,
                      child: state.answerFeedback.isLoading
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16.sp,
                                  height: 16.sp,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Submitting...',
                                  style: context.typography.medium.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Submit Answer',
                              style: context.typography.medium.copyWith(
                                fontSize: 14.sp,
                              ),
                            ),
                    ),
                  ],
                  // Next button - show AFTER question is answered, but not on last question when all answered
                  if (state.isCurrentQuestionAnswered &&
                      !state.isLastQuestion) ...[
                    PrimaryButton(
                      onPressed: () {
                        context.read<DriverQuizCubit2>().nextQuestion();
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: context.typography.medium.copyWith(
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(Icons.arrow_forward, size: 16.sp),
                        ],
                      ),
                    ),
                  ],
                  // Complete Quiz button - show on last question when ALL questions are answered
                  if (state.isLastQuestion && state.allQuestionsAnswered) ...[
                    PrimaryButton(
                      onPressed: state.result.isLoading
                          ? null
                          : () {
                              context.read<DriverQuizCubit2>().completeQuiz();
                            },
                      enabled: !state.result.isLoading,
                      child: state.result.isLoading
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 16.sp,
                                  height: 16.sp,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Completing...',
                                  style: context.typography.medium.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle, size: 16.sp),
                                SizedBox(width: 4.w),
                                Text(
                                  'Complete Quiz',
                                  style: context.typography.medium.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ],
      ),
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

  Widget _buildStartScreen(DriverQuizState2 state) {
    return Column(
      spacing: 8.h,
      children: [
        Icon(
          Icons.quiz_outlined,
          size: 64.sp,
          color: context.colorScheme.primary,
        ),
        Text(
          context.l10n.driver_knowledge_quiz,
          style: context.typography.h2.copyWith(fontSize: 20.sp),
          textAlign: TextAlign.center,
        ),
        Text(
          context.l10n.driver_knowledge_quiz_description,
          style: context.typography.textMuted.copyWith(
            fontSize: 14.sp,
            color: context.colorScheme.mutedForeground,
          ),
          textAlign: TextAlign.center,
        ),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final driver = state.driver.data?.value;

            if (driver?.quizStatus == DriverQuizStatus.FAILED) {
              return Alert.destructive(
                title: Text(
                  context.l10n.previous_attempt_failed,
                  style: context.typography.h2.copyWith(fontSize: 16.sp),
                ),
                content: Text(
                  context.l10n.previous_attempt_failed_description,
                  style: context.typography.small.copyWith(fontSize: 14.sp),
                ),
                leading: Icon(Icons.info_outline, size: 24.sp),
              );
            }

            return SizedBox.shrink();
          },
        ),
        if (state.answer.value?.status ==
            DriverQuizAnswerStatus.IN_PROGRESS) ...[
          const Alert.destructive(
            title: Text('Quiz In Progress'),
            content: Text(
              'You have an incomplete quiz attempt. Starting a new quiz will replace it.',
            ),
            leading: Icon(Icons.dangerous_outlined),
          ),
        ],

        Alert(
          title: Text(
            'Quiz Information',
            style: context.typography.h2.copyWith(fontSize: 16.sp),
          ),
          content: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• You will be presented with multiple-choice questions',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
              Text(
                '• Cover topics: Safety, Navigation, Customer Service, Platform Rules',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
              Text(
                '• Passing score: 70%',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
              Text(
                '• You must pass this quiz to be eligible for driver approval',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
              Text(
                '• Take your time - there is no time limit',
                style: context.typography.small.copyWith(fontSize: 14.sp),
              ),
            ],
          ),
        ),

        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            onPressed: state.attempt.isLoading
                ? null
                : () {
                    context.read<DriverQuizCubit2>().startQuiz();
                  },
            enabled: !state.attempt.isLoading,
            child: state.attempt.isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 20.sp,
                        height: 20.sp,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Starting...',
                        style: context.typography.medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 20.sp),
                      SizedBox(width: 8.w),
                      Text(
                        state.answer.value?.status ==
                                DriverQuizAnswerStatus.IN_PROGRESS
                            ? 'Start New Quiz'
                            : context.l10n.start_quiz,
                        style: context.typography.medium.copyWith(
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
