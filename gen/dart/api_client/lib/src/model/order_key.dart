//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderKey {
  @JsonValue(r'id')
  id(r'id'),
  @JsonValue(r'userId')
  userId(r'userId'),
  @JsonValue(r'driverId')
  driverId(r'driverId'),
  @JsonValue(r'merchantId')
  merchantId(r'merchantId'),
  @JsonValue(r'type')
  type(r'type'),
  @JsonValue(r'status')
  status(r'status'),
  @JsonValue(r'pickupLocation')
  pickupLocation(r'pickupLocation'),
  @JsonValue(r'dropoffLocation')
  dropoffLocation(r'dropoffLocation'),
  @JsonValue(r'distanceKm')
  distanceKm(r'distanceKm'),
  @JsonValue(r'basePrice')
  basePrice(r'basePrice'),
  @JsonValue(r'tip')
  tip(r'tip'),
  @JsonValue(r'totalPrice')
  totalPrice(r'totalPrice'),
  @JsonValue(r'note')
  note(r'note'),
  @JsonValue(r'requestedAt')
  requestedAt(r'requestedAt'),
  @JsonValue(r'acceptedAt')
  acceptedAt(r'acceptedAt'),
  @JsonValue(r'arrivedAt')
  arrivedAt(r'arrivedAt'),
  @JsonValue(r'cancelReason')
  cancelReason(r'cancelReason'),
  @JsonValue(r'createdAt')
  createdAt(r'createdAt'),
  @JsonValue(r'updatedAt')
  updatedAt(r'updatedAt'),
  @JsonValue(r'gender')
  gender(r'gender');

  const OrderKey(this.value);

  final String value;

  @override
  String toString() => value;
}
