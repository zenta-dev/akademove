//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum OrderStatus {
      @JsonValue(r'SCHEDULED')
      SCHEDULED(r'SCHEDULED'),
      @JsonValue(r'REQUESTED')
      REQUESTED(r'REQUESTED'),
      @JsonValue(r'MATCHING')
      MATCHING(r'MATCHING'),
      @JsonValue(r'ACCEPTED')
      ACCEPTED(r'ACCEPTED'),
      @JsonValue(r'PREPARING')
      PREPARING(r'PREPARING'),
      @JsonValue(r'READY_FOR_PICKUP')
      READY_FOR_PICKUP(r'READY_FOR_PICKUP'),
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
      @JsonValue(r'CANCELLED_BY_MERCHANT')
      CANCELLED_BY_MERCHANT(r'CANCELLED_BY_MERCHANT'),
      @JsonValue(r'CANCELLED_BY_SYSTEM')
      CANCELLED_BY_SYSTEM(r'CANCELLED_BY_SYSTEM'),
      @JsonValue(r'NO_SHOW')
      NO_SHOW(r'NO_SHOW');

  const OrderStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
