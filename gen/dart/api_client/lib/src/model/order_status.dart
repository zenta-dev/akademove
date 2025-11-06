//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderStatus {
  @JsonValue(r'requested')
  requested(r'requested'),
  @JsonValue(r'matching')
  matching(r'matching'),
  @JsonValue(r'accepted')
  accepted(r'accepted'),
  @JsonValue(r'arriving')
  arriving(r'arriving'),
  @JsonValue(r'in_trip')
  inTrip(r'in_trip'),
  @JsonValue(r'completed')
  completed(r'completed'),
  @JsonValue(r'cancelled_by_user')
  cancelledByUser(r'cancelled_by_user'),
  @JsonValue(r'cancelled_by_driver')
  cancelledByDriver(r'cancelled_by_driver'),
  @JsonValue(r'cancelled_by_system')
  cancelledBySystem(r'cancelled_by_system');

  const OrderStatus(this.value);

  final String value;

  @override
  String toString() => value;
}
