//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum DriverScheduleKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'driverId')
  driverId(r'driverId'),
  @JsonValue(r'dayOfWeek')
  dayOfWeek(r'dayOfWeek'),
  @JsonValue(r'startTime')
  startTime(r'startTime'),
  @JsonValue(r'endTime')
  endTime(r'endTime'),
  @JsonValue(r'isRecurring')
  isRecurring(r'isRecurring'),
  @JsonValue(r'specificDate')
  specificDate(r'specificDate'),
  @JsonValue(r'isActive')
  isActive(r'isActive'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt');

  const DriverScheduleKey(this.value);

  final String value;

  @override
  String toString() => value;
}
