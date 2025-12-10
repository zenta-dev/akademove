//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_min_quiz_question_options_inner.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_min_quiz_question.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverMinQuizQuestion {
  /// Returns a new [DriverMinQuizQuestion] instance.
  const DriverMinQuizQuestion({
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
  final List<DriverMinQuizQuestionOptionsInner> options;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverMinQuizQuestion &&
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

  factory DriverMinQuizQuestion.fromJson(Map<String, dynamic> json) =>
      _$DriverMinQuizQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$DriverMinQuizQuestionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
