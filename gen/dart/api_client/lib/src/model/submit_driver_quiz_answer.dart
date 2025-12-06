//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'submit_driver_quiz_answer.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SubmitDriverQuizAnswer {
  /// Returns a new [SubmitDriverQuizAnswer] instance.
  const SubmitDriverQuizAnswer({
    required this.attemptId,
    required this.questionId,
    required this.selectedOptionId,
  });
  @JsonKey(name: r'attemptId', required: true, includeIfNull: false)
  final String attemptId;

  @JsonKey(name: r'questionId', required: true, includeIfNull: false)
  final String questionId;

  @JsonKey(name: r'selectedOptionId', required: true, includeIfNull: false)
  final String selectedOptionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubmitDriverQuizAnswer &&
          other.attemptId == attemptId &&
          other.questionId == questionId &&
          other.selectedOptionId == selectedOptionId;

  @override
  int get hashCode =>
      attemptId.hashCode + questionId.hashCode + selectedOptionId.hashCode;

  factory SubmitDriverQuizAnswer.fromJson(Map<String, dynamic> json) =>
      _$SubmitDriverQuizAnswerFromJson(json);

  Map<String, dynamic> toJson() => _$SubmitDriverQuizAnswerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
