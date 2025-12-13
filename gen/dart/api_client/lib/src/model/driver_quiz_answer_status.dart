//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DriverQuizAnswerStatus {
  @JsonValue(r'IN_PROGRESS')
  IN_PROGRESS(r'IN_PROGRESS'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'PASSED')
  PASSED(r'PASSED'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');

  const DriverQuizAnswerStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
