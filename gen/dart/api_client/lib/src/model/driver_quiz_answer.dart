//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_answer.dart';
import 'package:api_client/src/model/driver_quiz_answer_status.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_answer.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizAnswer {
  /// Returns a new [DriverQuizAnswer] instance.
  const DriverQuizAnswer({
    required this.id,
    required this.driverId,
    required this.status,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.totalPoints,
    required this.earnedPoints,
     this.passingScore = 70,
    required this.scorePercentage,
    required this.answers,
    required this.startedAt,
    required this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;
  
  @JsonKey(name: r'driverId', required: true, includeIfNull: false)
  final String driverId;
  
  @JsonKey(name: r'status', required: true, includeIfNull: false)
  final DriverQuizAnswerStatus status;
  
          // minimum: 1
          // maximum: 9007199254740991
  @JsonKey(name: r'totalQuestions', required: true, includeIfNull: false)
  final int totalQuestions;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'correctAnswers', required: true, includeIfNull: false)
  final int correctAnswers;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'totalPoints', required: true, includeIfNull: false)
  final int totalPoints;
  
          // minimum: 0
          // maximum: 9007199254740991
  @JsonKey(name: r'earnedPoints', required: true, includeIfNull: false)
  final int earnedPoints;
  
          // minimum: 0
          // maximum: 1000
  @JsonKey(defaultValue: 70,name: r'passingScore', required: false, includeIfNull: false)
  final int? passingScore;
  
          // minimum: 0
          // maximum: 1000
  @JsonKey(name: r'scorePercentage', required: true, includeIfNull: false)
  final num scorePercentage;
  
  @JsonKey(name: r'answers', required: true, includeIfNull: false)
  final List<DriverQuizQuestionAnswer> answers;
  
  @JsonKey(name: r'startedAt', required: true, includeIfNull: false)
  final DateTime startedAt;
  
  @JsonKey(name: r'completedAt', required: true, includeIfNull: true)
  final DateTime? completedAt;
  
  @JsonKey(name: r'createdAt', required: true, includeIfNull: false)
  final DateTime createdAt;
  
  @JsonKey(name: r'updatedAt', required: true, includeIfNull: false)
  final DateTime updatedAt;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizAnswer &&
    other.id == id &&
    other.driverId == driverId &&
    other.status == status &&
    other.totalQuestions == totalQuestions &&
    other.correctAnswers == correctAnswers &&
    other.totalPoints == totalPoints &&
    other.earnedPoints == earnedPoints &&
    other.passingScore == passingScore &&
    other.scorePercentage == scorePercentage &&
    other.answers == answers &&
    other.startedAt == startedAt &&
    other.completedAt == completedAt &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
      id.hashCode +
      driverId.hashCode +
      status.hashCode +
      totalQuestions.hashCode +
      correctAnswers.hashCode +
      totalPoints.hashCode +
      earnedPoints.hashCode +
      passingScore.hashCode +
      scorePercentage.hashCode +
      answers.hashCode +
      startedAt.hashCode +
      (completedAt == null ? 0 : completedAt.hashCode) +
      createdAt.hashCode +
      updatedAt.hashCode;

  factory DriverQuizAnswer.fromJson(Map<String, dynamic> json) => _$DriverQuizAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizAnswerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

