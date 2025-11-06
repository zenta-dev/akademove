//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum WSEnvelopeType {
  @JsonValue(r'order:request')
  orderColonRequest(r'order:request'),
  @JsonValue(r'order:matching')
  orderColonMatching(r'order:matching'),
  @JsonValue(r'order:cancelled')
  orderColonCancelled(r'order:cancelled'),
  @JsonValue(r'order:accepted')
  orderColonAccepted(r'order:accepted'),
  @JsonValue(r'driver:location_update')
  driverColonLocationUpdate(r'driver:location_update'),
  @JsonValue(r'driver:assigned')
  driverColonAssigned(r'driver:assigned'),
  @JsonValue(r'wallet:top_up_success')
  walletColonTopUpSuccess(r'wallet:top_up_success');

  const WSEnvelopeType(this.value);

  final String value;

  @override
  String toString() => value;
}
