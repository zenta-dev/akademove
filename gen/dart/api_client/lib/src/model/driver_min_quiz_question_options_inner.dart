//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';
import 'package:copy_with_extension/copy_with_extension.dart';

part 'driver_min_quiz_question_options_inner.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class DriverMinQuizQuestionOptionsInner {
  /// Returns a new [DriverMinQuizQuestionOptionsInner] instance.
  const DriverMinQuizQuestionOptionsInner({
    required this.id,
    required this.text,
  });
  @JsonKey(name: r'id', required: true, includeIfNull: false)
  final String id;

  @JsonKey(name: r'text', required: true, includeIfNull: false)
  final String text;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverMinQuizQuestionOptionsInner &&
          other.id == id &&
          other.text == text;

  @override
  int get hashCode => id.hashCode + text.hashCode;

  factory DriverMinQuizQuestionOptionsInner.fromJson(
    Map<String, dynamic> json,
  ) => _$DriverMinQuizQuestionOptionsInnerFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DriverMinQuizQuestionOptionsInnerToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
