//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_category.dart';
import 'package:api_client/src/model/driver_quiz_question_option.dart';
import 'package:api_client/src/model/driver_quiz_question_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'insert_driver_quiz_question.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class InsertDriverQuizQuestion {
  /// Returns a new [InsertDriverQuizQuestion] instance.
  const InsertDriverQuizQuestion({
    required this.question,
    required this.type,
    required this.category,
    required this.options,
    required this.explanation,
    this.points = 10,
    this.isActive = true,
    this.displayOrder = 0,
  });
  @JsonKey(name: r'question', required: true, includeIfNull: false)
  final String question;

  @JsonKey(name: r'type', required: true, includeIfNull: false)
  final DriverQuizQuestionType type;

  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final DriverQuizQuestionCategory category;

  @JsonKey(name: r'options', required: true, includeIfNull: false)
  final List<DriverQuizQuestionOption> options;

  @JsonKey(name: r'explanation', required: true, includeIfNull: true)
  final String? explanation;

  // minimum: 1
  // maximum: 1000
  @JsonKey(
    defaultValue: 10,
    name: r'points',
    required: false,
    includeIfNull: false,
  )
  final int? points;

  @JsonKey(
    defaultValue: true,
    name: r'isActive',
    required: false,
    includeIfNull: false,
  )
  final bool? isActive;

  // minimum: -9007199254740991
  // maximum: 9007199254740991
  @JsonKey(
    defaultValue: 0,
    name: r'displayOrder',
    required: false,
    includeIfNull: false,
  )
  final int? displayOrder;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsertDriverQuizQuestion &&
          other.question == question &&
          other.type == type &&
          other.category == category &&
          other.options == options &&
          other.explanation == explanation &&
          other.points == points &&
          other.isActive == isActive &&
          other.displayOrder == displayOrder;

  @override
  int get hashCode =>
      question.hashCode +
      type.hashCode +
      category.hashCode +
      options.hashCode +
      (explanation == null ? 0 : explanation.hashCode) +
      points.hashCode +
      isActive.hashCode +
      displayOrder.hashCode;

  factory InsertDriverQuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$InsertDriverQuizQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$InsertDriverQuizQuestionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
