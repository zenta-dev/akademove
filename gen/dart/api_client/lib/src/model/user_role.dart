//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum UserRole {
  @JsonValue(r'ADMIN')
  ADMIN(r'ADMIN'),
  @JsonValue(r'OPERATOR')
  OPERATOR(r'OPERATOR'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'USER')
  USER(r'USER');

  const UserRole(this.value);

  final String value;

  @override
  String toString() => value;
}
