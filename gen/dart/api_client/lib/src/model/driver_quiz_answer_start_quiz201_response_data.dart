//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_get_quiz_questions200_response_data_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_answer_start_quiz201_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizAnswerStartQuiz201ResponseData {
  /// Returns a new [DriverQuizAnswerStartQuiz201ResponseData] instance.
  const DriverQuizAnswerStartQuiz201ResponseData({
    required this.attemptId,
    required this.questions,
    required this.totalQuestions,
    required this.totalPoints,
    required this.passingScore,
  });
  @JsonKey(name: r'attemptId', required: true, includeIfNull: false)
  final String attemptId;
  
  @JsonKey(name: r'questions', required: true, includeIfNull: false)
  final List<DriverQuizQuestionGetQuizQuestions200ResponseDataInner> questions;
  
  @JsonKey(name: r'totalQuestions', required: true, includeIfNull: false)
  final num totalQuestions;
  
  @JsonKey(name: r'totalPoints', required: true, includeIfNull: false)
  final num totalPoints;
  
  @JsonKey(name: r'passingScore', required: true, includeIfNull: false)
  final num passingScore;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizAnswerStartQuiz201ResponseData &&
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

  factory DriverQuizAnswerStartQuiz201ResponseData.fromJson(Map<String, dynamic> json) => _$DriverQuizAnswerStartQuiz201ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizAnswerStartQuiz201ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

