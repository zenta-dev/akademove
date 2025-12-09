//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_answer_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_result.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizResult {
  /// Returns a new [DriverQuizResult] instance.
  const DriverQuizResult({
    required this.attemptId,
    required this.status,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.scorePercentage,
    required this.passed,
    required this.earnedPoints,
    required this.totalPoints,
    required this.completedAt,
  });
  @JsonKey(name: r'attemptId', required: true, includeIfNull: false)
  final String attemptId;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DriverQuizAnswerStatus status;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'totalQuestions', required: true, includeIfNull: false)
  final int totalQuestions;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'correctAnswers', required: true, includeIfNull: false)
  final int correctAnswers;
  
  @JsonKey(name: r'scorePercentage', required: true, includeIfNull: false)
  final num scorePercentage;
  
  @JsonKey(name: r'passed', required: true, includeIfNull: false)
  final bool passed;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'earnedPoints', required: true, includeIfNull: false)
  final int earnedPoints;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPoints', required: true, includeIfNull: false)
  final int totalPoints;
  
  @JsonKey(name: r'completedAt', required: true, includeIfNull: true)
  final DateTime? completedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizResult &&
    other.attemptId == attemptId &&
    other.status == status &&
    other.totalQuestions == totalQuestions &&
    other.correctAnswers == correctAnswers &&
    other.scorePercentage == scorePercentage &&
    other.passed == passed &&
    other.earnedPoints == earnedPoints &&
    other.totalPoints == totalPoints &&
    other.completedAt == completedAt;

  @override
  int get hashCode =>
      attemptId.hashCode +
      status.hashCode +
      totalQuestions.hashCode +
      correctAnswers.hashCode +
      scorePercentage.hashCode +
      passed.hashCode +
      earnedPoints.hashCode +
      totalPoints.hashCode +
      (completedAt == null ? 0 : completedAt.hashCode);

  factory DriverQuizResult.fromJson(Map<String, dynamic> json) => _$DriverQuizResultFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizResultToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

