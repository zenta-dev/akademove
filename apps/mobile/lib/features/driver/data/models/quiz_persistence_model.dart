import 'dart:convert';

/// Local persistence model for quiz attempt state
/// Stored in KeyValueService to survive app restarts
class QuizAttemptPersistence {
  QuizAttemptPersistence({
    required this.attemptId,
    required this.status,
    required this.currentQuestionIndex,
    required this.selectedAnswers,
    required this.answeredQuestions,
    required this.totalQuestions,
    required this.lastSyncTime,
  });

  /// Quiz attempt ID from server
  final String attemptId;

  /// Current status: 'IN_PROGRESS', 'COMPLETED', 'PASSED', 'FAILED'
  final String status;

  /// Current question index being displayed
  final int currentQuestionIndex;

  /// Map of questionId -> selectedOptionId for all answered questions
  final Map<String, String> selectedAnswers;

  /// Set of question IDs that have been answered
  final Set<String> answeredQuestions;

  /// Total number of questions in this attempt
  final int totalQuestions;

  /// Last sync time with server (ISO format string)
  final String lastSyncTime;

  /// Convert to JSON string for storage
  String toJsonString() {
    return jsonEncode({
      'attemptId': attemptId,
      'status': status,
      'currentQuestionIndex': currentQuestionIndex,
      'selectedAnswers': selectedAnswers,
      'answeredQuestions': answeredQuestions.toList(),
      'totalQuestions': totalQuestions,
      'lastSyncTime': lastSyncTime,
    });
  }

  /// Create from JSON string
  factory QuizAttemptPersistence.fromJsonString(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return QuizAttemptPersistence(
      attemptId: json['attemptId'] as String,
      status: json['status'] as String,
      currentQuestionIndex: json['currentQuestionIndex'] as int,
      selectedAnswers: Map<String, String>.from(
        json['selectedAnswers'] as Map<dynamic, dynamic>,
      ),
      answeredQuestions: Set<String>.from(
        (json['answeredQuestions'] as List<dynamic>).cast<String>(),
      ),
      totalQuestions: json['totalQuestions'] as int,
      lastSyncTime: json['lastSyncTime'] as String,
    );
  }

  /// Copy with method for immutable updates
  QuizAttemptPersistence copyWith({
    String? attemptId,
    String? status,
    int? currentQuestionIndex,
    Map<String, String>? selectedAnswers,
    Set<String>? answeredQuestions,
    int? totalQuestions,
    String? lastSyncTime,
  }) {
    return QuizAttemptPersistence(
      attemptId: attemptId ?? this.attemptId,
      status: status ?? this.status,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      answeredQuestions: answeredQuestions ?? this.answeredQuestions,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
    );
  }

  /// Check if quiz is still in progress
  bool get isInProgress => status == 'IN_PROGRESS';

  /// Check if all questions have been answered
  bool get allQuestionsAnswered => answeredQuestions.length == totalQuestions;

  /// Get progress as percentage (0.0 - 1.0)
  double get progress =>
      totalQuestions > 0 ? answeredQuestions.length / totalQuestions : 0.0;
}
