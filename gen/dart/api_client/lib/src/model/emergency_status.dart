//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum EmergencyStatus {
  @JsonValue(r'REPORTED')
  REPORTED(r'REPORTED'),
  @JsonValue(r'ACKNOWLEDGED')
  ACKNOWLEDGED(r'ACKNOWLEDGED'),
  @JsonValue(r'RESPONDING')
  RESPONDING(r'RESPONDING'),
  @JsonValue(r'RESOLVED')
  RESOLVED(r'RESOLVED');

  const EmergencyStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
