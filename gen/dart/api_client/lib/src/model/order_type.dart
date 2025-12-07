//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';


enum OrderType {
      @JsonValue(r'RIDE')
      RIDE(r'RIDE'),
      @JsonValue(r'DELIVERY')
      DELIVERY(r'DELIVERY'),
      @JsonValue(r'FOOD')
      FOOD(r'FOOD');

  const OrderType(this.value);

  final String value;

  @override
  String toString() => value;
}
