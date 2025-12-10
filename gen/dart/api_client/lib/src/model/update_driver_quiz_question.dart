//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_question_category.dart';
import 'package:api_client/src/model/driver_quiz_question_option.dart';
import 'package:api_client/src/model/driver_quiz_question_type.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'update_driver_quiz_question.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class UpdateDriverQuizQuestion {
  /// Returns a new [UpdateDriverQuizQuestion] instance.
  const UpdateDriverQuizQuestion({
     this.question,
     this.type,
     this.category,
     this.options,
     this.explanation,
     this.points = 10,
     this.isActive = true,
     this.displayOrder = 0,
  });
  @JsonKey(name: r'question', required: false, includeIfNull: false)
  final String? question;
  
  @JsonKey(name: r'type', required: false, includeIfNull: false)
  final DriverQuizQuestionType? type;
  
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final DriverQuizQuestionCategory? category;
  
  @JsonKey(name: r'options', required: false, includeIfNull: false)
  final List<DriverQuizQuestionOption>? options;
  
  @JsonKey(name: r'explanation', required: false, includeIfNull: false)
  final String? explanation;
  
          // minimum: 1
          // maximum: 1000
  @JsonKey(defaultValue: 10,name: r'points', required: false, includeIfNull: false)
  final int? points;
  
  @JsonKey(defaultValue: true,name: r'isActive', required: false, includeIfNull: false)
  final bool? isActive;
  
          // minimum: -9007199254740991
          // maximum: 9007199254740991
  @JsonKey(defaultValue: 0,name: r'displayOrder', required: false, includeIfNull: false)
  final int? displayOrder;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is UpdateDriverQuizQuestion &&
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

  factory UpdateDriverQuizQuestion.fromJson(Map<String, dynamic> json) => _$UpdateDriverQuizQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateDriverQuizQuestionToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

