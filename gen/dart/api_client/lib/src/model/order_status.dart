//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(r'REQUESTED')
  REQUESTED(r'REQUESTED'),
  @JsonValue(r'MATCHING')
  MATCHING(r'MATCHING'),
  @JsonValue(r'ACCEPTED')
  ACCEPTED(r'ACCEPTED'),
  @JsonValue(r'ARRIVING')
  ARRIVING(r'ARRIVING'),
  @JsonValue(r'IN_TRIP')
  IN_TRIP(r'IN_TRIP'),
  @JsonValue(r'COMPLETED')
  COMPLETED(r'COMPLETED'),
  @JsonValue(r'CANCELLED_BY_USER')
  CANCELLED_BY_USER(r'CANCELLED_BY_USER'),
  @JsonValue(r'CANCELLED_BY_DRIVER')
  CANCELLED_BY_DRIVER(r'CANCELLED_BY_DRIVER'),
  @JsonValue(r'CANCELLED_BY_SYSTEM')
  CANCELLED_BY_SYSTEM(r'CANCELLED_BY_SYSTEM');

  const OrderStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
