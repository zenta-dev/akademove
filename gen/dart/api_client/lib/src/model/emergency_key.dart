//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum EmergencyKey {
      @JsonValue(r'id')
      id(r'id'),
      @JsonValue(r'orderId')
      orderId(r'orderId'),
      @JsonValue(r'userId')
      userId(r'userId'),
      @JsonValue(r'driverId')
      driverId(r'driverId'),
      @JsonValue(r'type')
      type(r'type'),
      @JsonValue(r'status')
      status(r'status'),
      @JsonValue(r'description')
      description(r'description'),
      @JsonValue(r'location')
      location(r'location'),
      @JsonValue(r'contactedAuthorities')
      contactedAuthorities(r'contactedAuthorities'),
      @JsonValue(r'respondedById')
      respondedById(r'respondedById'),
      @JsonValue(r'resolution')
      resolution(r'resolution'),
      @JsonValue(r'reportedAt')
      reportedAt(r'reportedAt'),
      @JsonValue(r'acknowledgedAt')
      acknowledgedAt(r'acknowledgedAt'),
      @JsonValue(r'respondingAt')
      respondingAt(r'respondingAt'),
      @JsonValue(r'resolvedAt')
      resolvedAt(r'resolvedAt');

  const EmergencyKey(this.value);

  final String value;

  @override
  String toString() => value;
}
