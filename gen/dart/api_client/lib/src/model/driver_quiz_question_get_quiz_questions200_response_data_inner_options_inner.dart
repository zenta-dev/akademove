//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_question_get_quiz_questions200_response_data_inner_options_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner {
  /// Returns a new [DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner] instance.
  const DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner({
    required this.id,
    required this.text,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: true)
  final String? id;
  
  @JsonKey(name: r'text', required: true, includeIfNull: true)
  final String? text;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner &&
    other.id == id &&
    other.text == text;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) +
      (text == null ? 0 : text.hashCode);

  factory DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner.fromJson(Map<String, dynamic> json) => _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

