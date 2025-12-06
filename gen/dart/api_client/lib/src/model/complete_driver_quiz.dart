//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'complete_driver_quiz.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class CompleteDriverQuiz {
  /// Returns a new [CompleteDriverQuiz] instance.
  const CompleteDriverQuiz({required this.attemptId});
  @JsonKey(name: r'attemptId', required: true, includeIfNull: false)
  final String attemptId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompleteDriverQuiz && other.attemptId == attemptId;

  @override
  int get hashCode => attemptId.hashCode;

  factory CompleteDriverQuiz.fromJson(Map<String, dynamic> json) =>
      _$CompleteDriverQuizFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteDriverQuizToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
