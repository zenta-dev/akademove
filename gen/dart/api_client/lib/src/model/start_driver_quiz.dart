//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'start_driver_quiz.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class StartDriverQuiz {
  /// Returns a new [StartDriverQuiz] instance.
  const StartDriverQuiz({
     this.questionIds,
     this.category,
  });
  @JsonKey(name: r'questionIds', required: false, includeIfNull: false)
  final List<String>? questionIds;
  
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final StartDriverQuizCategoryEnum? category;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is StartDriverQuiz &&
    other.questionIds == questionIds &&
    other.category == category;

  @override
  int get hashCode =>
      questionIds.hashCode +
      category.hashCode;

  factory StartDriverQuiz.fromJson(Map<String, dynamic> json) => _$StartDriverQuizFromJson(json);

  Map<String, dynamic> toJson() => _$StartDriverQuizToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

enum StartDriverQuizCategoryEnum {
  @JsonValue(r'SAFETY')
  SAFETY(r'SAFETY'),
  @JsonValue(r'NAVIGATION')
  NAVIGATION(r'NAVIGATION'),
  @JsonValue(r'CUSTOMER_SERVICE')
  CUSTOMER_SERVICE(r'CUSTOMER_SERVICE'),
  @JsonValue(r'PLATFORM_RULES')
  PLATFORM_RULES(r'PLATFORM_RULES'),
  @JsonValue(r'EMERGENCY_PROCEDURES')
  EMERGENCY_PROCEDURES(r'EMERGENCY_PROCEDURES'),
  @JsonValue(r'VEHICLE_MAINTENANCE')
  VEHICLE_MAINTENANCE(r'VEHICLE_MAINTENANCE'),
  @JsonValue(r'GENERAL')
  GENERAL(r'GENERAL');
  
  const StartDriverQuizCategoryEnum(this.value);
  
  final String value;
  
  @override
  String toString() => value;
}

