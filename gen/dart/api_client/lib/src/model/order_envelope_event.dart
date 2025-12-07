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
      CHAT_MESSAGE(r'CHAT_MESSAGE'),
      @JsonValue(r'MERCHANT_ACCEPTED')
      MERCHANT_ACCEPTED(r'MERCHANT_ACCEPTED'),
      @JsonValue(r'MERCHANT_REJECTED')
      MERCHANT_REJECTED(r'MERCHANT_REJECTED'),
      @JsonValue(r'MERCHANT_PREPARING')
      MERCHANT_PREPARING(r'MERCHANT_PREPARING'),
      @JsonValue(r'MERCHANT_READY')
      MERCHANT_READY(r'MERCHANT_READY'),
      @JsonValue(r'NO_SHOW')
      NO_SHOW(r'NO_SHOW');

  const OrderEnvelopeEvent(this.value);

  final String value;

  @override
  String toString() => value;
}
