//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderEnvelopeAction {
  // Driver actions (sent by driver app)
  @JsonValue(r'DRIVER_UPDATE_LOCATION')
  DRIVER_UPDATE_LOCATION(r'DRIVER_UPDATE_LOCATION'),
  @JsonValue(r'DRIVER_COMPLETE_ORDER')
  DRIVER_COMPLETE_ORDER(r'DRIVER_COMPLETE_ORDER');

  const OrderEnvelopeAction(this.value);

  final String value;

  @override
  String toString() => value;
}
