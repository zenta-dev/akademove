//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderEnvelopeAction {
  @JsonValue(r'MATCHING')
  MATCHING(r'MATCHING'),
  @JsonValue(r'ACCEPTED')
  ACCEPTED(r'ACCEPTED'),
  @JsonValue(r'UPDATE_LOCATION')
  UPDATE_LOCATION(r'UPDATE_LOCATION'),
  @JsonValue(r'DONE')
  DONE(r'DONE'),
  @JsonValue(r'SEND_MESSAGE')
  SEND_MESSAGE(r'SEND_MESSAGE'),
  @JsonValue(r'MERCHANT_ACCEPT')
  MERCHANT_ACCEPT(r'MERCHANT_ACCEPT'),
  @JsonValue(r'MERCHANT_REJECT')
  MERCHANT_REJECT(r'MERCHANT_REJECT'),
  @JsonValue(r'MERCHANT_MARK_PREPARING')
  MERCHANT_MARK_PREPARING(r'MERCHANT_MARK_PREPARING'),
  @JsonValue(r'MERCHANT_MARK_READY')
  MERCHANT_MARK_READY(r'MERCHANT_MARK_READY'),
  @JsonValue(r'REPORT_NO_SHOW')
  REPORT_NO_SHOW(r'REPORT_NO_SHOW');

  const OrderEnvelopeAction(this.value);

  final String value;

  @override
  String toString() => value;
}
