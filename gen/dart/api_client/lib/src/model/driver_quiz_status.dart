//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DriverQuizStatus {
  @JsonValue(r'NOT_STARTED')
  NOT_STARTED(r'NOT_STARTED'),
  @JsonValue(r'IN_PROGRESS')
  IN_PROGRESS(r'IN_PROGRESS'),
  @JsonValue(r'PASSED')
  PASSED(r'PASSED'),
  @JsonValue(r'FAILED')
  FAILED(r'FAILED');

  const DriverQuizStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
