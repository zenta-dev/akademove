//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_question_option.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizQuestionOption {
  /// Returns a new [DriverQuizQuestionOption] instance.
  const DriverQuizQuestionOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'text', required: true, includeIfNull: false)
  final String text;

  @JsonKey(name: r'isCorrect', required: true, includeIfNull: false)
  final bool isCorrect;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverQuizQuestionOption &&
          other.id == id &&
          other.text == text &&
          other.isCorrect == isCorrect;

  @override
  int get hashCode => id.hashCode + text.hashCode + isCorrect.hashCode;

  factory DriverQuizQuestionOption.fromJson(Map<String, dynamic> json) =>
      _$DriverQuizQuestionOptionFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizQuestionOptionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
