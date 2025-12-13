//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum MerchantEnvelopeEvent {
      @JsonValue(r'NEW_ORDER')
      NEW_ORDER(r'NEW_ORDER'),
      @JsonValue(r'ORDER_CANCELLED')
      ORDER_CANCELLED(r'ORDER_CANCELLED'),
      @JsonValue(r'DRIVER_ASSIGNED')
      DRIVER_ASSIGNED(r'DRIVER_ASSIGNED'),
      @JsonValue(r'ORDER_COMPLETED')
      ORDER_COMPLETED(r'ORDER_COMPLETED'),
      @JsonValue(r'ORDER_STATUS_CHANGED')
      ORDER_STATUS_CHANGED(r'ORDER_STATUS_CHANGED'),
      @JsonValue(r'NEW_DATA')
      NEW_DATA(r'NEW_DATA'),
      @JsonValue(r'NO_DATA')
      NO_DATA(r'NO_DATA');

  const MerchantEnvelopeEvent(this.value);

  final String value;

  @override
  String toString() => value;
}
