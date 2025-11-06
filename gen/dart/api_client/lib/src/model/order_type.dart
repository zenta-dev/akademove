//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

enum OrderType {
  @JsonValue(r'ride')
  ride(r'ride'),
  @JsonValue(r'delivery')
  delivery(r'delivery'),
  @JsonValue(r'food')
  food(r'food');

  const OrderType(this.value);

  final String value;

  @override
  String toString() => value;
}
