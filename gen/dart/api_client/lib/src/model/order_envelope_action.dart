//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderEnvelopeAction {
  @JsonValue(r'DRIVER_UPDATE_LOCATION')
  DRIVER_UPDATE_LOCATION(r'DRIVER_UPDATE_LOCATION'),
  @JsonValue(r'DRIVER_COMPLETE_ORDER')
  DRIVER_COMPLETE_ORDER(r'DRIVER_COMPLETE_ORDER'),
  @JsonValue(r'CHECK_NEW_DATA')
  CHECK_NEW_DATA(r'CHECK_NEW_DATA');

  const OrderEnvelopeAction(this.value);

  final String value;

  @override
  String toString() => value;
}
