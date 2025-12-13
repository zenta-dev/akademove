//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum PaymentEnvelopeEvent {
      @JsonValue(r'TOP_UP_SUCCESS')
      TOP_UP_SUCCESS(r'TOP_UP_SUCCESS'),
      @JsonValue(r'PAYMENT_SUCCESS')
      PAYMENT_SUCCESS(r'PAYMENT_SUCCESS'),
      @JsonValue(r'TOP_UP_FAILED')
      TOP_UP_FAILED(r'TOP_UP_FAILED'),
      @JsonValue(r'PAYMENT_FAILED')
      PAYMENT_FAILED(r'PAYMENT_FAILED'),
      @JsonValue(r'NEW_DATA')
      NEW_DATA(r'NEW_DATA'),
      @JsonValue(r'NO_DATA')
      NO_DATA(r'NO_DATA');

  const PaymentEnvelopeEvent(this.value);

  final String value;

  @override
  String toString() => value;
}
