//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum EmergencyContactKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'name')
  name(r'name'),
  @JsonValue(r'phone')
  phone(r'phone'),
  @JsonValue(r'description')
  description(r'description'),
  @JsonValue(r'isActive')
  isActive(r'isActive'),
  @JsonValue(r'priority')
  priority(r'priority'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt'),
  @JsonValue(r'createdById')
  createdById(r'createdById'),
  @JsonValue(r'updatedById')
  updatedById(r'updatedById');

  const EmergencyContactKey(this.value);

  final String value;

  @override
  String toString() => value;
}
