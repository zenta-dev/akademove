//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_get_quiz_questions200_response_data_inner_options_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_question_get_quiz_questions200_response_data_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizQuestionGetQuizQuestions200ResponseDataInner {
  /// Returns a new [DriverQuizQuestionGetQuizQuestions200ResponseDataInner] instance.
  const DriverQuizQuestionGetQuizQuestions200ResponseDataInner({
    required this.id,
    required this.question,
    required this.type,
    required this.category,
    required this.points,
    required this.displayOrder,
    required this.options,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: true)
  final String? id;

  @JsonKey(name: r'question', required: true, includeIfNull: true)
  final String? question;

  @JsonKey(name: r'type', required: true, includeIfNull: true)
  final String? type;

  @JsonKey(name: r'category', required: true, includeIfNull: true)
  final String? category;

  @JsonKey(name: r'points', required: true, includeIfNull: false)
  final num points;

  @JsonKey(name: r'displayOrder', required: true, includeIfNull: false)
  final num displayOrder;

  @JsonKey(name: r'options', required: true, includeIfNull: false)
  final List<DriverQuizQuestionGetQuizQuestions200ResponseDataInnerOptionsInner>
  options;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverQuizQuestionGetQuizQuestions200ResponseDataInner &&
          other.id == id &&
          other.question == question &&
          other.type == type &&
          other.category == category &&
          other.points == points &&
          other.displayOrder == displayOrder &&
          other.options == options;

  @override
  int get hashCode =>
      (id == null ? 0 : id.hashCode) +
      (question == null ? 0 : question.hashCode) +
      (type == null ? 0 : type.hashCode) +
      (category == null ? 0 : category.hashCode) +
      points.hashCode +
      displayOrder.hashCode +
      options.hashCode;

  factory DriverQuizQuestionGetQuizQuestions200ResponseDataInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverQuizQuestionGetQuizQuestions200ResponseDataInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
