//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_verify_quiz_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverVerifyQuizRequest {
  /// Returns a new [DriverVerifyQuizRequest] instance.
  const DriverVerifyQuizRequest({required this.quizVerified});
  @JsonKey(name: r'quizVerified', required: true, includeIfNull: false)
  final bool quizVerified;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverVerifyQuizRequest && other.quizVerified == quizVerified;

  @override
  int get hashCode => quizVerified.hashCode;

  factory DriverVerifyQuizRequest.fromJson(Map<String, dynamic> json) =>
      _$DriverVerifyQuizRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DriverVerifyQuizRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
