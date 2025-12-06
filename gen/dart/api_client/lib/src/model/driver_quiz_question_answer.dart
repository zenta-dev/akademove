//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_question_answer.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizQuestionAnswer {
  /// Returns a new [DriverQuizQuestionAnswer] instance.
  const DriverQuizQuestionAnswer({
    required this.questionId,
    required this.selectedOptionId,
    required this.isCorrect,
    required this.pointsEarned,
    required this.answeredAt,
  });
  @JsonKey(name: r'questionId', required: true, includeIfNull: false)
  final String questionId;

  @JsonKey(name: r'selectedOptionId', required: true, includeIfNull: false)
  final String selectedOptionId;

  @JsonKey(name: r'isCorrect', required: true, includeIfNull: false)
  final bool isCorrect;

  // minimum: 0
  // maximum: 9007199254740991
  @JsonKey(name: r'pointsEarned', required: true, includeIfNull: false)
  final int pointsEarned;

  @JsonKey(name: r'answeredAt', required: true, includeIfNull: false)
  final DateTime answeredAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverQuizQuestionAnswer &&
          other.questionId == questionId &&
          other.selectedOptionId == selectedOptionId &&
          other.isCorrect == isCorrect &&
          other.pointsEarned == pointsEarned &&
          other.answeredAt == answeredAt;

  @override
  int get hashCode =>
      questionId.hashCode +
      selectedOptionId.hashCode +
      isCorrect.hashCode +
      pointsEarned.hashCode +
      answeredAt.hashCode;

  factory DriverQuizQuestionAnswer.fromJson(Map<String, dynamic> json) =>
      _$DriverQuizQuestionAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizQuestionAnswerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
