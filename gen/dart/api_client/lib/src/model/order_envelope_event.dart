//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum OrderEnvelopeEvent {
      @JsonValue(r'CANCELED')
      CANCELED(r'CANCELED'),
      @JsonValue(r'OFFER')
      OFFER(r'OFFER'),
      @JsonValue(r'UNAVAILABLE')
      UNAVAILABLE(r'UNAVAILABLE'),
      @JsonValue(r'DRIVER_ACCEPTED')
      DRIVER_ACCEPTED(r'DRIVER_ACCEPTED'),
      @JsonValue(r'DRIVER_LOCATION_UPDATE')
      DRIVER_LOCATION_UPDATE(r'DRIVER_LOCATION_UPDATE'),
      @JsonValue(r'COMPLETED')
      COMPLETED(r'COMPLETED'),
      @JsonValue(r'MATCHING')
      MATCHING(r'MATCHING'),
      @JsonValue(r'CHAT_MESSAGE')
      CHAT_MESSAGE(r'CHAT_MESSAGE');

  const OrderEnvelopeEvent(this.value);

  final String value;

  @override
  String toString() => value;
}
