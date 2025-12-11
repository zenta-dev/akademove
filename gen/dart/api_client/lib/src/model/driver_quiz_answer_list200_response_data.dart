//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:api_client/src/model/driver_quiz_answer.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_quiz_answer_list200_response_data.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverQuizAnswerList200ResponseData {
  /// Returns a new [DriverQuizAnswerList200ResponseData] instance.
  const DriverQuizAnswerList200ResponseData({
    required this.rows,
  });
  @JsonKey(name: r'rows', required: true, includeIfNull: false)
  final List<DriverQuizAnswer> rows;
  
  @override
  bool operator ==(Object other) => identical(this, other) || other is DriverQuizAnswerList200ResponseData &&
    other.rows == rows;

  @override
  int get hashCode =>
      rows.hashCode;

  factory DriverQuizAnswerList200ResponseData.fromJson(Map<String, dynamic> json) => _$DriverQuizAnswerList200ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$DriverQuizAnswerList200ResponseDataToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }

}

