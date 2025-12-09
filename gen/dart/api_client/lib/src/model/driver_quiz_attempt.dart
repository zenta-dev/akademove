//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_min_quiz_question.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_attempt.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizAttempt {
  /// Returns a new [DriverQuizAttempt] instance.
  const DriverQuizAttempt({
    required this.attemptId,
    required this.questions,
    required this.totalQuestions,
    required this.totalPoints,
    required this.passingScore,
  });
  @JsonKey(name: r'attemptId', required: true, includeIfNull: false)
  final String attemptId;
  
  @JsonKey(name: r'questions', required: true, includeIfNull: false)
  final List<DriverMinQuizQuestion> questions;
  
  @JsonKey(name: r'totalQuestions', required: true, includeIfNull: false)
  final num totalQuestions;
  
  @JsonKey(name: r'totalPoints', required: true, includeIfNull: false)
  final num totalPoints;
  
  @JsonKey(name: r'passingScore', required: true, includeIfNull: false)
  final num passingScore;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizAttempt &&
    other.attemptId == attemptId &&
    other.questions == questions &&
    other.totalQuestions == totalQuestions &&
    other.totalPoints == totalPoints &&
    other.passingScore == passingScore;

  @override
  int get hashCode =>
      attemptId.hashCode +
      questions.hashCode +
      totalQuestions.hashCode +
      totalPoints.hashCode +
      passingScore.hashCode;

  factory DriverQuizAttempt.fromJson(Map<String, dynamic> json) => _$DriverQuizAttemptFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizAttemptToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

