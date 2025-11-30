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
      DONE(r'DONE');

  const OrderEnvelopeAction(this.value);

  final String value;

  @override
  String toString() => value;
}
