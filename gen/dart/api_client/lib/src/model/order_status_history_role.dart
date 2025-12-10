//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderStatusHistoryRole {
  @JsonValue(r'USER')
  USER(r'USER'),
  @JsonValue(r'DRIVER')
  DRIVER(r'DRIVER'),
  @JsonValue(r'MERCHANT')
  MERCHANT(r'MERCHANT'),
  @JsonValue(r'OPERATOR')
  OPERATOR(r'OPERATOR'),
  @JsonValue(r'ADMIN')
  ADMIN(r'ADMIN'),
  @JsonValue(r'SYSTEM')
  SYSTEM(r'SYSTEM');

  const OrderStatusHistoryRole(this.value);

  final String value;

  @override
  String toString() => value;
}
