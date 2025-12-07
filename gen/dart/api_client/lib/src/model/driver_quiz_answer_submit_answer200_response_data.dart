//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_answer_submit_answer200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizAnswerSubmitAnswer200ResponseData {
  /// Returns a new [DriverQuizAnswerSubmitAnswer200ResponseData] instance.
  const DriverQuizAnswerSubmitAnswer200ResponseData({
    required this.isCorrect,
    required this.pointsEarned,
     this.correctOptionId,
    required this.explanation,
  });
  @JsonKey(name: r'isCorrect', required: true, includeIfNull: false)
  final bool isCorrect;
  
  @JsonKey(name: r'pointsEarned', required: true, includeIfNull: false)
  final num pointsEarned;
  
  @JsonKey(name: r'correctOptionId', required: false, includeIfNull: false)
  final String? correctOptionId;
  
  @JsonKey(name: r'explanation', required: true, includeIfNull: true)
  final String? explanation;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizAnswerSubmitAnswer200ResponseData &&
    other.isCorrect == isCorrect &&
    other.pointsEarned == pointsEarned &&
    other.correctOptionId == correctOptionId &&
    other.explanation == explanation;

  @override
  int get hashCode =>
      isCorrect.hashCode +
      pointsEarned.hashCode +
      correctOptionId.hashCode +
      (explanation == null ? 0 : explanation.hashCode);

  factory DriverQuizAnswerSubmitAnswer200ResponseData.fromJson(Map<String, dynamic> json) => _$DriverQuizAnswerSubmitAnswer200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizAnswerSubmitAnswer200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

